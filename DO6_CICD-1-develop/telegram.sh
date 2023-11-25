#!/bin/bash

TELEGRAM_BOT_TOKEN="6615331113:AAFrI2m1hmF7aGJGzPuAupTkHcdO-e--Vtk"
TELEGRAM_USER_ID="522455295"
export CI_JOB_STATUS
export CI_JOB_STAGE
export CI_PROJECT_NAME
export CI_PROJECT_URL
export CI_PIPELINE_ID
export CI_COMMIT_REF_SLUG
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Deploy status: $CI_JOB_STATUS%0ASTAGE: $CI_JOB_STAGE%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
