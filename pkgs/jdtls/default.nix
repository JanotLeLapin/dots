{ pkgs, ... }:

pkgs.writeTextFile {
  name = "java-language-server";
  destination = "/bin/java-language-server";
  executable = true;
  text = let
    jdt = "${pkgs.jdt-language-server}";
    config_dir = "$HOME/.cache/jdtls";
  in ''
    mkdir ${config_dir}
    cp ${jdt}/share/config/config.ini ${config_dir}
    mkdir $HOME/workspace
    ${pkgs.openjdk21}/bin/java \
      -Declipse.application=org.eclipse.jdt.ls.core.id1 \
      -Dosgi.bundles.defaultStartLevel=4 \
      -Declipse.product=org.eclipse.jdt.ls.core.product \
      -Dlog.protocol=true \
      -Dlog.level=ALL \
      -Xmx4g \
      -javaagent:${pkgs.lombok}/share/java/lombok.jar \
      --add-modules=ALL-SYSTEM \
      --add-opens java.base/java.util=ALL-UNNAMED \
      --add-opens java.base/java.lang=ALL-UNNAMED \
      -jar ${jdt}/share/java/plugins/org.eclipse.equinox.launcher_*.jar \
      -configuration ${config_dir} \
      -data $HOME/workspace/$1
  '';
}
