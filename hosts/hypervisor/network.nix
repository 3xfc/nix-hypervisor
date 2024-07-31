{

  # Use nftables
  networking.nftables.enable = true;

  # Use systemd-networkd
  networking.useNetworkd = true;
  systemd.network.wait-online.enable = false;

  # Only use DHCP when we explicitly request it
  networking.useDHCP = false;

  # Bridge that connects VMs to the network
  systemd.network.netdevs."10-vm-bridge" = {
    netdevConfig = {
      Kind = "bridge";
      Name = "br0";
    };
  };
  systemd.network.networks."10-vm-bridge" = {
    name = "br0";
    DHCP = "ipv4";
    bridgeConfig = {
      Learning = false;
    };
  };

  # Attach all ethernet interfaces to the bridge
  systemd.network.networks."20-bridge-ethernet-interfaces" = {
    name = "en*";
    bridge = [ "br0" ];
  };

  # Ignore VM taps
  systemd.network.networks."30-ignore-vm-taps" = {
    name = "vmtap-*";
    enable = false;
  };

  # Load required modules
  boot.kernelModules = [
    "ip_tables"
    "x_tables"
    "nf_tables"
    "nft_ct"
    "nft_log"
    "nf_log_syslog"
    "nft_fib"
    "nft_fib_inet"
    "nft_compat"
    "nft_nat"
    "nft_chain_nat"
    "nft_masq"
    "nfnetlink"
    "nf_conntrack"
    "nf_log_syslog"
    "nf_nat"
    "af_packet"
    "bridge"
    "tcp_bbr"
    "sch_fq_codel"
    "ipt_rpfilter"
    "ip6t_rpfilter"
    "sch_fq"
    "tun"
    "tap"
  ];

}
