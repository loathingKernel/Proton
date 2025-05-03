#!/bin/bash

### (1) PREP SECTION ###

    pushd dxvk
    git reset --hard HEAD
    git clean -xdf
    popd

    pushd vkd3d-proton
    git reset --hard HEAD
    git clean -xdf

    popd

    pushd dxvk-nvapi
    git reset --hard HEAD
    git clean -xdf
    popd

    pushd gstreamer
    git reset --hard HEAD
    git clean -xdf
    echo "GSTREAMER: fix for unclosable invisible wayland opengl windows in taskbar"
    patch -Np1 < ../patches/gstreamer/5509.patch
    patch -Np1 < ../patches/gstreamer/5511.patch
    popd

    pushd protonfixes
    git reset --hard HEAD
    git clean -xdf
    pushd subprojects
    pushd x11-xserver-utils
    git reset --hard HEAD
    git clean -xdf
    popd
    pushd xutils-dev
    git reset --hard HEAD
    git clean -xdf
    popd
    popd
    popd

### END PREP SECTION ###

### (2) WINE PATCHING ###

    pushd wine
    git reset --hard HEAD
    git clean -xdf

# This doesn't correctly resolve the issue. We have patches that handle this for gstreamer
# Need to revert this so our patches work.

    git revert --no-commit 37818f7a547f7090ef684f8202438374fc31a165

### (2-3) GAME PATCH SECTION ###

### END GAME PATCH SECTION ###

### (2-4) WINE HOTFIX/BACKPORT SECTION ###

### END WINE HOTFIX/BACKPORT SECTION ###

### (2-5) WINE PENDING UPSTREAM SECTION ###

    # https://github.com/Frogging-Family/wine-tkg-git/commit/ca0daac62037be72ae5dd7bf87c705c989eba2cb
    echo "WINE: -PENDING- unity crash hotfix"
    patch -Np1 < ../patches/wine-hotfixes/pending/unity_crash_hotfix.patch

    # https://github.com/ValveSoftware/wine/pull/205
    # https://github.com/ValveSoftware/Proton/issues/4625
    echo "WINE: -PENDING- Add WINE_DISABLE_SFN option. (Yakuza 5 cutscenes fix)"
    patch -Np1 < ../patches/wine-hotfixes/pending/ntdll_add_wine_disable_sfn.patch

    echo "WINE: -PENDING- ncrypt: NCryptDecrypt implementation (PSN Login for Ghost of Tsushima)"
    patch -Np1 < ../patches/wine-hotfixes/pending/NCryptDecrypt_implementation.patch

    echo "WINE: -PENDING- DXGI_FORMAT_R8G8B8A8_UNORM: Suport for DXGI_FORMAT_R8G8B8A8_UNORM on d2d_wic_render_target_init (Alt:V GTA V coustom client)"
    patch -Np1 < ../patches/wine-hotfixes/pending/support_for_DXGI_FORMAT_R8G8B8A8_UNORM.patch

    # https://gitlab.winehq.org/wine/wine/-/merge_requests/7032
    # https://bugs.winehq.org/show_bug.cgi?id=56259
    # https://forum.winehq.org/viewtopic.php?t=38443
    echo "WINE: --PENDING-- add webview2 patches for GIRLS' FRONTLINE 2: EXILIUM and Vermintide 2"
    patch -Np1 < ../patches/wine-hotfixes/pending/webview2.patch
    patch -Np1 < ../patches/wine-hotfixes/pending/webview2-install-fix.patch

### END WINE PENDING UPSTREAM SECTION ###

    popd

### END WINE PATCHING ###

