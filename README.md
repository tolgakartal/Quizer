# Quizer App

Quizer App is a quiz application built using Flutter and the BLoC pattern. This document provides an overview of the key components of the application and includes a coding challenge that encourages the application of SOLID principles.

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

Your task is to enhance the Quizer App by introducing a new feature or refactoring an existing one. The key requirement is to apply at least one of the SOLID principles in your solution. The SOLID principles are crucial for creating scalable, maintainable, and robust software designs.

### Challenge Description

- **Feature Enhancement**: Introduce a feature that allows users to categorize quiz questions (e.g., by difficulty, topic, etc.). This feature should be implemented in a way that adheres to the SOLID principles. Think about how you can design your classes and interfaces to be single-responsible, open for extension but closed for modification, and so on.

- **Refactoring Existing Code**: Identify an area in the existing codebase where a SOLID principle can be better applied. Refactor the code to enhance its design. This could involve separating concerns, reducing dependencies, or making the code more extendable without modifying existing functionality.

### Expectations

- **Code Quality**: Your code should be clean, well-organized, and properly documented.
- **SOLID Application**: Clearly demonstrate the use of SOLID principles in your solution. Provide comments or documentation explaining how your design adheres to these principles.
- **Testing**: Include unit tests for your new feature or refactored code to ensure functionality and robustness.

### Submission

Submit your code as a pull request to the project repository. Include a brief description of your changes and how they adhere to SOLID principles.

## Contributing

Contributions to the Quizer App are welcome. Please read our contributing guidelines before submitting your pull request.

## License

This project is licensed under the [MIT License](LICENSE).
