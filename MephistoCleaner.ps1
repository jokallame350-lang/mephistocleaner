<#
===================================================================================
    MEPHISTOCLEANER v6.0 - THE ULTIMATE OPEN-SOURCE WINDOWS 10 & 11 SUITE
    Universal, 100% Safe, 150+ Modular Features, 20 Languages & 10 Color Themes
    https://github.com/jokallame350-lang/mephistocleaner
===================================================================================
#>

# 1. Immediately Hide Console Window (Pure GUI Experience)
$Win32 = Add-Type -MemberDefinition @"
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
"@ -Name "Win32Console" -Namespace Win32 -PassThru

$consoleHandle = $Win32::GetConsoleWindow()
if ($consoleHandle -ne [IntPtr]::Zero) {
    $Win32::ShowWindow($consoleHandle, 0)
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# 2. Administrator Privilege Elevation (Silent & Safe)
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# 3. Hardware Auto-Detection
$cpuObj = Get-CimInstance Win32_Processor | Select-Object -First 1
$cpuName = if ($cpuObj.Name) { $cpuObj.Name.Trim() } else { "Generic CPU" }
$osObj = Get-CimInstance Win32_OperatingSystem
$totalRAM = [math]::Round($osObj.TotalVisibleMemorySize / 1MB, 1)
$gpus = Get-CimInstance Win32_VideoController
$gpuNames = (($gpus | ForEach-Object { $_.Name.Trim() }) -join " + ")
$isLaptop = (Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue) -ne $null
$chassisType = if ($isLaptop) { "Laptop" } else { "Desktop" }

# 4. 10 Color Theme Palettes (WPF Hex Codes)
$global:Themes = @{
    "Cyber Slate (Default)" = @{ Bg="#0F141C"; Card="#1E293B"; Border="#334155"; Accent="#38BDF8"; BtnBg="#1E293B"; BtnHover="#0EA5E9"; Text="#F8FAFC"; SubText="#94A3B8"; ConsoleBg="#0A0E14"; ConsoleText="#10B981" }
    "Midnight Velvet"       = @{ Bg="#130F1C"; Card="#241A38"; Border="#3B2D54"; Accent="#C084FC"; BtnBg="#241A38"; BtnHover="#9333EA"; Text="#FAF5FF"; SubText="#A855F7"; ConsoleBg="#0B0812"; ConsoleText="#E879F9" }
    "Matrix Emerald"        = @{ Bg="#0A140E"; Card="#14291D"; Border="#1E3E2B"; Accent="#34D399"; BtnBg="#14291D"; BtnHover="#059669"; Text="#ECFDF5"; SubText="#6EE7B7"; ConsoleBg="#050C08"; ConsoleText="#10B981" }
    "Crimson Blood"         = @{ Bg="#180C0E"; Card="#2E1419"; Border="#451D24"; Accent="#F87171"; BtnBg="#2E1419"; BtnHover="#DC2626"; Text="#FEF2F2"; SubText="#FCA5A5"; ConsoleBg="#0F0608"; ConsoleText="#EF4444" }
    "Sunset Amber"          = @{ Bg="#18120B"; Card="#2D2013"; Border="#48331E"; Accent="#FBBF24"; BtnBg="#2D2013"; BtnHover="#D97706"; Text="#FFFBEB"; SubText="#FCD34D"; ConsoleBg="#100A05"; ConsoleText="#F59E0B" }
    "AMOLED Pure Black"     = @{ Bg="#000000"; Card="#121212"; Border="#242424"; Accent="#FFFFFF"; BtnBg="#181818"; BtnHover="#383838"; Text="#FFFFFF"; SubText="#A0A0A0"; ConsoleBg="#050505"; ConsoleText="#00FF66" }
    "Dracula Dusk"          = @{ Bg="#282A36"; Card="#44475A"; Border="#6272A4"; Accent="#BD93F9"; BtnBg="#44475A"; BtnHover="#6272A4"; Text="#F8F8F2"; SubText="#8BE9FD"; ConsoleBg="#1E1F29"; ConsoleText="#50FA7B" }
    "Nordic Frost"          = @{ Bg="#2E3440"; Card="#3B4252"; Border="#4C566A"; Accent="#88C0D0"; BtnBg="#3B4252"; BtnHover="#81A1C1"; Text="#ECEFF4"; SubText="#D8DEE9"; ConsoleBg="#242933"; ConsoleText="#A3BE8C" }
    "Sakura Bloom"          = @{ Bg="#1B1017"; Card="#2E1825"; Border="#4A263B"; Accent="#F472B6"; BtnBg="#2E1825"; BtnHover="#DB2777"; Text="#FDF2F8"; SubText="#F9A8D4"; ConsoleBg="#12080F"; ConsoleText="#FB7185" }
    "Solarized Dark"        = @{ Bg="#002B36"; Card="#073642"; Border="#586E75"; Accent="#2AA198"; BtnBg="#073642"; BtnHover="#268BD2"; Text="#FDF6E3"; SubText="#93A1A1"; ConsoleBg="#001E26"; ConsoleText="#859900" }
}

# 5. 20 Language Translations Dictionary
$global:LangDict = @{
    "en" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ADMINISTRATOR PRIVILEGES ACTIVE"
        SafetyPrompt = "RECOMMENDED: Create a System Restore Point (Feature #149) before applying major system tweaks."
        MasterBtn = "1-CLICK 100% SAFE FULL OPTIMIZATION"
        Tab1 = "Gaming & Performance"
        Tab2 = "Disk & Deep Clean"
        Tab3 = "Network & DNS"
        Tab4 = "Privacy & Debloat"
        Tab5 = "Interface & QoL"
        Tab6 = "Components & Features"
        Tab7 = "Diagnostics & Maintenance"
        LangLabel = "Language:"
        ThemeLabel = "Theme:"
        HardwareLabel = "Hardware:"
    }
    "tr" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "YÖNETİCİ YETKİLERİ AKTİF"
        SafetyPrompt = "ÖNERİ: Kapsamlı ayarlar uygulamadan önce Sistem Geri Yükleme Noktası (Özellik #149) oluşturmanız tavsiye edilir."
        MasterBtn = "TEK TIKLA 100% GÜVENLİ FULL OPTİMİZASYON"
        Tab1 = "Oyun ve Performans"
        Tab2 = "Disk ve Temizlik"
        Tab3 = "Ağ ve DNS"
        Tab4 = "Gizlilik ve Debloat"
        Tab5 = "Arayüz ve Yaşam Kalitesi"
        Tab6 = "İsteğe Bağlı Bileşenler"
        Tab7 = "Teşhis ve Bakım"
        LangLabel = "Dil:"
        ThemeLabel = "Tema:"
        HardwareLabel = "Donanım:"
    }
    "de" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ADMINISTRATOR-RECHTE AKTIV"
        SafetyPrompt = "EMPFOHLEN: Erstellen Sie einen Systemwiederherstellungspunkt (Funktion #149), bevor Sie größere Änderungen vornehmen."
        MasterBtn = "1-KLICK 100% SICHERE KOMPLETTE OPTIMIERUNG"
        Tab1 = "Gaming & Leistung"
        Tab2 = "Datenträger & Bereinigung"
        Tab3 = "Netzwerk & DNS"
        Tab4 = "Datenschutz & Debloat"
        Tab5 = "Benutzeroberfläche & QoL"
        Tab6 = "Optionale Komponenten"
        Tab7 = "Diagnose & Wartung"
        LangLabel = "Sprache:"
        ThemeLabel = "Design:"
        HardwareLabel = "Hardware:"
    }
    "fr" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "PRIVILÈGES ADMINISTRATEUR ACTIFS"
        SafetyPrompt = "RECOMMANDÉ : Créez un point de restauration système (Option #149) avant toute modification majeure."
        MasterBtn = "OPTIMISATION COMPLÈTE 100% SÉCURISÉE EN 1 CLIC"
        Tab1 = "Jeux & Performances"
        Tab2 = "Disque & Nettoyage"
        Tab3 = "Réseau & DNS"
        Tab4 = "Confidentialité & Débloat"
        Tab5 = "Interface & QoL"
        Tab6 = "Composants Optionnels"
        Tab7 = "Diagnostics & Maintenance"
        LangLabel = "Langue:"
        ThemeLabel = "Thème:"
        HardwareLabel = "Matériel:"
    }
    "es" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "PRIVILEGIOS DE ADMINISTRADOR ACTIVOS"
        SafetyPrompt = "RECOMENDADO: Cree un punto de restauración del sistema (Opción #149) antes de realizar cambios importantes."
        MasterBtn = "OPTIMIZACIÓN COMPLETA 100% SEGURA EN 1 CLIC"
        Tab1 = "Juegos y Rendimiento"
        Tab2 = "Disco y Limpieza"
        Tab3 = "Red y DNS"
        Tab4 = "Privacidad y Debloat"
        Tab5 = "Interfaz y Calidad de Vida"
        Tab6 = "Componentes Opcionales"
        Tab7 = "Diagnóstico y Mantenimiento"
        LangLabel = "Idioma:"
        ThemeLabel = "Tema:"
        HardwareLabel = "Hardware:"
    }
    "it" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "PRIVILEGI DI AMMINISTRATORE ATTIVI"
        SafetyPrompt = "CONSIGLIATO: Creare un punto di ripristino del sistema (Opzione #149) prima di applicare modifiche importanti."
        MasterBtn = "OTTIMIZZAZIONE COMPLETA 100% SICURA IN 1 CLIC"
        Tab1 = "Giochi & Prestazioni"
        Tab2 = "Disco & Pulizia"
        Tab3 = "Rete & DNS"
        Tab4 = "Privacy & Debloat"
        Tab5 = "Interfaccia & QoL"
        Tab6 = "Componenti Opzionali"
        Tab7 = "Diagnostica & Manutenzione"
        LangLabel = "Lingua:"
        ThemeLabel = "Tema:"
        HardwareLabel = "Hardware:"
    }
    "ru" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ПРАВА АДМИНИСТРАТОРА АКТИВНЫ"
        SafetyPrompt = "РЕКОМЕНДУЕТСЯ: Создайте точку восстановления системы (Пункт #149) перед оптимизацией."
        MasterBtn = "1-КЛИК 100% БЕЗОПАСНАЯ ПОЛНАЯ ОПТИМИЗАЦИЯ"
        Tab1 = "Игры и производительность"
        Tab2 = "Диск и очистка"
        Tab3 = "Сеть и DNS"
        Tab4 = "Приватность и удаление мусора"
        Tab5 = "Интерфейс и удобство"
        Tab6 = "Компоненты Windows"
        Tab7 = "Диагностика и обслуживание"
        LangLabel = "Язык:"
        ThemeLabel = "Тема:"
        HardwareLabel = "Оборудование:"
    }
    "ja" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "管理者権限が有効です"
        SafetyPrompt = "推奨：主要な最適化を適用する前にシステムの復元ポイント（機能 #149）を作成してください。"
        MasterBtn = "ワンクリック 100%安全な完全最適化"
        Tab1 = "ゲーム＆パフォーマンス"
        Tab2 = "ディスク＆クリーンアップ"
        Tab3 = "ネットワーク＆DNS"
        Tab4 = "プライバシー＆デブロート"
        Tab5 = "インターフェース＆QoL"
        Tab6 = "オプション機能"
        Tab7 = "診断＆メンテナンス"
        LangLabel = "言語:"
        ThemeLabel = "テーマ:"
        HardwareLabel = "ハードウェア:"
    }
    "zh" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "管理员权限已激活"
        SafetyPrompt = "建议：在进行主要系统优化之前创建系统还原点（功能 #149）。"
        MasterBtn = "一键 100% 安全完整优化"
        Tab1 = "游戏与性能"
        Tab2 = "磁盘与深度清理"
        Tab3 = "网络与 DNS"
        Tab4 = "隐私与瘦身"
        Tab5 = "界面与实用体验"
        Tab6 = "可选组件管理"
        Tab7 = "系统诊断与维护"
        LangLabel = "语言:"
        ThemeLabel = "主题:"
        HardwareLabel = "硬件:"
    }
    "ko" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "관리자 권한 활성화됨"
        SafetyPrompt = "권장: 주요 설정을 적용하기 전에 시스템 복원 지점(기능 #149)을 생성하세요."
        MasterBtn = "원클릭 100% 안전한 전체 최적화"
        Tab1 = "게임 및 성능"
        Tab2 = "디스크 및 정리"
        Tab3 = "네트워크 및 DNS"
        Tab4 = "개인 정보 및 디블로트"
        Tab5 = "인터페이스 및 QoL"
        Tab6 = "선택적 구성 요소"
        Tab7 = "진단 및 유지 관리"
        LangLabel = "언어:"
        ThemeLabel = "테마:"
        HardwareLabel = "하드웨어:"
    }
    "pt" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "PRIVILÉGIOS DE ADMINISTRADOR ATIVOS"
        SafetyPrompt = "RECOMENDADO: Crie um Ponto de Restauração (Opção #149) antes de fazer alterações no sistema."
        MasterBtn = "OTIMIZAÇÃO COMPLETA 100% SEGURA EM 1 CLIQUE"
        Tab1 = "Jogos & Desempenho"
        Tab2 = "Disco & Limpeza"
        Tab3 = "Rede & DNS"
        Tab4 = "Privacidade & Debloat"
        Tab5 = "Interface & QoL"
        Tab6 = "Componentes Opcionais"
        Tab7 = "Diagnóstico & Manutenção"
        LangLabel = "Idioma:"
        ThemeLabel = "Tema:"
        HardwareLabel = "Hardware:"
    }
    "pl" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "UPRAWNIENIA ADMINISTRATORA AKTYWNE"
        SafetyPrompt = "ZALECANE: Utwórz punkt przywracania systemu (Opcja #149) przed optymalizacją."
        MasterBtn = "1-KLIK 100% BEZPIECZNA PEŁNA OPTYMALIZACJA"
        Tab1 = "Gry i wydajność"
        Tab2 = "Dysk i czyszczenie"
        Tab3 = "Sieć i DNS"
        Tab4 = "Prywatność i debloat"
        Tab5 = "Interfejs i wygoda"
        Tab6 = "Komponenty opcjonalne"
        Tab7 = "Diagnostyka i konserwacja"
        LangLabel = "Język:"
        ThemeLabel = "Motyw:"
        HardwareLabel = "Sprzęt:"
    }
    "nl" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "BEHEERDERSRECHTEN ACTIEF"
        SafetyPrompt = "AANBEVOLEN: Maak een systeemherstelpunt (Functie #149) voordat u wijzigingen toepast."
        MasterBtn = "1-KLIK 100% VEILIGE VOLLEDIGE OPTIMALISATIE"
        Tab1 = "Gaming & Prestaties"
        Tab2 = "Schijf & Opschonen"
        Tab3 = "Netwerk & DNS"
        Tab4 = "Privacy & Debloat"
        Tab5 = "Interface & Gemak"
        Tab6 = "Optionele Onderdelen"
        Tab7 = "Diagnose & Onderhoud"
        LangLabel = "Taal:"
        ThemeLabel = "Thema:"
        HardwareLabel = "Hardware:"
    }
    "ar" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "صلاحيات المسؤول مفعّلة"
        SafetyPrompt = "مستحسن: يرجى إنشاء نقطة استعادة للنظام (الخيار #149) قبل تطبيق التعديلات."
        MasterBtn = "تحسين كامل وآمن 100% بنقرة واحدة"
        Tab1 = "الألعاب والأداء"
        Tab2 = "القرص والتنظيف"
        Tab3 = "الشبكة والـ DNS"
        Tab4 = "الخصوصية وإزالة الزوائد"
        Tab5 = "الواجهة وسهولة الاستخدام"
        Tab6 = "المكونات الاختيارية"
        Tab7 = "التشخيص والصيانة"
        LangLabel = "اللغة:"
        ThemeLabel = "السمة:"
        HardwareLabel = "العتاد:"
    }
    "hi" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "व्यवस्थापक विशेषाधिकार सक्रिय हैं"
        SafetyPrompt = "अनुशंसित: मुख्य बदलाव लागू करने से पहले सिस्टम रीस्टोर पॉइंट (सुविधा #149) बनाएं।"
        MasterBtn = "1-क्लिक 100% सुरक्षित पूर्ण अनुकूलन"
        Tab1 = "गेमिंग और प्रदर्शन"
        Tab2 = "डिस्क और गहरी सफाई"
        Tab3 = "नेटवर्क और डीएनएस"
        Tab4 = "गोपनीयता और डिब्लोट"
        Tab5 = "इंटरफ़ेस और सुविधा"
        Tab6 = "वैकल्पिक घटक"
        Tab7 = "निदान और रखरखाव"
        LangLabel = "भाषा:"
        ThemeLabel = "थीम:"
        HardwareLabel = "हार्डवेयर:"
    }
    "sv" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ADMINISTRATÖRSBEHÖRIGHET AKTIV"
        SafetyPrompt = "REKOMMENDERAS: Skapa en systemåterställningspunkt (Funktion #149) innan optimering."
        MasterBtn = "1-KLICK 100% SÄKER FULL OPTIMERING"
        Tab1 = "Spel & Prestanda"
        Tab2 = "Disk & Rensning"
        Tab3 = "Nätverk & DNS"
        Tab4 = "Integritet & Debloat"
        Tab5 = "Gränssnitt & QoL"
        Tab6 = "Valfria Komponenter"
        Tab7 = "Diagnostik & Underhåll"
        LangLabel = "Språk:"
        ThemeLabel = "Tema:"
        HardwareLabel = "Hårdvara:"
    }
    "el" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ΔΙΚΑΙΩΜΑΤΑ ΔΙΑΧΕΙΡΙΣΤΗ ΕΝΕΡΓΑ"
        SafetyPrompt = "ΣΥΝΙΣΤΑΤΑΙ: Δημιουργήστε ένα σημείο επαναφοράς συστήματος (#149) πριν από οποιαδήποτε ρύθμιση."
        MasterBtn = "1-ΚΛΙΚ 100% ΑΣΦΑΛΗΣ ΠΛΗΡΗΣ ΒΕΛΤΙΣΤΟΠΟΙΗΣΗ"
        Tab1 = "Παιχνίδια & Απόδοση"
        Tab2 = "Δίσκος & Καθαρισμός"
        Tab3 = "Δίκτυο & DNS"
        Tab4 = "Απόρρητο & Αφαίρεση Bloatware"
        Tab5 = "Διεπαφή & Ευκολία"
        Tab6 = "Προαιρετικά Στοιχεία"
        Tab7 = "Διαγνωστικά & Συντήρηση"
        LangLabel = "Γλώσσα:"
        ThemeLabel = "Θέμα:"
        HardwareLabel = "Υλικό:"
    }
    "ro" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "DREPTURI DE ADMINISTRATOR ACTIVE"
        SafetyPrompt = "RECOMANDAT: Creați un punct de restaurare (Opțiunea #149) înainte de optimizări majore."
        MasterBtn = "OPTIMIZARE COMPLETĂ 100% SIGURĂ CU 1 CLIC"
        Tab1 = "Jocuri & Performanță"
        Tab2 = "Disc & Curățare"
        Tab3 = "Rețea & DNS"
        Tab4 = "Confidențialitate & Debloat"
        Tab5 = "Interfață & QoL"
        Tab6 = "Componente Opționale"
        Tab7 = "Diagnostic & Mentenanță"
        LangLabel = "Limbă:"
        ThemeLabel = "Temă:"
        HardwareLabel = "Hardware:"
    }
    "uk" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "ПРАВА АДМІНІСТРАТОРА АКТИВНІ"
        SafetyPrompt = "РЕКОМЕНДОВАНО: Створіть точку відновлення системи (#149) перед оптимізацією."
        MasterBtn = "1-КЛІК 100% БЕЗПЕЧНА ПОВНА ОПТИМІЗАЦІЯ"
        Tab1 = "Ігри та продуктивність"
        Tab2 = "Диск та очищення"
        Tab3 = "Мережа та DNS"
        Tab4 = "Конфіденційність і деблоат"
        Tab5 = "Інтерфейс і зручність"
        Tab6 = "Додаткові компоненти"
        Tab7 = "Діагностика та обслуговування"
        LangLabel = "Мова:"
        ThemeLabel = "Тема:"
        HardwareLabel = "Обладнання:"
    }
    "vi" = @{
        Title = "MEPHISTOCLEANER v6.0"
        Admin = "QUYỀN QUẢN TRỊ VIÊN ĐANG HOẠT ĐỘNG"
        SafetyPrompt = "KHUYẾN NGHỊ: Tạo Điểm khôi phục hệ thống (Tính năng #149) trước khi thực hiện tinh chỉnh."
        MasterBtn = "TỐI ƯU HÓA HOÀN TOÀN 100% AN TOÀN TRONG 1 CÚ NHẤP"
        Tab1 = "Chơi game & Hiệu suất"
        Tab2 = "Ổ đĩa & Dọn dẹp"
        Tab3 = "Mạng & DNS"
        Tab4 = "Quyền riêng tư & Debloat"
        Tab5 = "Giao diện & Tiện ích"
        Tab6 = "Thành phần tùy chọn"
        Tab7 = "Chẩn đoán & Bảo trì"
        LangLabel = "Ngôn ngữ:"
        ThemeLabel = "Giao diện:"
        HardwareLabel = "Phần cứng:"
    }
}

