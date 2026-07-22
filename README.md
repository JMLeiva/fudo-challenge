# fudo_challenge

This project is a hiring process challenge for FUDO.

## Requirements:
Specification was: "build a project in Flutter that shows a list, and some details of the item when clicked"

## Overview
A Flutter application that allows users to search for stocks and view detailed information including real-time quotes, company overview, and intraday price charts.

## Stack
- **Flutter**: UI Framework.
- **Dio**: HTTP client for API requests.
- **Injectable & Get_it**: For dependency injection.
- **Dart Either**: Functional error handling.
- **Memory Cache**: Simple in-memory caching for repository data.
- **Json Annotation & Serializable**: For automated JSON parsing.
- **Logger**: For debugging and logging purposes.

## Architecture
The project follows **Clean Architecture** principles, separating concerns into layers:
- **Domain**: Contains business logic, entities, and repository interfaces.
- **Data**: Implements repository interfaces, handling network requests and caching.
- **Presentation**: Uses **MVVM** (Model-View-ViewModel) pattern to manage UI state and interactions.
- **Repository Pattern**: Utilized with a **Decorator** to provide transparent memory caching for API responses.

## Stock APIs
The project includes two different implementations for stock data:
1. **Twelve Data** (Currently active)
2. **Alpha Vantage**

### How to change implementation
To switch between implementations, modify `lib/di/main_module.dart`:
```dart
@Named(InjectionKeys.remoteRepository)
StockRepository remoteRepository(StockRepositoryTwelveDataApi impl) => impl; // Change implementation here
```

### API Limitations
- **Twelve Data**: Approximately 800 API credits per day (costs vary by endpoint).
- **Alpha Vantage**: Limited to 25 API calls per day in the free tier.

**Note**: Since Twelve Data's free tier does not include full company overview details (like Market Cap, PE Ratio, Sector, Industry, etc.), these fields are currently mocked.

## API Keys
The project requires API keys from the providers mentioned above. These keys should be stored in a `secrets.json` file in the root directory.

### secrets.json structure
```json
{
  "ALPHA_VANTAGE_API_KEY": "YOUR_ALPHA_VANTAGE_KEY",
  "TWELVE_DATA_API_KEY": "YOUR_TWELVE_DATA_KEY"
}
```

### Running the project
To include the API keys during the build process, run the application using the following flag:
```bash
flutter run --dart-define-from-file=secrets.json
```
