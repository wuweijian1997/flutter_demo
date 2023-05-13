import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';

class EventChannelPage extends StatefulWidget {
  static const String rName = "EventChannel";

  const EventChannelPage({Key? key}) : super(key: key);

  @override
  _EventChannelPageState createState() => _EventChannelPageState();
}

class _EventChannelPageState extends State<EventChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<AccelerometerReadings>(
          stream: FlutterEventChannel.stream,
          builder: (BuildContext context, AsyncSnapshot<AccelerometerReadings> snapshot) {
            if (snapshot.hasError) {
              return Text("error: ${snapshot.error}");
            } else if(snapshot.hasData) {
              return Text(
                'x axis: ${snapshot.data!.x.toStringAsFixed(3)}'
                'y axis: ${snapshot.data!.y.toStringAsFixed(3)}'
                'z axis: ${snapshot.data!.z.toStringAsFixed(3)}',
                style: const TextStyle(fontSize: 30),
              );
            } else {
              return const Text("No Data Available");
            }
          },
        ),
      ),
    );
  }
}
