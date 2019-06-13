package my_test;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Properties;

public class ParamsUtils {
    private static final Logger logger = Logger.getLogger(ParamsUtils.class);
    public static Properties properties = null;

    public ParamsUtils() {
    }

    public static int getInt(String key) {
        if(properties == null) {
            init();
        }
        String property = properties.getProperty(key);
        if (property.startsWith("0x")) {
			return Integer.parseInt(property.substring(2),16);
		} else{
			return Integer.parseInt(property);
		}
    }

    public static byte getByte(String key) {
        if(properties == null) {
            init();
        }
        return Byte.parseByte(properties.getProperty(key));
    }
    
    public static long getLong(String key) {
        if(properties == null) {
            init();
        }

        return Long.parseLong(properties.getProperty(key));
    }

    public static int getInt(String key, int defaultValue) {
        if(properties == null) {
            init();
        }

        return properties.get(key) == null?defaultValue:Integer.parseInt(properties.getProperty(key));
    }

    public static String getString(String key) {
        if(properties == null) {
            init();
        }

        return properties.getProperty(key);
    }

    public static String getString(String key, String defaultValue) {
        if(properties == null) {
            init();
        }

        return properties.getProperty(key, defaultValue);
    }

    public static void init() {
        properties = new Properties();

        try {
            properties.load(ParamsUtils.class.getResourceAsStream("/bm-streaming-conf.properties"));
            logger.info("-- 配置文件加载成功！ --");
        } catch (IOException var1) {
            logger.warn("初始化配置文件错误！" + var1);
        }

    }
}
