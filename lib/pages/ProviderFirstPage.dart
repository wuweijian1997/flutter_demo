import 'package:demo/NavigatorUtil.dart';
import 'package:demo/model/CounterModel.dart';
import 'package:demo/model/blog_provider.dart';
import 'package:demo/model/user_info_provider.dart';
import 'package:demo/pages/ProviderSecondPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderFirstPage extends StatelessWidget {
  static const rName = 'Provider';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProviderFirstPage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<CounterModel>(
                builder: (BuildContext context, CounterModel counterModel,
                    Widget child) {
                  return Text(
                      'CounterModel: ${counterModel.count}',
                      style: TextStyle(fontSize: 20)
                  );
                },
              ),
              Consumer2<UserInfoProvider, BlogProvider>(
                builder: (BuildContext context, UserInfoProvider userInfo,
                    BlogProvider blog, Widget child) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Text('name: ${userInfo.userInfo.name} age: ${userInfo.userInfo.age}'),
                      Text('title: ${blog.blog?.title} like: ${blog.blog?.like}'),
                    ],),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            NavigatorUtil.getInstance()
                .pushNamed(context, ProviderSecondPage.rName),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
