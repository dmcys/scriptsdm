#!bin/bash
sysctl(){
sysct(){
sudo echo -ne -n -e "# Set the kernel panic timeout to 10 seconds\n
kernel.panic=10\n
# Randomize the memory layout of the kernel to make it harder for attackers\n
kernel.randomize_va_space=2\n
\n
# Enable kernel executable space protection\n
kernel.exec-shield = 2\n
\n
# Use PID as core filename\n
kernel.core_uses_pid = 1\n
\n
# Restrict access to kernel log buffer\n
kernel.dmesg_restrict = 1\n
\n
# Restrict access to kernel pointers\n
kernel.kptr_restrict = 2\n
\n
# Panic the system if a kernel oops occurs\n
kernel.panic_on_oops = 60\n
\n
# Restrict access to perf events\n
kernel.perf_event_paranoid = 3\n
\n
# Disable the sysrq key\n
kernel.sysrq = 0\n
\n
# Disable unprivileged access to BPF (Berkeley Packet Filter) system calls\n
kernel.unprivileged_bpf_disabled = 1\n
\n
# Set the ptrace scope to only allow tracing of direct child processes\n
kernel.yama.ptrace_scope = 2\n
\n
# Increase the maximum number of process IDs to 65536\n
kernel.pid_max = 65536\n
\n
# Reduce swapping\n
vm.swappiness = 10\n
\n
# Set the ratio of memory pages allowed to get dirty to 60%\n
vm.dirty_ratio = 60\n
\n
# Set the ratio of memory pages allowed to remain dirty to 2%\n
vm.dirty_background_ratio = 2\n
\n
# Disable automatic loading of line disciplines for tty devices\n
dev.tty.ldisc_autoload = 0\n
\n
# Increase the maximum number of open files to 65535\n
fs.file-max = 65535\n
\n
# Set FIFOs protection level to 2 (only owner can read/write)\n
fs.protected_fifos = 2\n
\n
# Disable setuid dumps\n
fs.suid_dumpable = 0\n
\n
# Enable protection of hardlinks against modification\n
fs.protected_hardlinks=1\n
\n
# Enable protection of symbolic links against exploitation\n
fs.protected_symlinks=1\n
\n
# Enable Fair Queue packet scheduler as the default queuing discipline\n
net.core.default_qdisc = fq\n
\n
# Set the default receive buffer size for all protocols to 256KB\n
net.core.rmem_default = 262144\n
\n
# Set the maximum receive buffer size for all protocols to 16MB\n
net.core.rmem_max = 16777216\n
\n
# Set the default send buffer size for all protocols to 256KB\n
net.core.wmem_default = 262144\n
\n
# Set the maximum send buffer size for all protocols to 16MB\n
net.core.wmem_max = 16777216\n
\n
# Set the maximum length of the listen queue backlog\n
net.core.somaxconn = 32768\n
\n
# Set the maximum number of packets that can be queued on the input side of each network interface\n
net.core.netdev_max_backlog = 16384\n
\n
# Set the default weight of all network interfaces to 64\n
net.core.dev_weight = 64\n
\n
# Set the maximum socket buffer size allocatable to a single socket\n
net.core.optmem_max = 65535\n
\n
# Enable hardened Berkeley Packet Filter (BPF) JIT compiler\n
net.core.bpf_jit_harden = 2\n
\n
# Set the maximum receive buffer size for TCP connections to 8MB\n
net.ipv4.tcp_rmem_max = 8388608\n
\n
# Set the maximum send buffer size for TCP connections to 8MB\n
net.ipv4.tcp_wmem_max = 8388608\n
\n
# Set the maximum length of the listen queue backlog for all protocols to 5000\n
net.core.netdev_max_backlog = 5000\n
\n
#Set the default receive buffer size for TCP connections\n
net.ipv4.tcp_rmem = 4096 87380 6291456\n
\n
#Set the maximum receive buffer size for TCP connections to 16MB\n
net.ipv4.tcp_rmem_max = 16777216\n
\n
#Set the maximum number of sockets allowed to queue up for accepting connections to 500\n
net.core.somaxconn = 500\n
\n
#Enable TCP window scaling\n
net.ipv4.tcp_window_scaling = 1\n
\n
#Enable TCP timestamps\n
net.ipv4.tcp_timestamps = 1\n
\n
#Enable TCP selective acknowledgements\n
net.ipv4.tcp_sack = 1\n
\n
#Enable TCP Fast Open\n
net.ipv4.tcp_fastopen = 3\n
\n
#Increase TCP maximum syn backlog\n
net.ipv4.tcp_max_syn_backlog = 4096\n
\n
#Increase the maximum number of open file descriptors\n
fs.file-max = 2097152\n
\n
#Increase the maximum amount of memory allocated to each socket receive buffer\n
net.core.rmem_max = 16777216\n
\n
#Increase the maximum amount of memory allocated to each socket send buffer\n
net.core.wmem_max = 16777216\n
\n
#Increase the default amount of memory allocated to each socket receive buffer\n
net.core.rmem_default = 16777216\n
\n
#Increase the default amount of memory allocated to each socket send buffer\n
net.core.wmem_default = 16777216\n
\n
#Enable low latency mode\n
net.core.busy_poll = 50\n
\n
#Decrease the amount of time a connection spends in the 'TIME_WAIT' state\n
net.ipv4.tcp_fin_timeout = 10\n
\n
#Enable TCP keepalive\n
net.ipv4.tcp_keepalive_time = 1200\n
net.ipv4.tcp_keepalive_intvl = 30\n
net.ipv4.tcp_keepalive_probes = 3\n
\n
#Enable SYN cookies\n
net.ipv4.tcp_syncookies = 1\n
\n
#Enable automatic congestion control\n
net.ipv4.tcp_congestion_control = cubic\n
\n
#Enable explicit congestion notification\n
net.ipv4.tcp_ecn = 2\n
\n
#Disable TCP slow start after idle for 120 seconds\n
net.ipv4.tcp_slow_start_after_idle = 0\n
\n
#Enable TCP window scaling\n
net.ipv4.tcp_window_scaling = 1\n
\n
#Enable TCP selective acknowledgments\n
net.ipv4.tcp_sack = 1\n
\n
#Enable TCP Fast Open\n
net.ipv4.tcp_fastopen = 3\n
\n
#Enable TCP timestamps\n
net.ipv4.tcp_timestamps = 1\n
\n
#Increase TCP buffer limits\n
net.core.rmem_max = 16777216\n
net.core.wmem_max = 16777216\n
net.ipv4.tcp_rmem = 4096 87380 16777216\n
net.ipv4.tcp_wmem = 4096 65536 16777216\n
\n
#Increase the maximum number of open files and file descriptors\n
ulimit -n 1000000\n
\n
#Increase the maximum number of user processes\n
ulimit -u 2048\n
\n
#Increase the maximum number of memory map areas a process may have\n
vm.max_map_count = 262144\n" > /etc/sysctl.conf
}
# Ask user for input
read -p "Do you want configure sysctl? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  sysct
else
  echo "Sysctl configuration canceled by user"
fi
}
sysctl
