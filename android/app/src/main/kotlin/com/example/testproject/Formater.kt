package com.example.testproject

import android.os.Build
import androidx.annotation.RequiresApi
import java.text.DateFormat
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*

const val DATE_FORMAT = "d-MM-yyyy hh:mm"
const val DATE_FORMAT_HOUR_MINUTE = "hh:mm aaa"
const val DATE_FORMAT_YEAR_MONTH_DAY = "MM-d-yyyy"
@RequiresApi(Build.VERSION_CODES.O)
fun getDateInMilliSeconds(dateString: String): Long {
    val sdf = SimpleDateFormat(DATE_FORMAT, Locale.ENGLISH)
    val date = sdf.parse(dateString)
    return date.time
}
fun getDateInMilliSecondsForCal(dateString: String): Long {
    val sdf = SimpleDateFormat(DATE_FORMAT_YEAR_MONTH_DAY, Locale.ENGLISH)
    val date = sdf.parse(dateString)
    return date.time
}
/**
 * Return date in specified format.
 * @param timeInMilliseconds Date in milliseconds
 * @return String representing date in specified format
 */
fun getDate(timeInMilliseconds: Long?): String {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && timeInMilliseconds != null) {
        val formatter = SimpleDateFormat(DATE_FORMAT, Locale.US)
        val calendar = Calendar.getInstance()
        calendar.timeInMillis = timeInMilliseconds
        formatter.format(calendar.time)
    } else {
        // getDateTimeInstance will use it's default DATE_FORMAT to convert
        DateFormat.getDateTimeInstance().format(timeInMilliseconds?.let { Date(it) })
    }
}
fun getDateForCalendar(timeInMilliseconds: Long?): String {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && timeInMilliseconds != null) {
        val formatter = SimpleDateFormat(DATE_FORMAT_YEAR_MONTH_DAY, Locale.US)
        val calendar = Calendar.getInstance()
        calendar.timeInMillis = timeInMilliseconds
        formatter.format(calendar.time)
    } else {
        // getDateTimeInstance will use it's default DATE_FORMAT to convert
        DateFormat.getDateTimeInstance().format(timeInMilliseconds?.let { Date(it) })
    }
}
fun getDateJustHourMinute(timeInMilliseconds: Long?): String {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && timeInMilliseconds != null) {
        val formatter = SimpleDateFormat(DATE_FORMAT_HOUR_MINUTE, Locale.US)
        val calendar = Calendar.getInstance()
        calendar.timeInMillis = timeInMilliseconds
        formatter.format(calendar.time)
    } else {
        // getDateTimeInstance will use it's default DATE_FORMAT to convert
        DateFormat.getDateTimeInstance().format(timeInMilliseconds?.let { Date(it) })
    }
}

fun getCurrentDate(): Long {
    var date = Date()
    val sdf = SimpleDateFormat(DATE_FORMAT, Locale.US)
    try {
        date = sdf.parse(DATE_FORMAT) as Date
    } catch (e: ParseException) {
        e.printStackTrace()
    }
    return date.time
}

fun getCurrentDateForCalendar(): Long {
    var date = Date()
    val sdf = SimpleDateFormat(DATE_FORMAT_YEAR_MONTH_DAY, Locale.US)
    try {
        date = sdf.parse(DATE_FORMAT) as Date
    } catch (e: ParseException) {
        e.printStackTrace()
    }
    return date.time
}

//all together
fun getCurrentDateInString(): String {
    val calendar = Calendar.getInstance()
    val simpleDateFormat = SimpleDateFormat("E.LLLL.yyyy", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

//Day in String (full form. Ex: Monday)
fun getToday(): String {
    val calendar = Calendar.getInstance()
    val simpleDateFormat = SimpleDateFormat("EEEE ", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

fun getToday(date: Long): String {
    val calendar = Calendar.getInstance()
    calendar.timeInMillis = date
    val simpleDateFormat = SimpleDateFormat("EEEE ", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

//Date in numeric value
fun getTodayNumeric(): String {
    val calendar = Calendar.getInstance()
    val simpleDateFormat = SimpleDateFormat("dd", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

fun getTodayNumeric(date: Long): String {
    val calendar = Calendar.getInstance()
    calendar.timeInMillis = date
    val simpleDateFormat = SimpleDateFormat("dd", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

//Month in String (full form. Ex: March)
fun getTodayMonth(): String {
    val calendar = Calendar.getInstance()
    val simpleDateFormat = SimpleDateFormat(" LLLL", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}

fun getTodayMonth(date: Long): String {
    val calendar = Calendar.getInstance()
    calendar.timeInMillis = date
    val simpleDateFormat = SimpleDateFormat(" LLLL", Locale.US)
    return simpleDateFormat.format(calendar.time).toString()
}