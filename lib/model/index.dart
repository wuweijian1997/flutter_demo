import 'package:demo/model/counter_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
export 'canvas/index.dart';
export 'slide_update_model.dart';
export 'clip_tab_model.dart';
export 'sliver_model.dart';
export 'bloc/index.dart';
export 'list_page_model.dart';
export 'sprite.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => CounterModel(),
  ),
];