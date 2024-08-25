import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/home/home.dart';
import 'package:campus_connect_frontend/home/widgets/components/appbar.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _filtersController = FiltersController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: ThemeService.clubColor,
        icon: Icons.add,
        children: [
          SpeedDialChild(
            label: "Second Hand",
            onTap: () {
              launchPage(
                  context,
                  CreateSecondHand(
                      controller: CreateSecondHandController.create()));
            },
          ),
          SpeedDialChild(
            label: "Donation",
            onTap: () {
              launchPage(
                  context,
                  CreateDonation(
                      controller: CreateDonationController.create()));
            },
          ),
          SpeedDialChild(
            label: "Borrowable",
            onTap: () {
              launchPage(
                  context,
                  CreateBorrowable(
                      controller: CreateBorrwableController.create()));
            },
          ),
          SpeedDialChild(
            label: "Lost and Found",
            onTap: () {
              launchPage(
                  context,
                  CreateLostAndFound(
                      controller: CreateLostAndFoundController.create()));
            },
          ),
        ],

      ),
      appBar: ConnectAppBar(context: context),
      body: FilteredPosts(filtersController: _filtersController),
    );
  }
}
