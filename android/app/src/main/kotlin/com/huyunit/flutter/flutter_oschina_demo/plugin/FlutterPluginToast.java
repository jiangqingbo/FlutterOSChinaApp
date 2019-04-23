package com.huyunit.flutter.flutter_oschina_demo.plugin;

import android.content.Context;
import android.widget.TextView;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * author: bobo
 * create time: 2019/4/22 5:01 PM
 * email: jqbo84@163.com
 */
public class FlutterPluginToast implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = "com.huyunit.flutter.flutter_oschina_demo/flutter_toast";

    private Context mContext;
    private Toast mToast;

    public FlutterPluginToast(Context mContext) {
        this.mContext = mContext;
    }

    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new FlutterPluginToast(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("showToast")) {
            String msg = call.argument("msg");
            String duration = call.argument("duration");//long or short
            Number textColor = call.argument("textColor");
            Number textSize = call.argument("textSize");

            mToast = Toast.makeText(mContext, "", Toast.LENGTH_SHORT);
            //set text
            if (msg != null) {
                mToast.setText(msg);
            }
            //set duration
            if (duration != null && duration.equals("long")) {
                mToast.setDuration(Toast.LENGTH_LONG);
            } else {
                mToast.setDuration(Toast.LENGTH_SHORT);
            }
            //set styles
            TextView textView = (TextView) mToast.getView().findViewById(android.R.id.message);
            //set text color
            if (textView != null) {
                textView.setTextColor(textColor.intValue());
            }
            //set text size
            if (textView != null) {
                textView.setTextSize(textSize.floatValue());
            }
            mToast.show();
        } else {
            result.notImplemented();
        }
    }

}