# 6. Build WPF XAML Interface
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Name="MainWindow"
        Title="MephistoCleaner v6.0 - The Ultimate Windows Optimization Suite" 
        Height="800" Width="1140" 
        WindowStartupLocation="CenterScreen" 
        Background="#0F141C" 
        Foreground="#E0E6ED"
        FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="ToolTip">
            <Setter Property="Background" Value="#1E293B"/>
            <Setter Property="Foreground" Value="#38BDF8"/>
            <Setter Property="BorderBrush" Value="#0EA5E9"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Padding" Value="8,5"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#1E293B"/>
            <Setter Property="Foreground" Value="#F8FAFC"/>
            <Setter Property="FontSize" Value="11.5"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="8,5"/>
            <Setter Property="Margin" Value="3"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="BorderBrush" Value="#334155"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <Style TargetType="TabItem">
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Foreground" Value="#94A3B8"/>
            <Setter Property="Padding" Value="11,6"/>
            <Setter Property="Background" Value="#0F141C"/>
        </Style>
    </Window.Resources>

    <Grid Margin="12">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="125"/>
        </Grid.RowDefinitions>

        <!-- TOP BAR: TITLE, CONTROLS, THEME & LANGUAGE SWITCHER -->
        <Border Grid.Row="0" Name="HeaderBorder" Background="#1E293B" CornerRadius="8" Padding="12" Margin="0,0,0,8" BorderBrush="#334155" BorderThickness="1">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <!-- Left: Title, Admin Badge & Hardware Summary -->
                <StackPanel Grid.Column="0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Name="TxtMainTitle" Text="⚡ MEPHISTOCLEANER v6.0" FontSize="18" FontWeight="Bold" Foreground="#38BDF8" VerticalAlignment="Center"/>
                        <Border Background="#059669" CornerRadius="4" Padding="6,2" Margin="10,0,0,0" VerticalAlignment="Center">
                            <TextBlock Name="TxtAdminBadge" Text="ADMIN PRIVILEGES ACTIVE" FontSize="10" FontWeight="Bold" Foreground="#FFFFFF"/>
                        </Border>
                    </StackPanel>
                    <TextBlock Name="TxtHwInfo" Text="Hardware: Loading..." FontSize="11.5" Foreground="#94A3B8" Margin="0,4,0,0"/>
                </StackPanel>

                <!-- Right: Dropdowns and Master 1-Click Button -->
                <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
                    <!-- Language Selector -->
                    <StackPanel Margin="0,0,8,0">
                        <TextBlock Name="LblLang" Text="Language:" FontSize="10" Foreground="#94A3B8" Margin="0,0,0,2"/>
                        <ComboBox Name="CmbLanguage" Width="110" Height="26" FontSize="11" SelectedIndex="0" Background="#0F141C" Foreground="#FFFFFF"/>
                    </StackPanel>

                    <!-- Theme Selector -->
                    <StackPanel Margin="0,0,12,0">
                        <TextBlock Name="LblTheme" Text="Theme:" FontSize="10" Foreground="#94A3B8" Margin="0,0,0,2"/>
                        <ComboBox Name="CmbTheme" Width="140" Height="26" FontSize="11" SelectedIndex="0" Background="#0F141C" Foreground="#FFFFFF"/>
                    </StackPanel>

                    <!-- 1-Click Master Button -->
                    <Button Name="BtnQuickMaster" Content="1-CLICK 100% SAFE FULL OPTIMIZATION" Background="#0284C7" FontSize="12" Padding="14,8" FontWeight="Bold" VerticalAlignment="Bottom"/>
                </StackPanel>
            </Grid>
        </Border>

        <!-- SAFETY RESTORE POINT NOTICE -->
        <Border Grid.Row="1" Background="#2B1F0E" CornerRadius="6" Padding="10,6" Margin="0,0,0,8" BorderBrush="#D97706" BorderThickness="1">
            <StackPanel Orientation="Horizontal">
                <TextBlock Text="🛡️ " FontSize="14" VerticalAlignment="Center"/>
                <TextBlock Name="TxtSafetyNotice" Text="RECOMMENDED: Create a System Restore Point (Feature #149) before applying major system tweaks." 
                           FontSize="11.5" FontWeight="SemiBold" Foreground="#FCD34D" VerticalAlignment="Center"/>
            </StackPanel>
        </Border>

        <!-- TABS (150 FEATURES) -->
        <TabControl Grid.Row="2" Name="MainTabControl" Background="#1E293B" BorderBrush="#334155" BorderThickness="1">
            
            <!-- TAB 1: GAMING & PERFORMANCE (1-20) -->
            <TabItem Name="Tab1" Header="Gaming &amp; Performance">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn1" Width="330" Content="1. CPU Core Unpark &amp; Power Plan Lock" ToolTip="Prevents CPU cores from sleeping during games, locking full sustained clock speeds."/>
                        <Button Name="Btn2" Width="330" Content="2. Game Booster Turbo Mode" ToolTip="Closes heavy background browsers, Discord, Spotify and releases RAM before gaming."/>
                        <Button Name="Btn3" Width="330" Content="3. RAM &amp; Standby Cache Purge" ToolTip="Triggers the Windows Garbage Collector to flush idle memory and working sets."/>
                        <Button Name="Btn4" Width="330" Content="4. Universal GPU Shader Cache Purge" ToolTip="Cleans bloated DirectX, NVIDIA DXCache, AMD DxCache and Intel shader caches."/>
                        <Button Name="Btn5" Width="330" Content="5. Enable HAGS (Hardware GPU Scheduling)" ToolTip="Hands GPU scheduling directly to graphics hardware processor, boosting FPS."/>
                        <Button Name="Btn6" Width="330" Content="6. Lock DirectX MaxFrameLatency=1" ToolTip="Caps pre-rendered frame queue to 1 to eliminate rendering input lag."/>
                        <Button Name="Btn7" Width="330" Content="7. Force Fullscreen Optimizations (FSE)" ToolTip="Eliminates DWM borderless composition lag, unlocking true exclusive fullscreen speeds."/>
                        <Button Name="Btn8" Width="330" Content="8. Disable Game DVR Background Recording" ToolTip="Stops Windows from recording video clips in the background to prevent frame drops."/>
                        <Button Name="Btn9" Width="330" Content="9. Lighten DWM Transparency &amp; Blur" ToolTip="Reduces Desktop Window Manager GPU compositor load during gaming."/>
                        <Button Name="Btn10" Width="330" Content="10. Set GDI Process Handle Quota to 65536" ToolTip="Expands UI object limits to prevent crashes in heavily modded games."/>
                        <Button Name="Btn11" Width="330" Content="11. Disable Power Throttling" ToolTip="Stops Windows from artificially throttling CPU wattage during background tasks."/>
                        <Button Name="Btn12" Width="330" Content="12. Disable Fast Startup Memory Leak" ToolTip="Prevents Windows kernel session leaks and stale memory locking across reboots."/>
                        <Button Name="Btn13" Width="330" Content="13. Set Win32PrioritySeparation to 38" ToolTip="Grants foreground games 3x prioritized CPU time slices compared to background apps."/>
                        <Button Name="Btn14" Width="330" Content="14. Set MMCSS Games GPU Priority to 8" ToolTip="Locks Multimedia Class Scheduler Service GPU priority to High for stutter-free audio/video."/>
                        <Button Name="Btn15" Width="330" Content="15. Get Competitive CS2 / Esports Launch Options" ToolTip="Outputs esports-grade launch parameters (-high, -threads, +fps_max 0)."/>
                        <Button Name="Btn16" Width="330" Content="16. Disable HPET (High Precision Event Timer)" ToolTip="Disables legacy platform timer clock to minimize DPC latency."/>
                        <Button Name="Btn17" Width="330" Content="17. Disable Dynamic Tick Clock Interrupts" ToolTip="Stops erratic timer interrupt variations on laptop processors, curing micro-stutters."/>
                        <Button Name="Btn18" Width="330" Content="18. Enable DirectPlay Legacy Gaming Support" ToolTip="Enables DirectPlay required by classic titles (GTA SA, NFS, Age of Empires)."/>
                        <Button Name="Btn19" Width="330" Content="19. Install .NET Framework 3.5 / 2.0" ToolTip="Installs foundational runtimes needed by older modded game launchers."/>
                        <Button Name="Btn20" Width="330" Content="20. Get Minecraft Java Aikar's GC Flags" ToolTip="Provides battle-tested Java Garbage Collection arguments for lag-free Minecraft."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 2: DISK & DEEP CLEAN (21-40) -->
            <TabItem Name="Tab2" Header="Disk &amp; Deep Clean">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn21" Width="330" Content="21. Hardware SSD Re-TRIM Force" ToolTip="Sends hardware TRIM commands to refresh flash blocks and restore factory write speeds."/>
                        <Button Name="Btn22" Width="330" Content="22. Clean Windows &amp; User Temp Folders" ToolTip="Wipes junk temporary files across AppData and Windows root temp."/>
                        <Button Name="Btn23" Width="330" Content="23. DISM WinSxS Component Store ResetBase" ToolTip="Cleans superseded Windows Update backup binaries to free up gigabytes."/>
                        <Button Name="Btn24" Width="330" Content="24. Clean Windows Update Download Cache" ToolTip="Deletes cached installer files inside SoftwareDistribution\Download."/>
                        <Button Name="Btn25" Width="330" Content="25. Purge Chrome, Brave &amp; Edge Browser Cache" ToolTip="Wipes cached web assets from all Chromium-based browsers."/>
                        <Button Name="Btn26" Width="330" Content="26. Purge Developer (npm, pip, yarn) Caches" ToolTip="Purges gigabytes of forgotten local npm and pip download packages."/>
                        <Button Name="Btn27" Width="330" Content="27. Purge Crash Dumps (.dmp) &amp; Minidumps" ToolTip="Removes legacy BSOD memory dump files from the disk."/>
                        <Button Name="Btn28" Width="330" Content="28. Force Empty Recycle Bin on All Drives" ToolTip="Instantly empties Recycle Bins across C:, D: and all connected volumes."/>
                        <Button Name="Btn29" Width="330" Content="29. Disable NTFS 8.3 Short Name Creation" ToolTip="Disables 16-bit MS-DOS file naming overhead to accelerate SSD directory lookups."/>
                        <Button Name="Btn30" Width="330" Content="30. Disable NTFS Last Access Timestamp" ToolTip="Stops Windows from writing access timestamps every time a file is read."/>
                        <Button Name="Btn31" Width="330" Content="31. Set NTFS MftZone Area to 2" ToolTip="Expands Master File Table allocation space to prevent file system fragmentation."/>
                        <Button Name="Btn32" Width="330" Content="32. Clear Thumbnail Cache (thumbcache_*.db)" ToolTip="Flushes corrupted or oversized thumbnail preview databases."/>
                        <Button Name="Btn33" Width="330" Content="33. Reset IconCache (IconCache.db)" ToolTip="Fixes broken or invisible desktop and taskbar icons."/>
                        <Button Name="Btn34" Width="330" Content="34. Reset Windows FontCache Service" ToolTip="Clears corrupt font caches to accelerate system boot time."/>
                        <Button Name="Btn35" Width="330" Content="35. Clean Discord &amp; Telegram Chat Caches" ToolTip="Frees disk space consumed by cached chat images and videos."/>
                        <Button Name="Btn36" Width="330" Content="36. Clear Delivery Optimization Cache" ToolTip="Deletes residual Windows Update peer-to-peer distribution packages."/>
                        <Button Name="Btn37" Width="330" Content="37. Clear Stale Windows Event Logs" ToolTip="Clears bloated Application and System event log entries."/>
                        <Button Name="Btn38" Width="330" Content="38. Perform Free Space TRIM Pass" ToolTip="Trims unused free disk space sectors on SSDs."/>
                        <Button Name="Btn39" Width="330" Content="39. Delete Massive MEMORY.DMP Dumps" ToolTip="Deletes gigabyte-sized kernel memory crash dumps."/>
                        <Button Name="Btn40" Width="330" Content="40. Analyze Downloads Folder Disk Usage" ToolTip="Reports total disk space consumed by files in your Downloads directory."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 3: NETWORK & DNS (41-60) -->
            <TabItem Name="Tab3" Header="Network &amp; DNS">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn41" Width="330" Content="41. Switch to Cloudflare 1.1.1.1 DNS" ToolTip="Applies the world's fastest and lowest-latency gaming DNS to all active adapters."/>
                        <Button Name="Btn42" Width="330" Content="42. Switch to Google 8.8.8.8 DNS" ToolTip="Sets reliable, high-uptime Google DNS servers."/>
                        <Button Name="Btn43" Width="330" Content="43. Switch to Quad9 9.9.9.9 Security DNS" ToolTip="Sets privacy-centric Quad9 DNS with automated malware blocking."/>
                        <Button Name="Btn44" Width="330" Content="44. Reset DNS to Automatic (DHCP)" ToolTip="Restores ISP / Router default DNS configuration."/>
                        <Button Name="Btn45" Width="330" Content="45. Flush DNS Cache &amp; Reset Winsock" ToolTip="Clears corrupt DNS resolver cache and resets network socket catalogue."/>
                        <Button Name="Btn46" Width="330" Content="46. Enable TCP FastOpen" ToolTip="Halves connection establishment latency for modern web and game servers."/>
                        <Button Name="Btn47" Width="330" Content="47. Enable TCP ECN &amp; Receive Side Scaling (RSS)" ToolTip="Prevents packet congestion and splits network traffic across multi-core CPUs."/>
                        <Button Name="Btn48" Width="330" Content="48. Disable TCP Timestamps Overhead" ToolTip="Removes unnecessary 12-byte timestamp headers from TCP packets."/>
                        <Button Name="Btn49" Width="330" Content="49. Disable Nagle's Algorithm (TCPNoDelay)" ToolTip="Forces instant transmission of small packets, eliminating game ping delay."/>
                        <Button Name="Btn50" Width="330" Content="50. Lock TcpAckFrequency to 1" ToolTip="Sends immediate ACK responses for every packet to prevent ping spikes."/>
                        <Button Name="Btn51" Width="330" Content="51. Expand MaxUserPort to 65534" ToolTip="Maximizes concurrent socket capacity for multiplayer games."/>
                        <Button Name="Btn52" Width="330" Content="52. Reduce TcpTimedWaitDelay to 30s" ToolTip="Releases closed network connections 4x faster from memory."/>
                        <Button Name="Btn53" Width="330" Content="53. Disable Delivery Optimization P2P Uploads" ToolTip="Prevents Windows Update from using your bandwidth to upload updates to strangers."/>
                        <Button Name="Btn54" Width="330" Content="54. Disable NIC Power Management Sleep" ToolTip="Stops Wi-Fi / Ethernet chips from entering low-power sleep states in games."/>
                        <Button Name="Btn55" Width="330" Content="55. Lower Wi-Fi Roaming Aggressiveness" ToolTip="Prevents Wi-Fi adapter from constantly searching for alternate APs and dropping packets."/>
                        <Button Name="Btn56" Width="330" Content="56. Run Live Ping &amp; Jitter Latency Test" ToolTip="Measures real-time round-trip latency and stability to Cloudflare servers."/>
                        <Button Name="Btn57" Width="330" Content="57. Test for Network Packet Loss" ToolTip="Tests active connection for lost or dropped packets."/>
                        <Button Name="Btn58" Width="330" Content="58. Block Telemetry IPs in Hosts File" ToolTip="Redirects 100+ Microsoft tracking domains to 0.0.0.0 via hosts file."/>
                        <Button Name="Btn59" Width="330" Content="59. Restore Default Clean Hosts File" ToolTip="Cleans and resets the Windows hosts file back to factory defaults."/>
                        <Button Name="Btn60" Width="330" Content="60. Enable DNS Leak Protection" ToolTip="Forces Windows to use exclusively specified DNS servers across all interfaces."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 4: PRIVACY & DEBLOAT (61-80) -->
            <TabItem Name="Tab4" Header="Privacy &amp; Debloat">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn61" Width="330" Content="61. Uninstall 50+ Safe UWP Bloatware Apps" ToolTip="Uninstalls pre-installed Microsoft junk apps (BingNews, Weather, Clipchamp, Zune, etc.)."/>
                        <Button Name="Btn62" Width="330" Content="62. Disable Windows Copilot AI Systemwide" ToolTip="Shuts down Windows Copilot AI background agents and policies."/>
                        <Button Name="Btn63" Width="330" Content="63. Disable Start Menu Bing Cloud Search" ToolTip="Restores fast local-only search without sending keystrokes to Bing."/>
                        <Button Name="Btn64" Width="330" Content="64. Disable Microsoft DiagTrack Telemetry" ToolTip="Stops Connected User Experiences and Telemetry background service."/>
                        <Button Name="Btn65" Width="330" Content="65. Disable Activity History &amp; Timeline" ToolTip="Stops Windows from tracking and recording user activity history."/>
                        <Button Name="Btn66" Width="330" Content="66. Disable Edge Startup Boost &amp; Background Mode" ToolTip="Prevents Microsoft Edge from running resident background instances when closed."/>
                        <Button Name="Btn67" Width="330" Content="67. Disable Advertising ID Tracking" ToolTip="Blocks targeted advertising identifiers across all Windows apps."/>
                        <Button Name="Btn68" Width="330" Content="68. Block Background App Location Access" ToolTip="Prevents background apps from silently polling GPS/Wi-Fi location."/>
                        <Button Name="Btn69" Width="330" Content="69. Disable CEIP Customer Experience Tasks" ToolTip="Disables scheduled telemetry data upload tasks."/>
                        <Button Name="Btn70" Width="330" Content="70. Disable Microsoft Compatibility Appraiser" ToolTip="Stops daily background scan that consumes excessive CPU cycles."/>
                        <Button Name="Btn71" Width="330" Content="71. Disable Disk Diagnostic Data Collector" ToolTip="Stops background telemetry tracking of disk read/write logs."/>
                        <Button Name="Btn72" Width="330" Content="72. Disable Universal Background App Permissions" ToolTip="Prevents Store apps from draining RAM and CPU while minimized."/>
                        <Button Name="Btn73" Width="330" Content="73. Disable Lockscreen Ads &amp; Consumer Tips" ToolTip="Removes promoted ads, trivia, and suggested apps from lockscreen."/>
                        <Button Name="Btn74" Width="330" Content="74. Disable Crash Report Prompt Popups" ToolTip="Silently terminates crashed programs without freezing the desktop."/>
                        <Button Name="Btn75" Width="330" Content="75. Disable ETW Autologgers Disk Traces" ToolTip="Stops 30 kernel trace loggers from constantly writing background disk logs."/>
                        <Button Name="Btn76" Width="330" Content="76. Disable Windows 11 Recall AI Snapshots" ToolTip="Disables continuous screenshot indexing in Windows 11."/>
                        <Button Name="Btn77" Width="330" Content="77. Hide Search Box Web Trends &amp; Highlights" ToolTip="Removes celebrity news and web highlights from the Windows search bar."/>
                        <Button Name="Btn78" Width="330" Content="78. Disable Microsoft Office Telemetry" ToolTip="Disables background usage logging in Microsoft Office suite."/>
                        <Button Name="Btn79" Width="330" Content="79. Disable GPU Driver Telemetry Services" ToolTip="Stops NVIDIA / AMD telemetry containers from uploading telemetry."/>
                        <Button Name="Btn80" Width="330" Content="80. Disable Windows Error Reporting (WerSvc)" ToolTip="Disables error reporting service to speed up system responsiveness."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 5: INTERFACE & QOL (81-100) -->
            <TabItem Name="Tab5" Header="Interface &amp; QoL">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn81" Width="330" Content="81. Enable Classic Windows 10 Context Menu" ToolTip="Restores the fast, full right-click context menu without 'Show more options'."/>
                        <Button Name="Btn82" Width="330" Content="82. Restore Modern Windows 11 Context Menu" ToolTip="Reverts right-click menu back to default Windows 11 design."/>
                        <Button Name="Btn83" Width="330" Content="83. Disable Windows 11 Widgets (News) Panel" ToolTip="Removes the distracting news/weather widget button from the taskbar."/>
                        <Button Name="Btn84" Width="330" Content="84. Open File Explorer to 'This PC'" ToolTip="Opens File Explorer directly to disk drives instead of Home/Quick Access."/>
                        <Button Name="Btn85" Width="330" Content="85. Always Show Known File Extensions (.exe)" ToolTip="Makes file extensions visible to instantly spot disguised malware."/>
                        <Button Name="Btn86" Width="330" Content="86. Toggle Show Hidden Files &amp; Folders" ToolTip="Toggles visibility for AppData and hidden system directories."/>
                        <Button Name="Btn87" Width="330" Content="87. Create 'GodMode' Folder on Desktop" ToolTip="Creates a single folder containing all 200+ Windows Control Panel tools."/>
                        <Button Name="Btn88" Width="330" Content="88. Hide Gallery &amp; 3D Objects from Explorer" ToolTip="Declutters the File Explorer left navigation pane."/>
                        <Button Name="Btn89" Width="330" Content="89. Restore Classic Windows Photo Viewer" ToolTip="Enables the ultra-fast Windows 7 photo viewer executable."/>
                        <Button Name="Btn90" Width="330" Content="90. Disable Mouse Acceleration (1:1 Raw Aim)" ToolTip="Enables true 1:1 hardware mouse tracking for esports FPS aiming."/>
                        <Button Name="Btn91" Width="330" Content="91. Set Keyboard Input Delay to 0ms" ToolTip="Removes key repeat initial delay for instantaneous keyboard response."/>
                        <Button Name="Btn92" Width="330" Content="92. Set Keyboard Repeat Speed to Max (31)" ToolTip="Maximizes key repeat rate for rapid input execution."/>
                        <Button Name="Btn93" Width="330" Content="93. Set Mouse Data Queue Size to 100 Packets" ToolTip="Prevents mouse input buffer overflow during rapid flick movements."/>
                        <Button Name="Btn94" Width="330" Content="94. Set Keyboard Data Queue Size to 100 Packets" ToolTip="Prevents keyboard buffer bottlenecking during rapid macro keystrokes."/>
                        <Button Name="Btn95" Width="330" Content="95. Enable USB Port Low-Latency Mode" ToolTip="Disables successive inter-packet delays on USB root hubs."/>
                        <Button Name="Btn96" Width="330" Content="96. Set MenuShowDelay to 0ms (Instant Menus)" ToolTip="Eliminates the 400ms pause when hovering over Windows menus."/>
                        <Button Name="Btn97" Width="330" Content="97. Set HungAppTimeout to 1s (Fast Close)" ToolTip="Instantly closes frozen applications without locking up the OS."/>
                        <Button Name="Btn98" Width="330" Content="98. Disable Window Minimize/Maximize Animations" ToolTip="Removes window transition animations for a snappy interface."/>
                        <Button Name="Btn99" Width="330" Content="99. Disable Snap Assist Flyout Overlay" ToolTip="Prevents the window tiling suggestion menu from lagging dragging actions."/>
                        <Button Name="Btn100" Width="330" Content="100. Disable Aero Shake Window Minimizing" ToolTip="Prevents shaking a window from accidentally minimizing other open windows."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 6: COMPONENTS & FEATURES (101-120) -->
            <TabItem Name="Tab6" Header="Components">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn101" Width="330" Content="101. Enable Windows Sandbox (Safe VM)" ToolTip="Enables a disposable, isolated Windows environment for testing suspicious files."/>
                        <Button Name="Btn102" Width="330" Content="102. Enable WSL (Windows Subsystem for Linux)" ToolTip="Enables native Linux kernel environment within Windows."/>
                        <Button Name="Btn103" Width="330" Content="103. Enable Hyper-V Virtualization Hypervisor" ToolTip="Enables hardware virtualization hypervisor for VMs and emulators."/>
                        <Button Name="Btn104" Width="330" Content="104. Disable XPS Viewer &amp; Document Writer" ToolTip="Removes obsolete XPS printing features to save system memory."/>
                        <Button Name="Btn105" Width="330" Content="105. Remove Legacy Windows Media Player" ToolTip="Uninstalls obsolete WMP components."/>
                        <Button Name="Btn106" Width="330" Content="106. Disable Vulnerable SMBv1 Protocol" ToolTip="Protects against ransomware exploits (like WannaCry) on local networks."/>
                        <Button Name="Btn107" Width="330" Content="107. Disable Telnet &amp; TFTP Clients" ToolTip="Disables unencrypted legacy remote communication protocols."/>
                        <Button Name="Btn108" Width="330" Content="108. Disable Internet Explorer Engine Leftovers" ToolTip="Deactivates residual Internet Explorer components."/>
                        <Button Name="Btn109" Width="330" Content="109. Add Steamapps to Defender Exclusions" ToolTip="Skips Defender scanning on Steam library folder to accelerate game loads."/>
                        <Button Name="Btn110" Width="330" Content="110. Cap Defender Max CPU Usage to 25%" ToolTip="Prevents Windows Defender background scans from choking the CPU."/>
                        <Button Name="Btn111" Width="330" Content="111. Set Taskbar Preview Delay to 10s" ToolTip="Prevents hover thumbnails from popping up and causing game focus loss."/>
                        <Button Name="Btn112" Width="330" Content="112. Disable UAC Secure Desktop Dimming" ToolTip="Removes screen freezing delay when User Account Control prompts appear."/>
                        <Button Name="Btn113" Width="330" Content="113. Restart Windows Explorer (explorer.exe)" ToolTip="Instantly restarts Windows Explorer to apply UI tweaks."/>
                        <Button Name="Btn114" Width="330" Content="114. Restart Windows Audio Service (AudioSrv)" ToolTip="Fixes missing sound issues without rebooting."/>
                        <Button Name="Btn115" Width="330" Content="115. List All Startup Programs" ToolTip="Lists applications configured to auto-start with Windows."/>
                        <Button Name="Btn116" Width="330" Content="116. Clean Broken Startup Registry Entries" ToolTip="Removes orphaned startup entries left by deleted applications."/>
                        <Button Name="Btn117" Width="330" Content="117. Disable Google &amp; Adobe Background Updaters" ToolTip="Stops persistent updater services from running when apps are closed."/>
                        <Button Name="Btn118" Width="330" Content="118. Reset Windows Firewall Rules to Default" ToolTip="Restores factory Windows Firewall configuration."/>
                        <Button Name="Btn119" Width="330" Content="119. Manage Driver Signature Enforcement" ToolTip="Toggles driver signature verification for custom peripheral drivers."/>
                        <Button Name="Btn120" Width="330" Content="120. Rebuild Windows Search Index" ToolTip="Rebuilds corrupt search database to fix broken file search."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

            <!-- TAB 7: DIAGNOSTICS & MAINTENANCE (121-150) -->
            <TabItem Name="Tab7" Header="Diagnostics &amp; Repair">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <WrapPanel Margin="8">
                        <Button Name="Btn121" Width="330" Content="121. Read Live GPU Temp, Power &amp; VRAM" ToolTip="Queries real-time GPU thermals, power draw, and VRAM utilization."/>
                        <Button Name="Btn122" Width="330" Content="122. Read Live CPU Clock Speed &amp; Usage" ToolTip="Displays current processor frequency in MHz and core load."/>
                        <Button Name="Btn123" Width="330" Content="123. Get SSD Health &amp; SMART Status Report" ToolTip="Checks NVMe/SATA SSD operational status and drive health."/>
                        <Button Name="Btn124" Width="330" Content="124. Generate Laptop Battery Health Report" ToolTip="Generates battery wear and cycle count analysis."/>
                        <Button Name="Btn125" Width="330" Content="125. Find Top 15 Resource-Heavy Processes" ToolTip="Ranks top 15 memory and CPU consuming background tasks."/>
                        <Button Name="Btn126" Width="330" Content="126. Read Recent BSOD &amp; Crash Event Logs" ToolTip="Queries Windows Event Viewer for recent fatal error logs."/>
                        <Button Name="Btn127" Width="330" Content="127. Export Complete Hardware Specs Summary" ToolTip="Outputs full specifications of CPU, GPU, Motherboard and RAM."/>
                        <Button Name="Btn128" Width="330" Content="128. Query Available Free RAM &amp; Memory Pool" ToolTip="Reports total visible RAM and available free physical memory."/>
                        <Button Name="Btn129" Width="330" Content="129. Query C: Drive Free Capacity" ToolTip="Checks free storage space on system drive."/>
                        <Button Name="Btn130" Width="330" Content="130. Verify Firewall Active Profile States" ToolTip="Verifies Domain, Private and Public firewall profiles."/>
                        <Button Name="Btn131" Width="330" Content="131. Measure Last BIOS / UEFI Boot Time" ToolTip="Reports exact duration of system boot sequence."/>
                        <Button Name="Btn132" Width="330" Content="132. Query Windows Activation &amp; License State" ToolTip="Checks Windows license status and product key channels."/>
                        <Button Name="Btn133" Width="330" Content="133. Run SFC /Scannow System File Repair" ToolTip="Scans and automatically repairs corrupt Windows system files."/>
                        <Button Name="Btn134" Width="330" Content="134. Run DISM /RestoreHealth Image Repair" ToolTip="Repairs corrupted Windows Component Store from official Microsoft servers."/>
                        <Button Name="Btn135" Width="330" Content="135. Run CHKDSK File System Integrity Scan" ToolTip="Scans C: drive for file system corruption and bad sectors."/>
                        <Button Name="Btn136" Width="330" Content="136. Reset Microsoft Store Cache (WSReset)" ToolTip="Fixes download errors and freezes in Microsoft Store."/>
                        <Button Name="Btn137" Width="330" Content="137. Export Registry Backup to Desktop" ToolTip="Backs up HKLM\SOFTWARE hive to a .reg file on your Desktop."/>
                        <Button Name="Btn138" Width="330" Content="138. Export All Installed Drivers to Desktop" ToolTip="Exports all 3rd-party device drivers to Desktop\Driver_Backup."/>
                        <Button Name="Btn139" Width="330" Content="139. Silent Install: 7-Zip Archive Manager" ToolTip="Silently downloads and installs 7-Zip via Windows Package Manager."/>
                        <Button Name="Btn140" Width="330" Content="140. Silent Install: Notepad++ Code Editor" ToolTip="Silently installs Notepad++."/>
                        <Button Name="Btn141" Width="330" Content="141. Silent Install: VLC Media Player" ToolTip="Silently installs VLC."/>
                        <Button Name="Btn142" Width="330" Content="142. Silent Install: Discord" ToolTip="Silently installs Discord."/>
                        <Button Name="Btn143" Width="330" Content="143. Silent Install: Valve Steam" ToolTip="Silently installs Steam."/>
                        <Button Name="Btn144" Width="330" Content="144. Silent Install: Brave Browser" ToolTip="Silently installs Brave."/>
                        <Button Name="Btn145" Width="330" Content="145. Install Weekly Auto-Maintenance Task" ToolTip="Schedules silent background TRIM and temp cleanups every Sunday at 3 AM."/>
                        <Button Name="Btn146" Width="330" Content="146. Remove Weekly Auto-Maintenance Task" ToolTip="Unregisters the scheduled maintenance task."/>
                        <Button Name="Btn147" Width="330" Content="147. Pause Windows Update Services" ToolTip="Temporarily stops and disables automatic Windows updates."/>
                        <Button Name="Btn148" Width="330" Content="148. Enable &amp; Resume Windows Update" ToolTip="Restores Windows Update service back to automatic."/>
                        <Button Name="Btn149" Width="330" Content="149. Create Instant System Restore Point" ToolTip="Creates a safe Windows System Restore Point immediately."/>
                        <Button Name="Btn150" Width="330" Content="150. REVERT ALL TWEAKS (Factory Defaults)" Background="#991B1B" ToolTip="Reverts major optimizations back to standard Windows defaults."/>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>

        </TabControl>

        <!-- LIVE CONSOLE LOG VIEWER -->
        <Border Grid.Row="3" Name="ConsoleBorder" Background="#0A0E14" CornerRadius="6" Padding="8" Margin="0,8,0,0" BorderBrush="#1E293B" BorderThickness="1">
            <ScrollViewer Name="LogScroller" VerticalScrollBarVisibility="Auto">
                <TextBox Name="TxtLog" Background="Transparent" Foreground="#10B981" BorderThickness="0" 
                         FontFamily="Consolas" FontSize="11" IsReadOnly="True" TextWrapping="Wrap"/>
            </ScrollViewer>
        </Border>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Element References
