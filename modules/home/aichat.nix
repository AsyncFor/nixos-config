{ self, ... }:
{
  flake.homeModules.main =
    { ... }:
    {
            programs.aichat = {
                enable = true;
                settings = {
                    model = "qwen2.5-coder:14b";
                    clients = [
                    {
                        type = "ollama";
                        api_base = "http://127.0.0.1:11434";
                    }
                    ];
                    cmd_prelude = "Respond only with the command. No explanation unless asked.";
                };
            };

            programs.fish.shellAliases = {
                "??" = "aichat -e";  
            };
    };
}
