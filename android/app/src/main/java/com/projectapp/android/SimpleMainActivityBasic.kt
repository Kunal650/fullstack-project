package com.projectapp.android

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView
import android.widget.Button
import android.widget.LinearLayout
import android.view.ViewGroup
import android.widget.Toast

class SimpleMainActivityBasic : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Create a simple layout programmatically
        val layout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(32, 32, 32, 32)
        }
        
        // Add title
        val title = TextView(this).apply {
            text = "Welcome to ProjectApp"
            textSize = 24f
            setPadding(0, 0, 0, 32)
        }
        layout.addView(title)
        
        // Add description
        val description = TextView(this).apply {
            text = "Your full-stack mobile application built with modern technologies:\n\n" +
                   "• Web Platform (Django + HTML/CSS/JS)\n" +
                   "• Android App (Native Kotlin)\n" +
                   "• iOS App (Native Swift)\n" +
                   "• PostgreSQL Database"
            textSize = 16f
            setPadding(0, 0, 0, 32)
        }
        layout.addView(description)
        
        // Add login button
        val loginButton = Button(this).apply {
            text = "Login"
            setOnClickListener {
                Toast.makeText(this@SimpleMainActivityBasic, "Login clicked!", Toast.LENGTH_SHORT).show()
            }
        }
        layout.addView(loginButton)
        
        // Add register button
        val registerButton = Button(this).apply {
            text = "Register"
            setOnClickListener {
                Toast.makeText(this@SimpleMainActivityBasic, "Register clicked!", Toast.LENGTH_SHORT).show()
            }
        }
        layout.addView(registerButton)
        
        setContentView(layout)
    }
}
