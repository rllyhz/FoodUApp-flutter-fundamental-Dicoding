import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/notification_settings.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (ctx, provider, _) {
        return Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(height: 32.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5.0),
                        spreadRadius: 0,
                        blurRadius: 42.0,
                        color: Colors.black12),
                  ]),
                  child: CircleAvatar(
                    backgroundColor: lightGreen,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 42.0),
              Text(
                'Rully Ihza Mahendra',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                'rullyihza00@gmail.com',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCardInfoUI(
                    context,
                    provider,
                    0,
                    'Marked',
                    12,
                    provider.seletedCardInfoIndex == 0
                        ? Colors.purple.withOpacity(0.3)
                        : Colors.grey.shade300,
                    provider.seletedCardInfoIndex == 0
                        ? Colors.black38
                        : Colors.black26,
                    provider.seletedCardInfoIndex == 0
                        ? Colors.white
                        : Colors.black,
                    provider.seletedCardInfoIndex == 0
                        ? _buildSelectedShadow()
                        : _buildUnselectedShadow(),
                  ),
                  _buildCardInfoUI(
                    context,
                    provider,
                    1,
                    'Recipes',
                    6,
                    provider.seletedCardInfoIndex == 1
                        ? Colors.purple.withOpacity(0.3)
                        : Colors.grey.shade300,
                    provider.seletedCardInfoIndex == 1
                        ? Colors.black38
                        : Colors.black26,
                    provider.seletedCardInfoIndex == 1
                        ? Colors.white
                        : Colors.black,
                    provider.seletedCardInfoIndex == 1
                        ? _buildSelectedShadow()
                        : _buildUnselectedShadow(),
                  ),
                  _buildCardInfoUI(
                    context,
                    provider,
                    2,
                    'Orders',
                    22,
                    provider.seletedCardInfoIndex == 2
                        ? Colors.purple.withOpacity(0.3)
                        : Colors.grey.shade300,
                    provider.seletedCardInfoIndex == 2
                        ? Colors.black38
                        : Colors.black26,
                    provider.seletedCardInfoIndex == 2
                        ? Colors.white
                        : Colors.black,
                    provider.seletedCardInfoIndex == 2
                        ? _buildSelectedShadow()
                        : _buildUnselectedShadow(),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 12.0),
                        blurRadius: 16.0,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      _buildProfileMenuItem(
                        context,
                        'Username',
                        '@' + provider.username,
                        LineIcons.user,
                        () {
                          // show dialog
                          _showInteractiveDialog(
                            ctx,
                            'Set username',
                            'Save',
                            () async {
                              if (provider.inputController.text.isNotEmpty) {
                                provider.saveUsername();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'The field should not be empty!',
                                );
                              }
                            },
                            TextField(
                              controller: provider.inputController,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                            ),
                          );
                        },
                      ),
                      _buildProfileMenuItem(
                        ctx,
                        'Notifications',
                        'Daily Notifications',
                        Icons.notifications_none_outlined,
                        () {
                          Navigator.of(context)
                              .pushNamed(NotificationSettings.route);
                        },
                      ),
                      _buildProfileMenuItem(
                        ctx,
                        'Settings',
                        'Security, Privacy',
                        LineIcons.gripLines,
                        () {
                          Fluttertoast.showToast(msg: "Not implemented yet!");
                        },
                        isLastIndex: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileMenuItem(BuildContext context, String title,
      String description, IconData iconData, Function() onTap,
      {bool isLastIndex = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        margin: !isLastIndex ? EdgeInsets.only(bottom: 12.0) : null,
        decoration: BoxDecoration(
          border: !isLastIndex
              ? Border(bottom: BorderSide(width: 1.0, color: Colors.black12))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(width: 1.0, color: Colors.black12),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4.0),
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.05),
                        )
                      ]),
                  child: Icon(iconData),
                )),
            SizedBox(width: 16.0),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.0),
                    Text(description,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black38)),
                  ],
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(LineIcons.arrowRight),
            ),
          ],
        ),
      ),
    );
  }

  BoxShadow _buildSelectedShadow() => BoxShadow(
        offset: Offset(0, 12.0),
        blurRadius: 12.0,
        color: Colors.black12,
      );

  BoxShadow _buildUnselectedShadow() => BoxShadow(
        offset: Offset(0, 12.0),
        blurRadius: 12.0,
        color: Colors.transparent,
      );

  Widget _buildCardInfoUI(
      BuildContext context,
      PreferencesProvider provider,
      int index,
      String label,
      int total,
      Color backgroundColor,
      Color labelColor,
      Color totalColor,
      BoxShadow shadow) {
    return GestureDetector(
      onTap: () {
        provider.setSelectedCardInfoIndex(index);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 4) - 8.0,
        height: 120.0,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(32.0),
          ),
          boxShadow: [shadow],
          border: Border.all(color: Colors.transparent, width: 0),
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Text(total.toString(),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: totalColor)),
            SizedBox(height: 12.0),
            Text(label, style: TextStyle(color: labelColor)),
          ],
        ),
      ),
    );
  }

  void _showInteractiveDialog(
    BuildContext context,
    String title,
    String actionButtonPositiveText,
    void Function()? onButtonPositiveClick,
    Widget inputWidget,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            height: 194.0,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 18.0),
                inputWidget,
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade400,
                        onPrimary: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: onButtonPositiveClick,
                      child: Text(actionButtonPositiveText),
                      style: ElevatedButton.styleFrom(
                        primary: darkGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
