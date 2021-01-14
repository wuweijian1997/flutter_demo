package com.example.flutter_demo

import android.util.Log
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*
import java.io.InputStream
import java.nio.ByteBuffer

class MainActivity : FlutterActivity() {
    private val methodChannelName = "flutter_demo/method_channel";
    private val eventChannelName = "flutter_demo/event_channel";
    private val basicMessageChannelName = "flutter_demo/basic_message_channel";

    private val jsonMessageChannelName = "flutter_demo/json_message_channel";
    private val binaryMessageChannelName = "flutter_demo/binary_message_channel";
    private val stringMessageChannelName = "flutter_demo/string_message_channel";

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
                    try {
                        val inputStream: InputStream = assets.open(message as String)
                        reply.reply(inputStream.readBytes())
                    } catch (e: Exception) {
                        reply.reply(null)
                    }
                }

        ///PetList
        val petList = mutableListOf<Map<String, String>>()
        val gson = Gson()

        /// String Message Channel
        val stringMessageChannel = BasicMessageChannel(flutterEngine.dartExecutor, stringMessageChannelName, StringCodec.INSTANCE)

        ///Json Message Channel
        BasicMessageChannel(flutterEngine.dartExecutor, jsonMessageChannelName, JSONMessageCodec.INSTANCE)
                .setMessageHandler { message, reply ->
                    petList.add(0, gson.fromJson(message.toString(),
                            object : TypeToken<Map<String, String>>() {}.type))
                    stringMessageChannel.send(gson.toJson(mapOf("petList" to petList)))
                }

        ///Binary Message Channel
        BasicMessageChannel(flutterEngine.dartExecutor, binaryMessageChannelName, BinaryCodec.INSTANCE)
                .setMessageHandler { message, reply ->
                    Log.d("BinaryMessageChannel", "message: $message")
                    val index = String(message!!.array()).toInt()
                    if (index >= 0 && index < petList.size) {
                        petList.removeAt(index)
                        val replyMessage = "Remove Successfully"
                        reply.reply(ByteBuffer.allocateDirect(replyMessage.toByteArray().size).put(replyMessage.toByteArray()))
                        stringMessageChannel.send(gson.toJson(mapOf("petList" to petList)))
                    }
                }
    }
}
