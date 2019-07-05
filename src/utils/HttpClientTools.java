package utils;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;


/**
 * Created by junhong
 * on 2017/1/18.
 */
public class HttpClientTools {
    private final static Logger LOG = Logger.getLogger(HttpClientTools.class);
    private static final String DEFAULT_ENCODING = "UTF-8";
    private static final int RETRY = 3;
    private static HttpClientTools hcTool;

    private HttpClientTools() {
        try {
//            ProxyManager.getInstance().init(CrawlerConf.getInstance());
//            AccountManager.getInstance().init();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("init error!", e);
        }
    }

    public static HttpClientTools getInstance() {
        if (hcTool == null) {
            synchronized (HttpClientTools.class) {
                if (hcTool == null)
                    hcTool = new HttpClientTools();
            }
        }
        return hcTool;
    }


    /**
     * add httpClient 'post' with proxy
     *
     * @param url      访问连接
     * @param useProxy 是否用代理
     * @param header   头部参数
     * @return json或者html
     */
    public String fetch(String url, boolean useProxy, Map<String, Object> header) {
        return fetch(url, useProxy, header, DEFAULT_ENCODING);
    }

    public String fetch(String url, boolean useProxy) {
        return fetch(url, useProxy, null);
    }

    public String fetch(String url, HTTP_METHOD_TYPE type, boolean useProxy, Map<String, Object> header,
                        Map<String, Object> params) {
        return fetch(url, type, useProxy, header, params, DEFAULT_ENCODING);
    }

    public String fetch(String url, boolean useProxy, Map<String, Object> header,
                        Map<String, Object> params) {
        return fetch(url, HTTP_METHOD_TYPE.POST, useProxy, header, params, DEFAULT_ENCODING);
    }

    public String fetch(String url, HTTP_METHOD_TYPE type, Map<String, Object> header, String charset) {
        return fetch(url, type, false, header, charset);
    }

    public String fetch(String url, HTTP_METHOD_TYPE type, Map<String, Object> header) {
        return fetch(url, type, false, header, DEFAULT_ENCODING);
    }

    public String fetch(String url) {
        return fetch(url, new HashMap<String, Object>());
    }

    public String fetch(String url, String charset) {
        return fetch(url, false,null, charset);
    }

    public String fetch(String url, Map<String, Object> header) {
        return fetch(url, false, header, DEFAULT_ENCODING);
    }

    public String fetch(String url, boolean useProxy, Map<String, Object> header, String charset) {
        return fetch(url, HTTP_METHOD_TYPE.GET, useProxy, header, charset);
    }

    public String fetch(String url, HTTP_METHOD_TYPE type, boolean useProxy, Map<String, Object> header) {
        return fetch(url, type, useProxy, header, DEFAULT_ENCODING);
    }

    /**
     * @param url      访问连接
     * @param type     [get|post]
     * @param useProxy 是否用代理
     * @param header   头部参数
     * @param charset  头部编码
     * @return json or html
     */
    public String fetch(String url, HTTP_METHOD_TYPE type, boolean useProxy, Map<String, Object> header, String charset) {
        return fetch(url, type, useProxy, header, null, charset);
    }


    public String fetch(String url, HTTP_METHOD_TYPE type, boolean useProxy, Map<String, Object> header,
                        Map<String, Object> params, String charset) {
        return fetch(url, type, useProxy, header, params, charset, RETRY);
    }

