#!/usr/bin/env bash

# TODO: add & parse user command line input for folder

mkdir logs

mkdir bz2 && mv *.bz2 bz2 && cd bz2
echo -e "\nUnzipping files"
ls *.bz2 | xargs -n1 '-I{}' sh -c 'echo {}; lbunzip2 -k {}' &> ../logs/unzip.log

cd .. && mkdir ecw && mv bz2/*.ecw ecw && mkdir tif
echo -e "\nGenerating Geotiff & COG files using ecw_convert_2_cog.py"
ecw_convert_2_cog.py ecw tif ? &> logs/ecw_convert_2_cog.log

echo -e "\nValidating COG files"
ls img/compliant-cog/ | xargs -n1 '-I{}' sh -c 'echo {}; validate_cog.py img/compliant-cog/{};' &> logs/validate_cog.log
