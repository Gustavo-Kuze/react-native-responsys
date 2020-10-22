# Responsys React Native

An honest react native project to bridge Oracle Responsys SDK.

**DISCLAIMER:** **This** package is a fork of [react-native-responsys](https://github.com/juntossomosmais/react-native-responsys), which doesn't have an ios version implemented. All the rights regarding the Android parts of this package's code, as well as the react native bridge base goes to "justossomosmais".

## How to setup your project

First install this native module:

    npm install responsys-react-native

React Native does automatic linking from 0.60 version onwards, but if you're using an older version, then do the following:

    react-native link responsys-react-native


## Manual Installation
If your are using a React Native version older than 0.60, then follow the steps:

### iOS

1. Make sure you have the following pod installed in your `PodFile`:

```
pod 'RNResponsysBridge', :path => '../node_modules/responsys-react-native/ios'
```

2. Run `pod install` inside the `ios` project subfolder

_____

### Android


1. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
   ```
     implementation project(':juntossomosmais_react-native-responsys')
   ```
2. Open up `android/app/src/main/java/[...]/MainActivity.java`

- Add `import br.com.juntossomosmais.reactnative.responsys.RNResponsysBridgePackage;` to the imports at the top of the file
- Add `new RNResponsysBridgePackage()` to the list returned by the `getPackages()` method

---

Add the following in your `AndroidManifest.xml`:

```xml
    .....
    <!-- Do not forget to follow Oracle Responsys documentation regarding permissions -->
    .....
    <!-- Permission for your app to handle push notifications -->
    <permission
        android:name="${applicationId}.permission.PUSHIO_MESSAGE"
        android:protectionLevel="signature" />
    <uses-permission android:name="${applicationId}.permission.PUSHIO_MESSAGE"/>

    <application ....>
        <!-- Do not forget to follow Oracle Responsys documentation -->
        <service
            android:name="br.com.juntossomosmais.reactnative.responsys.RNResponsysBridgeListenerService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>

        <!-- Add this inside the activity that will open when the user clicks the push notification -->
         <intent-filter>
            <action android:name="${applicationId}.NOTIFICATIONPRESSED"/>
            <category android:name="android.intent.category.DEFAULT"/>
        </intent-filter>

      <!-- Add this receiver right before application closing -->
      <receiver
          android:name="com.pushio.manager.PushIOBroadcastReceiver"
          android:permission="com.google.android.c2dm.permission.SEND">
          <intent-filter>
              <action  android:name="com.google.android.c2dm.intent.RECEIVE" />
              <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
              <category android:name="${applicationId}" />
          </intent-filter>
      </receiver>
    </application>

     .....
```

### Notification Icon

For Android, you just need to put an icon called `ic_notification` inside `res/drawable`.
You can use [this tool](http://romannurik.github.io/AndroidAssetStudio/icons-notification.html#source.type=image&source.space.trim=1&source.space.pad=0&name=ic_notification) to gereate your notification icon

### Oracle Setup

In order to use it, you must follow Oracle guide to configure either for Android and iOS:

- [Steps to configure your Android project](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCFB/android/step-by-step/)
- [Steps to configure your iOS project](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCFB/ios/step-by-step/)

## How to receive push notifications

In case you have multiple push SDKs (sample with Firebase Messaging):

```javascript
import firebase from 'react-native-firebase'
import ResponsysBridge from 'responsys-react-native'

const messaging = firebase.messaging()

messaging
  .getToken()
  .then((token) => {
    ResponsysBridge.configureDeviceToken(token)
    const useLocation = false
    ResponsysBridge.registerApp(useLocation)
  })
  .catch((e) => {
    console.error(`Something went wrong with your setup: ${e}`)
  })
```

Or simply:

```javascript
import ResponsysBridge from 'responsys-react-native'

const useLocation = false
ResponsysBridge.registerApp(useLocation)
```

## Useful links

Regarding Oracle Responsys:

- [Organization which has all repositories related to Oracle Marketing Cloud](https://github.com/pushio)
- [Android SDK (Push IO Manager)](https://github.com/pushio/PushIOManager_Android)
- [Everything related to Android integration](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCFB/android/)
- [iOS SDK (Push IO Manager)](https://github.com/pushio/PushIOManager_iOS)
- [Everything related to iOS integration](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCFB/ios/)

Native Module:

- [Modules for iOS](https://facebook.github.io/react-native/docs/native-modules-ios)
- [Modules for Android](https://facebook.github.io/react-native/docs/native-modules-android)
- [Swift in React Native - The Ultimate Guide Part 1: Modules](https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-1-modules-9bb8d054db03)

## How to setup your development environment

You should use Node v12.13.1

After downloading this project, you can execute in the root folder:

    npm install

After it, using IntelliJ open the folder [android](android) to start to work. For iOS is the same logic, using AppCode open the folder [ios](ios).

## Important notice

The purpose of this App and even this README is not fully closed.
