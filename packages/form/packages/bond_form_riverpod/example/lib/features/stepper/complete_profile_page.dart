import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/complete_profile_form_provider.dart';
import 'steps/personal_information_step.dart';
import 'steps/vehicle_information_step.dart';

class CompleteProfilePage extends ConsumerWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepper = ref.watch(completeProfileFormProvider);
    final controller = ref.read(completeProfileFormProvider.notifier);
    return Scaffold(
      body: Stepper(
        currentStep: stepper.currentStep,
        onStepContinue: controller.next,
        onStepCancel: controller.previous,

        steps: const [
          Step(
            title: Text('Personal Information'),
            content: PersonalInformationStep(),
          ),
          Step(
            title: Text('Vehicle Information'),
            content: VehicleInformationStep(),
          ),
        ],
      ),
    );
  }
}
