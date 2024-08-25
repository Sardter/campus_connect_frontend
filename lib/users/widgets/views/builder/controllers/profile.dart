import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class EditProfileController extends BuilderPublisher<User> {
  final EditProfileDescriptionController descriptionController;
  @override
  final BuilderWarningsController warningsController;
  @override
  final ModelService<User> modelService;
  @override
  final ItemParameters? itemParameters;
  @override
  final bool isUpdating;

  factory EditProfileController.create() {
    final warningsController = BuilderWarningsController();
    return EditProfileController(
        descriptionController: EditProfileDescriptionController(
            warningsController: warningsController),
        warningsController: warningsController,
        modelService: ServiceFactory.userService,
        itemParameters: null,
        isUpdating: false);
  }

  factory EditProfileController.update({required User user}) {
    final warningsController = BuilderWarningsController();
    return EditProfileController(
        descriptionController: EditProfileDescriptionController(
            initialBio: user.bio,
            initialEmail: user.email,
            initialFirstName: user.firstName,
            initialLastName: user.lastName,
            initialProfilePhoto: user.profilePhoto,
            warningsController: warningsController),
        warningsController: warningsController,
        modelService: ServiceFactory.userService,
        itemParameters: ItemParameters(id: user.id),
        isUpdating: true);
  }

  EditProfileController(
      {required this.descriptionController,
      required this.warningsController,
      required this.modelService,
      required this.itemParameters,
      required this.isUpdating});

  User get user => User(
      id: -1,
      email: descriptionController.data!.email,
      firstName: descriptionController.data!.firstName,
      lastName: descriptionController.data!.lastName,
      profilePhoto: descriptionController.data!.profilePhoto,
      bio: descriptionController.data!.bio);

  @override
  User? get data => isValid ? user : null;

  @override
  List<String> get errorMesseges => descriptionController.errorMesseges;

  @override
  List<MediaData?> get media => [
    descriptionController.photoController.value
  ];
}
