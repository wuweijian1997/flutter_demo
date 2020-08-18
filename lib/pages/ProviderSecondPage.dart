import 'package:demo/model/CounterModel.dart';
import 'package:demo/model/blog_provider.dart';
import 'package:demo/model/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSecondPage extends StatefulWidget {
  static const rName = 'ProviderSecondPage';

  @override
  _ProviderSecondPageState createState() => _ProviderSecondPageState();
}

class _ProviderSecondPageState extends State<ProviderSecondPage> {

  @override
  Widget build(BuildContext context) {
    print(ProviderSecondPage.rName);
    return Scaffold(
      appBar: AppBar(
        title: Text('ProviderSecondPage'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Consumer<BlogProvider>(
                builder: (BuildContext context, BlogProvider blog, child) {
                  return IconButton(
                    icon: child,
                    onPressed: () {
                      blog.blogLike();
                    },
                  );
                },
                child: Icon(Icons.favorite),
              ),
              Consumer<UserInfoProvider>(
                builder: (BuildContext context, UserInfoProvider userInfo, child) {
                  return IconButton(
                    icon: child,
                    onPressed: () {
                      userInfo.addAge();
                    },
                  );
                },
                child: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
