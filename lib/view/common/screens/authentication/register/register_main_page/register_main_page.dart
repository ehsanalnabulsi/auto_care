import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'list_tile_builder.dart';

class RegisterMainPage extends StatelessWidget {
  const RegisterMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              RegisterHeader(
                title: 'Please Select To Continue',
              ),
              SizedBox(height: 60),
              ListTileBuilder()
            ]),
      ),
    );
  }
}

