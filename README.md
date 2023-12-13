# Quizer App

Quizer App is a quiz application built using Flutter and the BLoC pattern. This document provides an overview of the key components of the application and includes a coding challenge to enhance its functionality and design.

## Components

### QuizCubit

`QuizCubit` is a BLoC component responsible for managing the quiz state. It interacts with `QuizRepository` to perform CRUD operations on quiz elements.

...

### Datastore

The application uses Hive for local data storage. The `QuizRepository` interacts with Hive to perform data operations.

## Installation

1. Clone the repository.
2. Run `flutter pub get` to fetch the dependencies.
3. Build and run the application on your device or emulator.

## Coding Challenge: Enhancing the Quizer App

### Objective

Your task is to enhance the Quizer App by introducing a new feature or refactoring an existing one. The goal is to improve the application's architecture and maintainability.

### Challenge Description

- **Feature Enhancement**: Add a feature that allows users to categorize quiz questions (e.g., by difficulty, topic, etc.). Your implementation should consider how to integrate this seamlessly with the existing structure, focusing on maintainability and scalability.

- **Refactoring Existing Code**: Examine the current codebase and identify potential areas for improvement in terms of design and structure. Refactor the code to enhance its maintainability, scalability, and overall quality.

### Expectations

- **Code Quality**: Write clean, well-organized, and properly documented code.
- **Design Consideration**: Your design should clearly demonstrate thoughtful architectural decisions. Pay attention to how your code fits into the existing codebase and how it can evolve in the future.
- **Testing**: Include unit tests for your new feature or refactored code to ensure functionality and robustness.

### Submission

Submit your code as a pull request to the project repository. Include a brief description of your changes and the reasons behind your architectural choices.

## Contributing

Contributions to the Quizer App are welcome. Please read our contributing guidelines before submitting your pull request.

## License

This project is licensed under the [MIT License](LICENSE).
