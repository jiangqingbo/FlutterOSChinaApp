package com.huyunit.flutter.flutter_oschina_demo;

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

/**
 * author: bobo
 * create time: 2019/4/23 9:32 AM
 * email: jqbo84@163.com
 */
public class TwoActivity extends AppCompatActivity {

    private TextView mTextView;

    public static final String VALUE = "value";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.a_two);

        mTextView = findViewById(R.id.text);

        String text = getIntent().getStringExtra(VALUE);

        Log.e("bobo", "value: " + text);

        mTextView.setText(text);

        findViewById(R.id.mGoFlutterView).setOnClickListener(v -> finish());
    }

}
