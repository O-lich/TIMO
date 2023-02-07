import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';



class MyHomePage extends StatefulWidget {
  static const routeName = '/my_home_page';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final panelController = PanelController();
  bool isDeleted = false; //manage undo floating action button visibility
  bool isMoveTo = false; //manage add floating action button visibility
  final scrollController = ScrollController();
  final listController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondBackgroundColor,
      body: SlidingUpPanel(
        isDraggable: false,
        backdropEnabled: true,
        backdropColor: Colors.white,
        backdropOpacity: 1,
        boxShadow: const [
          BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0))
        ],
        minHeight: 0.58 * heightScreen,
        maxHeight: 0.95 * heightScreen,
        borderRadius: commonBorderRadius,
        controller: panelController,
        onPanelOpened: () => setState(() {}),
        onPanelClosed: () => setState(() {}),
        body: MainScreenBackgroundWidget(
          width: widthScreen,
          height: heightScreen,
          onPressed: () {
            Navigator.of(context).pushNamed(ListsPage.routeName);
          },
        ),
        panelBuilder: (controller) => TasksWidget(
          onPressed: () {
            SlidingPanelHelper().onPressedShowBottomSheet(
              ListsPanelWidget(
                height: heightScreen,
                width: widthScreen,
                lists: sampleLists,
                onTapClose: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isMoveTo = false;
                  });
                },
                onAddNewListPressed: () {
                  SlidingPanelHelper()
                      .onAddNewListPressed(widthScreen, heightScreen, context);
                },
              ),
              context,
            );
            setState(() {
              isMoveTo = true;
            });
          },
          isPanelOpen: panelController.isPanelOpen,
          tasks: sampleTasks,
          controller: scrollController,
          panelController: panelController,
          height: panelController.isPanelOpen
              ? 0.95 * heightScreen
              : 0.55 * heightScreen,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 0.0086 * heightScreen, // ToDo
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isDeleted
                    ? FloatingActionButton(
                        heroTag: "fab1",
                        backgroundColor: textColor,
                        onPressed: () {},
                        child: const Icon(Icons.undo),
                      )
                    : Container(),
                isMoveTo
                    ? Container()
                    : FloatingActionButton(
                        heroTag: "fab2",
                        backgroundColor: textColor,
                        onPressed: () {
                          Navigator.pushNamed(context, NewTaskPage.routeName);
                        },
                        child: Image.asset(AppIcons.addButton),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
