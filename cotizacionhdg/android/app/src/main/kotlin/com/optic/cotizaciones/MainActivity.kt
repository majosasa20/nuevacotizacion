package com.optic.cotizaciones

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Configuración de Microsoft App Center
        AppCenter.start(application, "{Your app secret here}",
            Analytics::class.java, Crashes::class.java)
    }
}
