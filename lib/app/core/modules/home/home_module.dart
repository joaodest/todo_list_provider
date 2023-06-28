import 'package:todo_list_provider/app/core/modules/home/home_page.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(routers: {
          "/home": (context) => HomePage(),
        }, bindings: []);
}
