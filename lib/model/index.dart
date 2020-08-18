import 'package:demo/model/CounterModel.dart';
import 'package:demo/model/blog_provider.dart';
import 'package:demo/model/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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