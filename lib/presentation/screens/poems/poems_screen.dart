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

class _PoemsScreenState extends State<PoemsScreen> {
  late ScrollController _hideBottomNavController;
  bool networkConnectionEnabled = true;
  var _isVisible = true;

  @override
  void initState() {
    super.initState();
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(() {
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          _isVisible = false;
          context.read<MenuBloc>().add(MenuHide());
        }
      } else if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisible) {
          _isVisible = true;
          context.read<MenuBloc>().add(MenuShow());
        }
      }
    });
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
                color: ColorStyles.mainColor,
                indicatorsSize: 48,
              ),
            );
          } else if (state is PoemsLoaded) {
            context.read<MenuBloc>().add(MenuShow());
            return LiquidPullToRefresh(
              onRefresh: () async => _loadPoems(),
              // showChildOpacityTransition: false,
              child: CustomScrollView(
                controller: _hideBottomNavController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverListAppBar(),
                    floating: true,
                    pinned: true,
                  ),
                  TopicsBar(
                    sortByType: sortByType,
                    currentTopic: state.value,
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

  Future<void> sortByType(Topics value) async {
    context.read<PoemsBloc>().add(PoemsSortByType(value: value));
  }
}
