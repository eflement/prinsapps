package org.flement.model;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class EmailAddress {

    private static Properties props;
    private static final EmailAddress instance = new EmailAddress();

    /**
     * Private constructor that loads the emailaddresses from the properties file, called when the class is detected
     */
    private EmailAddress() {
        try {
            props = new Properties();
            InputStream inputStream = this.getClass().getClassLoader()
                    .getResourceAsStream("resources/emailAddresses.properties");
            props.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns the email corresponding to the given key
     * @param key the key to search for
     * @return  the emailaddress or <code>null</code> if no emailaddress was found
     */
    public static String get(String key){
        if(props != null && props.containsKey(key)){
            return props.getProperty(key);
        } else {
            return null;
        }
    }
}