    public String fetch(String url, HTTP_METHOD_TYPE type, boolean useProxy, Map<String, Object> header,
                        Map<String, Object> params, String charset, int retry) {
        String ret = "";
        while (!StringUtils.isNotEmpty(ret) && retry-- > 0) {
            try {
                HttpClient httpClient = new HttpClient();
                PostMethod method;
                if (HTTP_METHOD_TYPE.POST.getName().equals(type.getName()) || HTTP_METHOD_TYPE.POST_JSON.getName().equals(type.getName())) {
                    method = new PostMethod(url);
                    method.getParams().setContentCharset(charset);
                } else {
                    ret = fetchWithGet(url, useProxy, header, charset);
                    continue;
                }
                //post参数
                if (HTTP_METHOD_TYPE.POST.getName().equals(type.getName())) {
                	for (Map.Entry<String, Object> entry : params.entrySet()) {
                        method.setParameter(entry.getKey(), ObjectUtils.toString(entry.getValue()));
                    }
				} else if(HTTP_METHOD_TYPE.POST_JSON.getName().equals(type.getName())){
					System.out.println(net.sf.json.JSONObject.fromObject(params).toString());
					method.setRequestEntity(new StringRequestEntity(net.sf.json.JSONObject.fromObject(params).toString(),"application/json",charset));
				}
                //设置请求头
                if (header != null) {

                    for (Map.Entry<String, Object> entry : header.entrySet()) {
                        method.setRequestHeader(entry.getKey(), ObjectUtils.toString(entry.getValue()));
                    }
                }

                httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(5000);
                httpClient.getHttpConnectionManager().getParams().setSoTimeout(20000);
                if (useProxy) {
                    Proxy proxy = ProxyManager.getProxy();
                    InetSocketAddress address = (InetSocketAddress) proxy.address();
                    String proxyHost = address.getHostName();
                    int proxyPort = address.getPort();
                    httpClient.getHostConfiguration().setProxy(proxyHost, proxyPort);
                }

                httpClient.executeMethod(method);
                ret = method.getResponseBodyAsString();
            } catch (Exception e) {
                LOG.error("fetch error for url=" + url);
                LOG.error("==> retry=" + retry);
                try {
                    Thread.sleep(3 * 1000L);
                } catch (Exception ex) {
                    e.printStackTrace();
                }
                e.printStackTrace();
            }
        }
        return ret;
    }

    private String fetchWithGet(String url, boolean useProxy, Map<String, Object> header,
                                String charset) throws IOException {
        GetMethod method = new GetMethod(url);
        method.getParams().setContentCharset(charset);
        if (header != null) {
	        for (Map.Entry<String, Object> entry : header.entrySet()) {
	            method.setRequestHeader(entry.getKey(), ObjectUtils.toString(entry.getValue()));
	        }
        }
        HttpClient httpClient = new HttpClient();
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(5000);
        httpClient.getHttpConnectionManager().getParams().setSoTimeout(20000);
        if (useProxy) {
            Proxy proxy = ProxyManager.getProxy();
            InetSocketAddress address = (InetSocketAddress) proxy.address();
            String proxyHost = address.getHostName();
            int proxyPort = address.getPort();
            httpClient.getHostConfiguration().setProxy(proxyHost, proxyPort);
        }

        httpClient.executeMethod(method);
        return method.getResponseBodyAsString();

    }

    public enum HTTP_METHOD_TYPE {
        POST, GET, POST_JSON;

        public String getName() {
            return this.name().toLowerCase();
        }
    }

    static class ProxyManager{
    	private static final Proxy proxy = new Proxy(Proxy.Type.DIRECT.HTTP, new InetSocketAddress(ParamsUtils.getString("proxy.host"), ParamsUtils.getInt("proxy.port")));
        public static Proxy getProxy(){
            return proxy;
        }
    }
    
    
    public static void main(String[] args) {
    	HttpClientTools toos  = new HttpClientTools();
    	//String fetch = toos.fetch("https://dev-mp-manage.100mi.com/Task/inDeiveProbeUser/secret/1556006611/mac_addr/11:22:33:44:55/user_num/3/stat_day/2019-04-28", HTTP_METHOD_TYPE.GET,false, null,
         //       null, "UTF-8", 1) ;
    	// 默认重试3次
    	String fetch = toos.fetch("https://dev-mp-manage.100mi.com/Task/inDeiveProbeUser/secret/1556006611/mac_addr/11:22:33:44:55/user_num/3/stat_day/2019-04-28",false);
    	System.out.println(fetch);
	}
}
