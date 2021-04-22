# Simple TOTP Authenticator

Actually, this is my first flutter application. After a while trying to figure out, I decided to code an TOTP App for replacing my current installed App Google Authenticator.

New TOTP accounts can be added via Setup page. As inputs, we have:
- Account name/description
- Seed key via direct input from keyboard, or also via QR Code Scanner
- Time-interval can be selected between 30/60/90/120/150/180s

The app was mostly tested for Android smartphone. I built an apk and installed this on my Android phone for using. 

A few things to be noticed and probably will be improved in the future:
- For QR Code Scanner, I am using "qr_code_scanner 0.4.0", including the example on the page. As just for scanning QR Code, I think, it works fine. Most of the time, the Camera screen does not display on the second time starting Scanner. But even it displays nothing, you can still be able to scanner the QR Code successfully.   
>https://pub.dev/packages/qr_code_scanner/versions/0.4.0-nullsafety.0
- I am using "shared_preferences" for storing accounts info. So you might lose all accounts when reinstalling the app. But it is extremly simple and fulfill all my current needs.

