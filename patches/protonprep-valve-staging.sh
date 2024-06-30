#!/bin/bash

### (1) PREP SECTION ###

    pushd gstreamer
    git reset --hard HEAD
    git clean -xdf
    
    echo "GSTREAMER: fix for unclosable invisible wayland opengl windows in taskbar"
    patch -Np1 < ../patches/gstreamer/5509.patch
    patch -Np1 < ../patches/gstreamer/5511.patch
    popd

### END PREP SECTION ###

### (2) WINE PATCHING ###

    pushd wine
    git reset --hard HEAD
    git clean -xdf

### (2-3) GAME PATCH SECTION ###

    echo "WINE: -GAME FIXES- assetto corsa hud fix"
    patch -Np1 < ../patches/game-patches/assettocorsa-hud.patch

    echo "WINE: -GAME FIXES- add file search workaround hack for Phantasy Star Online 2 (WINE_NO_OPEN_FILE_SEARCH)"
    patch -Np1 < ../patches/game-patches/pso2_hack.patch

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

    echo "WINE: -PENDING- Add TCP_KEEP patch (Star Citizen Launcher 2.0 fix)"
    patch -Np1 < ../patches/wine-hotfixes/pending/TCP_KEEP-fixup.patch

    echo "WINE: -PENDING- shell32: Implement some file_operation apis. (Solo Leveling netmarble launcher)"
    # https://gitlab.winehq.org/wine/wine/-/merge_requests/5671
    patch -Np1 < ../patches/wine-hotfixes/pending/5671.patch

    echo "WINE: -PENDING- ncrypt: NCryptDecrypt implementation (PSN Login for Ghost of Tsushima)"
    patch -Np1 < ../patches/wine-hotfixes/pending/NCryptDecrypt_implementation.patch

    echo "WINE: -PENDING- DXGI_FORMAT_R8G8B8A8_UNORM: Suport for DXGI_FORMAT_R8G8B8A8_UNORM on d2d_wic_render_target_init (Alt:V GTA V coustom client)"
    patch -Np1 < ../patches/wine-hotfixes/pending/support_for_DXGI_FORMAT_R8G8B8A8_UNORM.patch

### END WINE PENDING UPSTREAM SECTION ###

    echo "WINE: -PENDING- Add options to disable proton media converter."
    patch -Np1 < ../patches/wine-hotfixes/pending/add-envvar-to-gate-media-converter.patch

    popd

### END WINE PATCHING ###

