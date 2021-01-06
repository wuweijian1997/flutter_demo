package com.example.flutter_demo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val counterChannel = "flutter_demo/counter";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, counterChannel).setMethodCallHandler { call, result ->
            val count: Int? = call.argument<Int>("count")
            if (count == null) {
                result.error("404", "count not be null", null);
            } else {
                when (call.method) {
                    "increment" -> result.success(count + 1)
                }
            }
        }
    }
}
