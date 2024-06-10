import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

class SearchField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onSaved;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;

  
  const SearchField({
    super.key, 
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,  
    keyboardType: TextInputType.name,
    minLines: 1, 
    cursorColor: ColorStyles.pallete1,
    cursorWidth: 1, 
    style: Theme.of(context).textTheme.bodySmall,
    controller: controller,
    focusNode: focusNode,
    initialValue: initialValue,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(    
      fillColor: ColorStyles.pallete3,  
      suffixIconConstraints: const BoxConstraints(maxHeight: 16),     
      labelText: 'Поиск по названию',
      hintText:  'Название', 
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
      ),       
      enabledBorder: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
      ),
    ),
    onSaved: (value) => onSaved?.call(value!),
    onChanged: (value) => onChanged?.call(value),
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
  );
}


