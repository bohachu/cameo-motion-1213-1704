#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
cd ..


javascript-obfuscator cameo-divergent-stacked-bars/cameo-divergent-stacked-bars.js
mkdir -p dist/cameo-divergent-stacked-bars
mv cameo-divergent-stacked-bars/cameo-divergent-stacked-bars-obfuscated.js dist/cameo-divergent-stacked-bars/cameo-divergent-stacked-bars.js

javascript-obfuscator cameo-run/cameo-run.js
mkdir -p dist/cameo-run
mv cameo-run/cameo-run-obfuscated.js dist/cameo-run/cameo-run.js

javascript-obfuscator cameo-line/cameo-line.js
mkdir -p dist/cameo-line
mv cameo-line/cameo-line-obfuscated.js dist/cameo-line/cameo-line.js

javascript-obfuscator cameo-rank/cameo-rank.js
mkdir -p dist/cameo-rank
mv cameo-rank/cameo-line-rank.js dist/cameo-rank/cameo-rank.js

javascript-obfuscator cameo-multi-axis-prediction/cameo-multi-axis-prediction.js
mkdir -p dist/cameo-multi-axis-prediction
mv cameo-multi-axis-prediction/cameo-multi-axis-prediction-obfuscated.js dist/cameo-multi-axis-prediction/cameo-multi-axis-prediction.js

javascript-obfuscator cameo-map-tw/cameo-map-tw.js
mkdir -p dist/cameo-map-tw
mv cameo-map-tw/cameo-map-tw-obfuscated.js dist/cameo-map-tw/cameo-map-tw.js
