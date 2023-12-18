#!/bin/sh

riverctl keyboard-layout fr

riverctl spawn rivertile
riverctl output-layout rivertile

riverctl map normal Super E exit
riverctl map normal Super Q close
riverctl map normal Super D spawn "wofi --show drun"
riverctl map normal Super Return spawn "kitty"

riverctl map normal Super J focus-view next
riverctl map normal Super K focus-view previous

riverctl map normal Super+Shift J swap next
riverctl map normal Super+Shift K swap previous

riverctl map normal Super Space toggle-float

touchpad=$(riverctl list-inputs | grep "Touchpad")
riverctl input $touchpad natural-scroll enabled
riverctl input $touchpad tap enabled

riverctl border-color-unfocused 0x94a3b8
riverctl border-color-focused 0xa78bfa
riverctl border-width 2

workspaceKeys=(ampersand eacute quotedbl apostrophe parenleft minus egrave underscore ccedilla agrave)
for i in $(seq 0 8)
do
  tags=$((1 << ($i)))
  riverctl map normal Super ${workspaceKeys[i]} set-focused-tags $tags
  riverctl map normal Super+Shift ${workspaceKeys[i]} set-view-tags $tags
done
