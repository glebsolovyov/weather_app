  String? emailValidator(String? value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Введите корректный e-mail';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else if (value.length < 6) {
      return 'Пароль слишком короткий';
    } else {
      return null;
    }
  }