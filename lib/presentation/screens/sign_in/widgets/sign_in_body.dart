

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevesomiy/domain/entites/svg_repo.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';


class SignInBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextInputController;
  final TextEditingController passwordTextInputController;
  final Function() onSignInTap;
  final Function() onSignInGoogleTap;
  final Function() onSignOutTap;
  final Function() onForgetPasswordTap;        

  const SignInBody({
    super.key,
    required this.formKey,
    required this.emailTextInputController,
    required this.passwordTextInputController,
    required this.onSignInTap,
    required this.onSignInGoogleTap,
    required this.onSignOutTap,
    required this.onForgetPasswordTap,
  });


  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
        key: formKey,
        child: Column(
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
                } 
                return null;  
              },
              onFieldSubmitted: (email) {
                formKey.currentState!.validate();
              },              
            ),                  
            const SizedBox(height: 12),
            ActionMaterialButton(
              name: 'Вход',
              onTap: onSignInTap,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onSignInGoogleTap,   //Theme.of(context).textButtonTheme.style,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Вход по Google аккаунту', 
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Pacifico',     
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    SvgRepo.google.location,
                    width: 24,
                    height: 24,
                  )
                ],
              )
            ),                                      
            TextButton(
              onPressed: onSignOutTap,   //Theme.of(context).textButtonTheme.style,
              child: Text(
                'Регистрация', 
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Pacifico',     
                  color: Theme.of(context).colorScheme.primary,
                )
              )
            ),    
            TextButton(
              onPressed: onForgetPasswordTap, 
              child: Text(
                'Забыли пароль?', 
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Pacifico',     
                  color: Theme.of(context).colorScheme.primary,
                )
              )
            )                                             
          ],
        )
      )
    );
}