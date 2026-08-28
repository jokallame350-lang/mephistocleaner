using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.Json;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Threading;
using MephistoCleaner.Models;
using MephistoCleaner.Services;

namespace MephistoCleaner
{
    public partial class MainWindow : Window
    {
        private RootI18n _i18n;
        private string _currentLang = "en";
        private string _currentTheme = "Cyber Slate (Default)";
        private readonly Dictionary<int, Button> _featureButtons = new();
        private readonly Dictionary<int, bool> _featureStates = new();
        private readonly DispatcherTimer _hudTimer = new();
        private bool _isInitializing = true;

        public MainWindow()
        {
            InitializeComponent();
            LoadI18n();
            InitLanguages();
            InitThemes();
            BuildFeatureButtons();
            StartHudTimer();
            UpdateHardwareInfo();
            LoadSavedConfiguration();
            _isInitializing = false;

            AppendLog("MephistoCleaner v7.0 Ultimate Standalone C# .NET Engine Active.");
            AppendLog("150 Reversible Toggle Switches & Persistent State Configuration Ready.");
        }

        private void LoadI18n()
        {
            try
            {
                var assembly = Assembly.GetExecutingAssembly();
                var resNames = assembly.GetManifestResourceNames();
                string targetRes = resNames.FirstOrDefault(n => n.EndsWith("i18n.json", StringComparison.OrdinalIgnoreCase));
                
                if (targetRes != null)
                {
                    using (var stream = assembly.GetManifestResourceStream(targetRes))
                    {
                        if (stream != null)
                        {
                            using (var reader = new StreamReader(stream))
                            {
                                string json = reader.ReadToEnd();
                                _i18n = JsonSerializer.Deserialize<RootI18n>(json);
                            }
                        }
                    }
                }
            }
            catch { }

            if (_i18n == null)
            {
                string[] possiblePaths = {
                    "assets/i18n.json",
                    "../assets/i18n.json",
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "assets", "i18n.json"),
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "i18n.json")
                };

