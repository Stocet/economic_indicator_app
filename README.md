# 📊 Economic Indicators App

A mobile application built with **Flutter** to visualize key economic indicators from the **National Bank of Ethiopia (NBE) 2023/2024 annual report**.

## ✨ Features

- **Interactive Data** – Select up to five key economic indicators to view.
- **Swipeable Charts** – Easily swipe through charts for selected indicators in a clean, immersive carousel view.
- **Clear Descriptions** – Each indicator includes a short, informative description to help you understand its meaning and significance.
- **NBE Data Source** – All data is sourced from the National Bank of Ethiopia's 2023/2024 annual report, as explicitly noted within the app.
- **Offline Functionality** – Uses a static JSON file as its data source, allowing it to function offline seamlessly.
- **Intuitive Navigation** – A bottom navigation bar provides easy access to the **Home**, **Indicators**, and **About** screens.

## 📸 Screenshots

> The app is designed to be fully responsive. Below are example views:

<p align="center">
  <img src="/assets/screenshots/home_page.png" alt="Home Page" width="30%"/>
  <img src="/assets/screenshots/indicator_page.png" alt="Investment Advisory" width="30%"/>
  <img src="/assets/screenshots/about_page.png" alt="Result" width="30%"/>
</p>

### **Home Screen**

- Displays welcome text and a couple of **Featured Indicator** cards.
- Bottom navigation bar visible at the bottom.

### **Indicators Selection**

- Dropdown menu with a list of available indicators.
- Carousel area below shows selected indicator cards or remains empty until selection.

### **Indicator Carousel View**

- Displays one indicator card with:
  - A chart (line or bar)
  - A clear title
  - Descriptive text below the chart

### **About Screen**

- Shows:
  - Purpose of the app
  - Data source information
  - Disclaimer

## 🚀 Getting Started

### 1️⃣ Clone the repository:

```bash
git clone https://github.com/Stocet/economic_indicator_app.git
cd economic-indicators-app
```

### 2️⃣ Install dependencies:

```bash
flutter pub get
```

### 3️⃣ Run the app:

```bash
flutter run
```

## 📂 Data Source

The application uses data from the **National Bank of Ethiopia (NBE) 2023/2024 annual report**.
The `assets/indicators.json` file contains a static representation of this data for **offline** use.

## 📦 Dependencies

- **[fl_chart](https://pub.dev/packages/fl_chart)** – Create and render beautiful charts.
- **[carousel_slider](https://pub.dev/packages/carousel_slider)** – Enable swipeable chart views.
- **[google_fonts](https://pub.dev/packages/google_fonts)** – Use the modern, clean **Inter** font throughout the app.
- **[flutter_native_splash](https://pub.dev/packages/flutter_native_splash)** – Generate the native splash screen.
