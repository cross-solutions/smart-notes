# Build app release (production) version.
#
# Run this script in the `src/app` directory.
#
# $APP_VERSIONNAME and $APP_VERSIONCODE are
# defined in the CI pipeline in Azure DevOps.

# Change current working directory to `src/app`
cd ..
cd "src/app"

echo "Building app version $APP_VERSIONNAME ($APP_VERSIONCODE)"

# Build Android APK
echo "Building Android..."

flutter build apk --build-name=$APP_VERSIONNAME --build-number=$APP_VERSIONCODE --target="lib/main_prod.dart"

# Build iOS APP
echo "Building iOS..."

flutter build ios --build-name=$APP_VERSIONNAME --build-number=$APP_VERSIONCODE --target="lib/main_prod.dart" --codesign