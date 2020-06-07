#!/bin/bash
mega-login ${EMAIL} ${PASSWORD}
mega-sync ./ /MEGAsync
cat
