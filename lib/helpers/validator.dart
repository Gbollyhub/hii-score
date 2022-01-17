textFieldVal(String? value) {
  if (value!.isEmpty) {
    return 'This field is required';
  }
}

emailFieldVal(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'This field is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
}
