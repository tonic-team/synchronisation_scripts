#!/usr/bin/env bash
cd ../../Files/github_repo
ls 

gin get fake_lab/SFB_a04_larkum.main
cd SFB_a04_larkum.main
sh ../../../02_tonic-gin/11_tonic-synchronisation_scripts/initialisation_scripts/template_init.command



gin get fake_lab/labreports 02_fakelab_reports

repo="nt3.main"
gin get "tonictests/""$repo"
cd "$repo"
git checkout main
