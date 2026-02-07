{ self, ... }:
{
  flake.homeModules.main =
    { ... }:
    {
            programs.aichat = {
                enable = true;
                settings = {
                    model = "ollama:qwen2.5-coder:14b";
                    clients = [
                    {
                        type= "openai-compatible";
                        name = "ollama";
                        api_base = "http://127.0.0.1:11434/v1";
                        models = [
                            { name = "qwen2.5-coder:14b"; }
                            { name = "qwen2.5-coder:7b"; }
                        ];
                    }
                    ];
                    cmd_prelude = "role:shell";
                };
            };

            programs.fish.shellAliases = {
                "??" = "aichat -e";  
            };
    };
}
