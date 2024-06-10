import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';
import 'package:nevesomiy/utils/snack_bar_dialogs.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late GlobalKey<FormState> _formKey;
  
  late TextEditingController _emailTextInputController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTextInputController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const SimpleAppBar(title: 'Сброс пароля'),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordReseted) {
            _passwordReseted('Пароль успешно сброшен');
          } else if(state is AuthError) {
            _showError(state.error.toString());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: SvgPicture.asset(
                        SvgRepo.key.location,
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 60),                      
                    EmailField(
                      controller: _emailTextInputController,
                      validator: (email) => !EmailValidator.validate(email) ? 'Введите правильный Email' : null,
                      onFieldSubmitted: (email) {
                        _formKey.currentState!.validate();
                      },
                    ),
                    const SizedBox(height: 12),
                    ActionMaterialButton(
                      name: 'Сбросить пароль',
                      onTap: _resetPassword,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );

  void _showError(String title) {
    SnackBarDialog.showSnackBar(
      context, 
      title, 
      isError: true
    );             
  }

  void _resetPassword() {
    context.read<AuthBloc>().add(ResetPassword(email: _emailTextInputController.text.trim()));
  }

  void _passwordReseted(
    String title,
  ) {
    SnackBarDialog.showSnackBar(context, title, isError: false);
    Future.delayed(const Duration(seconds: 2), () => context.pop());
  }
}
