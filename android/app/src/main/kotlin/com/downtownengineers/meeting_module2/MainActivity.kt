package com.downtownengineers.meeting_module2

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
//import org.devio.flutter.splashscreen.SplashScreen


import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
//        SplashScreen.show(this, true) // here
        super.onCreate(savedInstanceState)
    }
   
}
