## Getting started

1. Add `android:enableOnBackInvokedCallback="true"` to AndroidManifest.xml

This fixes

```
W/WindowOnBackDispatcher( 2369): OnBackInvokedCallback is not enabled for the application.
W/WindowOnBackDispatcher( 2369): Set 'android:enableOnBackInvokedCallback="true"' in the application manifest.
```