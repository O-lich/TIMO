import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/lists_page_background_widget.dart';

class ListsPage extends StatefulWidget {
  final List<ListModel> listsList;
  final List <FocusNode> focusNodeList;
  final List <TextEditingController> controllerList;

  static const routeName = '/lists_page';

  const ListsPage({
    Key? key,
    required this.listsList, required this.focusNodeList, required this.controllerList,
  }) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListsPageBackgroundWidget(
        height: heightScreen,
        width: widthScreen,
        onPressed: () {
          context.read<AppBloc>().add(
                const AppEventGoToMainView(),
              );
        },
        lists: widget.listsList,
        onAddButtonTap: () {
          SlidingPanelHelper().onAddNewListPressed(
            widthScreen: widthScreen,
            heightScreen: heightScreen,
            context: context,
            onBlackButtonTap: (TextEditingController myListController) {
              Navigator.pop(context);
              context.read<AppBloc>().add(
                    AppEventAddNewListFromListScreen(
                      listController: myListController,
                    ),
                  );
            },
          );
        },
        onSettingsButtonTap: () {
          context.read<AppBloc>().add(
                const AppEventGoToSettings(),
              );
        }, focusNodeList: widget.focusNodeList,
        controllerList: widget.controllerList,
      ),
    );
  }
}