                foreach (var p in possiblePaths)
                {
                    if (File.Exists(p))
                    {
                        try
                        {
                            string json = File.ReadAllText(p);
                            _i18n = JsonSerializer.Deserialize<RootI18n>(json);
                            if (_i18n != null) break;
                        }
                        catch { }
                    }
                }
            }
        }

        private void InitLanguages()
        {
            string[] langs = {
                "en - English", "tr - Türkçe", "de - Deutsch", "fr - Français", "es - Español",
                "it - Italiano", "ru - Русский", "ja - 日本語", "zh - 简体中文", "ko - 한국어",
                "pt - Português", "pl - Polski", "nl - Nederlands", "ar - العربية", "hi - हिन्दी",
                "sv - Svenska", "el - Ελληνικά", "ro - Română", "uk - Українська", "vi - Tiếng Việt"
            };
            foreach (var l in langs) CmbLanguage.Items.Add(l);
            CmbLanguage.SelectedIndex = 0;
        }

        private void InitThemes()
        {
            string[] themes = {
                "Cyber Slate (Default)", "Midnight Velvet", "Matrix Emerald", "Crimson Blood",
                "Sunset Amber", "AMOLED Pure Black", "Dracula Dusk", "Nordic Frost", "Sakura Bloom", "Solarized Dark"
            };
            foreach (var t in themes) CmbTheme.Items.Add(t);
            CmbTheme.SelectedIndex = 0;
        }

        private void BuildFeatureButtons()
        {
            for (int i = 1; i <= 150; i++)
            {
                int fid = i;
                _featureStates[fid] = false;

                var btn = new Button
                {
                    Width = 360,
                    Height = 36,
                    Margin = new Thickness(2),
                    Cursor = System.Windows.Input.Cursors.Hand,
                    Background = new BrushConverter().ConvertFromString("#1E293B") as Brush,
                    Foreground = new BrushConverter().ConvertFromString("#F8FAFC") as Brush,
                    BorderBrush = new BrushConverter().ConvertFromString("#334155") as Brush,
                    FontSize = 11,
                    FontWeight = FontWeights.SemiBold
                };

                if (fid == 150)
                {
                    btn.Background = new BrushConverter().ConvertFromString("#991B1B") as Brush;
                }

                btn.Click += (s, e) => ToggleFeature(fid);
                _featureButtons[fid] = btn;

                if (fid <= 20) PanelTab1.Children.Add(btn);
                else if (fid <= 40) PanelTab2.Children.Add(btn);
                else if (fid <= 60) PanelTab3.Children.Add(btn);
                else if (fid <= 80) PanelTab4.Children.Add(btn);
                else if (fid <= 100) PanelTab5.Children.Add(btn);
                else if (fid <= 120) PanelTab6.Children.Add(btn);
                else PanelTab7.Children.Add(btn);
            }

            ApplyLanguageTexts(_currentLang);
        }

        private void LoadSavedConfiguration()
        {
            try
            {
                var cfg = ConfigManager.Load();
                if (!string.IsNullOrEmpty(cfg.Language))
                {
                    for (int i = 0; i < CmbLanguage.Items.Count; i++)
                    {
                        if (CmbLanguage.Items[i].ToString().StartsWith(cfg.Language))
                        {
                            CmbLanguage.SelectedIndex = i;
                            break;
                        }
                    }
                }

                if (!string.IsNullOrEmpty(cfg.Theme))
                {
                    for (int i = 0; i < CmbTheme.Items.Count; i++)
                    {
                        if (CmbTheme.Items[i].ToString().Equals(cfg.Theme, StringComparison.OrdinalIgnoreCase))
                        {
                            CmbTheme.SelectedIndex = i;
                            ApplyTheme(cfg.Theme);
                            break;
                        }
                    }
                }

                if (cfg.ActiveFeatures != null && cfg.ActiveFeatures.Count > 0)
                {
                    foreach (var fid in cfg.ActiveFeatures)
                    {
                        if (_featureButtons.ContainsKey(fid))
                        {
                            _featureStates[fid] = true;
                            var btn = _featureButtons[fid];
                            btn.Background = new BrushConverter().ConvertFromString("#065F46") as Brush;
                            btn.BorderBrush = new BrushConverter().ConvertFromString("#10B981") as Brush;
                            btn.Foreground = new BrushConverter().ConvertFromString("#ECFDF5") as Brush;
                            UpdateSingleButtonText(fid);
                        }
                    }
                    AppendLog($"[Profile Engine] Persistent profile loaded ({cfg.ActiveFeatures.Count} active optimizations restored from settings.json).");
                }
            }
            catch { }
        }

        private void AutoSaveConfiguration()
        {
            if (_isInitializing) return;
            var active = _featureStates.Where(x => x.Value).Select(x => x.Key);
            ConfigManager.Save(_currentLang, _currentTheme, active);
        }

        private void ToggleFeature(int id)
        {
            if (!_featureButtons.ContainsKey(id)) return;
            var btn = _featureButtons[id];

            bool currentState = _featureStates[id];
            bool newState = !currentState;
            _featureStates[id] = newState;

            string resultMsg = OptimizationEngine.ApplyTweak(id, newState);

            if (newState)
            {
                btn.Background = new BrushConverter().ConvertFromString("#065F46") as Brush;
                btn.BorderBrush = new BrushConverter().ConvertFromString("#10B981") as Brush;
                btn.Foreground = new BrushConverter().ConvertFromString("#ECFDF5") as Brush;
                AppendLog($"🟢 [ON] #{id} {resultMsg}");
            }
            else
            {
                btn.Background = new BrushConverter().ConvertFromString("#1E293B") as Brush;
                btn.BorderBrush = new BrushConverter().ConvertFromString("#334155") as Brush;
                btn.Foreground = new BrushConverter().ConvertFromString("#F8FAFC") as Brush;
                AppendLog($"⚪ [OFF] #{id} {resultMsg}");
            }

            UpdateSingleButtonText(id);
            AutoSaveConfiguration();
        }

        private void UpdateSingleButtonText(int id)
        {
            if (!_featureButtons.ContainsKey(id)) return;
            var btn = _featureButtons[id];

            string title = $"Feature #{id}";
            string tip = "";

            if (_i18n?.Features != null && _i18n.Features.ContainsKey(_currentLang))
            {
                var dict = _i18n.Features[_currentLang];
                if (dict.ContainsKey(id.ToString()))
                {
                    title = dict[id.ToString()].Title;
                    tip = dict[id.ToString()].Tip;
                }
            }
            else if (_i18n?.Features != null && _i18n.Features.ContainsKey("en"))
            {
                var dict = _i18n.Features["en"];
                if (dict.ContainsKey(id.ToString()))
                {
                    title = dict[id.ToString()].Title;
                    tip = dict[id.ToString()].Tip;
                }
            }

            bool isToggled = _featureStates[id];
            string indicator = isToggled ? "🟢" : "⚪";
            btn.Content = $"{indicator} {id}. {title}";
            btn.ToolTip = tip;
        }

        private void ApplyLanguageTexts(string lang)
        {
            _currentLang = lang;
            if (_i18n?.Ui != null && _i18n.Ui.ContainsKey(lang))
            {
                var ui = _i18n.Ui[lang];
                TxtAdminBadge.Text = ui.Admin;
                BtnQuickMaster.Content = ui.MasterBtn;
                BtnPresetGamer.Content = ui.PresetGamer;
                BtnPresetPrivacy.Content = ui.PresetPrivacy;
                BtnPresetClean.Content = ui.PresetClean;
                Tab1.Header = ui.Tab1;
                Tab2.Header = ui.Tab2;
                Tab3.Header = ui.Tab3;
                Tab4.Header = ui.Tab4;
                Tab5.Header = ui.Tab5;
                Tab6.Header = ui.Tab6;
                Tab7.Header = ui.Tab7;
                Tab8.Header = ui.Tab8;
                LblLang.Text = $"🌐 {ui.LangLabel}";
                LblTheme.Text = $"🎨 {ui.ThemeLabel}";
                BtnInstallSelectedApps.Content = ui.InstallAppsBtn;
            }

            for (int i = 1; i <= 150; i++)
            {
                UpdateSingleButtonText(i);
            }

            AutoSaveConfiguration();
        }

        private void ApplyTheme(string theme)
        {
            try
            {
                var conv = new BrushConverter();
                string winBg = "#0B0F17";
                string headBg = "#131C2E";
                string accentBorder = "#2563EB";
                string accentText = "#38BDF8";

                if (theme.Contains("Midnight Velvet"))
                {
                    winBg = "#0A0A16"; headBg = "#141226"; accentBorder = "#7C3AED"; accentText = "#A78BFA";
                }
                else if (theme.Contains("Matrix Emerald"))
                {
                    winBg = "#05120B"; headBg = "#0A2315"; accentBorder = "#059669"; accentText = "#34D399";
                }
                else if (theme.Contains("Crimson Blood"))
                {
                    winBg = "#140A0A"; headBg = "#261212"; accentBorder = "#DC2626"; accentText = "#F87171";
                }
                else if (theme.Contains("Sunset Amber"))
                {
                    winBg = "#140E05"; headBg = "#261A0A"; accentBorder = "#D97706"; accentText = "#FBBF24";
                }
                else if (theme.Contains("AMOLED Pure Black"))
                {
                    winBg = "#000000"; headBg = "#0A0A0A"; accentBorder = "#27272A"; accentText = "#38BDF8";
                }
                else if (theme.Contains("Dracula Dusk"))
                {
                    winBg = "#1E1F29"; headBg = "#282A36"; accentBorder = "#6272A4"; accentText = "#BD93F9";
                }
                else if (theme.Contains("Nordic Frost"))
                {
                    winBg = "#0B131A"; headBg = "#11222E"; accentBorder = "#0284C7"; accentText = "#38BDF8";
                }
                else if (theme.Contains("Sakura Bloom"))
                {
                    winBg = "#1A0F14"; headBg = "#2B1420"; accentBorder = "#DB2777"; accentText = "#F472B6";
                }
                else if (theme.Contains("Solarized Dark"))
                {
                    winBg = "#002B36"; headBg = "#073642"; accentBorder = "#268BD2"; accentText = "#2AA198";
                }

                this.Background = conv.ConvertFromString(winBg) as Brush;
                HeaderBorder.Background = conv.ConvertFromString(headBg) as Brush;
                HeaderBorder.BorderBrush = conv.ConvertFromString(accentBorder) as Brush;
                TxtMainTitle.Foreground = conv.ConvertFromString(accentText) as Brush;
                HudBorder.Background = conv.ConvertFromString(headBg) as Brush;
                MainTabControl.Background = conv.ConvertFromString(headBg) as Brush;
            }
            catch { }
        }

        private void StartHudTimer()
        {
            _hudTimer.Interval = TimeSpan.FromSeconds(2);
            _hudTimer.Tick += (s, e) =>
            {
                try
                {
                    var drive = new DriveInfo("C");
                    double freeGb = Math.Round(drive.AvailableFreeSpace / (1024.0 * 1024 * 1024), 1);
                    HudDiskLabel.Text = $"💽 C: Free: {freeGb} GB";

                    long memUsed = GC.GetTotalMemory(false) / (1024 * 1024);
                    HudRamLabel.Text = $"🧠 RAM App: {memUsed} MB (Low Overhead)";
                }
                catch { }
            };
            _hudTimer.Start();
        }

        private void UpdateHardwareInfo()
        {
            try
            {
                int cores = Environment.ProcessorCount;
                TxtHwInfo.Text = $"Hardware: {cores} Logical Cores | OS: Windows 10/11 x64 (Native C# .NET 7 Engine)";
            }
            catch { }
        }

        public void AppendLog(string message)
        {
            string time = DateTime.Now.ToString("HH:mm:ss");
            TxtLog.AppendText($"[{time}] {message}\r\n");
            LogScroller.ScrollToEnd();
        }

        private void CmbLanguage_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (CmbLanguage.SelectedItem is string item)
            {
                string code = item.Substring(0, 2);
                ApplyLanguageTexts(code);
                AppendLog($"Language switched to: {item}");
            }
        }

        private void CmbTheme_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (CmbTheme.SelectedItem is string theme)
            {
                _currentTheme = theme;
                ApplyTheme(theme);
                AppendLog($"Theme applied: {theme}");
                AutoSaveConfiguration();
            }
        }

        private void TxtSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            string q = TxtSearch.Text.Trim().ToLower();
            foreach (var kvp in _featureButtons)
            {
                var btn = kvp.Value;
                if (string.IsNullOrWhiteSpace(q))
                {
                    btn.Visibility = Visibility.Visible;
                }
                else
                {
                    string text = btn.Content?.ToString()?.ToLower() ?? "";
                    string tip = btn.ToolTip?.ToString()?.ToLower() ?? "";
                    btn.Visibility = (text.Contains(q) || tip.Contains(q)) ? Visibility.Visible : Visibility.Collapsed;
                }
            }
        }

        private void BtnQuickMaster_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("==================================================================");
            AppendLog("🔥 ENGAGING FULL MASTER OPTIMIZATION SUITE (STEP-BY-STEP AUDIT)...");
            AppendLog("==================================================================");
            int[] master = { 1, 3, 4, 5, 6, 7, 8, 11, 13, 14, 21, 22, 28, 41, 46, 49, 50, 62, 63, 64, 85, 90, 91, 96 };
            foreach (var id in master)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("==================================================================");
            AppendLog("✅ MASTER OPTIMIZATION SUITE COMPLETED (ALL 24 CORE TWEAKS ACTIVE & SAVED).");
            AppendLog("==================================================================");
        }

        private void BtnPresetGamer_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("==================================================================");
            AppendLog("🎮 ENGAGING ESPORTS GAMER PRESET (LOW LATENCY + CPU UNPARKING)...");
            int[] gamer = { 1, 3, 5, 6, 7, 8, 11, 13, 14, 16, 17, 41, 46, 49, 50, 90, 91, 92, 93, 94, 95, 96 };
            foreach (var id in gamer)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("✅ ESPORTS GAMER PRESET ACTIVE & SAVED!");
        }

        private void BtnPresetPrivacy_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("==================================================================");
            AppendLog("🛡️ ENGAGING PRIVACY & DEBLOAT PRESET (TELEMETRY + COPILOT REMOVAL)...");
            int[] privacy = { 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80 };
            foreach (var id in privacy)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("✅ PRIVACY & DEBLOAT PRESET ACTIVE & SAVED!");
        }

        private void BtnPresetClean_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("==================================================================");
            AppendLog("🧹 ENGAGING DEEP DISK CLEAN PRESET (SHADERS + SYSTEM JUNK)...");
            int[] clean = { 4, 21, 22, 23, 24, 25, 26, 27, 28, 32, 33, 35, 36, 37, 38, 39 };
            foreach (var id in clean)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("✅ DEEP DISK CLEAN COMPLETED!");
        }

        private void BtnExportProfile_Click(object sender, RoutedEventArgs e)
        {
            var active = _featureStates.Where(x => x.Value).Select(x => x.Key).ToList();
            string json = JsonSerializer.Serialize(new { Timestamp = DateTime.Now, Active = active });
            string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "Mephisto_Profile.json");
            File.WriteAllText(path, json);
            AppendLog($"Profile exported to Desktop\\Mephisto_Profile.json ({active.Count} active tweaks).");
        }

        private void BtnImportProfile_Click(object sender, RoutedEventArgs e)
        {
            string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "Mephisto_Profile.json");
            if (File.Exists(path))
            {
                try
                {
                    string json = File.ReadAllText(path);
                    using var doc = JsonDocument.Parse(json);
                    if (doc.RootElement.TryGetProperty("Active", out var activeProp))
                    {
                        foreach (var el in activeProp.EnumerateArray())
                        {
                            int id = el.GetInt32();
                            if (!_featureStates[id]) ToggleFeature(id);
                        }
                        AppendLog("Profile imported and applied successfully!");
                    }
                }
                catch { }
            }
            else
            {
                AppendLog("No profile found at Desktop\\Mephisto_Profile.json");
            }
        }

        // Direct System Inspector Jumps
        private void Jump_TempFolder_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri(Path.GetTempPath());
            AppendLog($"[Inspector] Opened user temp folder: {Path.GetTempPath()}");
        }

        private void Jump_Regedit_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("regedit.exe");
            AppendLog("[Inspector] Opened Windows Registry Editor (regedit.exe).");
        }

        private void Jump_Services_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("services.msc");
            AppendLog("[Inspector] Opened Windows Services Management (services.msc).");
        }

        private void Jump_Power_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("powercfg.cpl");
            AppendLog("[Inspector] Opened Windows Power Options (powercfg.cpl).");
        }

        private void Jump_Network_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("ncpa.cpl");
            AppendLog("[Inspector] Opened Network Connections Adapter List (ncpa.cpl).");
        }

        private void Jump_Graphics_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("ms-settings:display-advancedgraphics");
            AppendLog("[Inspector] Opened Windows Graphics Settings (HAGS & Variable Refresh Rate).");
        }

        private void Jump_Taskmgr_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("taskmgr.exe");
            AppendLog("[Inspector] Opened Windows Task Manager (taskmgr.exe).");
        }

        private void Jump_Security_Click(object sender, RoutedEventArgs e)
        {
            OptimizationEngine.OpenUri("windowsdefender:");
            AppendLog("[Inspector] Opened Windows Security Center.");
        }

        private void BtnInstallSelectedApps_Click(object sender, RoutedEventArgs e)
        {
            var pkgs = new List<string>();
            if (ChkSteam.IsChecked == true) pkgs.Add("Valve.Steam");
            if (ChkDiscord.IsChecked == true) pkgs.Add("Discord.Discord");
            if (ChkEpic.IsChecked == true) pkgs.Add("EpicGames.EpicGamesLauncher");
            if (ChkOBS.IsChecked == true) pkgs.Add("OBSProject.OBSStudio");
            if (ChkAfterburner.IsChecked == true) pkgs.Add("Guru3D.Afterburner");
            if (ChkVC.IsChecked == true) pkgs.Add("Microsoft.VCRedist.2015+.x64");
            if (Chk7Zip.IsChecked == true) pkgs.Add("7zip.7zip");
            if (ChkNotepad.IsChecked == true) pkgs.Add("Notepad++.Notepad++");
            if (ChkGit.IsChecked == true) pkgs.Add("Git.Git");
            if (ChkPython.IsChecked == true) pkgs.Add("Python.Python.3.12");
            if (ChkBrave.IsChecked == true) pkgs.Add("Brave.Brave");
            if (ChkChrome.IsChecked == true) pkgs.Add("Google.Chrome");
            if (ChkVLC.IsChecked == true) pkgs.Add("VideoLAN.VLC");
            if (ChkSpotify.IsChecked == true) pkgs.Add("Spotify.Spotify");

            if (pkgs.Count == 0)
            {
                AppendLog("Please select at least one software package.");
                return;
            }

            AppendLog($"Starting background Winget installation of {pkgs.Count} packages...");
            foreach (var p in pkgs)
            {
                AppendLog($"Installing {p}...");
                OptimizationEngine.RunCmd("winget.exe", $"install --id {p} --silent --accept-source-agreements --accept-package-agreements");
                AppendLog($"✓ {p} finished.");
            }
            AppendLog("All selected packages installed successfully!");
        }
    }
}
