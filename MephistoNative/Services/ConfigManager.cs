using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;

namespace MephistoCleaner.Services
{
    public class AppConfig
    {
        public string Language { get; set; } = "en";
        public string Theme { get; set; } = "Cyber Slate (Default)";
        public List<int> ActiveFeatures { get; set; } = new();
        public DateTime LastSaved { get; set; } = DateTime.Now;
    }

    public static class ConfigManager
    {
        private static readonly string ConfigDir = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), 
            "MephistoCleaner"
        );
        private static readonly string ConfigFile = Path.Combine(ConfigDir, "settings.json");

        public static AppConfig Load()
        {
            try
            {
                if (File.Exists(ConfigFile))
                {
                    string json = File.ReadAllText(ConfigFile);
                    var cfg = JsonSerializer.Deserialize<AppConfig>(json);
                    if (cfg != null) return cfg;
                }
            }
            catch { }

            return new AppConfig();
        }

        public static void Save(string lang, string theme, IEnumerable<int> activeFeatures)
        {
            try
            {
                if (!Directory.Exists(ConfigDir))
                {
                    Directory.CreateDirectory(ConfigDir);
                }

                var cfg = new AppConfig
                {
                    Language = lang,
                    Theme = theme,
                    ActiveFeatures = new List<int>(activeFeatures),
                    LastSaved = DateTime.Now
                };

                string json = JsonSerializer.Serialize(cfg, new JsonSerializerOptions { WriteIndented = true });
                File.WriteAllText(ConfigFile, json);
            }
            catch { }
        }
    }
}
