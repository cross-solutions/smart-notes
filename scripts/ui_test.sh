# Runs ui/integration test using Flutter Driver
#
# Run this script in the `src/app` directory
#
# Change current working directory to `src/app`
cd "src/app"

# Install AVD files
echo "y" | $ANDROID_HOME/tools/bin/sdkmanager --install 'system-images;android-29;google_apis;x86'

# Create Android emulator
echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n android_29_emulator -k 'system-images;android-29;google_apis;x86' --device 14 --force

$ANDROID_HOME/tools/bin/avdmanager list avd

echo "Starting emulator"

# Start emulator in background
nohup $ANDROID_HOME/emulator/emulator -avd android_29_emulator -no-snapshot > /dev/null 2>&1 &
$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

$ANDROID_HOME/platform-tools/adb devices

echo "Emulator started"

echo "Starting Flutter Driver"

flutter drive test_driver/ui.dart