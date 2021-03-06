export PATH="$PATH:/Users/kirill/dev/flutter/bin"
flutter build ios --release --no-codesign --config-only

cd ios
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FASTLANE_USER=kirill1998fed@yandex.ru
export FASTLANE_PASSWORD=fkmlbyf18021998F
export FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=chxm-qwcy-tlef-qdox

fastlane ios upload_to_tf version_number:$1 build_number:$2 
