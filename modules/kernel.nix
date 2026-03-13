_: {
  flake.nixosModules.kernel =
    { config, pkgs, ... }:
    {
            boot.kernelPackages = pkgs.linuxPackages_latest;
            boot.kernelParams = [
                "splash"
                "slab_nomerge" 
                "init_on_free=1" 
                "page_alloc.shuffle=1" 
                "mitigations=auto"
                "random.trust_cpu=0"
            ];
            security = {
                protectKernelImage = true;
                lockKernelModules = false;
                unprivilegedUsernsClone = true;
                apparmor.enable = true;
                apparmor.killUnconfinedConfinables = true;
            };

            environment.memoryAllocator.provider = "scudo";
            environment.variables.SCUDO_OPTIONS = "zero_contents=true";

            boot.kernel.sysctl = {
                "kernel.kptr_restrict" = 1;
                "kernel.dmesg_restrict" = 1;
                "kernel.unprivileged_bpf_disabled" = 1;
                "net.core.bpf_jit_harden" = 2;
            };


    };
}
