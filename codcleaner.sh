#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# ==========================================
# 1. PROCESS 'uo' DIRECTORY
# ==========================================
if [ -d "uo" ]; then
    mkdir -p "archived_maps"
    echo "Scanning 'uo' for custom .pk3 files..."
    
    UO_EXCLUDED=(
        "pakuo00.pk3" "pakuo01.pk3" "pakuo02.pk3" "pakuo03.pk3"
        "pakuo04.pk3" "pakuo05.pk3" "pakuo06.pk3" "pakuo07.pk3"
        "uomappack00.pk3"
        "localized_english_pakuo00.pk3" "localized_english_pakuo01.pk3" "localized_english_pakuo02.pk3"
    )
    
    find "uo" -maxdepth 1 -type f -name "*.pk3" | while read -r filepath; do
        filename=$(basename "$filepath")
        skip=0
        for excluded in "${UO_EXCLUDED[@]}"; do
            if [ "$filename" == "$excluded" ]; then
                skip=1
                break
            fi
        done
        
        if [ $skip -eq 1 ]; then
            echo "  [Skipped] uo/$filename"
        else
            echo "  [Moving]  uo/$filename -> archived_maps/"
            mv "$filepath" "archived_maps/"
        fi
    done
fi

# ==========================================
# 2. PROCESS 'main' DIRECTORY
# ==========================================
if [ -d "main" ]; then
    mkdir -p "archived_main"
    echo "Scanning 'main' for custom .pk3 files..."
    
    MAIN_EXCLUDED=(
        # DLLs, logs, configs, data
        "cgame_mp_x86.dll" "console.log" "config.cfg" "config_mp.cfg"
        "game_mp_x86.dll" "hunkusage.dat" "ui_mp_x86.dll"
        # Official paks & zips
        "pak0.pk3" "pak1.pk3" "pak2.pk3" "pak3.pk3" "pak4.pk3"
        "pak5.pk3" "pak6.pk3" "pak7.pk3" "pak8.pk3" "pak9.pk3"
        "paka.pk3" "pakb.pk3" "pak4.zip"
        # Localized english paks
        "localized_english_pak0.pk3" "localized_english_pak1.pk3"
        "localized_english_pak2.pk3" "localized_english_pak3.pk3"
        "localized_english_pak4.pk3" "localized_english_pak5.pk3"
    )
    
    find "main" -maxdepth 1 -type f -name "*.pk3" | while read -r filepath; do
        filename=$(basename "$filepath")
        skip=0
        for excluded in "${MAIN_EXCLUDED[@]}"; do
            if [ "$filename" == "$excluded" ]; then
                skip=1
                break
            fi
        done
        
        if [ $skip -eq 1 ]; then
            echo "  [Skipped] main/$filename"
        else
            echo "  [Moving]  main/$filename -> archived_main/"
            mv "$filepath" "archived_main/"
        fi
    done
fi

echo "Operation complete!"
