
enum FireBaseAuthErroCode {
  userNotFound('user-not-found', 'Пользователь не найден'),
  userNotExists('INVALID_LOGIN_CREDENTIALS', 'Вы ввели неверные данные'),  
  wrongPassword('wrong-password', 'Неверный пароль'),
  existsEmail('email-already-in-use', 'Данный E-mail уже зарегистрирован в системе'),
  unknown('unknown', 'Ошибка авторизации');



  const FireBaseAuthErroCode(this.fireBasemessage, this.uiMessage);
  final String fireBasemessage;
  final String uiMessage;
}

