-keep class com.android.support.** { *; }
-keep class com.google.code.gson.** { *; }
-keep class com.squareup.retrofit2.** { *; }
-keep class com.squareup.okhttp3.** { *; }
-keep class com.squareup.retrofit2.** { *; }
-keep class org.apache.http.params.** { *; }
-keep class org.apache.http.conn.params.** { *; }
-keep class android.net.http.** { *; }
-keep class java.nio.file.** { *; }
-keep class org.codehaus.mojo.animal_sniffer.** { *; }
-keep class java.lang.invoke.** { *; }
-keep class sun.misc.** { *; }
-keep class com.android.org.conscrypt.** { *; }
-keep class org.apache.harmony.xnet.provider.jsse.** { *; }
-keep class sun.security.ssl.** { *; }
-keep class org.robovm.apple.foundation.** { *; }

-dontwarn org.apache.http.params.**
-dontwarn org.apache.http.conn.params.**
-dontwarn android.net.http.**
-dontwarn java.nio.file.**
-dontwarn org.codehaus.mojo.animal_sniffer.**
-dontwarn java.lang.invoke.**
-dontwarn sun.misc.**
-dontwarn com.android.org.conscrypt.**
-dontwarn org.apache.harmony.xnet.provider.jsse.**
-dontwarn sun.security.ssl.**
-dontwarn org.robovm.apple.foundation.**
-dontwarn org.robovm.apple.foundation.**
