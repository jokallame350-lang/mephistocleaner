using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Windows.Forms;

[assembly: AssemblyTitle("MephistoCleaner")]
[assembly: AssemblyDescription("The Transparent & Modular Windows 10 & 11 Optimization Suite")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("MephistoCleaner Open-Source")]
[assembly: AssemblyProduct("MephistoCleaner")]
[assembly: AssemblyCopyright("Copyright © 2026 MephistoCleaner Project")]
[assembly: AssemblyTrademark("MephistoCleaner")]
[assembly: AssemblyCulture("")]
[assembly: AssemblyVersion("7.0.0.0")]
[assembly: AssemblyFileVersion("7.0.0.0")]

namespace MephistoCleaner
{
    static class Program
    {
        [DllImport("kernel32.dll")]
        static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        [STAThread]
        static void Main(string[] args)
        {
            IntPtr hWnd = GetConsoleWindow();
            if (hWnd != IntPtr.Zero)
            {
                ShowWindow(hWnd, 0);
            }

            if (!IsAdministrator())
            {
                try
                {
                    ProcessStartInfo psi = new ProcessStartInfo();
                    psi.FileName = Application.ExecutablePath;
                    psi.Verb = "runas";
                    psi.UseShellExecute = true;
                    Process.Start(psi);
                    return;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Administrator privileges are required to run MephistoCleaner:\n" + ex.Message, "Permission Required", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            string appDir = AppDomain.CurrentDomain.BaseDirectory;
            string ps1Path = Path.Combine(appDir, "MephistoCleaner.ps1");

            if (!File.Exists(ps1Path))
            {
                string localAppData = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "MephistoCleaner", "MephistoCleaner.ps1");
                string programFiles = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles), "MephistoCleaner", "MephistoCleaner.ps1");
                string programFilesX86 = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ProgramFilesX86), "MephistoCleaner", "MephistoCleaner.ps1");

                if (File.Exists(localAppData)) ps1Path = localAppData;
                else if (File.Exists(programFiles)) ps1Path = programFiles;
                else if (File.Exists(programFilesX86)) ps1Path = programFilesX86;
            }

            if (!File.Exists(ps1Path))
            {
                MessageBox.Show("Could not locate MephistoCleaner.ps1 engine file at:\n" + ps1Path, "Engine Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            ProcessStartInfo pInfo = new ProcessStartInfo();
            pInfo.FileName = "powershell.exe";
            pInfo.Arguments = "-STA -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File \"" + ps1Path + "\"";
            pInfo.WorkingDirectory = Path.GetDirectoryName(ps1Path);
            pInfo.WindowStyle = ProcessWindowStyle.Hidden;
            pInfo.CreateNoWindow = true;
            pInfo.UseShellExecute = false;

            try
            {
                Process proc = Process.Start(pInfo);
                proc.WaitForExit();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to launch optimization engine:\n" + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private static bool IsAdministrator()
        {
            WindowsIdentity identity = WindowsIdentity.GetCurrent();
            WindowsPrincipal principal = new WindowsPrincipal(identity);
            return principal.IsInRole(WindowsBuiltInRole.Administrator);
        }
    }
}
