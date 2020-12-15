#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
cd ..


javascript-obfuscator cameo-divergent-stacked-bars/cameo-divergent-stacked-bars.js
mkdir -p dist/cameo-divergent-stacked-bars
cp cameo-divergent-stacked-bars/cameo-divergent-stacked-bars-obfuscated.js dist/cameo-divergent-stacked-bars/cameo-divergent-stacked-bars.js
rm cameo-divergent-stacked-bars/cameo-divergent-stacked-bars-obfuscated.js

javascript-obfuscator cameo-run/cameo-run.js
mkdir -p dist/cameo-run
cp cameo-run/cameo-run-obfuscated.js dist/cameo-run/cameo-run.js
rm cameo-run/cameo-run-obfuscated.js

javascript-obfuscator cameo-line/cameo-line.js
mkdir -p dist/cameo-line
cp cameo-line/cameo-line-obfuscated.js dist/cameo-line/cameo-line.js
rm cameo-line/cameo-line-obfuscated.js

javascript-obfuscator cameo-rank/cameo-rank.js
mkdir -p dist/cameo-rank
cp cameo-rank/cameo-rank-obfuscated.js dist/cameo-rank/cameo-rank.js
rm cameo-rank/cameo-rank-obfuscated.js

javascript-obfuscator cameo-multi-axis-prediction/cameo-multi-axis-prediction.js
mkdir -p dist/cameo-multi-axis-prediction
cp cameo-multi-axis-prediction/cameo-multi-axis-prediction-obfuscated.js dist/cameo-multi-axis-prediction/cameo-multi-axis-prediction.js
rm cameo-multi-axis-prediction/cameo-multi-axis-prediction-obfuscated.js

javascript-obfuscator cameo-map-tw/cameo-map-tw.js
mkdir -p dist/cameo-map-tw
cp cameo-map-tw/cameo-map-tw-obfuscated.js dist/cameo-map-tw/cameo-map-tw.js
rm cameo-map-tw/cameo-map-tw-obfuscated.js