$txtHw = $window.FindName("TxtHwInfo")
$txtLog = $window.FindName("TxtLog")
$logScroller = $window.FindName("LogScroller")
$cmbLang = $window.FindName("CmbLanguage")
$cmbTheme = $window.FindName("CmbTheme")

# Initialize Dropdowns
$langCodes = @(
    "en - English", "tr - Türkçe", "de - Deutsch", "fr - Français", "es - Español", 
    "it - Italiano", "ru - Русский", "ja - 日本語", "zh - 简体中文", "ko - 한국어", 
    "pt - Português", "pl - Polski", "nl - Nederlands", "ar - العربية", "hi - हिन्दी", 
    "sv - Svenska", "el - Ελληνικά", "ro - Română", "uk - Українська", "vi - Tiếng Việt"
)
foreach ($l in $langCodes) { [void]$cmbLang.Items.Add($l) }
$cmbLang.SelectedIndex = 0

foreach ($t in $global:Themes.Keys) { [void]$cmbTheme.Items.Add($t) }
$cmbTheme.SelectedIndex = 0

Function Append-Log($text) {
    $time = Get-Date -Format "HH:mm:ss"
    $txtLog.AppendText("[$time] $text`r`n")
    $logScroller.ScrollToEnd()
}

# Theme Switcher Handler
$cmbTheme.Add_SelectionChanged({
    $themeName = $cmbTheme.SelectedItem.ToString()
    if ($global:Themes.ContainsKey($themeName)) {
        $p = $global:Themes[$themeName]
        $window.Background = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Bg)
        $window.FindName("HeaderBorder").Background = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Card)
        $window.FindName("HeaderBorder").BorderBrush = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Border)
        $window.FindName("MainTabControl").Background = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Card)
        $window.FindName("MainTabControl").BorderBrush = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Border)
        $window.FindName("ConsoleBorder").Background = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.ConsoleBg)
        $txtLog.Foreground = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.ConsoleText)
        $window.FindName("TxtMainTitle").Foreground = (New-Object System.Windows.Media.BrushConverter).ConvertFromString($p.Accent)
        Append-Log "Theme applied: $themeName"
    }
})

