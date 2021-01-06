package com.example.flutter_demo

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import java.io.InputStream

class MainActivity : FlutterActivity() {
    private val methodChannelName = "flutter_demo/method_channel";
    private val eventChannelName = "flutter_demo/event_channel";
    private val basicMessageChannelName = "flutter_demo/basic_message_channel";
    private lateinit var eventChannel: EventChannel
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName)
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "increment" -> {
                    val count: Int? = call.argument<Int>("count")
                    if (count == null) {
                        result.error("404", "count not be null", null);
                    } else {
                        result.success(count + 1)
                    }
                }
                "decrement" -> {
                    val count: Int? = call.argument<Int>("count")
                    if (count == null) {
                        result.error("404", "count not be null", null);
                    } else {
                        // Android 调用 Flutter
                        methodChannel.invokeMethod("increment", count - 1)
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
        BasicMessageChannel(flutterEngine.dartExecutor, basicMessageChannelName, StandardMessageCodec())
                .setMessageHandler { message, reply ->

                    if (assets.locales.contains(message)) {
                        val inputStream: InputStream = assets.open(message as String)
                        reply.reply(inputStream.readBytes())
                    }
                }
    }
}
