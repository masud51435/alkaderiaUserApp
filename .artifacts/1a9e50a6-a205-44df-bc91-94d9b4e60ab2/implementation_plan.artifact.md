# Fix Gradle and Java Compatibility Issue

The project is currently using Gradle 8.11.1 and AGP 8.9.1, which are incompatible with the Java 25 version used by Flutter. This plan upgrades the project to AGP 9.0.1 and Gradle 9.1.0 to restore compatibility.

## Proposed Changes

### Android Build Configuration

#### [MODIFY] [gradle-wrapper.properties](file:///D:/jamal-vai-project/foodnanny-customer-app/android/gradle/wrapper/gradle-wrapper.properties)
- Upgrade `distributionUrl` to use Gradle 9.1.0.

#### [MODIFY] [settings.gradle](file:///D:/jamal-vai-project/foodnanny-customer-app/android/settings.gradle)
- Upgrade the `com.android.application` plugin version to `9.0.1`.
- Upgrade the `org.jetbrains.kotlin.android` plugin version to `2.2.10` (compatible with AGP 9.0).

#### [MODIFY] [gradle.properties](file:///D:/jamal-vai-project/foodnanny-customer-app/android/gradle.properties)
- Add compatibility flags `android.newDsl=false` and `android.builtInKotlin=false` to ensure existing build scripts continue to work without extensive refactoring, as AGP 9.0 introduces major DSL changes and built-in Kotlin support.

## Verification Plan

### Manual Verification
- Run `flutter build apk` to verify that the compatibility error is resolved and the build completes successfully.
- Run `flutter doctor -v` again to ensure the toolchain is recognized correctly.
