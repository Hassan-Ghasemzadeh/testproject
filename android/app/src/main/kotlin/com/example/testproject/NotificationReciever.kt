package com.example.testproject

import android.app.Notification
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class NotificationReciever: BroadcastReceiver() {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onReceive(context: Context?, intent: Intent?) {
        val description = intent?.getStringExtra("description")
        val time = intent?.getLongExtra("EXTRA_EXACT_ALARM_TIME", 0L)
        when (intent?.action) {
            "ACTION_SET_EXACT_NOTIFICATION" -> {
                if (context != null) {
                    buildNotification(
                        context,
                        "$description  ${getDate(time)}",
                        "You have a task to do"
                    )
                }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    @Suppress("DEPRECATION")
    private fun buildNotification(
        context: Context,
        message: String,
        title: String,
    ) {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val builder = NotificationCompat.Builder(context, "Task_channel")
                .setSmallIcon(R.drawable.alert_notify)
                .setContentText(message)
                .setContentTitle(title)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)

            with(NotificationManagerCompat.from(context)) {
                notify(0, builder.build())
            }
        }else{
            val  builder = Notification.Builder(context, "Task_channel")
                .setContentText(message)
                .setContentTitle(title)
                .setSmallIcon(R.drawable.alert_notify)
            with(NotificationManagerCompat.from(context)) {
                notify(0, builder.build())
            }
        }
    }
}