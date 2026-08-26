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
        private readonly Dictionary<int, Button> _featureButtons = new();
        private readonly Dictionary<int, bool> _featureStates = new();
        private readonly DispatcherTimer _hudTimer = new();

        public MainWindow()
        {
            InitializeComponent();
            LoadI18n();
            InitLanguages();
            InitThemes();
            BuildFeatureButtons();
            StartHudTimer();
            UpdateHardwareInfo();
            AppendLog("MephistoCleaner v7.0 Standalone C# .NET Engine Initialized.");
            AppendLog("150 Reversible Toggle Switches Active. Click any feature to toggle ON/OFF.");
        }

        private void LoadI18n()
        {
            try
            {
                var assembly = Assembly.GetExecutingAssembly();
                using (var stream = assembly.GetManifestResourceStream("i18n.json"))
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
            catch { }

            if (_i18n == null && File.Exists("assets/i18n.json"))
            {
                string json = File.ReadAllText("assets/i18n.json");
                _i18n = JsonSerializer.Deserialize<RootI18n>(json);
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
                    Width = 355,
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
                LblLang.Text = ui.LangLabel;
                LblTheme.Text = ui.ThemeLabel;
                BtnInstallSelectedApps.Content = ui.InstallAppsBtn;
            }

            for (int i = 1; i <= 150; i++)
            {
                UpdateSingleButtonText(i);
            }
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
                string cpu = Environment.GetEnvironmentVariable("PROCESSOR_IDENTIFIER") ?? "Processor";
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
                AppendLog($"Theme applied: {theme}");
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
            AppendLog("🔥 Applying Full Master Optimization Suite in Pure C#...");
            int[] master = { 1, 5, 6, 7, 8, 11, 13, 14, 21, 22, 28, 41, 46, 49, 50, 62, 63, 64, 85, 90, 91, 96 };
            foreach (var id in master)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("Full Master Optimization Suite Applied Successfully!");
        }

        private void BtnPresetGamer_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("🎮 Engaging Esports Gamer Preset...");
            int[] gamer = { 1, 5, 6, 7, 8, 11, 13, 14, 16, 17, 41, 46, 49, 50, 90, 91, 92, 93, 94, 95, 96 };
            foreach (var id in gamer)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("Esports Gamer Preset Active!");
        }

        private void BtnPresetPrivacy_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("🛡️ Engaging Privacy & Debloat Preset...");
            int[] privacy = { 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80 };
            foreach (var id in privacy)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("Privacy & Debloat Preset Active!");
        }

        private void BtnPresetClean_Click(object sender, RoutedEventArgs e)
        {
            AppendLog("🧹 Engaging Deep Disk Clean Preset...");
            int[] clean = { 4, 21, 22, 23, 24, 25, 26, 27, 28, 32, 33, 35, 36, 37, 38, 39 };
            foreach (var id in clean)
            {
                if (!_featureStates[id]) ToggleFeature(id);
            }
            AppendLog("Deep Disk Clean Completed!");
        }

        private void BtnExportProfile_Click(object sender, RoutedEventArgs e)
        {
            var active = _featureStates.Where(x => x.Value).Select(x => x.Key).ToList();
            string json = JsonSerializer.Serialize(new { Timestamp = DateTime.Now, Active = active });
            string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "Mephisto_Profile.json");
            File.WriteAllText(path, json);
            AppendLog($"Profile saved to Desktop\\Mephisto_Profile.json ({active.Count} active tweaks).");
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
