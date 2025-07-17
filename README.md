# Auto Car

<img src="https://github.com/user-attachments/assets/a4c2d937-886c-4ea0-a848-daddcfbb6371" alt="Auto Car App Cover" width="100%">

## Overview

Auto Car is a comprehensive mobile application designed for automotive enthusiasts and drivers. The app combines essential car-related services in one sleek, user-friendly interface.

## Features

- **Fuel Station Locator**: Find nearby fuel stations with real-time navigation
- **Car Components Marketplace**: Browse and purchase automotive parts and accessories
- **Interactive Map**: View automotive services in your area
- **Secure Checkout**: Multiple payment options including credit card and cash on delivery
- **Turn-by-Turn Navigation**: Get to your destination with clear directions

## Technical Specifications

- Built with Flutter for cross-platform compatibility
- Bloc/Cubit state management for efficient app architecture
- RESTful API integration for product and service data
- Responsive design that works across various device sizes
- Minimalist UI with intuitive navigation

## Design

- Fully customizable UI components
- Responsive layout for all screen sizes
- Organized layer structure
- Figma components and auto layout
- Minimalist design philosophy with yellow and black theme

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio or VS Code
- iOS simulator or physical device (for iOS testing)
- Android emulator or physical device (for Android testing)

### Installation

1. Clone the repository:
```
git clone https://github.com/yourusername/auto_car.git
```

2. Navigate to the project directory:
```
cd auto_car
```

3. Install dependencies:
```
flutter pub get
```

4. Run the app:
```
flutter run
```

## Project Structure

```
auto_car/
├── android/               # Android native code
├── ios/                   # iOS native code
├── assets/
│   ├── images/            # App images, icons, and logo
│   └── fonts/             # App fonts
├── lib/
│   ├── core/              # Core functionality used across the app
│   │   ├── api/           # API handling and network requests
│   │   ├── cache/         # Local data caching
│   │   ├── routes/        # App navigation and routing
│   │   ├── ui/            # Shared UI components and themes
│   │   ├── utils/         # Utility functions and helpers
│   │   └── widgets/       # Reusable widgets
│   ├── features/          # App features organized by domain
│   │   ├── auth/          # Authentication feature
│   │   │   ├── data/      # Data layer (models, repositories)
│   │   │   ├── domain/    # Domain layer (entities, use cases)
│   │   │   └── presentation/ # UI layer (screens, widgets, cubits)
│   │   ├── home/          # Home screen feature
│   │   ├── on_boarding/   # Onboarding screens feature
│   │   ├── profile/       # User profile feature
│   │   ├── splash/        # Splash screen feature
│   │   └── store/         # Store/marketplace feature
│   │       ├── data/      # Store data models and repositories
│   │       ├── domain/    # Store business logic
│   │       └── presentation/ # Store UI components and state management
│   └── main.dart          # App entry point
├── test/                  # Unit and widget tests
├── pubspec.yaml           # Dependencies and app metadata
└── README.md              # Project documentation
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

Designed by Karim Mohamed
