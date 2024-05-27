import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/icon_wrapper.dart';

class MessagesSwitcher extends StatefulWidget {
  final TextStyle? textStyle;
  final Color iconWrapperColor;
  final String text;
  final Function({required bool onChanged})? onChanged;

  const MessagesSwitcher({
    Key? key,
    required this.textStyle,
    required this.iconWrapperColor,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MessagesSwitcher> createState() => _MessagesSwitcherState();
}

class _MessagesSwitcherState extends State<MessagesSwitcher> {

  final ValueNotifier<bool> isEnabled = ValueNotifier(true);
  
  @override
  Widget build(BuildContext context) => BlocListener<CloudMessagingBloc, CloudMessagingState>(
        listener: (context, state) {
          if(state is CloudMessagingActivation) {
            isEnabled.value = state.isEnabled;
          } else if(state is CloudMessagingError) {
            
          }
        },
        child: Row(
          children: [
            IconWrapper(
              onTap: null,
              color: widget.iconWrapperColor,              
              child: SvgPicture.asset(
                SvgRepo.notification.location,
                colorFilter: ColorFilter.mode(ColorStyles.pallete3, BlendMode.srcIn),
                width: 24,
                height: 24
              ),
            ),  
            const SizedBox(width: 8),              
            Expanded(
              child: Text(
                widget.text,
                style: widget.textStyle
              ),
            ),       
            ValueListenableBuilder<bool>(
              valueListenable: isEnabled,
              builder: (context, value, child) => Switch(
                value: isEnabled.value,
                activeTrackColor: ColorStyles.pallete1,
                inactiveTrackColor: ColorStyles.pallete2.withOpacity(0.5),
                inactiveThumbColor: ColorStyles.pallete3,
                activeColor: ColorStyles.pallete3,
                onChanged: _onTap,
              ),
            ),
          ],
        ),
      );

  void _onTap(bool value) {
    isEnabled.value = value;
    widget.onChanged?.call(onChanged: value);
  }
}
