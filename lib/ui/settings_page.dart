import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restail/provider/scheduling_provider.dart';
import 'package:restail/widgets/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFFFC107).withOpacity(0.7),
                    child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Material(
                  child: ListTile(
                    title: Text('Scheduling Notifications'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: scheduled.isScheduled,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.scheduledRestaurant(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
