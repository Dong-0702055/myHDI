class AppValidators {
  static String?  validatorPhone(String? value){
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập số điện thoại";
    }
    return null;
  }

  static String? validatorPassword(String? value){
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập mật khẩu";
    }
    if (value.length < 8) {
      return "Mật khẩu phải có ít nhất 8 ký tự";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Mật khẩu phải chứa ít nhất 1 chữ in hoa";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Mật khẩu phải chứa ít nhất 1 chữ thường";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Mật khẩu phải chứa ít nhất 1 chữ số";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt";
    }
    return null;
  }
  static String? validatorConfirm(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return "Vui lòng xác nhận mật khẩu";
    }

    if (value != password) {
      return "Mật khẩu xác nhận không khớp";
    }

    return null;
  }
  static String? validatorFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập họ tên";
    }

    if (value.trim().length < 2) {
      return "Họ tên phải có ít nhất 2 ký tự";
    }

    if (!RegExp(r'^[a-zA-ZÀ-ỹ\s]+$').hasMatch(value.trim())) {
      return "Họ tên không được chứa số hoặc ký tự đặc biệt";
    }
    if (value.trim().split(RegExp(r'\s+')).length < 2) {
      return "Vui lòng nhập đầy đủ họ và tên";
    }
    return null;
  }

}