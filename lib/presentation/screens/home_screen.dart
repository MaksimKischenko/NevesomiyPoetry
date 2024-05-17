import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/screens/screens.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isVisible = true; 
  int selectedBottomNavigationIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;  
  static const Map<MenuTab, Widget> screensTabs = {
    MenuTab.poems:  PoemsScreen(),    
    MenuTab.settings:  SettingsScreen(),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        _isVisible = state.isVisible;
        if (_isVisible) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },      
      builder: (context, state) => Scaffold(
        body: IndexedStack(
          index: screensTabs.keys.toList().indexWhere((e) => e == state.tab),
          children: screensTabs.values.toList(),
        ),    //screensTabs[state.tab],
        bottomNavigationBar: SlideTransition(
          position: _offsetAnimation,
            child: BottomNavigationBar(
            enableFeedback: true,
            items:  [          
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgRepo.bookClosed.location,
                  width: 24,
                  height: 24,
                ),  
                activeIcon: SvgPicture.asset(
                  SvgRepo.bookOpen.location,
                  width: 24,
                  height: 24,
                ),    
                label: 'Стихи',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgRepo.settings.location,
                  width: 24,
                  height: 24,
                ),  
                activeIcon: SvgPicture.asset(
                  SvgRepo.wrench.location,
                  width: 24,
                  height: 24,
                ),    
                label: 'Настройки',
              ),
            ],
            currentIndex: screensTabs.keys.toList().indexOf(state.tab),
            selectedItemColor: ColorStyles.mainColor,
            onTap: _onItemTapped,
          ),         
        ),        
      )
    );
  }
   void _onItemTapped(int index) {
    selectedBottomNavigationIndex = index;
    context.read<MenuBloc>().add(MenuTabUpdate(tab: screensTabs.keys.toList()[index]));
  } 
}
