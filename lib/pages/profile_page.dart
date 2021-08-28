import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedCardInfoIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                0,
                'Marked',
                12,
                _selectedCardInfoIndex == 0
                    ? Colors.purple.withOpacity(0.3)
                    : Colors.grey.shade300,
                _selectedCardInfoIndex == 0 ? Colors.black38 : Colors.black26,
                _selectedCardInfoIndex == 0 ? Colors.white : Colors.black,
                _selectedCardInfoIndex == 0
                    ? _buildSelectedShadow()
                    : _buildUnselectedShadow(),
              ),
              _buildCardInfoUI(
                context,
                1,
                'Recipes',
                6,
                _selectedCardInfoIndex == 1
                    ? Colors.purple.withOpacity(0.3)
                    : Colors.grey.shade300,
                _selectedCardInfoIndex == 1 ? Colors.black38 : Colors.black26,
                _selectedCardInfoIndex == 1 ? Colors.white : Colors.black,
                _selectedCardInfoIndex == 1
                    ? _buildSelectedShadow()
                    : _buildUnselectedShadow(),
              ),
              _buildCardInfoUI(
                context,
                2,
                'Orders',
                22,
                _selectedCardInfoIndex == 2
                    ? Colors.purple.withOpacity(0.3)
                    : Colors.grey.shade300,
                _selectedCardInfoIndex == 2 ? Colors.black38 : Colors.black26,
                _selectedCardInfoIndex == 2 ? Colors.white : Colors.black,
                _selectedCardInfoIndex == 2
                    ? _buildSelectedShadow()
                    : _buildUnselectedShadow(),
              ),
            ],
          ),
          SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 260.0,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                children: [
                  _buildProfileMenuItem(
                      context, 'Username', '@rllyhz', LineIcons.user),
                  _buildProfileMenuItem(context, 'Notifications',
                      'Mute, Push, Email', Icons.notifications_none_outlined),
                  _buildProfileMenuItem(context, 'Settings',
                      'Security, Privacy', LineIcons.gripLines),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem(BuildContext context, String title,
      String description, IconData iconData) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
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
      int index,
      String label,
      int total,
      Color backgroundColor,
      Color labelColor,
      Color totalColor,
      BoxShadow shadow) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCardInfoIndex = index;
        });
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
}
