package com.huyunit.flutter.flutter_oschina_demo;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

/**
 * @author: bobo
 * @createtime: 2019-07-26 17:46
 * @emial: jqbo84@163.com
 */
public class CallFlutterViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.a_call_flutterview);

//        Fragment flutterFragment = Flutter.createFragment("r2");
//        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
//        ft.add(R.id.content, flutterFragment);
//        ft.commit();
    }

}
