import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/posts/posts.dart';

abstract class DonationService<T extends Donation> extends PostService<T> {
}