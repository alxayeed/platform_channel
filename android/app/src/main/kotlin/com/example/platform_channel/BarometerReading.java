package com.example.platform_channel;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import io.flutter.plugin.common.EventChannel;

public class BarometerReading implements EventChannel.StreamHandler, SensorEventListener {
    private SensorManager sensorManager;
    private Sensor barometer;
    private float latestReading = 0;
    private EventChannel.EventSink barometerEventSink;

    public void init(Context context){
        sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        barometer = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE);
        sensorManager.registerListener(this, barometer, SensorManager.SENSOR_DELAY_NORMAL);
    }


    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        barometerEventSink = events;

    }

    @Override
    public void onCancel(Object arguments) {
        barometerEventSink = null;
    }

    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        latestReading = sensorEvent.values[0];
        if(barometerEventSink !=null){
            barometerEventSink.success(latestReading);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {

    }


}