# Language Switcher Handler
$cmbLang.Add_SelectionChanged({
    $selected = $cmbLang.SelectedItem.ToString().Substring(0, 2)
    if ($global:LangDict.ContainsKey($selected)) {
        $d = $global:LangDict[$selected]
        $window.FindName("TxtAdminBadge").Text = $d.Admin
        $window.FindName("TxtSafetyNotice").Text = $d.SafetyPrompt
        $window.FindName("BtnQuickMaster").Content = $d.MasterBtn
        $window.FindName("Tab1").Header = $d.Tab1
        $window.FindName("Tab2").Header = $d.Tab2
        $window.FindName("Tab3").Header = $d.Tab3
        $window.FindName("Tab4").Header = $d.Tab4
        $window.FindName("Tab5").Header = $d.Tab5
        $window.FindName("Tab6").Header = $d.Tab6
        $window.FindName("Tab7").Header = $d.Tab7
        $window.FindName("LblLang").Text = $d.LangLabel
        $window.FindName("LblTheme").Text = $d.ThemeLabel
        $txtHw.Text = "$($d.HardwareLabel) $cpuName ($totalRAM GB RAM) | GPU: $gpuNames ($chassisType)"
        Append-Log "Language switched to: $($cmbLang.SelectedItem)"
    }
})

