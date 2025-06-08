
# 🎮 Undertale 電子書 App

這是一個使用 Flutter 製作的 Undertale 主題電子書應用程式，內含角色介紹、地區場景、背景音樂播放等功能，並採用像素風格字體與背景，致敬經典遊戲《Undertale》。

## 📱 預覽畫面

| 主畫面 | 角色頁面 | 地區列表 | 音樂播放 |
|--------|----------|----------|----------|
| ![Home](screenshots/home.png) | ![Character](screenshots/character.png) | ![Area](screenshots/area.png) | ![Music](screenshots/music.png) |

## 🧩 功能特色

- 🔖 **角色介紹頁面**：點擊角色卡片可查看詳細介紹與主題音樂。
- 🗺️ **地區展示頁面**：呈現地圖場景圖片與標題。
- 🎵 **音樂播放功能**：可點擊播放不同背景音樂，自動循環播放。
- 🧭 **多頁面導覽**：使用 `Navigator` 管理頁面切換。
- 🧱 **卡片式布局**：角色卡片使用 `Card` 和 `GridView` 呈現。
- 📚 **分頁式介面**：整體 UI 使用 `TabBar` 和 `TabBarView` 實作分頁。
- 🖱️ **點擊偵測**：透過 `GestureDetector` 處理點擊事件。
- 🔤 **像素字體**：整體應用風格融合復古像素字體與遊戲元素。

## 🛠️ 技術細節

- Flutter 3.x
- 使用 `audioplayers` 播放音樂
- 自訂資料模型：
  - `Character`：角色資訊
  - `Area`：地區圖片與名稱
  - `MusicTrack`：音樂標題、作曲者與檔案路徑
- 使用 `ListView.separated`, `GridView.count`, `DefaultTabController`, `StatelessWidget`, `Navigator` 等核心 Flutter widget

## 📁 專案結構簡述

```

assets/
images/         # 所有角色與地圖圖像
audio/          # 所有背景音樂檔案
lib/
main.dart       # App 主入口
models.dart     # 自訂的資料型別（若拆檔）
fonts/
PixelFont.ttf   # 像素風格字體
pubspec.yaml      # 依賴與資源設定

````

## ▶️ 安裝與執行

1. Clone 本專案：

```bash
git clone https://github.com/yourusername/undertale-ebook-app.git
cd undertale-ebook-app
````

2. 安裝相依套件：

```bash
flutter pub get
```

3. 執行模擬器或真機：

```bash
flutter run
```

## 🧾 作業需求檢核表 ✅

* [x] 每個頁面定義對應的 `StatelessWidget`
* [x] 定義資料型別：`Character`, `Area`, `MusicTrack`
* [x] 使用 `ListView.separated`
* [x] 使用 `GridView.count` 排列角色卡片
* [x] 自訂資料 Widget（如角色卡片）
* [x] 使用 `Navigator` 切換頁面
* [x] 使用 `GestureDetector` 偵測點擊事件
* [x] 使用 `DefaultTabController` 搭配 `TabBar` 分頁
* [x] 使用 `Card` widget 呈現角色格子

## 💡 參考與致敬

* 遊戲素材與音樂取自 Toby Fox 創作之《Undertale》
* 音樂僅用於非商業展示與學術用途

## 📜 License

此專案為學術用途，若您喜愛 Undertale，請支持原作：[https://undertale.com/](https://undertale.com/)

```

---

```
