



# Setup

## Nuance SpeechKit

Add `SpeechKit.framework` of Nuance into `lib`folder. Download it from their [website](https://developer.nuance.com//public/index.php?task=prodDev) .

## Configuration File

Create a file in the location `Fandango/Config/Constants.swift` containing following configurations:

```
struct Constants {
    static let HOST = "YOUR_HOST"
    static let PORT = 443
    static let USE_SSL = false
    static let APP_ID = "APP_ID"
    static let APP_KEY = [ 0x00 ]
}
```

## APP_KEY

Add your APP_KEY to the `Fandango/Voice/NuanceHeader.m`file, into the variable `SpeechKitApplicationKey`.
