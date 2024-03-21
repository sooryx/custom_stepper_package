# custom_stepper 0.0.1

**custom_stepper** - Easy Step-by-Step Forms for Flutter

The `custom_stepper` package provides a user-friendly and easily customizable stepper widget for Flutter applications. This widget simplifies the creation of step-by-step forms, guiding users through a multi-stage process intuitively.

![custom_stepper.gif](custom_stepper.gif)

## Key Features:

- **Easy Integration:** Seamlessly integrate the stepper widget into your Flutter forms.
- **Customization:** Tailor the stepper's appearance and behavior to match your app's design and workflow.
- **User-Friendly:** Provide a clear and intuitive experience for users navigating multi-step forms.
- **Flexibility:** Create steppers with any number of steps to suit your specific needs.

## Benefits:

- **Enhanced User Experience:** Guide users through complex forms efficiently with a step-by-step approach.
- **Improved Form Completion Rates:** Reduce form abandonment by simplifying the process.
- **Increased Clarity:** Organize forms logically, making it easier for users to understand the flow.

## Ideal for:

- Onboarding workflows
- Registration processes
- Checkout procedures
- Wizard-like interactions
- Any scenario requiring users to complete a multi-step process

## Get Started:

1. Install the package: `flutter pub add custom_stepper`
2. Import the package in your Flutter code: `import 'package:custom_stepper/custom_stepper.dart';`
3. Refer to the package documentation for detailed usage instructions and customization options.
4. Content for each can be given in the content parameter

```dart
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStepper(
        connectorColor: AppTheme.getAppTheme().primaryColor,
        steps: [
          MyStep(
            content: Container(),
          ),
          MyStep(content: Container()),
        ],
        onSumbit: () {},
      ),
    );
  }
}
```

![custom_stepper1.gif](custom_stepper1.gif)


Make your forms effortless with the `custom_stepper` package!
