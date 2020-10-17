import 'package:demo/util/index.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final ImageProvider image;
  final double width;
  final double height;
  final ImageLoadingBuilder loadingBuilder;
  final ImageErrorWidgetBuilder errorWidgetBuilder;

  CustomImage({this.image, this.width, this.height, this.loadingBuilder, this.errorWidgetBuilder});

  @override
  _CustomImageState createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  ImageStream _stream;
  ImageStreamListener _imageStreamListener;
  ImageChunkEvent _loadingProgress;
  ImageInfo _imageInfo;
  bool _loading = true;
  Object _lastException;
  StackTrace _stackTrace;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getImage();
  }

  void _getImage() {
    _stream = widget.image.resolve(createLocalImageConfiguration(
        context,
        size: widget.width != null && widget.height != null
            ? Size(widget.width, widget.height)
            : null));

    _imageStreamListener = ImageStreamListener(
      handleImageFrame,
      onChunk: handleImageChunk,
      onError: handleError,
    );
    _stream.addListener(_imageStreamListener);
  }

  ///加载进度
  void handleImageChunk(ImageChunkEvent event) {
    Log.info('onChunk', StackTrace.current);
    setState(() {
      _loadingProgress = event;
    });
  }

  ///加载完成
  void handleImageFrame(ImageInfo info, bool synchronousCall) {
    Log.info('onImage: ${info.image}', StackTrace.current);
    setState(() {
      _loading = false;
      _imageInfo = info;

      _loadingProgress = null;
      _lastException = null;
      _stackTrace = null;
    });
  }

  /// 加载失败
  void handleError(dynamic error, StackTrace stackTrace) {
    Log.info('onError', StackTrace.current);
    setState(() {
      _loading = false;
      _lastException = error;
      _stackTrace = stackTrace;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result = RawImage(
      image: _imageInfo?.image,
      width: widget.width,
      height: widget.height,
    );
    if(_loading) {
      return widget.loadingBuilder(context, result, _loadingProgress);
    }
    if(_lastException != null) {
      return widget.errorWidgetBuilder(context, _lastException, _stackTrace);
    }
    return result;
  }
}
