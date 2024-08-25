import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

import '../../users/services/user_test_service.dart';

class DonationTestService extends ModelService<Donation>
    implements DonationService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<bool?> favorite({required ItemParameters post}) async {
    return true;
  }

  @override
  Future<Donation?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Donation>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      Donation(
          id: 1,
          allowedActions: null,
          targetValue: 100,
          currentValue: 35,
          isFavorited: false,
          favoriteCount: 5,
          subject: (await SubjectTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Donation Title 1",
          description: "Donation Description",
          media: []),
      Donation(
          id: 2,
          allowedActions: null,
          targetValue: 100,
          currentValue: 35,
          isFavorited: false,
          favoriteCount: 5,
          subject: (await SubjectTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Donation Title 2",
          description: "Donation Description",
          media: []),
      Donation(
          id: 3,
          allowedActions: null,
          targetValue: 100,
          currentValue: 35,
          isFavorited: false,
          favoriteCount: 5,
          subject: (await SubjectTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Donation Title 3",
          description: "Donation Description",
          media: []),
      Donation(
          id: 4,
          allowedActions: null,
          targetValue: 100,
          currentValue: 35,
          isFavorited: false,
          favoriteCount: 5,
          subject: (await SubjectTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Donation Title 4",
          description: "Donation Description",
          media: []),
      Donation(
          id: 5,
          allowedActions: null,
          targetValue: 100,
          currentValue: 35,
          isFavorited: false,
          favoriteCount: 5,
          subject: (await SubjectTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Donation Title 5",
          description: "Donation Description",
          media: []),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters<Model>? queryParameters}) async {
    return (await getList())?.length;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Donation?> postItem({required Donation item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Donation?> updateItem(
      {required Donation updatedItem, required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
