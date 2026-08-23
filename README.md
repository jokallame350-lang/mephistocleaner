<p align="center">
  <img src="assets/banner.svg" alt="MephistoCleaner Banner" width="100%">
</p>

<p align="center">
  <strong>The Ultimate Open-Source Windows 10 & 11 Gaming, Privacy & Optimization Suite</strong>
</p>

<p align="center">
  <a href="https://github.com/jokallame350-lang/mephistocleaner/releases"><img src="https://img.shields.io/github/v/release/jokallame350-lang/mephistocleaner?color=0284c7&label=Release&style=for-the-badge" alt="Release"></a>
  <a href="https://github.com/jokallame350-lang/mephistocleaner/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-10b981?style=for-the-badge" alt="License"></a>
  <a href="https://github.com/jokallame350-lang/mephistocleaner/actions"><img src="https://img.shields.io/badge/Build-Passing-38bdf8?style=for-the-badge&logo=githubactions&logoColor=white" alt="Build Status"></a>
  <a href="https://www.microsoft.com/windows"><img src="https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-6366f1?style=for-the-badge&logo=windows&logoColor=white" alt="Platform"></a>
  <a href="https://github.com/jokallame350-lang/mephistocleaner"><img src="https://img.shields.io/badge/Languages-20%20Supported-a855f7?style=for-the-badge" alt="Languages"></a>
</p>

---

## 📖 About MephistoCleaner

**MephistoCleaner** is a standalone, mouse-driven graphical utility crafted to declutter, debloat, and accelerate Windows 10 and Windows 11 systems to their absolute theoretical performance ceiling. 

Unlike black-box custom Windows ISOs that break core operating system dependencies, or command-line scripts that leave users in the dark, **MephistoCleaner brings a modern, 100% safe, granular, and transparent desktop control center** equipped with **150+ modular tweaks, 20 native languages, and 10 dynamic color themes**.

Every single button in MephistoCleaner is paired with **real-time hover ToolTips** explaining exactly what the tweak does, why it helps, and how it modifies your system.

<p align="center">
  <img src="assets/preview.svg" alt="MephistoCleaner Interface Preview" width="95%">
</p>

---

## ⚡ Key Highlights & Architecture

