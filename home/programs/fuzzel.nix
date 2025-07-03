{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "ghostty"; # Usa ghostty como terminal
        font = "monospace:size=10";
        width = 50;
        lines = 15;
        prompt = "❯ ";
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        border = "b4befe";
      };
    };
  };
}
