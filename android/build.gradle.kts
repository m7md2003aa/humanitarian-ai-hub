buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Needed for the Google Services plugin (Firebase)
        classpath 'com.google.gms:google-services:4.4.2'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'dev.flutter.flutter-gradle-plugin'
    id 'com.google.gms.google-services'
}

android {
    namespace "com.example.humanitarian_ai_hub"      // <-- change to your package
    compileSdk 34

    defaultConfig {
        applicationId "com.example.humanitarian_ai_hub"  // <-- change to your package
        minSdk 23
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            // TODO: add signingConfig for Play release
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.9.10"
}


val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
