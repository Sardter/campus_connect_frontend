import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/users/users.dart';

enum ServiceFactoryMode { test, api }

class ServiceFactory {
  static ServiceFactoryMode get mode => ServiceFactoryMode.api;

  static BorrowableService get borrowableService =>
      mode == ServiceFactoryMode.test
          ? BorrowableTestService()
          : BorrowableAPIService();

  static CommentService get commentService => mode == ServiceFactoryMode.test
      ? CommentTestService()
      : CommentAPIService();

  static CourseService get courseService => mode == ServiceFactoryMode.test
      ? CourseTestService()
      : CourseAPIService();

  static DonationService get donationService => mode == ServiceFactoryMode.test
      ? DonationTestService()
      : DonationAPIService();

  static ItemService get itemService =>
      mode == ServiceFactoryMode.test ? ItemTestService() : ItemAPIService();

  static LostAndFoundService get lostAndFoundService =>
      mode == ServiceFactoryMode.test
          ? LostAndFoundTestService()
          : LostAndFoundAPIService();

  static SecondHandService get secondHandService =>
      mode == ServiceFactoryMode.test
          ? SecondHandTestService()
          : SecondHandAPIService();

  static SubjectService get subjectService => mode == ServiceFactoryMode.test
      ? SubjectTestService()
      : SubjectAPIService();

  static UserService get userService =>
      mode == ServiceFactoryMode.test ? UserTestService() : UserAPIService();


}