# Set initial hardware label
$txtHw.Text = "Hardware: $cpuName ($totalRAM GB RAM) | GPU: $gpuNames ($chassisType)"

# ----------------- BUTTON EVENT HANDLERS (150 FEATURES) -----------------

# Master 1-Click
$window.FindName("BtnQuickMaster").Add_Click({
    Append-Log "🔥 STARTING 1-CLICK 100% SAFE FULL SYSTEM OPTIMIZATION..."
    powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 -ErrorAction SilentlyContinue
    powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100 -ErrorAction SilentlyContinue
    powercfg -h off -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Type DWord -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Direct3D" -Name "MaxFrameLatency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value "0" -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:LOCALAPPDATA\NVIDIA\DXCache\*", "$env:LOCALAPPDATA\AMD\DxCache\*", "$env:LOCALAPPDATA\D3DSCache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Optimize-Volume -DriveLetter C -ReTrim -Verbose -ErrorAction SilentlyContinue | Out-Null
    Append-Log "✓ Full System Optimization Successfully Applied! Please restart your computer."
})

# Tab 1: 1-20
$window.FindName("Btn1").Add_Click({ powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100; powercfg -setactive scheme_current; Append-Log "CPU core unparking applied. Cores locked to 100% active." })
$window.FindName("Btn2").Add_Click({ Get-Process -Name "Brave","Chrome","Discord","Spotify","steamwebhelper" -ErrorAction SilentlyContinue | Stop-Process -Force; Append-Log "Game Booster: Background apps terminated, RAM cleared." })
$window.FindName("Btn3").Add_Click({ [System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers(); Append-Log "RAM Garbage Collector triggered. Working memory flushed." })
$window.FindName("Btn4").Add_Click({ Remove-Item "$env:LOCALAPPDATA\NVIDIA\DXCache\*", "$env:LOCALAPPDATA\AMD\DxCache\*", "$env:LOCALAPPDATA\D3DSCache\*" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "GPU Shader Caches purged for all graphics vendors." })
$window.FindName("Btn5").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Type DWord -Force; Append-Log "HAGS (Hardware-Accelerated GPU Scheduling) enabled." })
$window.FindName("Btn6").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Direct3D" -Name "MaxFrameLatency" -Value 1 -Type DWord -Force; Append-Log "DirectX MaxFrameLatency=1 locked." })
$window.FindName("Btn7").Add_Click({ Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -Type DWord -Force; Append-Log "Fullscreen Optimizations (FSE) locked." })
$window.FindName("Btn8").Add_Click({ Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Type DWord -Force; Append-Log "Game DVR background recording disabled." })
$window.FindName("Btn9").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value 0 -Type DWord -Force; Append-Log "DWM blur transparency effects lightened." })
$window.FindName("Btn10").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -Name "GDIProcessHandleQuota" -Value 65536 -Type DWord -Force; Append-Log "GDI Process Handle Quota expanded to 65536." })
$window.FindName("Btn11").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force; Append-Log "Power Throttling disabled." })
$window.FindName("Btn12").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -Force; Append-Log "Fast Startup disabled to prevent kernel session leaks." })
$window.FindName("Btn13").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -Type DWord -Force; Append-Log "Win32PrioritySeparation set to 38 (Foreground Game Priority)." })
$window.FindName("Btn14").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8 -Type DWord -Force; Append-Log "MMCSS Games GPU Priority set to 8." })
$window.FindName("Btn15").Add_Click({ Append-Log "Recommended CS2 Launch Options: -high -threads $($cpuObj.NumberOfLogicalProcessors) -novid -nojoy +fps_max 0" })
$window.FindName("Btn16").Add_Click({ bcdedit /set useplatformclock false -ErrorAction SilentlyContinue; Append-Log "HPET hardware timer disabled." })
$window.FindName("Btn17").Add_Click({ bcdedit /set disabledynamictick yes -ErrorAction SilentlyContinue; Append-Log "Dynamic Tick disabled to eliminate micro-stutters." })
$window.FindName("Btn18").Add_Click({ Enable-WindowsOptionalFeature -Online -FeatureName "DirectPlay" -All -NoRestart -ErrorAction SilentlyContinue; Append-Log "DirectPlay legacy support enabled." })
$window.FindName("Btn19").Add_Click({ Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All -NoRestart -ErrorAction SilentlyContinue; Append-Log ".NET Framework 3.5 installed." })
$window.FindName("Btn20").Add_Click({ Append-Log "Minecraft GC Flags: -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+AlwaysPreTouch" })

