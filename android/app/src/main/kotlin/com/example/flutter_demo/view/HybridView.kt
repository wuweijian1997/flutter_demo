package com.example.flutter_demo.view

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

internal class HybridView(context: Context, id: Int, creationParams: Map<String?, Any?>?) :
    PlatformView {
    private val textView: TextView
    override fun getView(): View {
        return textView
    }

    override fun dispose() {
    }

    init {
        textView = TextView(context)
        textView.textSize = 72f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "HybridView"
    }
}