Flashcard Quiz App

A modern Flutter application that helps students study using interactive flashcards. The app allows users to create, manage, and review flashcards through a clean and intuitive interface.

## Features

* Display one flashcard at a time with a question on the front.
* Show or hide the answer using a dedicated button.
* Navigate between flashcards using Previous and Next buttons.
* Add new flashcards with form validation.
* Edit existing flashcards.
* Delete flashcards with a confirmation dialog.
* Display the current card position (e.g., Card 3 of 10).
* Responsive Material 3 user interface.
* Smooth animations for card transitions.
* Empty state screen when no flashcards are available.
* Preloaded with sample flashcards for quick testing.

## Technologies Used

* Flutter
* Dart
* Provider (State Management)
* Material 3 Design

## Project Structure

```text
lib/
├── constants/
├── models/
├── providers/
├── screens/
├── services/
├── utils/
├── widgets/
└── main.dart
```

## Getting Started

### Prerequisites

* Flutter SDK (latest stable version)
* Dart SDK
* Android Studio or Visual Studio Code
* Android Emulator or Physical Device

### Installation

1. Clone the repository.

```bash
git clone https://github.com/qazihasnat1122/flashcard-quiz-app.git
```

2. Navigate to the project folder.

```bash
cd flashcard-quiz-app
```

3. Install dependencies.

```bash
flutter pub get
```

4. Run the application.

```bash
flutter run
```

## Usage

* Browse flashcards using the **Previous** and **Next** buttons.
* Press **Show Answer** to reveal or hide the answer.
* Tap the **+** Floating Action Button to add a new flashcard.
* Use the **Edit** button to modify an existing flashcard.
* Use the **Delete** button to remove a flashcard after confirmation.

## Validation

* Question field cannot be empty.
* Answer field cannot be empty.
* Confirmation dialog prevents accidental deletion.

## Future Improvements

* Local database support using SQLite or Hive.
* Firebase synchronization.
* Flashcard categories and tags.
* Search and filter functionality.
* Quiz mode with scoring.
* Favorite flashcards.
* Dark mode.
* Import and export flashcards.
* Cloud backup and user authentication.

Author

Hasnat Javed

GitHub: https://github.com/qazihasnat1122

## License

This project is developed for educational purposes as part of a Flutter mobile application assignment.
