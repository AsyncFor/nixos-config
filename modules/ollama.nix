{ inputs, ... }:
{
  flake.nixosModules.ollama =
    { pkgs, ... }:
    {
            services.ollama = {
                enable = true;
                acceleration = "cuda";
                loadModels = [ "qwen2.5-coder:14b" ];
                environmentVariables = {
                    OLLAMA_KEEP_ALIVE = "-1";
                };
            };
            environment.systemPackages = with pkgs; [
                ollama
            ];
    };
}
