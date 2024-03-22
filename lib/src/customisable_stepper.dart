
import 'package:flutter/material.dart';

class MyStepper extends StatefulWidget {
  final List<MyStep> steps;
  final int initialStep;
  final Icon? nextIcon;
  final Icon? endIcon;
  final Icon? backIcon;
  final double? thickness;
  final Color? connectorColor;
  final Color? connectorBackGroundColor;
  final Color? buttonColor;
  final StepperType? type;
  final Function onSumbit;
  final bool? backdisabled;
  final Icon? inProgressIcon;
  final Icon? completedIcon;
  final ScrollController? stepController;

  MyStepper({
    required this.steps,
    this.initialStep = 0,
    this.nextIcon,
    this.endIcon,
    this.backdisabled,
    this.buttonColor,
    required this.onSumbit,
    this.connectorColor,
    this.connectorBackGroundColor,
    this.type,
    this.thickness,
    this.inProgressIcon,
    this.completedIcon,
    this.stepController,
    this.backIcon,
  });

  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int currentStep = 0;
  bool showSubmit = false;

  @override
  void initState() {
    super.initState();
    currentStep = widget.initialStep;
  }

  StepState _stepState(int step) {
    if (currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> getSteps = List<Step>.generate(
      widget.steps.length,
          (index) => Step(
        state: _stepState(index),
        subtitle: widget.steps[index].subtitle,
        title: widget.steps[index].title ?? const Text(''),
        isActive: currentStep <= index,
        label: Text(
          widget.steps[index].label ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        content: widget.steps[index].content,
      ),
    );

    return Stack(
      children: [
        Stepper(
          controller: widget.stepController,
          connectorColor: MaterialStatePropertyAll(
              widget.connectorColor ?? Theme.of(context).colorScheme.primary),
          type: widget.type ?? StepperType.horizontal,
          steps: getSteps,
          currentStep: currentStep,
          stepIconBuilder: (stepIndex, stepState) {
            if (stepState == StepState.complete) {
              return widget.completedIcon ?? const Icon(Icons.check);
            } else if (stepState == StepState.indexed) {
              return widget.inProgressIcon ?? Text("${stepIndex + 1}");
            }
            return null;
          },
          controlsBuilder: controlsBuilder,
          connectorThickness: widget.thickness ?? 1.5,
          onStepCancel: () {
            setState(() {
              currentStep = (currentStep - 1).clamp(0, widget.steps.length - 1);
              showSubmit = false;
            });
          },
          onStepContinue: () {
            final isLastStep = currentStep == widget.steps.length - 1;
            final secondLaststep = currentStep == widget.steps.length - 2;
            if (secondLaststep) {
              setState(() {
                showSubmit = true;
              });
            }
            if (!isLastStep) {
              setState(() {
                currentStep++;
              });
            }
            if (isLastStep) {
              widget.onSumbit();
            }
          },
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: widget.connectorBackGroundColor,
                ),
              ),
            ))
      ],
    );
  }

  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (currentStep != 0)
            InkWell(
                onTap: controlsDetails.onStepCancel,
                child:
                widget.backIcon ?? const Icon(Icons.arrow_back_ios_new_rounded)),
          InkWell(
            onTap: controlsDetails.onStepContinue,
            child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: widget.buttonColor ??
                      Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: showSubmit
                    ? widget.endIcon ?? const Icon(Icons.check)
                    : widget.nextIcon ?? const Icon(Icons.arrow_forward_ios_rounded)),
          ),
        ],
      ),
    );
  }
}

class MyStep {
  final String? label;
  final Text? title;
  final Text? subtitle;
  final Widget content;
  final Icon? stepIcon; // Add this line

  MyStep({
    this.subtitle,
    this.title,
    this.label,
    required this.content,
    this.stepIcon, // Add this line
  });
}
