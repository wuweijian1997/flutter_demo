package com.example.flutter_demo

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, "flutter_demo/method_channel")
            .setMethodCallHandler { call, result ->
                val count: Int? = call.argument<Int>("count")
                if (count == null) {
                    result.error("INVALID ARGUMENT", "Value of count cannot be null", null)
                } else {
                    when (call.method) {
                        "increment" -> result.success(count + 1)
                        "decrement" -> result.success(count - 1)
                        else -> result.notImplemented()
                    }
                }
            }

        val sensorManger:SensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val accelerometerSensor: Sensor = sensorManger.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        EventChannel(flutterEngine.dartExecutor, "flutter_demo/event_channel")
            .setStreamHandler()
    }
}