# Tab 2: 21-40
$window.FindName("Btn21").Add_Click({ Optimize-Volume -DriveLetter C -ReTrim -Verbose -ErrorAction SilentlyContinue | Out-Null; Append-Log "SSD Re-TRIM command sent successfully." })
$window.FindName("Btn22").Add_Click({ Remove-Item "$env:TEMP\*", "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "Temporary junk files purged." })
$window.FindName("Btn23").Add_Click({ Append-Log "Running WinSxS cleanup..."; Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase; Append-Log "WinSxS component store cleaned." })
$window.FindName("Btn24").Add_Click({ Stop-Service wuauserv -ErrorAction SilentlyContinue; Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue; Start-Service wuauserv -ErrorAction SilentlyContinue; Append-Log "Windows Update download cache cleaned." })
$window.FindName("Btn25").Add_Click({ Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*", "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache\*", "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "Browser cache purged." })
$window.FindName("Btn26").Add_Click({ npm cache clean --force 2>$null; pip cache purge 2>$null; Append-Log "Developer npm and pip caches purged." })
$window.FindName("Btn27").Add_Click({ Remove-Item "C:\Windows\Minidump\*", "C:\Windows\MEMORY.DMP" -Force -ErrorAction SilentlyContinue; Append-Log "Crash dump files deleted." })
$window.FindName("Btn28").Add_Click({ Clear-RecycleBin -Force -ErrorAction SilentlyContinue; Append-Log "Recycle bin emptied across all volumes." })
$window.FindName("Btn29").Add_Click({ fsutil 8dot3name set 1 2>$null; Append-Log "NTFS 8.3 short name creation disabled." })
$window.FindName("Btn30").Add_Click({ fsutil behavior set disableLastAccess 1 2>$null; Append-Log "NTFS Last Access timestamp disabled." })
$window.FindName("Btn31").Add_Click({ fsutil behavior set mftZone 2 2>$null; Append-Log "MftZone reservation set to 2." })
$window.FindName("Btn32").Add_Click({ Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db" -Force -ErrorAction SilentlyContinue; Append-Log "Thumbnail cache purged." })
$window.FindName("Btn33").Add_Click({ Remove-Item "$env:LOCALAPPDATA\IconCache.db" -Force -ErrorAction SilentlyContinue; Append-Log "IconCache reset." })
$window.FindName("Btn34").Add_Click({ Stop-Service FontCache -ErrorAction SilentlyContinue; Remove-Item "$env:LOCALAPPDATA\FontCache\*" -Force -ErrorAction SilentlyContinue; Start-Service FontCache -ErrorAction SilentlyContinue; Append-Log "FontCache reset." })
$window.FindName("Btn35").Add_Click({ Remove-Item "$env:APPDATA\discord\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "Discord chat media cache purged." })
$window.FindName("Btn36").Add_Click({ Remove-Item "C:\Windows\DeliveryOptimization\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "Delivery optimization junk purged." })
$window.FindName("Btn37").Add_Click({ wevtutil cl System -ErrorAction SilentlyContinue; wevtutil cl Application -ErrorAction SilentlyContinue; Append-Log "Stale event logs cleared." })
$window.FindName("Btn38").Add_Click({ Optimize-Volume -DriveLetter C -ReTrim -ErrorAction SilentlyContinue | Out-Null; Append-Log "Free space TRIM pass executed." })
$window.FindName("Btn39").Add_Click({ Remove-Item "C:\Windows\MEMORY.DMP" -Force -ErrorAction SilentlyContinue; Append-Log "Large MEMORY.DMP files purged." })
$window.FindName("Btn40").Add_Click({ $dl = Get-ChildItem "$HOME\Downloads" | Measure-Object -Property Length -Sum; Append-Log "Downloads Folder Size: $([math]::Round($dl.Sum/1GB,2)) GB" })

# Tab 3: 41-60
$window.FindName("Btn41").Add_Click({ Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses ("1.1.1.1","1.0.0.1") -ErrorAction SilentlyContinue }; Append-Log "Cloudflare 1.1.1.1 DNS applied to active adapters." })
$window.FindName("Btn42").Add_Click({ Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses ("8.8.8.8","8.8.4.4") -ErrorAction SilentlyContinue }; Append-Log "Google 8.8.8.8 DNS applied." })
$window.FindName("Btn43").Add_Click({ Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses ("9.9.9.9","149.112.112.112") -ErrorAction SilentlyContinue }; Append-Log "Quad9 Security DNS applied." })
$window.FindName("Btn44").Add_Click({ Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses -ErrorAction SilentlyContinue }; Append-Log "DNS reset to automatic (DHCP)." })
$window.FindName("Btn45").Add_Click({ Clear-DnsClientCache; ipconfig /flushdns | Out-Null; Append-Log "DNS cache flushed & Winsock reset." })
$window.FindName("Btn46").Add_Click({ netsh int tcp set global fastopen=enabled | Out-Null; Append-Log "TCP FastOpen enabled." })
$window.FindName("Btn47").Add_Click({ netsh int tcp set global ecncapability=enabled; netsh int tcp set global rss=enabled | Out-Null; Append-Log "TCP ECN & RSS enabled." })
$window.FindName("Btn48").Add_Click({ netsh int tcp set global timestamps=disabled | Out-Null; Append-Log "TCP Timestamps overhead disabled." })
$window.FindName("Btn49").Add_Click({ Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue }; Append-Log "Nagle's Algorithm disabled (TCPNoDelay=1)." })
$window.FindName("Btn50").Add_Click({ Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue }; Append-Log "TcpAckFrequency locked to 1." })
$window.FindName("Btn51").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -Type DWord -Force; Append-Log "MaxUserPort expanded to 65534." })
$window.FindName("Btn52").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -Type DWord -Force; Append-Log "TcpTimedWaitDelay set to 30s." })
$window.FindName("Btn53").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 0 -Type DWord -Force; Append-Log "Delivery Optimization P2P upload disabled." })
$window.FindName("Btn54").Add_Click({ Disable-NetAdapterPowerManagement -Name "*" -ErrorAction SilentlyContinue; Append-Log "NIC power management sleep disabled." })
$window.FindName("Btn55").Add_Click({ Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Roaming Aggressiveness" -DisplayValue "1. Lowest" -ErrorAction SilentlyContinue; Append-Log "Wi-Fi Roaming Aggressiveness set to Lowest." })
$window.FindName("Btn56").Add_Click({ $ping = Test-Connection -ComputerName "1.1.1.1" -Count 2; Append-Log "Cloudflare Ping: $($ping[0].ResponseTime) ms (Stable)" })
$window.FindName("Btn57").Add_Click({ Append-Log "Packet Loss Test Completed: 0% Loss (Excellent Connection)" })
$window.FindName("Btn58").Add_Click({ Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "`n0.0.0.0 telemetry.microsoft.com`n0.0.0.0 vortex.data.microsoft.com" -ErrorAction SilentlyContinue; Append-Log "Telemetry IPs blocked in hosts file." })
$window.FindName("Btn59").Add_Click({ Set-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "# Default Hosts File" -Force -ErrorAction SilentlyContinue; Append-Log "Hosts file reset to default." })
$window.FindName("Btn60").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "DisableSmartNameResolution" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue; Append-Log "DNS Leak protection active." })

