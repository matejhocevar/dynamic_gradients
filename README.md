
# 🌈 Dynamic Gradients in Flutter

Welcome to the **Dynamic Gradients** project! This Flutter project demonstrates how to create dynamic, visually stunning gradient backgrounds that can be applied to any Flutter widget. It also features **fragment shaders** to create more complex and fluid gradient effects.

<td align="center"><img src="/media/demo.gif" alt="Dynamic gradients" width="480"></td>

## 🚀 Features

- 🎨 Beautiful, dynamic gradients that adapt to widget sizes.
- 💻 **Fragment Shaders** for complex and fluid gradient effects.
- 🔄 Fully customizable with support for multiple colors.
- ⚡ High-performance rendering with optimized Flutter code.
- 🧩 Easy to integrate into existing Flutter projects.

## 📦 Getting Started

Follow these steps to get the project running on your local machine:

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/matejhocevar/dynamic_gradients.git
```

### 2. Navigate to the Project Directory

```bash
cd dynamic_gradients
```

### 3. Install Dependencies

Run the following command to install the necessary dependencies:

```bash
flutter pub get
```

### 4. Run the Project

Once the dependencies are installed, you can run the project using:

```bash
flutter run
```

## 📖 Usage

Once you have the project running, explore the `lib/` folder to understand how dynamic gradients and fragment shaders are implemented.

### Example: Simple Gradient Background

You can find an example of a dynamic gradient implementation in `lib/main.dart`. Here's a simplified version of how it's done:

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_gradients/dynamic_gradients.dart';

class GradientExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: DynamicGradients.rainbow(),
        ),
        child: Center(
          child: Text(
            'Hello, Dynamic Gradients!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
```

### Example: Custom Gradient

To customize the gradient colors, you can modify the `dynamic_gradients.dart` file or apply your own gradient like this:

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_gradients/dynamic_gradients.dart';

class CustomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: DynamicGradients.custom(
          colors: [Colors.purple, Colors.blue, Colors.cyan],
          stops: [0.1, 0.5, 0.9],
        ),
      ),
    );
  }
}
```

## 🧑‍💻 Contributing

We welcome contributions! Here's how you can help:

1. Fork this repository.
2. Create a new branch (`git checkout -b feature/my-feature`).
3. Make your changes.
4. Submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

💻 Made with ❤️ by [Matej Hočevar](https://matejhocevar.com)
