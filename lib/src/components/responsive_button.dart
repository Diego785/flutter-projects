import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terminal_bimodal/src/screens/home/dashboard.dart';

import '../screens/auth/login2.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({Key? key, this.isResponsive = false, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
