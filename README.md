# Game Discovery

Game Discovery is a Flutter mobile application that allows users to discover games, search and filter titles, view game details, and save favorite games.

The project was developed as a personal portfolio project to practice Flutter mobile development.

## Features

- User registration and login with Firebase Authentication
- Browse games from REST API
- Search games by title
- Filter games by genre
- View game details
- View game screenshots
- Save favorite games
- Persistent favorite storage
- Error and loading states
- Retry failed API requests

## Tech Stack

- Flutter
- Dart
- Provider
- REST API
- Firebase Authentication
- SharedPreferences
- HTTP
- Git & GitHub

## Architecture

The project follows a simple layered architecture:

UI
↓
Provider
↓
Service
↓
REST API / Firebase / Local Storage

## Project Structure

lib/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
├── firebase_options.dart
└── main.dart

## API

Game data is provided by the FreeToGame API.

## Screenshots

Add screenshots here.

## Getting Started

Clone the repository:

git clone <repository-url>

Install dependencies:

flutter pub get

Run the application:

flutter run

## Author

Your Name

GitHub: <github-link>