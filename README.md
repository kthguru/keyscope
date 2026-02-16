<br />
<div align="center">
  <img src="https://download.keyscope.dev/logo.png" alt="Keyscope Logo" width="128" height="128">
  <br>
 
  <h1>Keyscope</h1>
  <p>
    Redis, Valkey, and Dragonfly GUI with built-in multilingual support for global users.
    <br><br>
  </p>

  [![pub package](https://img.shields.io/pub/v/keyscope.svg?label=Latest)](https://pub.dev/packages/keyscope)
  [![GUI](https://github.com/infradise/keyscope/actions/workflows/build-gui.yaml/badge.svg)](https://github.com/infradise/keyscope/actions/workflows/build-gui.yaml)
  [![CLI](https://github.com/infradise/keyscope/actions/workflows/build-cli.yaml/badge.svg)](https://github.com/infradise/keyscope/actions/workflows/build-cli.yaml)
  [![pub package](https://img.shields.io/pub/v/keyscope_client.svg?label=keyscope_client)](https://pub.dev/packages/keyscope_client)

  <!-- ![Build Status](https://img.shields.io/github/actions/workflow/status/infradise/keyscope/build.yml?branch=main) -->

  ![Keyscope Data Explorer for ZSet](https://download.keyscope.dev/screenshots/commands/sorted-set/keyscope-data-explorer-zset.png)
 
  <p>
    <a href="#-why-keyscope">Why Keyscope?</a> •
    <a href="#-key-features">Key Features</a> •
    <a href="#-powered-by">Powered By</a> •
    <a href="#-translations">Translations</a> •
    <a href="#-build">Build</a> •
    <a href="#-run">Run</a> •
    <a href="#-installation">Installation</a>
  </p>

  <br>

</div>

## ✨ Why Keyscope?

While existing tools are heavy (Electron-based) or lack support for modern Valkey and Dragonfly features, Keyscope runs natively and supports [Redis](https://redis.io), [Valkey](https://valkey.io), and [Dragonfly](https://www.dragonflydb.io/), with built-in multilingual support for global users.

## 🚀 Key Features

* **High Performance:** Render 100k+ keys smoothly using `dense_table` virtualization.
* **Cluster Ready:** First-class support for Redis/Valkey Cluster & Sentinel.
* **Secure:** Built-in SSH Tunneling and TLS (SSL) support.
* **Multi-Platform:** Runs natively on macOS, Windows, and Linux.
* **Multilingual:** Internationalization (i18n) with full multi-language support.
* **Developer Friendly:** JSON viewer, CLI console, and dark mode optimized for engineers.

## 🛠 Powered By

Built with ❤️ using [keyscope_client](https://pub.dev/packages/keyscope_client) and dense_table.

* **[keyscope_client](https://pub.dev/packages/keyscope_client):** The engine behind the connectivity.
* **dense_table:** The engine behind the UI performance.
  > Merged into Keyscope UI. Functionality now included directly in Keyscope.

## 🌐 Translations

Keyscope currently supports **15+ languages**, making it accessible to developers worldwide.

| Region | Languages |
| :--- | :--- |
| **Asia** | 🇰🇷 한국어, 🇯🇵 日本語, 🇨🇳 简体中文, 🇹🇼 繁體中文, 🇮🇩 Bahasa Indonesia, 🇻🇳 Tiếng Việt, 🇹🇭 ภาษาไทย |
| **Europe** | 🇩🇪 Deutsch (Standard/CH), 🇫🇷 Français, 🇮🇹 Italiano, 🇪🇸 Español, 🇵🇹 Português (PT), 🇷🇺 Русский |
| **Americas** | 🇺🇸 English, 🇵🇹 Português (BR) |

For more details or to contribute a new language, check out the [Translation Guide](https://github.com/infradise/keyscope/blob/main/docs/TRANSLATIONS.md).

## 🔨Build

For more details, check out the [Build Instructions](https://github.com/infradise/keyscope/blob/main/docs/BUILD.md).

<!-- <a id="-run"></a> ▶️ -->
## ⚡ Run

```sh
lib/main.dart
```

## 📦 Installation

Check the [Releases](https://github.com/infradise/keyscope/releases) page for the latest installer (`.dmg`, `.exe`, `.msi`, `.rpm`, `.deb`).