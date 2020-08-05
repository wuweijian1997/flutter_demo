import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListViewPage extends StatelessWidget {
  static final rName = 'ListViewPage';
  final List<String> list = [
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3684630111,809225667&fm=26&gp=0.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596628387613&di=75e4ff519a5277ae65f9ea86ed25c103&imgtype=0&src=http%3A%2F%2Fimage.thepaper.cn%2Fwww%2Fimage%2F4%2F42%2F373.jpg',
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1120860047,2888750080&fm=26&gp=0.jpg',
    'https://c-ssl.duitang.com/uploads/item/201609/23/20160923211308_ic4kG.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return ImageItem(path: list[index], index: index);
          }),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String path;
  final int index;

  ImageItem({this.path, this.index});

  @override
  Widget build(BuildContext context) {
    print('kafka build: index:$index');
    return Container(
      height: 500,
      child: Image.network(path, height: 300, loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
        print('kafka: index:$index');
        if (loadingProgress == null) return child;
        return Container(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
