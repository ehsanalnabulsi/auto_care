
String? validateInput(String? value, int min, int max, String type) {
  if (value == null || value.isEmpty) {
    return 'Must be not empty';
  }

  // if (type == 'phoneNumber') {
  //   if (!GetUtils.isPhoneNumber(value)) {
  //     return 'Phone Number is Not Valid';
  //   }
  // }

  // if (type == 'email') {
  //   if (!GetUtils.isEmail(value)) {
  //     return 'E-mail Address Is Wrong';
  //   }
  // }

  // if (value.length < min) {
  //   return 'Value can\'t be less than $min';
  // }

  // if (value.length > max) {
  //   return 'Value can\'t be larger than $max';
  // }

  return null;
}
