package com.android.applicaion

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    @Override
    protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FlutterKakaoMapPlugin.registerWith(registrarFor("com.yoonjaepark.flutter_kakao_map.FlutterKakaoMapPlugin"))
    }
}
