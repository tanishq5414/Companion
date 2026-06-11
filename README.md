# Companion App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

Companion App is a mobile application built using Flutter, Node.js, and Supabase. It allows students to easily organize and share digital documents among a community of people. Students can rate the quality of digital documents shared and have all their notes present under one application.

[![Download on Play Store](https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.lightheads.companion.app)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [App Flow](#-app-flow)
- [Installation](#-installation)
- [Design](#-design)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## ✨ Features

- 📄 Upload and share digital documents (PDF)
- 📝 Personal notes management
- 🔐 Secure login and authentication
- 💬 Community Chat
- 🔔 Push notifications
- 🔍 Search functionality
- ⭐ Rate and review shared documents

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Flutter & Dart |
| Backend | Node.js (Express) |
| User Database | Supabase |
| Files Database | MongoDB |
| File Storage | Amazon S3 |
| Real-time Chat | Google Firebase |
| State Management | Riverpod |
| Local Storage | Hive |

---

## 📁 Project Structure

```
lib/
├── apis/                      # Backend API services
│   ├── auth_api.dart          # Authentication API calls
│   ├── chat_api.dart          # Chat & messaging API
│   ├── courses_api.dart       # Courses management API
│   ├── notes_api.dart         # Notes CRUD operations
│   └── user_api.dart          # User profile API
│
├── common/                    # Shared UI components
│   ├── app_bar.dart           # Custom app bar widget
│   ├── error_page.dart        # Global error handling page
│   ├── loading_page.dart      # Loading indicator widget
│   └── sectionchip.dart       # Reusable chip component
│
├── core/                      # Core functionality
│   ├── providers/             # Global Riverpod providers
│   ├── failure.dart           # Error & failure handling
│   ├── type_defs.dart         # Custom type definitions
│   └── utils.dart             # Utility helper functions
│
├── features/                  # Feature-based modules
│   ├── auth/                  # Login & registration
│   ├── chat/                  # Community chat room
│   ├── courses/               # Course browsing & sharing
│   ├── home/                  # Main home screen
│   ├── notes/                 # Personal notes management
│   ├── notification/          # Push notifications
│   ├── search/                # Search across content
│   └── user/                  # User profile & settings
│
├── model/                     # Data models & entities
├── theme/                     # App theming & colors
├── constants/                 # App-wide constants
├── config/                    # Environment configuration
└── main.dart                  # App entry point
```

---

## 🔄 App Flow

```
Launch App
    ↓
Auth Check (Supabase)
    ↓
┌─────────────────┐
│   Home Screen   │
├─────────────────┤
│ • Browse Courses│
│ • My Notes      │
│ • Community Chat│
│ • Search        │
│ • Notifications │
└─────────────────┘
```

---

## 🚀 Installation

To run the app locally, follow these steps:

**Prerequisites:**
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Node.js `>=16.0.0`

**Steps:**

1. Clone the repository:
```bash
git clone https://github.com/tanishq5414/Companion.git
cd Companion
```

2. Install Flutter dependencies:
```bash
flutter pub get
```

3. Add Firebase configuration:
   - Create a Firebase project
   - Add `google-services.json` to `/android/app`

4. Set up environment variables:
   - Create a `.env` file in the project root (do not edit `.env.asc`, it’s an encrypted CI artifact)
   - Add `API_URL`, `SUPABASE_API_URL`, and `SUPABASE_API_PUBLIC_KEY` values
5. Run the app:
```bash
flutter run
```

6. Backend setup:
   - Available at [notesapp-backend](https://github.com/kaamilmirza/notesapp-backend)

---

## 🎨 Design

The Figma design file is available here:

[View Figma Design](https://www.figma.com/file/E2kq9JcsduEksaxnZx1OKE/Companion-(Design-Prototypes))

---

## 🤝 Contributing

Contributions are welcome and encouraged! To contribute:

1. Fork the repository
2. Create a new branch:
```bash
git checkout -b feature/your-feature-name
```
3. Make your changes and commit:
```bash
git commit -am 'Add: your feature description'
```
4. Push to your branch:
```bash
git push origin feature/your-feature-name
```
5. Open a Pull Request

---

## 📄 License

Companion App is licensed under the **MIT License**. See the `LICENSE` file for more information.

---

## 📬 Contact

| Name | Email | LinkedIn |
|------|-------|----------|
| Kaamil | kaamil@lightheads.org | [kaamil-mirza](https://www.linkedin.com/in/kaamil-mirza/) |
| Tanishq | tanishq@lightheads.org | [tanishqagarwal](https://www.linkedin.com/in/tanishqagarwal/) |

---

## 👥 Contributors

Thank you to all contributors! 🙏

<a href="https://github.com/tanishq5414/Companion/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tanishq5414/Companion" />
</a>
- AMAZON S3 [File objects]
- Google Firebase [Real-time messaging]

## Installation

To run the app, follow these steps:

1. Clone the repository: `git clone https://github.com/tanishq5414/Companion.git`
2. Install dependencies for the frontend and backend by running the following commands in separate terminal windows:
   - `flutter pub get` 
3. Create a Firebase project and enable Supabase database and Authentication.
4. Add your Firebase project's `google-services.json` file to the `/android/app` directory.
5. Run the app on a device or emulator by running `flutter run`.
6. The endpoints are relevant to the backend of this application which will is available at https://github.com/kaamilmirza/notesapp-backend (also open-source)

## Usage

To use the app, create an account and log in. You can then upload and share digital documents, rate and provide feedback on documents shared by others, and manage your personal notes. You can also communicate with other students using the community chat feature.

## Design

The figma design file of this app is available at https://www.figma.com/file/E2kq9JcsduEksaxnZx1OKE/Companion-(Design-Prototypes)?type=design&node-id=0%3A1&t=HzbU5JQ2nCQCbxyP-1


## Contributing

Contributions to Companion App are welcome and encouraged! To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: `git checkout -b my-new-feature`.
3. Make changes and commit them: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

## License

Companion App is licensed under the MIT License. See the `LICENSE` file for more information.

## Download

Download the app on the Play Store: [https://play.google.com/store/apps/details?id=com.lightheads.companion.app](https://play.google.com/store/apps/details?id=com.lightheads.companion.app)

## Contact 

Kindly contact us regarding any queries or assitance regarding contributing to this repository.

Kaamil
kaamil@lightheads.org 
https://www.linkedin.com/in/kaamil-mirza/

Tanishq
tanishq@lightheads.org
https://www.linkedin.com/in/tanishqagarwal/

## Contributors
Thank you!

<a href="[https://github.com/tanishq5414/Companion]/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tanishq5414/Companion" />
</a>

<br/>
