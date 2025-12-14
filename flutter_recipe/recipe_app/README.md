# recipe_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


* **SETUP OF The Flutter APP**



* **Flutter Flavors (.dev, .staging, .prod)**
  Used to run the same app in different environments. Each flavor can have different configurations like API URLs, app name, or behavior for development, testing, and production.

* **Screen Utils**
  Used to make the UI responsive so the app looks consistent on different screen sizes and resolutions.

* **injectable & injectable_generator**
  Used for automatic dependency injection. They generate the code needed to manage app dependencies, reducing manual work and keeping the code clean.

* **build_runner**
  A tool that runs code generation. It is required by packages like injectable to generate necessary files automatically.

* **go_router**
  Used for navigation and routing in the app. It simplifies route management and supports features like deep linking and conditional navigation.

* **Dio**
  Used to handle API requests. It provides advanced features like interceptors, better error handling, and request configuration.

* **Shimmer**
  Used to show a loading placeholder effect while data is being fetched, improving the user experience.

* **get_it**
  A service locator used to manage and access dependencies throughout the app.

* **dotenv**
  Used to load environment-specific variables (like API URLs or keys) from `.env` files, keeping sensitive data out of the source code.