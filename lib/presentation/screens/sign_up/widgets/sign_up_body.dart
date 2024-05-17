import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';

class SignUpBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextInputController;
  final TextEditingController passwordTextInputController;
  final TextEditingController passwordRepeatTextInputController;
  final Function() onTap;  

  const SignUpBody({
    super.key,
    required this.formKey,
    required this.emailTextInputController,
    required this.passwordTextInputController,
    required this.passwordRepeatTextInputController,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [      
            EmailField(
              controller: emailTextInputController,
              validator: (email) => !EmailValidator.validate(email)
              ? 'Введите правильный Email': null,
              onFieldSubmitted: (email) {
                formKey.currentState!.validate();
              },
            ),
            const SizedBox(height: 12),          
            PasswordTextField(
              controller: passwordTextInputController,
              validator: (password) {
                if(password == null && (password ?? '').length <6) {
                  return 'Минимум 6 символов';
                } else if(passwordTextInputController.text != passwordRepeatTextInputController.text) {
                  return 'Пароли не совпадают';
                }
                return null;  
              },
              onFieldSubmitted: (email) {
                formKey.currentState!.validate();
              },              
            ),
            const SizedBox(height: 12),    
            PasswordTextField(
              controller: passwordRepeatTextInputController,
              repeatPassword: true,
              validator: (password) {
                if(password == null && (password ?? '').length <6) {
                  return 'Минимум 6 символов';
                } else if(passwordTextInputController.text != passwordRepeatTextInputController.text) {
                  return 'Пароли не совпадают';
                }
                return null;  
              },
              onFieldSubmitted: (email) {
                formKey.currentState!.validate();
              },                            
            ),                  
            const SizedBox(height: 12),
            ActionMaterialButton(
              name: 'Регистрация',
              onTap: onTap,
            ),                                  
            TextButton(
              onPressed: () => context.pop(), 
              child: Text(
                'Назад', 
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Pacifico',     
                  color: Theme.of(context).colorScheme.primary,
                )
              )
            )                                   
          ],
        ))
    );
  }
}