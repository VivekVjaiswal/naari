package com.example.naari;
import io.flutter.embedding.android.FlutterActivity;
import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class CustomApplication extends FlutterApplication {

    @Override
    protected void attachBaseContext(android.content.Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
