@echo off
echo Migrating Flutter project to new Gradle structure...

REM Copy lib folder
echo Copying lib folder...
xcopy /E /I lib temp_project\lib

REM Copy assets
echo Copying assets...
xcopy /E /I assets temp_project\assets

REM Update pubspec.yaml
echo Updating pubspec.yaml...
copy pubspec.yaml temp_project\pubspec.yaml

echo Migration completed!
echo You can now cd into temp_project and run "flutter pub get" to update dependencies
echo Then run "flutter build apk" to build your APK 