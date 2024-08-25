import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreateBorrwableController extends BuilderPublisher<Borrowable> {
  final CreateBorrowableDescriptionController descriptionController;
  final BuilderMediaController<ImageData> mediaController;
  final BuilderDateController dateController;
  @override
  final BuilderWarningsController warningsController;
  @override
  final ModelService<Borrowable> modelService;
  @override
  final ItemParameters? itemParameters;
  @override
  final bool isUpdating;

  factory CreateBorrwableController.create() {
    final warningsController = BuilderWarningsController();
    return CreateBorrwableController(
        descriptionController: CreateBorrowableDescriptionController(
            warningsController: warningsController),
        mediaController: BuilderMediaController(),
        warningsController: warningsController,
        dateController: BuilderDateController(),
        modelService: ServiceFactory.borrowableService,
        itemParameters: null,
        isUpdating: false);
  }

  factory CreateBorrwableController.update({required Borrowable borrowable}) {
    final warningsController = BuilderWarningsController();
    return CreateBorrwableController(
        descriptionController: CreateBorrowableDescriptionController(
            initialCourse: borrowable.course,
            initialDescription: borrowable.description,
            initialItem: borrowable.item,
            initialPrice: borrowable.price,
            intialEndDate: borrowable.borrowEndTime,
            intialStartDate: borrowable.borrowStartTime,
            initialTitle: borrowable.title,
            warningsController: warningsController),
        mediaController: BuilderMediaController(intialMedia: borrowable.media),
        warningsController: warningsController,
        dateController: BuilderDateController(
            initialEndDate: borrowable.borrowEndTime,
            initialStartDate: borrowable.borrowStartTime),
        modelService: ServiceFactory.borrowableService,
        itemParameters: ItemParameters(id: borrowable.id),
        isUpdating: true);
  }

  CreateBorrwableController(
      {required this.descriptionController,
      required this.mediaController,
      required this.dateController,
      required this.warningsController,
      required this.modelService,
      required this.itemParameters,
      required this.isUpdating});

  Borrowable get secondHand => Borrowable(
      id: -1,
      allowedActions: null,
      author: const User(id: -1, email: "null"),
      description: descriptionController.data!.description,
      course: descriptionController.data!.course,
      price: descriptionController.data!.price,
      item: descriptionController.data!.item,
      isFavorited: false,
          favoriteCount: 5,
      borrowStartTime: dateController.startDateController.date,
      borrowEndTime: dateController.endDateController.date,
      title: descriptionController.data!.title,
      media: mediaController.data ?? []);

  @override
  Borrowable? get data => isValid ? secondHand : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...mediaController.errorMesseges,
        ...dateController.errorMesseges,
      ];

  @override
  List<MediaData?> get media => mediaController.selectedMedia;
}
