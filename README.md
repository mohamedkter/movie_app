# 🎬 MovieFav - Flutter Movie App

A beautiful, modular Flutter application for browsing and favoriting movies. Designed with clean architecture and theming, powered by Firebase and remote/local data layers.

---

## 🚀 Features

- 🔐 Firebase Authentication
  - Email verification
  - Sign up / Sign in / Forgot password

- 🎞 Browse Movies
  - View trending and latest movies
  - Search for specific titles

- ⭐ Favorites
  - Add/remove movies to your favorite list
  - Favorites stored per user

- 🎨 Theming
  - Dark theme with custom colors (`app_color.dart`)
  - Responsive and clean UI design

- 🧱 Modular Architecture
  - `core`, `features`, `services`, `data`, `domain`, `presentation`
  - Uses Cubit/Bloc (if applicable) for state management

- 📦 Local & Remote data sources
  - Caches data locally for performance
  - Uses remote APIs for movie info

---

## 📁 Folder Structure

├── core/ # Constants, enums, services, theme
├── firebase/ # Firebase setup
├── modules/
│ ├── auth/ # Sign in, sign up, forgot password
│ ├── home/ # Home page movies + favorites
│ ├── search/ # Search functionality
│ └── view_movie/ # Movie details view
├── shared/ # Reusable widgets and icons
└── main.dart # App entry point

## 📱 App Screenshots

### 🏠 Home Screen  
<img src="https://github.com/user-attachments/assets/22b9569a-ccfe-4980-98c0-e5874e643a65" width="350"/>

---

### 🔐 Login & Sign Up  
**Login**  
<img src="https://github.com/user-attachments/assets/d0dd899c-bb46-4f4f-907b-48d1641eab26" width="350"/>

**Sign Up**  
<img src="https://github.com/user-attachments/assets/214a3437-1863-4485-95f8-e37775a1d645" width="350"/>

---

### 🎬 Movie Details  
<img src="https://github.com/user-attachments/assets/65c70db7-0eaf-4a5b-a325-e98e5e4e944f" width="350"/>
<img src="https://github.com/user-attachments/assets/1e51b949-e576-42ad-9f42-30247ca64ea1" width="350"/>
<img src="https://github.com/user-attachments/assets/ed7def7b-0662-4aa0-b172-c18244d0cf86" width="350"/>

---

### ⭐ Movie Stars  
<img src="https://github.com/user-attachments/assets/16ccb24c-8fe3-4bc8-a50e-5504c4f85c7f" width="350"/>

---

### ❤️ Favorite Screen  
<img src="https://github.com/user-attachments/assets/6d62bff3-c951-4073-8e72-03dcdcef4277" width="350"/>

---

### 🔍 Search Screens  
<img src="https://github.com/user-attachments/assets/c71ef173-05e9-404d-b150-26e6224eca79" width="350"/>
<img src="https://github.com/user-attachments/assets/2a9d0d51-9489-4382-8aaf-16d7926fc302" width="350"/>

---

### 📂 Show All & Drawer  
<img src="https://github.com/user-attachments/assets/fda71770-0734-4543-92e5-b0dd8bb5a34e" width="350"/>
<img src="https://github.com/user-attachments/assets/7dbc2aa2-0eca-404a-bb4a-d87ce14a490d" width="350"/>

---

### 🎞️ Movie V  
<img src="https://github.com/user-attachments/assets/87b9652e-87e3-4c0f-9045-29ed4b59f45b" width="350"/>


---

## 🧪 Setup Instructions

### ✅ Prerequisites

- Flutter SDK (Stable channel)
- Firebase project set up
- `.env` file (for API keys or Firebase config)

### 🔧 Run the App

```bash
flutter pub get
flutter run
Make sure to add your .env file in the root and keep it out of version control.

🌐 API & Data Sources
Movie data comes from a remote source (e.g., TMDB or your custom API)

Firebase handles authentication and possibly favorite movie storage per user

🎨 App Colors
Defined in app_color.dart:

Primary: #85924B

Secondary: #24303E

Variant: #16121F

🛠️ TODO / Coming Soon
 Implement genre-based browsing

 Add user profile with editable settings

 Unit & widget testing

 Offline mode with full caching



👨‍💻 Author
Mohamed El-Refaie
💼 LinkedIn | 🧑‍💻 Flutter Developer

