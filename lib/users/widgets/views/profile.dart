// ignore_for_file: use_build_context_synchronously

import 'package:campus_connect_frontend/auth/auth.dart';
import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/home/home.dart';
import 'package:campus_connect_frontend/home/widgets/components/appbar.dart';
import 'package:campus_connect_frontend/users/models/models.dart';
import 'package:campus_connect_frontend/users/widgets/views/views.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.id, this.myProfile = false});
  final dynamic id;
  final bool myProfile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _refreshKey = GlobalKey<RefreshablePageState>();
  final _userService = ServiceFactory.userService;
  final _courseService = ServiceFactory.courseService;

  String? _title;

  Widget _wrapper(Widget child) {
    return widget.myProfile
        ? Scaffold(
            appBar: ConnectAppBar(context: context, selectedIndex: 3),
            body: child)
        : AppPage(title: _title ?? "", body: child);
  }

  Widget _allowedActions(User user) => user.allowedActions == null
      ? const SizedBox()
      : AllowedActionsWidget<AllowedActions, User>(
          actions: user.allowedActions!,
          modelService: ServiceFactory.userService,
          model: user,
          actionMapper: (actions, context) => [
                if (actions.canDelete)
                  ActionData(
                      icon: Icons.delete,
                      title: "Delete",
                      onTap: () async {
                        if ((await launchConfirmationDialog(context,
                                    "Do you really want to delete your profile?") ??
                                false) &&
                            (await ServiceFactory.userService.deleteProfile() ??
                                false)) {
                          showSocialUtilSnackbar(
                              context: context,
                              message: "Profile deleted",
                              type: DisplayMessageType.success);
                        }
                      }),
                if (user.allowedActions!.canBlock)
                  ActionData(
                      icon: Icons.block,
                      title: "Block",
                      onTap: () async {
                        if ((await launchConfirmationDialog(context,
                                    "Do you really want to block this user?") ??
                                false) &&
                            (await ServiceFactory.userService.blockUser(
                                    itemParameters:
                                        ItemParameters(id: user.id)) ??
                                false)) {
                          showSocialUtilSnackbar(
                              context: context,
                              message: "User blocked",
                              type: DisplayMessageType.success);
                        }
                      }),
                if (actions.canReport)
                  ActionData(
                      icon: Icons.report,
                      title: "Report",
                      onTap: () async {
                        final reportController = TextEditingController();
                        if ((await launchTextConfirmationDialog(
                                    context,
                                    "What is wrong with this user?",
                                    reportController,
                                    "Write here") ??
                                false) &&
                            (await ServiceFactory.commentService.reportItem(
                                    itemParameters: ItemParameters(id: user.id),
                                    reason: reportController.text) ??
                                false)) {
                          showSocialUtilSnackbar(
                              context: context,
                              message: "User reported",
                              type: DisplayMessageType.success);
                        }
                      }),
              ]);

  @override
  Widget build(BuildContext context) {
    return _wrapper(RefreshablePage(
      key: _refreshKey,
      onRefresh: () async {
        final user = widget.myProfile
            ? await _userService.getProfile()
            : await _userService.getItem(
                itemParameters: ItemParameters(id: widget.id));

        if (user == null) {
          closePage(context);
          if (widget.myProfile) {
            launchPage(context, const RegisterPage());
          } else {
            launchPage(context, const HomeView());
          }
          return null;
        }

        _title = user.displayName;
        final courses = await _courseService.getList(
            queryParameters:
                CourseQueryParameters(searchQuery: null, user: user));

        return [
          const SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(
                  horizontal: getResponsiveMarginWidth(context)),
            child: SocialUtilImageProvider(
            image: user.profilePhoto,
            defaultImage: null,
            radius: 70,
          ),
          ),
          const SizedBox(height: 10),
          ...[
            Text(
              user.displayName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
           
          ].map((e) => Align(alignment: Alignment.center, child: e)),
          if (user.allowedActions != null)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: getResponsiveMarginWidth(context)),
              child: _allowedActions(user),
            ),
          const SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(

                  horizontal: getResponsiveMarginWidth(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: SocialUtilIconButton(
                        icon: null, title: "Courses", onTap: null),
                  ),
                  Wrap(
                      children: courses
                              ?.map((e) => CourseWidget(course: e))
                              .toList() ??
                          []),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        if (user.allowedActions?.canUpdate ?? false)
                          SocialUtilButton(
                              onTap: () async {
                                launchPage(
                                    context,
                                    EditProfilePage(
                                        controller:
                                            EditProfileController.update(
                                                user: user)));
                                return false;
                              },
                              children: const [
                                Text(
                                  "Edit Profile",
                                  style:
                                      TextStyle(color: ThemeService.clubColor),
                                )
                              ]),
                        const Spacer(),
                        SocialUtilButton(
                            onTap: () async {
                              launchPage(
                                  context,
                                  AppPage(
                                      title: "${user.displayName}'s Posts",
                                      body: FilteredPosts(
                                          author: user,
                                          filtersController:
                                              FiltersController())));
                              return false;
                            },
                            children: const [
                              Text(
                                "Posts",
                                style: TextStyle(color: ThemeService.clubColor),
                              )
                            ]),
                      ],
                    ),
                  )
                ],
              ))
        ];
      },
    ));
  }
}
