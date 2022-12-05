package com.example.flutter_demo

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

class AccelerometerStreamHandler(sManager: SensorManager, s: Sensor) : EventChannel.StreamHandler,
    SensorEventListener {
    private val sensorManager: SensorManager = sManager
    private val accelerometerSensor: Sensor = s
    private lateinit var eventSink: EventChannel.EventSink
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (events != null) {
            eventSink = events;
            sensorManager.registerListener(this, accelerometerSensor, SensorManager.SENSOR_DELAY_UI)
        }
    }

    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event != null) {
            val axisValues = listOf(event.values[0], event.values[1], event.values[2])
            eventSink.success(axisValues)
        } else {
            eventSink.error("data error", "error", null)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }
}