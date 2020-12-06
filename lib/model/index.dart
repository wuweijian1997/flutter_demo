import 'package:demo/model/counter_model.dart';
import 'package:demo/model/blog_provider.dart';
import 'package:demo/model/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
export 'canvas/index.dart';
export 'slide_update_model.dart';
export 'clip_tab_model.dart';
export 'page_route_model.dart';
export 'sliver_model.dart';
export 'bloc/index.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => UserInfoProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => BlogProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => CounterModel(),
  ),
];