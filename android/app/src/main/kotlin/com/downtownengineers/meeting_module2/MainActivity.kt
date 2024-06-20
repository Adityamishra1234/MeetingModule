package com.downtownengineers.meeting_module2

import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragment

import org.devio.flutter.splashscreen.SplashScreen

import io.flutter.embedding.android.FlutterFragmentActivity

import android.view.View;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterView


class MainActivity : FlutterFragmentActivity() {
    private val delayMillis = 1L

    override fun onResume() {
        super.onResume()

        if (isSamsungAndroid13OrHigher()) {
            val handler = Handler(Looper.getMainLooper())
            handler.postDelayed({
                val flutterView = findViewById<FlutterView>(FlutterFragment.FLUTTER_VIEW_ID)
                flutterView?.requestLayout()
            }, delayMillis)
        }
    }

    private fun isSamsungAndroid13OrHigher(): Boolean {
        // Simplified logic for demonstration
        return Build.VERSION.SDK_INT >= 34 &&
                Build.MANUFACTURER.toLowerCase() == "samsung"
    }

       override fun onCreate(savedInstanceState: Bundle?) {
       SplashScreen.show(this, true) // here
        super.onCreate(savedInstanceState)
    }
}



//public class MyFlutterFragment extends FlutterFragment {
//    private static final long DELAY_MILLIS = 1;
//
//    @Override
//    public void onResume() {
//        super.onResume();
//
//        if (isSamsungAndroid13OrHigher()) {
//            Handler handler = new Handler(Looper.getMainLooper());
//            handler.postDelayed(new Runnable() {
//                @Override
//                public void run() {
//                    // Simulate calling requestLayout() on the FlutterView
//                    findViewById(FlutterFragment.FLUTTER_VIEW_ID)?.requestLayout();
//                }
//            }, DELAY_MILLIS);
//        }
//    }
//
//    private boolean isSamsungAndroid13OrHigher() {
//        // This is a simplified version that simulates the actual logic
//        // You can replace this with a more robust implementation
//        return android.os.Build.VERSION.SDK_INT >= 34 &&
//                android.os.Build.MANUFACTURER.toLowerCase().equals("samsung");
//    }
//
//
//       override fun onCreate(savedInstanceState: Bundle?) {
//       SplashScreen.show(this, true) // here
//        super.onCreate(savedInstanceState)
//    }
//}