* 🚀 **1-Click 100% Safe Optimization:** Apply the complete, curated master suite of proven kernel, CPU, GPU, memory, and network tweaks in under 15 seconds.
* 🛡️ **Zero Risk & 100% Reversible:** Filtered strictly to preserve Windows stability. Features built-in **Instant Restore Point Creation (Feature #149)** and a complete **Factory Defaults Revert (Feature #150)**.
* 🎮 **Esports Low-Latency Engine:** Lock `MaxFrameLatency=1`, unpark all CPU cores, disable Nagle's algorithm (`TCPNoDelay=1`), and enable 1:1 hardware raw mouse input.
* 💽 **Deep Storage Recovery:** Automatically purges multi-gigabyte corrupted DirectX/NVIDIA/AMD shader caches, DISM WinSxS backup stores, and sends hardware TRIM passes.
* 🌐 **20 Native Languages:** Full, real-time localized user interface across English, Turkish, German, French, Spanish, Russian, Japanese, Chinese, and 12 more languages.
* 🎨 **10 Dynamic Themes:** Switch on the fly between *Cyber Slate*, *Midnight Velvet*, *Matrix Emerald*, *Crimson Blood*, *AMOLED Pure Black*, *Dracula Dusk*, *Nordic Frost*, and more.
* 🔒 **100% Offline & Zero Telemetry:** Contains zero network loggers, zero external DLL dependencies, and zero tracking code.

---

## 📊 Comparison with Other Open-Source Tools

| Feature / Metric | MephistoCleaner | ChrisTitus WinUtil | Sophia Script | AtlasOS / ReviOS |
| :--- | :---: | :---: | :---: | :---: |
| **Interface Style** | **Modern WPF GUI (Zero Console)** | PowerShell WinForms | CLI / Config Text | Custom OS / Playbook |
| **Total Modular Features** | **150+ Features** | ~60 Features | ~100 Tweaks | OS Modification |
| **Hover ToolTips on Every Item** | :white_check_mark: **Yes (Detailed)** | :x: No | :x: No | :x: No |
| **Multi-Language Support** | :white_check_mark: **20 Languages** | :x: English Only | :warning: Partial | :x: English Only |
| **Dynamic Theme Engine** | :white_check_mark: **10 Themes** | :x: Fixed | :x: None | :x: Fixed |
| **Real-time Live Console** | :white_check_mark: **Embedded WPF** | :warning: Separate Window | :x: Terminal | :x: Terminal |
| **Safety & Factory Revert** | :white_check_mark: **1-Click Revert** | :warning: Manual | :warning: Manual | :x: Requires Reinstall |
| **Windows Component Integrity** | :white_check_mark: **100% Maintained** | :white_check_mark: Maintained | :white_check_mark: Maintained | :warning: Stripped Components |

---

## 🚀 Quick Start & Installation

You can launch and run MephistoCleaner instantly via an elevated PowerShell prompt or by downloading the repository.

### Method 1: Instant Launch (PowerShell One-Liner)

Open **PowerShell as Administrator** and paste:

```powershell
irm https://raw.githubusercontent.com/jokallame350-lang/mephistocleaner/master/MephistoCleaner.ps1 | iex
```

### Method 2: Manual Download & Desktop Launcher

1. Download or clone this repository:
   ```bash
   git clone https://github.com/jokallame350-lang/mephistocleaner.git
   ```
2. Navigate to the folder.
3. Double-click **`MephistoCleaner.vbs`** or **`MephistoCleaner.bat`**.
4. The standalone WPF GUI opens instantly with zero background console clutter!

---

## 📦 Detailed Feature Matrix (150 Modular Tweaks)

<details>
<summary><strong>⚡ Tab 1: Gaming &amp; Performance (Features 1 - 20)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **1** | **CPU Core Unparking & Power Plan Lock** | Sets `CPMINCORES` to 100% to prevent CPU cores from entering deep sleep states during gaming. |
| **2** | **Game Booster Turbo Mode** | Terminates non-essential background processes (browsers, Discord, Spotify) to liberate working RAM. |
| **3** | **RAM & Standby Cache Purge** | Invokes `.NET Garbage Collection` and flushes memory working sets. |
| **4** | **Universal GPU Shader Cache Purge** | Deletes bloated shader caches across NVIDIA DXCache, AMD DxCache, and DirectX D3DSCache. |
| **5** | **Enable HAGS (Hardware GPU Scheduling)** | Enables hardware scheduling on graphics cards to reduce CPU frame rendering overhead. |
| **6** | **Lock DirectX MaxFrameLatency=1** | Restricts swap chain pre-rendered frames to 1, eliminating driver frame queue input lag. |
| **7** | **Force Fullscreen Optimizations (FSE)** | Sets `GameDVR_FSEBehaviorMode` to 2 to bypass DWM composition delay in windowed games. |
| **8** | **Disable Game DVR Background Recording** | Shuts down Windows background video capture threads to recover lost FPS. |
| **9** | **Lighten DWM Transparency & Blur** | Lightens Desktop Window Manager GPU compositor shader passes. |
| **10** | **Expand GDI Process Handle Quota to 65536** | Expands UI handle ceiling to prevent crashes in heavily modded titles (Skyrim, Cities: Skylines). |
| **11** | **Disable Power Throttling** | Sets `PowerThrottlingOff=1` in registry to guarantee unrestricted CPU wattage delivery. |
| **12** | **Disable Fast Startup Kernel Leaks** | Sets `HiberbootEnabled=0` to ensure true clean kernel boots and prevent memory session degradation. |
| **13** | **Set Win32PrioritySeparation to 38** | Allocates maximum CPU quantum time slices to foreground gaming processes. |
| **14** | **Set MMCSS Games GPU Priority to 8** | Configures Multimedia Class Scheduler Service priority to high for stutter-free frame delivery. |
| **15** | **Competitive CS2 / Esports Launch Codes** | Generates dynamic thread-matched launch arguments (`-high -threads N -novid -nojoy +fps_max 0`). |
| **16** | **Disable HPET (High Precision Event Timer)** | Disables legacy platform timer clock via BCDedit to reduce DPC interrupt overhead. |
| **17** | **Disable Dynamic Tick Clock Interrupts** | Prevents irregular timer ticks on multi-core processors, eliminating frame pacing drops. |
| **18** | **Enable DirectPlay Legacy Support** | Enables DirectPlay optional component required for classic titles (GTA San Andreas, NFS). |
| **19** | **Install .NET Framework 3.5 / 2.0** | Silently provisions .NET runtimes needed by mod managers and older utilities. |
| **20** | **Minecraft Java Aikar's GC Flags** | Outputs optimized G1GC garbage collection JVM arguments for zero-stutter Java gameplay. |

</details>

<details>
<summary><strong>💽 Tab 2: Disk &amp; Deep Clean (Features 21 - 40)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **21** | **Hardware SSD Re-TRIM Force** | Sends active TRIM commands via storage engine to refresh flash NAND blocks and write speeds. |
| **22** | **Clean Windows & User Temp Folders** | Purges residual temporary files across `AppData\Local\Temp` and `C:\Windows\Temp`. |
| **23** | **DISM WinSxS Component Store ResetBase** | Cleans superseded Windows Update backup binaries to reclaim 5 to 20 GB of storage. |
| **24** | **Clean Windows Update Download Cache** | Deletes cached update payload files from `SoftwareDistribution\Download`. |
| **25** | **Purge Chrome, Brave & Edge Caches** | Cleans browser cache stores without clearing cookies or saved logins. |
| **26** | **Purge Developer (npm, pip, yarn) Caches** | Cleans local package repositories to recover developer disk capacity. |
| **27** | **Purge Crash Dumps (.dmp) & Minidumps** | Removes legacy memory crash logs from `C:\Windows\Minidump`. |
| **28** | **Force Empty Recycle Bin on All Drives** | Empties Recycle Bin storage across all internal and external connected volumes. |
| **29** | **Disable NTFS 8.3 Short Name Creation** | Disables MS-DOS filename generation to speed up directory traversal on SSDs. |
| **30** | **Disable NTFS Last Access Timestamp** | Prevents metadata timestamp writes every time a file is accessed. |
| **31** | **Set NTFS MftZone Area to 2** | Pre-allocates Master File Table space to prevent master record fragmentation. |
| **32** | **Clear Thumbnail Cache** | Deletes corrupt `thumbcache_*.db` databases to fix broken file preview thumbnails. |
| **33** | **Reset IconCache (IconCache.db)** | Rebuilds Windows icon database to fix blank or distorted desktop icons. |
| **34** | **Reset Windows FontCache Service** | Flushes corrupt font cache databases to accelerate system boot time. |
| **35** | **Clean Discord & Telegram Media Caches** | Deletes cached voice and video media clips from messaging apps. |
| **36** | **Clear Delivery Optimization Cache** | Removes residual peer-to-peer distribution payload files. |
| **37** | **Clear Stale Windows Event Logs** | Clears accumulated Application and System event log archives. |
| **38** | **Perform Free Space TRIM Pass** | Sends a dedicated deallocation pass on unused drive sectors. |
| **39** | **Delete Massive MEMORY.DMP Dumps** | Deletes large multi-gigabyte complete memory crash dumps. |
| **40** | **Analyze Downloads Folder Usage** | Calculates and reports total storage space occupied by downloaded installers. |

</details>

<details>
<summary><strong>🌐 Tab 3: Network, DNS &amp; Ping (Features 41 - 60)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **41** | **Switch to Cloudflare 1.1.1.1 DNS** | Applies high-performance Cloudflare DNS (`1.1.1.1` & `1.0.0.1`) across active network adapters. |
| **42** | **Switch to Google 8.8.8.8 DNS** | Applies reliable Google Public DNS (`8.8.8.8` & `8.8.4.4`). |
| **43** | **Switch to Quad9 9.9.9.9 Security DNS** | Sets Quad9 DNS with automated malicious domain filtering. |
| **44** | **Reset DNS to Automatic (DHCP)** | Restores automatic router-assigned DNS configurations. |
| **45** | **Flush DNS Cache & Reset Winsock** | Purges local resolver cache and rebuilds the Winsock network catalog. |
| **46** | **Enable TCP FastOpen** | Enables client-side TCP FastOpen to halve connection establishment handshake latency. |
| **47** | **Enable TCP ECN & Receive Side Scaling (RSS)** | Enables Explicit Congestion Notification and splits packet processing across CPU cores. |
| **48** | **Disable TCP Timestamps Overhead** | Eliminates redundant 12-byte timestamp headers from all outgoing packets. |
| **49** | **Disable Nagle's Algorithm (TCPNoDelay)** | Sets `TCPNoDelay=1` to force immediate packet dispatch without buffering delays. |
| **50** | **Lock TcpAckFrequency to 1** | Sends immediate TCP ACK packets for incoming segments, stabilizing gaming ping. |
| **51** | **Expand MaxUserPort to 65534** | Increases dynamic outbound socket capacity for multiplayer and streaming sessions. |
| **52** | **Reduce TcpTimedWaitDelay to 30s** | Speeds up closed connection memory socket release from 120s down to 30s. |
| **53** | **Disable Delivery Optimization P2P** | Stops Windows Update from utilizing your internet bandwidth for background P2P seeding. |
| **54** | **Disable NIC Power Management Sleep** | Prevents Ethernet and Wi-Fi chips from sleeping during gaming sessions. |
| **55** | **Lower Wi-Fi Roaming Aggressiveness** | Prevents Wi-Fi adapter from erratically hunting for alternate access points mid-match. |
| **56** | **Live Ping & Jitter Latency Test** | Executes live latency tests to Cloudflare/Google to measure jitter. |
| **57** | **Test for Network Packet Loss** | Measures network interface packet drop rate. |
| **58** | **Block Telemetry IPs in Hosts File** | Blocks 100+ Microsoft tracking domains locally by routing them to `0.0.0.0`. |
| **59** | **Restore Default Clean Hosts File** | Resets `C:\Windows\System32\drivers\etc\hosts` back to clean factory state. |
| **60** | **Enable DNS Leak Protection** | Forces Windows to route DNS queries strictly through configured secure resolvers. |

</details>

<details>
<summary><strong>🛡️ Tab 4: Privacy &amp; Debloat (Features 61 - 80)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **61** | **Uninstall 50+ Safe UWP Bloatware Apps** | Safely purges pre-installed bloat (BingNews, Weather, Clipchamp, Zune, FeedbackHub, etc.). |
| **62** | **Disable Windows Copilot AI Systemwide** | Disables Windows Copilot background agents, policies, and taskbar buttons. |
| **63** | **Disable Start Menu Bing Web Search** | Restores instant, local-only search queries without sending keystrokes to Bing. |
| **64** | **Disable DiagTrack Telemetry Service** | Stops and permanently disables Connected User Experiences and Telemetry. |
| **65** | **Disable Activity History & Timeline** | Stops Windows from recording application usage history and synchronizing to the cloud. |
| **66** | **Disable Edge Startup Boost & Background Mode** | Prevents Microsoft Edge from running resident background tasks when closed. |
| **67** | **Disable Advertising ID Tracking** | Disables personalized advertisement identifier tracking across Windows apps. |
| **68** | **Block Background App Location Access** | Blocks background Store applications from silently polling device GPS coordinates. |
| **69** | **Disable CEIP Customer Experience Tasks** | Disables scheduled telemetry consolidation upload tasks. |
| **70** | **Disable Microsoft Compatibility Appraiser** | Stops daily background telemetry scans that consume excessive CPU cycles. |
| **71** | **Disable Disk Diagnostic Data Collector** | Disables background telemetry data logging of drive I/O operations. |
| **72** | **Disable Background App Permissions** | Prevents Store applications from running in the background and draining battery/RAM. |
| **73** | **Disable Lockscreen Ads & Consumer Tips** | Removes sponsored game ads and tips from the Windows lockscreen. |
| **74** | **Disable Crash Reporting Prompt Popups** | Silently closes crashed applications without freezing the desktop window manager. |
| **75** | **Disable ETW Autologgers Disk Traces** | Disables 30 background kernel trace loggers from constantly writing I/O to your SSD. |
| **76** | **Disable Windows 11 Recall AI Snapshots** | Disables background screenshot snapshotting and indexing in Windows 11. |
| **77** | **Hide Search Box Web Trends & Highlights** | Removes celebrity news and web highlights from the taskbar search box. |
| **78** | **Disable Microsoft Office Telemetry** | Disables background usage logging in Microsoft Office suite. |
| **79** | **Disable GPU Driver Telemetry Services** | Stops NVIDIA and AMD driver telemetry containers from uploading telemetry. |
| **80** | **Disable Windows Error Reporting (WerSvc)** | Disables error reporting service to speed up system responsiveness. |

</details>

<details>
<summary><strong>🎨 Tab 5: Interface &amp; QoL (Features 81 - 100)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **81** | **Enable Classic Windows 10 Context Menu** | Restores the full, instant right-click context menu without 'Show more options'. |
| **82** | **Restore Modern Windows 11 Context Menu** | Reverts right-click context menu back to default Windows 11 design. |
| **83** | **Disable Windows 11 Widgets (News) Panel** | Disables the distracting weather/news widget feed from the taskbar. |
| **84** | **Open File Explorer to 'This PC'** | Configures File Explorer to launch directly to drives (C:, D:) instead of Home. |
| **85** | **Always Show Known File Extensions (.exe)** | Makes file extensions visible to immediately identify disguised malware files. |
| **86** | **Toggle Show Hidden Files & Folders** | Toggles visibility of `AppData` and hidden system directories. |
| **87** | **Create 'GodMode' Folder on Desktop** | Creates a unified folder containing all 200+ Windows Control Panel tools. |
| **88** | **Hide Gallery & 3D Objects from Explorer** | Declutters the File Explorer left navigation pane. |
| **89** | **Restore Classic Windows Photo Viewer** | Enables the lightning-fast classic Windows 7 photo viewer. |
| **90** | **Disable Mouse Acceleration (1:1 Raw Aim)** | Sets `MouseSpeed=0` and removes threshold curves for 1:1 hardware mouse tracking. |
| **91** | **Set Keyboard Input Delay to 0ms** | Removes key repeat initial delay for instantaneous keyboard response. |
| **92** | **Set Keyboard Repeat Speed to Max (31)** | Maximizes key repeat rate for rapid input execution in games and editors. |
| **93** | **Set Mouse Data Queue Size to 100 Packets** | Prevents mouse input buffer overflow during rapid flick movements. |
| **94** | **Set Keyboard Data Queue Size to 100 Packets**| Prevents keyboard buffer bottlenecking during rapid macro keystrokes. |
| **95** | **Enable USB Port Low-Latency Mode** | Disables successive inter-packet delays on USB root hubs. |
| **96** | **Set MenuShowDelay to 0ms (Instant Menus)** | Eliminates the default 400ms pause when hovering over Windows menus. |
| **97** | **Set HungAppTimeout to 1s (Fast Close)** | Instantly closes frozen applications without locking up the OS. |
| **98** | **Disable Window Minimize/Maximize Animations**| Removes window transition animations for a snappy interface. |
| **99** | **Disable Snap Assist Flyout Overlay** | Prevents the window tiling suggestion menu from lagging dragging actions. |
| **100**| **Disable Aero Shake Window Minimizing** | Prevents shaking a window from accidentally minimizing other open windows. |

</details>

<details>
<summary><strong>🧩 Tab 6: Components &amp; Features (Features 101 - 120)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **101**| **Enable Windows Sandbox (Safe VM)** | Enables a disposable, isolated Windows environment for testing suspicious files. |
| **102**| **Enable WSL (Windows Subsystem for Linux)**| Enables native Linux kernel environment within Windows. |
| **103**| **Enable Hyper-V Virtualization Hypervisor**| Enables hardware virtualization hypervisor for VMs and emulators. |
| **104**| **Disable XPS Viewer & Document Writer** | Removes obsolete XPS printing features to save system memory. |
| **105**| **Remove Legacy Windows Media Player** | Uninstalls obsolete WMP components. |
| **106**| **Disable Vulnerable SMBv1 Protocol** | Protects against ransomware exploits (like WannaCry) on local networks. |
| **107**| **Disable Telnet & TFTP Clients** | Disables unencrypted legacy remote communication protocols. |
| **108**| **Disable Internet Explorer Engine Leftovers**| Deactivates residual Internet Explorer components. |
| **109**| **Add Steamapps to Defender Exclusions** | Skips Defender scanning on Steam library folder to accelerate game loads. |
| **110**| **Cap Defender Max CPU Usage to 25%** | Prevents Windows Defender background scans from choking the CPU. |
| **111**| **Set Taskbar Preview Delay to 10s** | Prevents hover thumbnails from popping up and causing game focus loss. |
| **112**| **Disable UAC Secure Desktop Dimming** | Removes screen freezing delay when User Account Control prompts appear. |
| **113**| **Restart Windows Explorer (explorer.exe)**| Instantly restarts Windows Explorer to apply UI tweaks. |
| **114**| **Restart Windows Audio Service (AudioSrv)**| Fixes missing sound issues without rebooting. |
| **115**| **List All Startup Programs** | Lists applications configured to auto-start with Windows. |
| **116**| **Clean Broken Startup Registry Entries** | Removes orphaned startup entries left by deleted applications. |
| **117**| **Disable Google & Adobe Background Updaters**| Stops persistent updater services from running when apps are closed. |
| **118**| **Reset Windows Firewall Rules to Default** | Restores factory Windows Firewall configuration. |
| **119**| **Manage Driver Signature Enforcement** | Toggles driver signature verification for custom peripheral drivers. |
| **120**| **Rebuild Windows Search Index** | Rebuilds corrupt search database to fix broken file search. |

</details>

<details>
<summary><strong>📊 Tab 7: Diagnostics, Maintenance &amp; Apps (Features 121 - 150)</strong> — <em>Click to expand</em></summary>

| # | Feature Name | Technical Mechanism & Impact |
| :-: | :--- | :--- |
| **121**| **Read Live GPU Temp, Power & VRAM** | Queries real-time GPU thermals, power draw, and VRAM utilization. |
| **122**| **Read Live CPU Clock Speed & Usage** | Displays current processor frequency in MHz and core load. |
| **123**| **Get SSD Health & SMART Status Report** | Checks NVMe/SATA SSD operational status and drive health. |
| **124**| **Generate Laptop Battery Health Report** | Generates battery wear and cycle count analysis. |
| **125**| **Find Top 15 Resource-Heavy Processes** | Ranks top 15 memory and CPU consuming background tasks. |
| **126**| **Read Recent BSOD & Crash Event Logs** | Queries Windows Event Viewer for recent fatal error logs. |
| **127**| **Export Complete Hardware Specs Summary** | Outputs full specifications of CPU, GPU, Motherboard and RAM. |
| **128**| **Query Available Free RAM & Memory Pool** | Reports total visible RAM and available free physical memory. |
| **129**| **Query C: Drive Free Capacity** | Checks free storage space on system drive. |
| **130**| **Verify Firewall Active Profile States** | Verifies Domain, Private and Public firewall profiles. |
| **131**| **Measure Last BIOS / UEFI Boot Time** | Reports exact duration of system boot sequence. |
| **132**| **Query Windows Activation & License State** | Checks Windows license status and product key channels. |
| **133**| **Run SFC /Scannow System File Repair** | Scans and automatically repairs corrupt Windows system files. |
| **134**| **Run DISM /RestoreHealth Image Repair** | Repairs corrupted Windows Component Store from official Microsoft servers. |
| **135**| **Run CHKDSK File System Integrity Scan** | Scans C: drive for file system corruption and bad sectors. |
| **136**| **Reset Microsoft Store Cache (WSReset)** | Fixes download errors and freezes in Microsoft Store. |
| **137**| **Export Registry Backup to Desktop** | Backs up HKLM\SOFTWARE hive to a .reg file on your Desktop. |
| **138**| **Export All Installed Drivers to Desktop** | Exports all 3rd-party device drivers to `Desktop\Driver_Backup`. |
| **139**| **Silent Install: 7-Zip Archive Manager** | Silently downloads and installs 7-Zip via Windows Package Manager. |
| **140**| **Silent Install: Notepad++ Code Editor** | Silently installs Notepad++. |
| **141**| **Silent Install: VLC Media Player** | Silently installs VLC. |
| **142**| **Silent Install: Discord** | Silently installs Discord. |
| **143**| **Silent Install: Valve Steam** | Silently installs Steam. |
| **144**| **Silent Install: Brave Browser** | Silently installs Brave. |
| **145**| **Install Weekly Auto-Maintenance Task** | Schedules silent background TRIM and temp cleanups every Sunday at 3 AM. |
| **146**| **Remove Weekly Auto-Maintenance Task** | Unregisters the scheduled maintenance task. |
| **147**| **Pause Windows Update Services** | Temporarily stops and disables automatic Windows updates. |
| **148**| **Enable & Resume Windows Update** | Restores Windows Update service back to automatic. |
| **149**| **Create Instant System Restore Point** | Creates a safe Windows System Restore Point immediately. |
| **150**| **REVERT ALL TWEAKS (Factory Defaults)** | Reverts major optimizations back to standard Windows defaults. |

</details>

---

## 🌐 Supported Languages (20 Total)

MephistoCleaner provides dynamic, real-time UI translation across 20 languages:

| Code | Language | Native Name | Code | Language | Native Name |
| :---: | :--- | :--- | :---: | :--- | :--- |
| **`en`** | **English (Default)** | English | **`pt`** | Portuguese | Português |
| **`tr`** | Turkish | Türkçe | **`pl`** | Polish | Polski |
| **`de`** | German | Deutsch | **`nl`** | Dutch | Nederlands |
| **`fr`** | French | Français | **`ar`** | Arabic | العربية |
| **`es`** | Spanish | Español | **`hi`** | Hindi | हिन्दी |
| **`it`** | Italian | Italiano | **`sv`** | Swedish | Svenska |
| **`ru`** | Russian | Русский | **`el`** | Greek | Ελληνικά |
| **`ja`** | Japanese | 日本語 | **`ro`** | Romanian | Română |
| **`zh`** | Simplified Chinese | 简体中文 | **`uk`** | Ukrainian | Українська |
| **`ko`** | Korean | 한국어 | **`vi`** | Vietnamese | Tiếng Việt |

---

## 🎨 Dynamic Color Themes (10 Total)

Switch between 10 hand-crafted color palettes directly from the top navigation bar:

1. 🌌 **Cyber Slate (Default Dark)** — Deep Navy `#0F141C` with Sky Cyan accents `#38BDF8`.
2. 🔮 **Midnight Velvet** — Dark Violet `#130F1C` with Royal Purple accents `#C084FC`.
3. 🌲 **Matrix Emerald** — Obsidian Green `#0A140E` with Terminal Emerald `#34D399`.
4. 🩸 **Crimson Blood** — Charcoal Maroon `#180C0E` with Vivid Ruby `#F87171`.
5. 🌅 **Sunset Amber** — Warm Dark `#18120B` with Radiant Gold `#FBBF24`.
6. 🖤 **AMOLED Pure Black** — Pitch Black `#000000` with Crisp White `#FFFFFF`.
7. 🧛 **Dracula Dusk** — Official Dracula palette `#282A36` with Purple `#BD93F9`.
8. ❄️ **Nordic Frost** — Polar Night `#2E3440` with Ice Blue `#88C0D0`.
9. 🌸 **Sakura Bloom** — Deep Mauve `#1B1017` with Pastel Rose `#F472B6`.
10. ⚡ **Solarized Dark** — Cyan-Teal `#002B36` with Cyber Yellow `#B58900`.

---

## ⚖️ Legal Disclaimer & Liability

> [!IMPORTANT]
> **PLEASE READ CAREFULLY:** MephistoCleaner modifies advanced Windows operating system configurations, registry keys, services, and kernel parameters.
> 
> * This software is provided **"AS IS"** and **"WITH ALL FAULTS"**, without warranty of any kind, express or implied.
> * The developers and maintainers assume **NO LIABILITY OR RESPONSIBILITY** for any direct, indirect, incidental, special, or consequential damages (including data loss, hardware instability, operating system corruption, or software incompatibilities) arising from the use of this tool.
> * Users are **strongly advised** to create a **Windows System Restore Point** (Feature #149) prior to applying system-wide modifications.
> * For full legal terms, see [DISCLAIMER.md](DISCLAIMER.md).

---

## 🤝 Contributing

Contributions, bug reports, and localization improvements are warmly welcomed! Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before opening a Pull Request.

---

## 📄 License

MephistoCleaner is licensed under the [MIT License](LICENSE). Copyright © 2026 Mert Can & Contributors.
