import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:auto_care/view/widgets/secondary_button.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userInfo = Get.arguments;
    TextEditingController fullNameController =
        TextEditingController(text: userInfo['fullName']);
    TextEditingController emailController =
        TextEditingController(text: 'ehsannabulsi5@gmail.com');
    TextEditingController phoneNumberController =
        TextEditingController(text: userInfo['phoneNumber']);
    TextEditingController addressController =
        TextEditingController(text: 'Al-Haifa,Damascus,Syria');

    // String selectedCity = cities[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.maxFinite,
          //   height: 80,
          //   decoration: const BoxDecoration(color: AppColors.whiteColor),
          //   child: Center(
          //     child: Text(
          //       'Welcome, ${dummyCarOwner.fullName}',
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //   ),
          // ),
          CustomTextFormField(
              labelText: 'Full Name',
              textInputType: TextInputType.name,
              controller: fullNameController),
          CustomTextFormField(
              labelText: 'E-mail',
              textInputType: TextInputType.name,
              controller: emailController),
          CustomTextFormField(
              labelText: 'Phone Number',
              textInputType: TextInputType.name,
              controller: phoneNumberController),
          CustomTextFormField(
              labelText: 'Address',
              textInputType: TextInputType.name,
              controller: addressController),
          // MyDropDownButton(
          //     value: selectedCity,
          //     hint: 'Damascus',
          //     onChanged: (value) {},
          //     items: cities),
          Row(
            children: [
              Expanded(
                  child: SecondaryButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              )),
              Expanded(
                  child:
                      PrimaryButton(onPressed: () {}, textButton: 'textButton'))
            ],
          )
        ],
      ),
    );
  }
}
