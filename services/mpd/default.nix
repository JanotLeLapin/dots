{ ... }: {
  enable = true;
  extraConfig = ''
    audio_output {
      type "pipewire"
      name "PipeWire Output"
    }
  '';
}
