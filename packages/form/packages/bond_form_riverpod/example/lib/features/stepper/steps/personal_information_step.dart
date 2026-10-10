import 'package:example/features/stepper/providers/user_information_form_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bond_form/bond_form.dart';

class PersonalInformationStep extends ConsumerWidget {
  const PersonalInformationStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formController = ref.watch(userInformationFormProvider.notifier);
    final formState = ref.watch(userInformationFormProvider);
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: formState.error('name'),
          ),
          onChanged: (value) => formController.updateText('name', value),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: formState.error('email'),
          ),
          onChanged: (value) => formController.updateText('email', value),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            errorText: formState.error('phone'),
          ),
          onChanged: (value) => formController.updateText('phone', value),
        ),
      ],
    );
  }
}
