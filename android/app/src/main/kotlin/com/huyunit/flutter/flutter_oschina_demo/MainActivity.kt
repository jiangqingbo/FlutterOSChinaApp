package com.huyunit.flutter.flutter_oschina_demo

import android.os.Bundle
import com.huyunit.flutter.flutter_oschina_demo.plugin.FlutterPluginToActivity
import com.huyunit.flutter.flutter_oschina_demo.plugin.FlutterPluginToast

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.PluginRegistry

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    registerCustomPlugin(this)
  }

  private fun registerCustomPlugin(registrar: PluginRegistry) {
    FlutterPluginToast.registerWith(registrar.registrarFor(FlutterPluginToast.CHANNEL))
    FlutterPluginToActivity.registerWith(registrarFor(FlutterPluginToActivity.CHANNEL))
  }
}
