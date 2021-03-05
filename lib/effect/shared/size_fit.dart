import 'dart:ui';

class SizeFit {
  static double physicalWidth = 0;
  static double physicalHeight = 0;
  static double dpr = 0;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double statusHeight = 0;

  static double rpx = 0;

  static void init() {
    //1.手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    //2.获取dpr
    dpr = window.devicePixelRatio;

    //3.宽度和高度
    screenWidth = physicalWidth /dpr;
    screenHeight = physicalHeight /dpr;

    //4.状态栏的高度
    statusHeight = window.padding.top;

    //5.计算rpx的大小
    rpx = screenWidth / 750;
  }

  static double fitWidth(double width) {
    return rpx * width;
  }
}