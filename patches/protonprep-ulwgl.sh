#!/bin/bash

### WINE PATCHING ###

    pushd wine

    git reset --hard HEAD
    git clean -xdf

### (2-1) GAME PATCH SECTION ###

    echo "WINE: -GAME FIXES- assetto corsa hud fix"
    patch -Np1 < ../patches/game-patches/assettocorsa-hud.patch

    echo "WINE: -GAME FIXES- add file search workaround hack for Phantasy Star Online 2 (WINE_NO_OPEN_FILE_SEARCH)"
    patch -Np1 < ../patches/game-patches/pso2_hack.patch

    echo "WINE: -GAME FIXES- Add Star Citizen EAC patch and wrap it around SteamGameId=starcitizen envvar"
    patch -Np1 < ../patches/game-patches/star-citizen-eac.patch

    # https://github.com/ValveSoftware/Proton/issues/6717
    # https://gitlab.winehq.org/wine/wine/-/merge_requests/4428
    echo "WINE: -GAME FIXES- Fix Farlight 84 crash"
    patch -Np1 < ../patches/game-patches/farlight-84.patch

### END GAME PATCH SECTION ###

### (2-2) WINE HOTFIX/BACKPORT SECTION ###

    # https://gitlab.winehq.org/wine/wine/-/merge_requests/3777
    echo "WINE: -BACKPORT- R6 Siege backport"
    patch -Np1 < ../patches/wine-hotfixes/upstream/3777.patch

### END WINE HOTFIX/BACKPORT SECTION ###

### (2-3) WINE PENDING UPSTREAM SECTION ###

    # https://github.com/ValveSoftware/wine/pull/205
    # https://github.com/ValveSoftware/Proton/issues/4625
    echo "WINE: -PENDING- Add WINE_DISABLE_SFN option. (Yakuza 5 cutscenes fix)"
    patch -Np1 < ../patches/wine-hotfixes/pending/ntdll_add_wine_disable_sfn.patch

### END WINE PENDING UPSTREAM SECTION ###

### END WINE PATCHING ###

    popd

