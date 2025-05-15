<br>

<p align="center">
<img src="https://github.com/user-attachments/assets/933c4deb-5758-4ceb-9616-2b4ea0560786" width="140px" alt="DishCovery" />
</p>

<h1 align="center">DishCovery</h1>

<br>

## 👀 Overview
*DishCovery* is a mobile app for Google Solution Challenge APAC 2025, addressing challenges in tourism and healthcare. By helping travelers overcome language barriers and unfamiliar menus, it enables safer and more enjoyable dining experiences abroad. The app supports users with allergies, religious dietary restrictions, and personal preferences by providing instant menu translations and ingredient information. It also allows you to ask questions by playing AI-generated audio in the local language. This project aligns with SDG 3: Good Health and Well-being by promoting informed and healthy food choices for travelers.


## 📱 Screens


| **Login Screen** | **Camera Screen** | **User Profile Screen** |
|---|---|---|
| <img src="https://github.com/user-attachments/assets/56f7704c-636b-4fdd-b910-3d08543ad60f" width="250"/> | <img src="https://github.com/user-attachments/assets/720b4eb6-96b1-44a1-b3b5-33b99995d439" width="250"/> | <img src="https://github.com/user-attachments/assets/eb54305f-68ac-4a45-9ffb-c6f98ae240ff" width="250"/> |
| **Preferences Screen** | **Language Screen** | **Translated Menu Screen** |
| <img src="https://github.com/user-attachments/assets/55ef33b1-118e-4853-948d-8645a59fc5db" width="250"/> | <img src="https://github.com/user-attachments/assets/0eecd41e-6d6d-47b6-8d85-f771d6b29702" width="250"/> | <img src="https://github.com/user-attachments/assets/30719a67-8a36-44e1-8d0a-cdc1af003254" width="250"/> |
| **Menu Detail Screen** | **Cart Screen** | **Order Screen** |
| <img src="https://github.com/user-attachments/assets/f36f4777-d64d-482b-9582-737981f8903f" width="250"/> | <img src="https://github.com/user-attachments/assets/5d83d604-5529-4741-810a-522bfa1d2e87" width="250"/> | <video src="https://github.com/user-attachments/assets/a3360fd9-e634-485b-afea-b362eb100565" width="250" controls/> |



## 📂 Dircectory Structure (Clean Architecture)

```
📂 lib
├─ main.dart
└─ 📂 src
   ├─ 📂 config
   │  └─ 📂 theme
   ├─ 📂 core
   │  └─📂 router
   ├─ 📂 data
   │  ├─ 📂 local
   │  ├─ 📂 network
   │  └─ 📂 repositories
   ├─ 📂 domain
   │  ├─ 📂 dtos
   │  ├─ 📂 entities
   │  ├─ 📂 errors
   │  ├─ 📂 repositories
   │  └─ 📂 usecases
   └─ 📂 presentation
      ├─ 📂 model
      ├─ 📂 notifiers
      ├─ 📂 pages
      │  └─ 📂 widgets
      ├─ 📂 notifiers
      └─ 📂 states

```
## 🔎 Features
- State management with Riverpod
- Network: Dio
- Router: Go Router
- Google Login with Firebase Authentication
- Local Storage: SharedPreferences
- Gemini 

## 🚀 Getting Started
 [Click to download a releaed apk](https://github.com/yonsei-autopilot/smart-menu-flutter/tree/main/release). To install this, you need to able downloading an app from unknown sources.