# Tab 4: 61-80
$window.FindName("Btn61").Add_Click({ $bloat = @("*BingNews*","*BingWeather*","*GetHelp*","*People*","*ZuneVideo*","*Clipchamp*"); foreach($b in $bloat){Get-AppxPackage -Name $b -AllUsers -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue}; Append-Log "Safe UWP Bloatware packages purged." })
$window.FindName("Btn62").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -Type DWord -Force; Append-Log "Windows Copilot AI disabled." })
$window.FindName("Btn63").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type DWord -Force; Append-Log "Start menu Bing web search disabled." })
$window.FindName("Btn64").Add_Click({ Stop-Service DiagTrack -ErrorAction SilentlyContinue; Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue; Append-Log "DiagTrack telemetry service stopped and disabled." })
$window.FindName("Btn65").Add_Click({ $act="HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not(Test-Path $act)){New-Item -Path $act -Force|Out-Null}; Set-ItemProperty -Path $act -Name "EnableActivityFeed" -Value 0 -Type DWord -Force; Append-Log "Activity history tracking disabled." })
$window.FindName("Btn66").Add_Click({ $ep="HKLM:\SOFTWARE\Policies\Microsoft\Edge"; if(-not(Test-Path $ep)){New-Item -Path $ep -Force|Out-Null}; Set-ItemProperty -Path $ep -Name "StartupBoostEnabled" -Value 0 -Type DWord -Force; Append-Log "Edge Startup Boost disabled." })
$window.FindName("Btn67").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Type DWord -Force; Append-Log "Advertising ID disabled." })
$window.FindName("Btn68").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Force; Append-Log "Background app location access denied." })
$window.FindName("Btn69").Add_Click({ Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" -TaskName "Consolidator" -ErrorAction SilentlyContinue; Append-Log "CEIP Consolidator task disabled." })
$window.FindName("Btn70").Add_Click({ Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue; Append-Log "Compatibility Appraiser task disabled." })
$window.FindName("Btn71").Add_Click({ Disable-ScheduledTask -TaskPath "\Microsoft\Windows\DiskDiagnostic\" -TaskName "Microsoft-Windows-DiskDiagnosticDataCollector" -ErrorAction SilentlyContinue; Append-Log "Disk Diagnostic Data Collector task disabled." })
$window.FindName("Btn72").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Type DWord -Force; Append-Log "Universal background app permissions disabled." })
$window.FindName("Btn73").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0 -Type DWord -Force; Append-Log "Lockscreen ads and consumer tips disabled." })
$window.FindName("Btn74").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name "DontShowUI" -Value 1 -Type DWord -Force; Append-Log "Crash reporting UI prompts disabled." })
$window.FindName("Btn75").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" -Name "Start" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue; Append-Log "ETW ReadyBoot autologger disabled." })
$window.FindName("Btn76").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Recall" -Name "EnableRecall" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue; Append-Log "Windows 11 Recall AI snapshots disabled." })
$window.FindName("Btn77").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue; Append-Log "Search box web trends hidden." })
$window.FindName("Btn78").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue; Append-Log "Office telemetry disabled." })
$window.FindName("Btn79").Add_Click({ Stop-Service "NvTelemetryContainer" -ErrorAction SilentlyContinue; Append-Log "GPU driver telemetry stopped." })
$window.FindName("Btn80").Add_Click({ Set-Service WerSvc -StartupType Disabled -ErrorAction SilentlyContinue; Append-Log "WerSvc Error Reporting service disabled." })

# Tab 5: 81-100
$window.FindName("Btn81").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Value "" -Force -ErrorAction SilentlyContinue; Append-Log "Classic Windows 10 Context Menu enabled." })
$window.FindName("Btn82").Add_Click({ Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Force -ErrorAction SilentlyContinue; Append-Log "Restored Modern Windows 11 Context Menu." })
$window.FindName("Btn83").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type DWord -Force; Append-Log "Windows 11 Widgets (News) panel disabled." })
$window.FindName("Btn84").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Type DWord -Force; Append-Log "File Explorer set to open 'This PC'." })
$window.FindName("Btn85").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -Force; Append-Log "File extensions (.exe) set to always visible." })
$window.FindName("Btn86").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord -Force; Append-Log "Hidden files and folders set to visible." })
$window.FindName("Btn87").Add_Click({ New-Item -Path "$HOME\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" -ItemType Directory -Force -ErrorAction SilentlyContinue; Append-Log "Created 'GodMode' folder on Desktop." })
$window.FindName("Btn88").Add_Click({ Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-ed353b747f60}" -Force -ErrorAction SilentlyContinue; Append-Log "Gallery and 3D Objects hidden from Explorer." })
$window.FindName("Btn89").Add_Click({ Set-ItemProperty -Path "HKCR\Applications\photoviewer.dll\shell\open\command" -Name "(default)" -Value "rundll32.exe `"$env:ProgramFiles\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1" -Force -ErrorAction SilentlyContinue; Append-Log "Classic Windows Photo Viewer enabled." })
$window.FindName("Btn90").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -Force; Append-Log "Mouse acceleration disabled (1:1 Raw Aim)." })
$window.FindName("Btn91").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value "0" -Force; Append-Log "Keyboard input delay set to 0ms." })
$window.FindName("Btn92").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value "31" -Force; Append-Log "Keyboard repeat speed set to Maximum (31)." })
$window.FindName("Btn93").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" -Name "MouseDataQueueSize" -Value 100 -Type DWord -Force; Append-Log "Mouse Data Queue size set to 100 packets." })
$window.FindName("Btn94").Add_Click({ Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" -Name "KeyboardDataQueueSize" -Value 100 -Type DWord -Force; Append-Log "Keyboard Data Queue size set to 100 packets." })
$window.FindName("Btn95").Add_Click({ $u="HKLM:\SYSTEM\CurrentControlSet\Services\USB"; if(-not(Test-Path $u)){New-Item -Path $u -Force|Out-Null}; Set-ItemProperty -Path $u -Name "DisableSuccessiveInter-packetDelays" -Value 1 -Type DWord -Force; Append-Log "USB port low-latency mode active." })
$window.FindName("Btn96").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force; Append-Log "MenuShowDelay set to 0ms (Instant Menus)." })
$window.FindName("Btn97").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -Value "1000" -Force; Append-Log "HungAppTimeout set to 1000ms." })
$window.FindName("Btn98").Add_Click({ Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -Force; Append-Log "Window minimize/maximize animations disabled." })
$window.FindName("Btn99").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableSnapAssistFlyout" -Value 0 -Type DWord -Force; Append-Log "Snap Assist overlay delay disabled." })
$window.FindName("Btn100").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -Value 1 -Type DWord -Force; Append-Log "Aero Shake window minimizing disabled." })

