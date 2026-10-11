// ignore_for_file: non_abstract_class_inherits_abstract_member
import 'package:bond_form_riverpod/bond_form_riverpod.dart';

class LoginForm extends AutoDisposeFormStateNotifier<String, Error> {}

class StepForm extends AutoDisposeStepFormStateNotifier<String, Error> {}

class SignUpStepper extends AutoDisposeStepperFormStateNotifier<String, Error> {}

class EditProfileForm extends AutoDisposeFamilyFormStateNotifier<String, Error, int> {}

class EditProfileStep extends AutoDisposeFamilyStepFormStateNotifier<String, Error, int> {}

class EditProfileStepper extends AutoDisposeFamilyStepperFormStateNotifier<String, Error, int> {}
