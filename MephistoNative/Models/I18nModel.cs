using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace MephistoCleaner.Models
{
    public class LanguageUi
    {
        public string Title { get; set; }
        public string Admin { get; set; }
        public string SafetyPrompt { get; set; }
        public string MasterBtn { get; set; }
        public string PresetGamer { get; set; }
        public string PresetPrivacy { get; set; }
        public string PresetClean { get; set; }
        public string PresetExport { get; set; }
        public string PresetImport { get; set; }
        public string SearchPlaceholder { get; set; }
        public string Tab1 { get; set; }
        public string Tab2 { get; set; }
        public string Tab3 { get; set; }
        public string Tab4 { get; set; }
        public string Tab5 { get; set; }
        public string Tab6 { get; set; }
        public string Tab7 { get; set; }
        public string Tab8 { get; set; }
        public string LangLabel { get; set; }
        public string ThemeLabel { get; set; }
        public string HardwareLabel { get; set; }
        public string InstallAppsBtn { get; set; }
    }

    public class FeatureInfo
    {
        public string Title { get; set; }
        public string Tip { get; set; }
    }

    public class RootI18n
    {
        [JsonPropertyName("ui")]
        public Dictionary<string, LanguageUi> Ui { get; set; }

        [JsonPropertyName("features")]
        public Dictionary<string, Dictionary<string, FeatureInfo>> Features { get; set; }
    }
}
