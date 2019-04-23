package com.huyunit.flutter.flutter_oschina_demo.plugin;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.huyunit.flutter.flutter_oschina_demo.OneActivity;
import com.huyunit.flutter.flutter_oschina_demo.TwoActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * author: bobo
 * create time: 2019/4/23 9:25 AM
 * email: jqbo84@163.com
 */
public class FlutterPluginToActivity implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = "com.huyunit.flutter.flutter_oschina_demo/flutter_to_activity";

    private Activity mActivity;

    public FlutterPluginToActivity(Activity activity) {
        this.mActivity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new FlutterPluginToActivity(registrar.activity()));
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

        //接收来自flutter的指令oneAct
        if (call.method.equals("oneActivity")) {

            //跳转到指定Activity
            Intent intent = new Intent(mActivity, OneActivity.class);
            mActivity.startActivity(intent);

            //返回给flutter的参数
            result.success("1.success");
        }
        //接收来自flutter的指令twoAct
        else if (call.method.equals("twoActivity")) {

            //解析参数
            String text = call.argument("flutter");

            Log.e("bobo", text);
            //带参数跳转到指定Activity
            Intent intent = new Intent(mActivity, TwoActivity.class);
            intent.putExtra(TwoActivity.VALUE, text);
            mActivity.startActivity(intent);

            //返回给flutter的参数
            result.success("2.success");
        } else {
            result.notImplemented();
        }
    }

}
