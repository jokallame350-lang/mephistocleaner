# 🤝 Contributing to MephistoCleaner

We welcome contributions from developers, system engineers, gamers, and translators from all over the world!

---

### How You Can Help

1. **Submitting New Features & Tweaks:**
   * Ensure any proposed tweak is **100% safe, stable, and reversible**.
   * Avoid destructive tweaks that break printing, audio services, or essential Windows security layers permanently.
   * Provide a clear description and testing evidence across Windows 10 and 11.

2. **Localization & Language Improvements:**
   * MephistoCleaner supports 20 languages. If you spot a mistranslation or want to refine language strings, submit a pull request updating `$global:LangDict` in `MephistoCleaner.ps1`.

3. **Reporting Bugs:**
   * Open an issue using the [Bug Report Template](https://github.com/jokallame350-lang/mephistocleaner/issues/new?template=bug_report.md).
   * Specify your Windows build, CPU, GPU, and the exact error log output.

---

### Development Workflow

1. Fork the repository on GitHub.
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/mephistocleaner.git
   ```
3. Create a descriptive feature branch:
   ```bash
   git checkout -b feature/awesome-new-tweak
   ```
4. Test your changes locally in an elevated PowerShell session:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\MephistoCleaner.ps1
   ```
5. Commit your changes with a clear commit message:
   ```bash
   git commit -m "feat(network): add automated MTU optimization"
   ```
6. Push to your branch and open a Pull Request!
