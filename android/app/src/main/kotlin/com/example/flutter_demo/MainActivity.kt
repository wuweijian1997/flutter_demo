package com.example.flutter_demo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val methodChannelName = "flutter_demo/method_channel";
    private val eventChannelName = "flutter_demo/event_channel";
    private lateinit var eventChannel : EventChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "increment" -> {
                    val count: Int? = call.argument<Int>("count")
                    if (count == null) {
                        result.error("404", "count not be null", null);
                    } else {
                        result.success(count + 1)
                    }
                }
                "start_countdown" -> {
                    val count: Int? = call.argument<Int>("count")
                    if (count == null) {
                        result.success(false);
                    } else {
                        result.success(true);
                        eventChannel.setStreamHandler(CountdownHandle(count))
                    }
                }
            }
        }
        eventChannel = EventChannel(flutterEngine.dartExecutor, eventChannelName)
    }
}
