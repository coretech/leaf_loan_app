package com.leafglobalfintech.loanapp

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*
import kotlinx.coroutines.*
import kotlin.coroutines.*

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.annotation.SuppressLint
import android.os.Build

import credoapp.CredoAppResult
import credoapp.CredoAppService
import credoapp.module.account.RegisterAccountModule
import credoapp.module.calendar.CalendarModule
import credoapp.module.contact.ContactModule
import credoapp.module.iovation.FraudForceModule
import credoapp.module.media.MediaModule
import java.util.*

class MainActivity : FlutterActivity() {
    lateinit var credoAppService: CredoAppService

    private val CHANNEL = "com.leafglobal.loanapp/credolabs"

    // The scope for the UI thread
    private val mainScope = CoroutineScope(Dispatchers.Main)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "submitCredoLabsData") {

                val authKey: String = call.argument("authKey")!!;
                val referenceNumber: String = call.argument("referenceNumber")!!;
                val url: String = call.argument("url")!!;
                mainScope.launch {
                    withContext(Dispatchers.IO) {
                        try {
                            val storedReferenceNumber = submitCredoLabsData(authKey, referenceNumber, url)
                            runOnUiThread {
                                result.success(storedReferenceNumber!!)
                            }
                        } catch (e: Exception) {
                            runOnUiThread {
                                result.error("Error", e.message, e)
                            }
                        }
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }

    suspend fun submitCredoLabsData(authKey: String, referenceNumber: String, url: String): String? {
        var storedReferenceNumber: String?
        val context = applicationContext
        // create an instance of CredoAppService
        if (::credoAppService.isInitialized.not())
            credoAppService = CredoAppService.Builder(context, url, authKey)
                    .addModule(CalendarModule())
                    .addModule(ContactModule())
                    .addModule(MediaModule())
                    .addModule(RegisterAccountModule())
                    .addModule(FraudForceModule())
                    .build()

        // Collects and uploads data from phone to the CredoLab web-service
        storedReferenceNumber = when (val result = credoAppService.execute(referenceNumber)) {
            is CredoAppResult.Success -> result.value
            is CredoAppResult.Error -> throw Exception("${result.message} ${result.code}")
        }
        return storedReferenceNumber
    }

}
