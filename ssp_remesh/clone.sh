#!/usr/bin/env bash
# Clone only the ssp_remesh subdirectory from the SSP_QND fork
# using git sparse-checkout (cone mode).
#
# Run this from the parent directory where you want external/SSP_QND to live.
# Example:
#   cd "C:/Users/alirz/Projects/Graphics/Neural QMAT"
#   bash external/SSP_QND/ssp_remesh/clone.sh

DEST="external/SSP_QND"
REPO="https://github.com/Alireza-Khatami/SSP_QND"

# Clone without checking out any files
git clone --no-checkout --depth 1 "$REPO" "$DEST"

cd "$DEST"

# Enable cone-mode sparse checkout and select only ssp_remesh
git sparse-checkout init --cone
git sparse-checkout set ssp_remesh
git checkout

# Pull the libigl submodule bundled inside ssp_remesh
git submodule update --init --recursive
