

# Bible App - Flutter

A modern, feature-rich Bible reading application built with Flutter, designed to provide an intuitive and customizable scripture reading experience.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Flutter Version](https://img.shields.io/badge/Flutter-3.16-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)

## Features

- **Theme Customization**: Toggle between light and dark themes with a single tap
- **Book Navigation**: Browse all books of the Bible with an intuitive interface
- **Chapter Selection**: View all chapters for each book with dynamic loading
- **Verse Reading**: Read individual verses with adjustable font size
- **Search Functionality**: Quickly find books and chapters
- **Responsive Design**: Optimized for both phones and tablets

## Screenshots

### Theme Settings

The theme customization interface allows users to switch between light and dark modes. The toggle switch provides visual feedback when changing themes, and the interface maintains consistency across both modes.

### Book Selection
![Book Selection](Screenshot_2025-08-19-18-43-28-591_com.example.bible.jpg)
The main book selection screen displays all books of the Bible in an organized list. Each book is represented by a tile with a navigation arrow, allowing users to access chapters. The green color scheme provides a calming, spiritual aesthetic.

### Chapter Selection
![Chapter Selection](Screenshot_2025-08-19-18-43-34-687_com.example.bible.jpg)
When a book is selected, the chapter selection interface appears. Chapters are presented in a grid layout with numbered buttons for easy navigation. The modal design ensures focus remains on chapter selection while maintaining context of the previous screen.

### Verse Reading
![Verse Reading](Screenshot_2025-08-19-18-43-39-204_com.example.bible.jpg)
The verse reading interface displays scripture content in a clean, readable format. Users can adjust font size for optimal readability, and navigation controls allow easy movement between verses. The green text container enhances readability while maintaining the app's visual identity.

## Technical Implementation

### Architecture
The app follows a clean architecture pattern with separation of concerns:
- **Presentation Layer**: Flutter widgets and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: API integration and data models

### Key Components
1. **Theme Management**: Implements `ThemeData` with a provider for state management
2. **API Integration**: Fetches Bible data from a REST API without local caching
3. **Navigation**: Uses named routes for screen transitions
4. **Responsive UI**: Adapts to different screen sizes using `MediaQuery`

### Data Flow
1. User selects a book → App fetches chapters from API
2. User selects a chapter → App fetches verses from API
3. All data is loaded on-demand without persistence

## Getting Started

### Prerequisites
- Flutter SDK 3.16 or higher
- Dart 3.2 or higher
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/bible-app-flutter.git
```

2. Navigate to the project directory:
```bash
cd bible-app-flutter
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Usage
1. **Choose a Chapter**: After the book loads (20-30 seconds), select a chapter number
2. **Read Verses**: View all verses in the selected chapter with adjustable font size
3. **Customize Appearance**: Toggle between light and dark themes using the menu
4. **Search Content**: Use the search bar to quickly find books

## Known Limitations
- Data loading times may vary based on network conditions (20-30 seconds expected)
- No offline storage - internet connection required
- Currently supports only English translation

## Future Enhancements
- Implement local caching for faster access
- Add multiple Bible translations
- Include bookmark and note-taking features
- Add daily reading plans
- Implement audio Bible functionality



---

Made with ❤️ by [Faizan Ali](https://github.com/faizanali49)