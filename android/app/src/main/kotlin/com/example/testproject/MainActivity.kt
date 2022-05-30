package com.example.testproject


import android.annotation.SuppressLint
import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec

@RequiresApi(Build.VERSION_CODES.KITKAT)
class MainActivity : FlutterActivity(),FlutterPlugin, MethodChannel.MethodCallHandler {
    lateinit var notificationChannel: NotificationChannel
    lateinit var notificationManager: NotificationManager
    lateinit var builder: Notification.Builder
    private val channelId = "12345"
    private val description = "Test Notification"
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as
                NotificationManager

        notificationChannel =
            NotificationChannel(channelId, description, NotificationManager.IMPORTANCE_HIGH)
    }
    private val CHANNEL = "samples.flutter.dev/createNotification"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->

            if (call.method == "create_alarm"){
                createAlarm()
            }else{
                result.notImplemented()
            }
        }
    }
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val taskQueue =
            flutterPluginBinding.binaryMessenger.makeBackgroundTaskQueue()
       val channel = MethodChannel(flutterPluginBinding.binaryMessenger,
            "com.example.testproject",
            StandardMethodCodec.INSTANCE,
            taskQueue)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    fun createAlarm() {
        btnNotify()
    }
    fun btnNotify() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notificationChannel.lightColor = Color.BLUE
            notificationChannel.enableVibration(true)
            notificationManager.createNotificationChannel(notificationChannel)
            builder = Notification.Builder(this, channelId)
                .setContentTitle("NOTIFICATION USING ")
                .setContentText("Test Notification")
                .setSmallIcon(R.drawable.alert_notify)
        }
        notificationManager.notify(12345, builder.build())
    }
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) { }
}
