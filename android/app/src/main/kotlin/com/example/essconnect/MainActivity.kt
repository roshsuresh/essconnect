package com.gjinfotech.essconnect

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import com.easebuzz.flutter_kt_androidx_accesskey.JsonConverter
import com.easebuzz.payment.kit.PWECouponsActivity
import datamodels.PWEStaticDataModel
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL1 = "samples.flutter.dev/battery"
    private val CHANNEL = "easebuzz"
    private var channelResult: MethodChannel.Result? = null
    private var startPayment = true

    private fun startPayment(arguments: Any) {
        try {
            val gson = Gson()
            val parameters = JSONObject(gson.toJson(arguments))
            val intentProceed = Intent(this, PWECouponsActivity::class.java)
            intentProceed.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
            val keys: Iterator<*> = parameters.keys()
            while (keys.hasNext()) {
                val key = keys.next() as String
                val value = parameters.optString(key)
                if (key == "amount") {
                    val amount: Double = parameters.optDouble("amount")
                    intentProceed.putExtra(key, amount)
                } else {
                    intentProceed.putExtra(key, value)
                }
            }
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE)
        } catch (e: Exception) {
            startPayment = true
            val errorMap: MutableMap<String, Any> = HashMap()
            val errorDescMap: MutableMap<String, Any> = HashMap()
            val errorDesc = "Exception occurred: ${e.message}"
            errorDescMap["error"] = "Exception"
            errorDescMap["error_msg"] = errorDesc
            errorMap["result"] = PWEStaticDataModel.TXN_FAILED_CODE
            errorMap["payment_response"] = errorDescMap
            channelResult?.success(errorMap)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up MethodChannel for Easebuzz payment integration
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            channelResult = result
            if (call.method == "payWithEasebuzz") {
                if (startPayment) {
                    startPayment = false
                    startPayment(call.arguments)
                }
            }
        }

        // Set up MethodChannel for battery level
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL1).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == PWEStaticDataModel.PWE_REQUEST_CODE) {
            startPayment = true
            val response = JSONObject()
            val errorMap: MutableMap<String, Any> = HashMap()
            if (data != null) {
                val result = data.getStringExtra("result")
                val paymentResponse = data.getStringExtra("payment_response")
                try {
                    val obj = JSONObject(paymentResponse)
                    response.put("result", result)
                    response.put("payment_response", obj)
                    channelResult?.success(JsonConverter.convertToMap(response))
                } catch (e: Exception) {
                    val errorDescMap: MutableMap<String, Any> = HashMap()
                    errorDescMap["error"] = result.toString()
                    errorDescMap["error_msg"] = paymentResponse.toString()
                    errorMap["result"] = result.toString()
                    errorMap["payment_response"] = errorDescMap
                    channelResult?.success(errorMap)
                }
            } else {
                val errorDescMap: MutableMap<String, Any> = HashMap()
                errorDescMap["error"] = "Empty error"
                errorDescMap["error_msg"] = "Empty payment response"
                errorMap["result"] = "payment_failed"
                errorMap["payment_response"] = errorDescMap
                channelResult?.success(errorMap)
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(BATTERY_SERVICE) as android.os.BatteryManager
        return batteryManager.getIntProperty(android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
