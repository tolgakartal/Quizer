# Quizer App

Quizer App is a quiz application built using Flutter and the BLoC pattern. This document provides an overview of the key components of the application.

## Components

### QuizCubit

`QuizCubit` is a BLoC component responsible for managing the quiz state. It interacts with `QuizRepository` to perform CRUD operations on quiz elements.

#### Methods
- `fetchQuizElements()`: Fetches all quiz elements from the repository.
- `addQuizElement()`: Adds a new quiz element to the repository.
- `deleteQuizElement()`: Deletes an existing quiz element from the repository.

### QuizState

`QuizState` represents the state of the quiz in the application. It extends `Equatable` for efficient state comparison.

#### States
- `loading`: Indicates the quiz elements are being loaded.
- `success`: Contains a list of quiz elements on successful loading.
- `failure`: Represents a failure state in loading quiz elements.

### QuizElement

`QuizElement` is a model class representing a single quiz element.

#### Properties
- `question`: The quiz question.
- `answer`: The answer to the quiz question.

### QuizRepository

`QuizRepository` is responsible for handling data operations related to quiz elements.

#### Methods
- `addQuizElement()`: Adds a new quiz element to the datastore.
- `deleteQuizElement()`: Deletes a quiz element from the datastore.
- `fetchQuizElements()`: Fetches all quiz elements from the datastore.

### Data Access Object (DAO)

- `QuizElementDao`: A Hive Object representing the quiz element for local storage.

#### Properties
- `question`: The quiz question stored in the local database.
- `answer`: The answer to the question stored in the local database.

## Datastore

The application uses Hive for local data storage. The `QuizRepository` interacts with Hive to perform data operations.

## Installation

1. Clone the repository.
2. Run `flutter pub get` to fetch the dependencies.
3. Build and run the application on your device or emulator.

## Contributing

Contributions to the Quizer App are welcome. Please read our contributing guidelines before submitting your pull request.

## License

This project is licensed under the [MIT License](LICENSE).

