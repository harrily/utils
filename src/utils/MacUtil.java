package utils;

import java.util.regex.Pattern;
import org.apache.commons.lang.StringUtils;

public class MacUtil {
    public static final String patternSrcMac = "^[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}$";
    public static final String patternSrcMacAndSign = "^[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+::-[0-9]{2}$";
    public static final String patternSimpleMac = "^[a-fA-F0-9]{12}$";
    public static final Pattern srcMacPattern = Pattern.compile("^[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}$");
    public static final Pattern srcMacAndSignPattern = Pattern.compile("^[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+::-[0-9]{2}$");
    public static final Pattern simpleMacPattern = Pattern.compile("^[a-fA-F0-9]{12}$");
    private static final String MAO_HAO = ":";

    public MacUtil() {
    }

    public static boolean isNotPrivateMac(String mac) {
        String simpleMac = getSimpleMac(mac);
        if(simpleMac != null) {
            String t2 = mac.substring(0, 2);
            long value = Long.parseLong(t2, 16);
            if(value % 2L == 0L) {
                return true;
            }
        }

        return false;
    }

    public static boolean isSrcMac(String mac) {
        return srcMacPattern.matcher(mac).find();
    }

    public static boolean isSrcMacAndSign(String mac) {
        return srcMacAndSignPattern.matcher(mac).find();
    }

    public static boolean isSimpleMac(String mac) {
        return simpleMacPattern.matcher(mac).find();
    }

    public static String getSimpleMac(String mac) {
        if(StringUtils.isNotBlank(mac)) {
            if(srcMacPattern.matcher(mac).find()) {
                return mac.toLowerCase().replace(":", "");
            }

            if(simpleMacPattern.matcher(mac).find()) {
                return mac.toLowerCase();
            }

            if(srcMacAndSignPattern.matcher(mac).find()) {
                String srcMac = mac.split("::")[0];
                return srcMac.toLowerCase().replace(":", "");
            }
        }

        return null;
    }

    public static String getSrcMac(String mac) {
        if(StringUtils.isNotBlank(mac)) {
            if(srcMacPattern.matcher(mac).find()) {
                return mac.toLowerCase();
            }

            if(simpleMacPattern.matcher(mac).find()) {
                StringBuffer sb = new StringBuffer();
                sb.append(mac.substring(0, 2));
                sb.append(":");
                sb.append(mac.substring(2, 4));
                sb.append(":");
                sb.append(mac.substring(4, 6));
                sb.append(":");
                sb.append(mac.substring(6, 8));
                sb.append(":");
                sb.append(mac.substring(8, 10));
                sb.append(":");
                sb.append(mac.substring(10, 12));
                return sb.toString().toLowerCase();
            }

            if(srcMacAndSignPattern.matcher(mac).find()) {
                return mac.split("::")[0].toLowerCase();
            }
        }

        return null;
    }

    public static void main(String[] args) {
        System.out.println(getSrcMac("F0:1B:6C:D4:DF:10::-78"));
        System.out.println(getSrcMac("F0:1B:6C:D4:DF:10"));
        System.out.println(getSrcMac("F01B6CD4DF10"));
        System.out.println(getSimpleMac("F0:1B:6C:D4:DF:10::-78"));
        System.out.println(getSimpleMac("F0:1B:6C:D4:DF:10"));
        System.out.println(getSimpleMac("F01B6CD4DF10"));
        System.out.println(isNotPrivateMac("60d9c7409278"));
        System.out.println(isNotPrivateMac("F0:1B:6C:D4:DF:10"));
        System.out.println(isNotPrivateMac("000822f8eaa5"));
        System.out.println(isNotPrivateMac("000000000000"));
    }
}
