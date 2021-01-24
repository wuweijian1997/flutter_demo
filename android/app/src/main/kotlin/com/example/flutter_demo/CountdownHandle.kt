package com.example.flutter_demo

import android.os.Handler
import android.os.Message
import io.flutter.plugin.common.EventChannel
import java.util.*

class CountdownHandle(private var count: Int) : EventChannel.StreamHandler {
    private lateinit var eventSink: EventChannel.EventSink
    private val timer: Timer= Timer()
    val handle = object : Handler() {
        override fun handleMessage(msg: Message) {
            when (msg.what) {
                0 -> eventSink.success(msg.arg1)
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (events != null && count > 0) {
            eventSink = events
            start()
        }
    }

    private fun start() {
        timer.schedule(object:TimerTask(){
            override fun run() {
                if (count < 0) {
                    timer.cancel()
                } else {
                    count -= 1
                    /// 这里直接用 `eventSink.success(count)` 会报错.java.lang.RuntimeException: Methods marked with @UiThread must be executed ...
                    val msg = Message()
                    msg.what = 0
                    msg.arg1 = count
                    handle.sendMessage(msg)
                }
            }
        }, 0,1000)
    }

    override fun onCancel(arguments: Any?) {
        timer.cancel()
    }
}
