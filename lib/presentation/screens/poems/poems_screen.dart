import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:nevesomiy/domain/entites/ettities.dart';
import 'package:nevesomiy/presentation/bloc/bloc.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';
import 'package:nevesomiy/presentation/widgets/widget.dart';
import 'package:nevesomiy/utils/utils.dart';
import 'widgets/widgets.dart';

class PoemsScreen extends StatefulWidget {
  const PoemsScreen({
    super.key,
  });

  @override
  State<PoemsScreen> createState() => _PoemsScreenState();
}

class _PoemsScreenState extends State<PoemsScreen> with SingleTickerProviderStateMixin{
  late ScrollController _hideBottomNavController;
  late TextEditingController _poetryNameController;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;  
  late ValueNotifier<bool> _isVisibleSearchField;
  bool networkConnectionEnabled = true;
  var _isVisibleBottomBar = true;

  @override
  void initState() {
    super.initState();
    _isVisibleSearchField = ValueNotifier(false);
    _poetryNameController = TextEditingController();
    _hideBottomNavController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: const Offset(0, 0.1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
    _hideBottomNavController.addListener(() {
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisibleBottomBar) {
          _isVisibleBottomBar = false;
          context.read<MenuBloc>().add(MenuHide());
        }
      } else if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisibleBottomBar) {
          _isVisibleBottomBar = true;
          context.read<MenuBloc>().add(MenuShow());
        }
      }
    });
  }

  @override
  void dispose() {
    _poetryNameController.dispose();
    _hideBottomNavController.dispose();
    _animationController.dispose();
    _isVisibleSearchField.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => BlocListener<NetworkConnectionBloc, NetworkConnectionState>(
      listener: (context, state) {
        if(state is NetworkConnectionEnabled) {
          networkConnectionEnabled = state.isEnabled;
        }
      },  
      child: BlocConsumer<PoemsBloc, PoemsState>(
        listener: (context, state) async {
          if (state is PoemsLoaded) { } 
          else if (state is PoemsError) {
            await SnackBarDialog.showSnackBar(
              context, 
              state.error.toString(), 
              isError:  true
            );    
          }
        },
        builder: (context, state) {
          if (state is PoemsLoading) {
            context.read<MenuBloc>().add(MenuHide());
            return Center(
              child: LoadingIndicator(
                color: ColorStyles.pallete1,
                indicatorsSize: 48,
              ),
            );
          } else if (state is PoemsLoaded) {
            context.read<MenuBloc>().add(MenuShow());
            return LiquidPullToRefresh(
              color: ColorStyles.pallete1,
              onRefresh: () async => _loadPoems(),
              child: CustomScrollView(
                controller: _hideBottomNavController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverListAppBar(
                      onTap: () {
                        _animationController.forward();
                        _isVisibleSearchField.value = true;
                      },
                    ),
                    floating: true,
                    pinned: true,
                  ),
                  TopicsBar(
                    sortByType: sortByType,
                    currentTopic: state.value,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _isVisibleSearchField,
                    builder: (context, value, child) => SearchPoetryBar(
                      isVisibleSearchField: _isVisibleSearchField.value,
                      offsetAnimation: _offsetAnimation,
                      poetryNameController: _poetryNameController,
                      onSearch: () {
                        _searchPoem(_poetryNameController.text);
                      },
                    ),
                  ),
                  PoemList(
                    poems: state.poems,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );

  Future<void> _loadPoems() async {
    context.read<PoemsBloc>().add(PoemsLoad(syncWithFireStore: networkConnectionEnabled));
  }

  Future<void> _searchPoem(String name) async {
    context.read<PoemsBloc>().add(PoemsSearch(name: name));
    await _animationController.reverse();
    _isVisibleSearchField.value = false;
    _poetryNameController.clear();
  }

  Future<void> sortByType(Topics value) async {
    context.read<PoemsBloc>().add(PoemsSortByType(value: value));
  }
}
