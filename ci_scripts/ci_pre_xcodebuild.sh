#!/bin/sh

#  ci_pre_xcodebuild.sh
#  History Republic
#
#  Created by Andy Heredia on 26/7/25.
#  

echo 'Change Beta App Icon'

APP_ICON_PATH="$CI_PRIMARY_REPOSITORY_PATH/History\ Republic/Assets.xcassets/AppIcon.appiconset"

echo $APP_ICON_PATH

rm -rf $APP_ICON_PATH

mv "$CI_PRIMARY_REPOSITORY_PATH/ci_script/AppIcon-Beta.appiconset" $APP_ICON_PATH

