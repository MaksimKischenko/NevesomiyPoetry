import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/styles/color_styles.dart';


class EmailField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onSaved;
  final String? Function(String)? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;

  
  const EmailField({
    super.key, 
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,  
    keyboardType: TextInputType.emailAddress,
    minLines: 1, 
    cursorColor: ColorStyles.mainColor,
    cursorWidth: 1, 
    style: Theme.of(context).textTheme.bodySmall,
    controller: controller,
    focusNode: focusNode,
    initialValue: initialValue,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgPicture.asset(
          SvgRepo.email.location,
          width: 16,
          height: 16,
        ),   
      ),        
      suffixIconConstraints: const BoxConstraints(maxHeight: 16),     
      labelText: 'E-mail',
      hintText:  'E-mail', 
    ),
    validator: (value) => validator?.call(value!),
    onSaved: (value) => onSaved?.call(value!),
    onChanged: (value) => onChanged?.call(value),
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
  );
}
