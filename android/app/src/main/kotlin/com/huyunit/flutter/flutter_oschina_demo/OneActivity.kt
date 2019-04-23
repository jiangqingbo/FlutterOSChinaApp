package com.huyunit.flutter.flutter_oschina_demo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.a_one.*

/**
 * author: bobo
 * create time: 2019/4/23 9:38 AM
 * email: jqbo84@163.com
 */
class OneActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.a_one)
        mGoFlutterView?.setOnClickListener {
            this.finish();
        }
    }
}