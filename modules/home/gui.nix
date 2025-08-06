{ pkgs, ... }: {
  home.packages = with pkgs; [
    pcmanfm pavucontrol blueberry firefox dmenu legcord # gui
    rimworld # games
    maim xclip # screenshot
    (st.override {
      conf = builtins.readFile ./st.h;
      extraLibs = with pkgs; [ harfbuzz ];
      patches = [
        (pkgs.fetchurl {
          url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20240105-0.9.diff";
          hash = "sha256-Wcm2RTPlokGFlCsG/GmBEMrwNFpAxgEcqDaTEqKRhL0=";
        })
      ];
    })
  ] ++ (map (name: (pkgs.writeScriptBin "${name}-browser" ''
      ${pkgs.mullvad-browser}/bin/mullvad-browser -P ${name}
    '')) [ "i2p" "tor" ]);
}

