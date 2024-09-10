package com.example.sendbird_test

import android.content.Context
import androidx.annotation.NonNull

import com.sendbird.calls.*
import com.sendbird.calls.DirectCall
import com.sendbird.calls.RoomInvitation
import com.sendbird.calls.SendBirdCall.addListener
import com.sendbird.calls.SendBirdCall.dial
import com.sendbird.calls.SendBirdCall.init
import com.sendbird.calls.SendBirdCall.ongoingCallCount
import com.sendbird.calls.SendBirdCall.removeAllListeners
import com.sendbird.calls.handler.AuthenticateHandler
import com.sendbird.calls.handler.DialHandler
import com.sendbird.calls.handler.DirectCallListener
import com.sendbird.calls.handler.SendBirdCallListener

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.util.*


class MainActivity : FlutterActivity() {
    private val channelName = "sendbird"

    private var methodChannel: MethodChannel? = null
    private var directCall: DirectCall? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)

        methodChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "init") {
                if (SendBirdCall.init(this, call.argument("appId")!!)) {
                    removeAllListeners()
                    addListener(
                        UUID.randomUUID().toString(),
                        object : SendBirdCallListener() {
                            override fun onInvitationReceived(invitation: RoomInvitation) {}

                            override fun onRinging(call: DirectCall) {
                                println("onRinging")

                                directCall = call
                                call.setListener(object : DirectCallListener() {
                                    override fun onEstablished(call: DirectCall) {
                                        println("onEstablished")

                                    }

                                    override fun onConnected(call: DirectCall) {
                                        println("onConnected")

                                    }

                                    override fun onEnded(call: DirectCall) {
                                        println("onEnded")

                                    }

                                    override fun onRemoteAudioSettingsChanged(call: DirectCall) {
                                        println("onRemoteAudioSettingsChanged")
                                    }
                                })
                            }
                        })
                }
                result
            } else if (call.method == "authenticate") {

                var params = AuthenticateParams(call.argument("userId")!!)
                SendBirdCall.authenticate(params, object : AuthenticateHandler {
                    override fun onResult(user: User?, e: SendBirdException?) {
                        if (e == null) {
                            // User is authenticated.
                            println("authenticatd")
                        }

                    }
                })
                result
            } else if (call.method == "call") {
                val callee: String = call.argument("callee")!!
                var params: DialParams = DialParams(callee)
                params.setCallOptions(CallOptions())

                directCall = dial(params, object : DialHandler {
                    override fun onResult(call: DirectCall?, e: SendBirdException?) {
                        if (e == null) {
                            // Called successfully.
                        }
                    }
                })

                result
            } else if (call.method == "receiveCall") {
                directCall?.accept(AcceptParams())
                result
            } else if (call.method == "endCall") {
                directCall?.end();
                result
            } else {
                result
            }
        }
    }
}
