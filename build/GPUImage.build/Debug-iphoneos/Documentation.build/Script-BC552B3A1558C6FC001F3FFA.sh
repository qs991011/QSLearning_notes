#!/bin/sh
# docsetutil was moved in Xcode 4.3
# if you're using Xcode 4.2 or earlier, remove --docsetutil-path
"${APPLEDOC_PATH}" \
--project-name "GPUImage" \
--project-company "Sunset Lake Software" \
--company-id "com.sunsetlakesoftware" \
--output "${SOURCE_ROOT}/../documentation" \
--keep-undocumented-objects \
--keep-undocumented-members \
--create-html \
--install-docset \
--keep-intermediate-files \
--no-repeat-first-par \
--exit-threshold 9999 \
--clean-output \
--ignore .m \
--logformat xcode \
"${SOURCE_ROOT}"