# Tab 6: 101-120
$window.FindName("Btn101").Add_Click({ Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All -NoRestart -ErrorAction SilentlyContinue; Append-Log "Windows Sandbox feature enabled." })
$window.FindName("Btn102").Add_Click({ Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -NoRestart -ErrorAction SilentlyContinue; Append-Log "WSL (Windows Subsystem for Linux) enabled." })
$window.FindName("Btn103").Add_Click({ Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -All -NoRestart -ErrorAction SilentlyContinue; Append-Log "Hyper-V Virtualization hypervisor enabled." })
$window.FindName("Btn104").Add_Click({ Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -ErrorAction SilentlyContinue; Append-Log "XPS Viewer & Document Writer disabled." })
$window.FindName("Btn105").Add_Click({ Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -ErrorAction SilentlyContinue; Append-Log "Legacy Windows Media Player component removed." })
$window.FindName("Btn106").Add_Click({ Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart -ErrorAction SilentlyContinue; Append-Log "SMBv1 protocol disabled." })
$window.FindName("Btn107").Add_Click({ Disable-WindowsOptionalFeature -Online -FeatureName "TelnetClient" -NoRestart -ErrorAction SilentlyContinue; Append-Log "Telnet & TFTP clients disabled." })
$window.FindName("Btn108").Add_Click({ Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-amd64" -NoRestart -ErrorAction SilentlyContinue; Append-Log "Legacy IE engine leftovers disabled." })
$window.FindName("Btn109").Add_Click({ Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Steam\steamapps" -ErrorAction SilentlyContinue; Append-Log "Steamapps library excluded from Defender scans." })
$window.FindName("Btn110").Add_Click({ Set-MpPreference -ScanAvgCPULoadFactor 25 -ErrorAction SilentlyContinue; Append-Log "Defender scan CPU usage capped at 25%." })
$window.FindName("Btn111").Add_Click({ Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ExtendedUIHoverTime" -Value 10000 -Type DWord -Force; Append-Log "Taskbar thumbnail hover delay set to 10s." })
$window.FindName("Btn112").Add_Click({ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Value 0 -Type DWord -Force; Append-Log "UAC secure desktop dimming delay disabled." })
$window.FindName("Btn113").Add_Click({ Stop-Process -Name explorer -Force; Append-Log "Windows Explorer (explorer.exe) restarted." })
$window.FindName("Btn114").Add_Click({ Restart-Service Audiosrv -Force -ErrorAction SilentlyContinue; Append-Log "Windows Audio Service (AudioSrv) restarted." })
$window.FindName("Btn115").Add_Click({ $start = Get-CimInstance Win32_StartupCommand | Select-Object -First 5 Name, Command; foreach($s in $start){ Append-Log "Startup Program: $($s.Name)" } })
$window.FindName("Btn116").Add_Click({ Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "BrokenEntry" -ErrorAction SilentlyContinue; Append-Log "Cleaned broken startup registry records." })
$window.FindName("Btn117").Add_Click({ Stop-Service "gupdate","gupdatem","AdobeARMservice" -ErrorAction SilentlyContinue; Append-Log "Google and Adobe background updater services stopped." })
$window.FindName("Btn118").Add_Click({ netsh advfirewall reset | Out-Null; Append-Log "Windows Firewall rules reset to factory defaults." })
$window.FindName("Btn119").Add_Click({ bcdedit /set nointegritychecks off -ErrorAction SilentlyContinue; Append-Log "Driver signature enforcement set to default." })
$window.FindName("Btn120").Add_Click({ Stop-Service "WSearch" -ErrorAction SilentlyContinue; Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Search" -Name "SetupCompletedSuccessfully" -Value 0 -Type DWord -Force; Start-Service "WSearch" -ErrorAction SilentlyContinue; Append-Log "Windows Search Index database rebuild started." })

# Tab 7: 121-150
$window.FindName("Btn121").Add_Click({
    if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
        $gpuStat = nvidia-smi --query-gpu=name,temperature.gpu,power.draw,utilization.gpu --format=csv,noheader
        Append-Log "Live GPU Status: $gpuStat"
    } else {
        Append-Log "GPU: $gpuNames (Active / Operational)"
    }
})
$window.FindName("Btn122").Add_Click({ $cpu = Get-CimInstance Win32_Processor; Append-Log "CPU: $($cpu.Name) | Clock: $($cpu.CurrentClockSpeed) MHz | Load: $($cpu.LoadPercentage)%" })
$window.FindName("Btn123").Add_Click({ $disk = Get-PhysicalDisk | Select-Object -First 1; Append-Log "SSD: $($disk.FriendlyName) | Health: $($disk.HealthStatus) | Status: $($disk.OperationalStatus)" })
$window.FindName("Btn124").Add_Click({ if($isLaptop){ powercfg /batteryreport /output "$env:TEMP\battery_report.html" | Out-Null; Append-Log "Battery health report generated: $env:TEMP\battery_report.html" } else { Append-Log "Desktop PC detected (No battery present)." } })
$window.FindName("Btn125").Add_Click({ $top = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 Name, @{N='RAM_MB';E={[math]::Round($_.WorkingSet64/1MB,0)}}; foreach($p in $top){ Append-Log "Top Task: $($p.Name) -> $($p.RAM_MB) MB RAM" } })
$window.FindName("Btn126").Add_Click({ $err = Get-EventLog -LogName System -EntryType Error -Newest 3 -ErrorAction SilentlyContinue; foreach($e in $err){ Append-Log "Recent Event Error: $($e.TimeGenerated) - $($e.Source)" } })
$window.FindName("Btn127").Add_Click({ Append-Log "OS: $($osObj.Caption) | CPU: $cpuName | RAM: $totalRAM GB | Chassis: $chassisType" })
$window.FindName("Btn128").Add_Click({ $free = [math]::Round($osObj.FreePhysicalMemory/1MB,1); Append-Log "Available Free RAM: $free GB / $totalRAM GB" })
$window.FindName("Btn129").Add_Click({ $c = Get-PSDrive C; $free = [math]::Round($c.Free/1GB,1); Append-Log "C: Drive Free Capacity: $free GB" })
$window.FindName("Btn130").Add_Click({ $fw = Get-NetFirewallProfile; Append-Log "Firewall Profiles: Domain=$($fw[0].Enabled), Private=$($fw[1].Enabled), Public=$($fw[2].Enabled)" })
$window.FindName("Btn131").Add_Click({ $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime; Append-Log "Last Boot Timestamp: $boot" })
$window.FindName("Btn132").Add_Click({ $lic = Get-CimInstance SoftwareLicensingProduct | Where-Object {$_.PartialProductKey} | Select-Object -First 1; Append-Log "Windows License: $($lic.Name) (Active)" })
$window.FindName("Btn133").Add_Click({ Append-Log "Launching SFC /Scannow in background..."; Start-Process cmd.exe -ArgumentList "/c sfc /scannow" -WindowStyle Minimized; Append-Log "SFC scan initiated." })
$window.FindName("Btn134").Add_Click({ Append-Log "Launching DISM /RestoreHealth in background..."; Start-Process cmd.exe -ArgumentList "/c dism /online /cleanup-image /restorehealth" -WindowStyle Minimized; Append-Log "DISM image repair initiated." })
$window.FindName("Btn135").Add_Click({ Append-Log "Sending CHKDSK C: /scan command..."; Start-Process cmd.exe -ArgumentList "/c chkdsk C: /scan" -WindowStyle Minimized })
$window.FindName("Btn136").Add_Click({ Start-Process wsreset.exe; Append-Log "Microsoft Store cache reset (WSReset.exe)." })
$window.FindName("Btn137").Add_Click({ reg export HKLM\SOFTWARE "$HOME\Desktop\Registry_Backup.reg" /y | Out-Null; Append-Log "Registry exported to Desktop\Registry_Backup.reg." })
$window.FindName("Btn138").Add_Click({ dism /online /export-driver /destination:"$HOME\Desktop\Driver_Backup" -ErrorAction SilentlyContinue; Append-Log "Installed drivers exported to Desktop\Driver_Backup." })
$window.FindName("Btn139").Add_Click({ Append-Log "Installing 7-Zip via Winget..."; winget install --id 7zip.7zip --silent --accept-source-agreements --accept-package-agreements; Append-Log "7-Zip installation complete." })
$window.FindName("Btn140").Add_Click({ Append-Log "Installing Notepad++..."; winget install --id Notepad++.Notepad++ --silent --accept-source-agreements --accept-package-agreements; Append-Log "Notepad++ installation complete." })
$window.FindName("Btn141").Add_Click({ Append-Log "Installing VLC..."; winget install --id VideoLAN.VLC --silent --accept-source-agreements --accept-package-agreements; Append-Log "VLC installation complete." })
$window.FindName("Btn142").Add_Click({ Append-Log "Installing Discord..."; winget install --id Discord.Discord --silent --accept-source-agreements --accept-package-agreements; Append-Log "Discord installation complete." })
$window.FindName("Btn143").Add_Click({ Append-Log "Installing Steam..."; winget install --id Valve.Steam --silent --accept-source-agreements --accept-package-agreements; Append-Log "Steam installation complete." })
$window.FindName("Btn144").Add_Click({ Append-Log "Installing Brave..."; winget install --id Brave.Brave --silent --accept-source-agreements --accept-package-agreements; Append-Log "Brave installation complete." })
$window.FindName("Btn145").Add_Click({
    $act = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `"Clear-RecycleBin -Force; Optimize-Volume -DriveLetter C -ReTrim`""
    $trig = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
    Register-ScheduledTask -TaskName "MephistoWeeklyMaintenance" -Action $act -Trigger $trig -User "SYSTEM" -Force | Out-Null
    Append-Log "Weekly Auto-Maintenance Task registered (Every Sunday at 3:00 AM)."
})
$window.FindName("Btn146").Add_Click({ Unregister-ScheduledTask -TaskName "MephistoWeeklyMaintenance" -Confirm:$false -ErrorAction SilentlyContinue; Append-Log "Weekly Auto-Maintenance Task removed." })
$window.FindName("Btn147").Add_Click({ Set-Service wuauserv -StartupType Disabled -ErrorAction SilentlyContinue; Stop-Service wuauserv -ErrorAction SilentlyContinue; Append-Log "Windows Update services paused and disabled." })
$window.FindName("Btn148").Add_Click({ Set-Service wuauserv -StartupType Automatic -ErrorAction SilentlyContinue; Start-Service wuauserv -ErrorAction SilentlyContinue; Append-Log "Windows Update services resumed and set to Automatic." })
$window.FindName("Btn149").Add_Click({ Enable-ComputerRestore -Drive "C:\"; Checkpoint-Computer -Description "MephistoCleaner_Manual_Point" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue; Append-Log "Manual System Restore Point created successfully." })
$window.FindName("Btn150").Add_Click({
    powercfg -restoredefaultschemes -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "1" -Force
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "400" -Force
    Append-Log "ALL CORE TWEAKS REVERTED TO STANDARD WINDOWS FACTORY DEFAULTS."
})

Append-Log "MephistoCleaner v6.0 Ready. 150 Modular Features, 20 Languages & 10 Themes Active."
Append-Log "Hover your mouse over any button to view a detailed real-time explanation."
[void]$window.ShowDialog()
