import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int fib(int n) {
  int a = n - 1;
  int b = n - 2;
  if (n <= 2) {
    return 1;
  } else {
    return fib(a) + fib(b);
  }
}

class ComputePage extends StatefulWidget {
  static const String rName = "Compute";

  const ComputePage({Key? key}) : super(key: key);

  @override
  _ComputePageState createState() => _ComputePageState();
}

class _ComputePageState extends State<ComputePage> {
  Future<void> computeFuture = Future.value();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _ExampleAnimationWidget(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                FutureBuilder(
                  future: computeFuture,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      child: const Text("Compute on Main"),
                      onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnMain(context)
                              : null,
                    );
                  },
                ),
                FutureBuilder(
                  future: computeFuture,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      child: const Text("Compute on Isolate"),
                      onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnIsolate(context)
                              : null,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  handleComputeOnMain(BuildContext context) {
    setState(() {
      computeFuture = Future.delayed(Duration.zero, () {
        int result = fib(45);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Compute Main Done. result: $result")));
      });
    });
  }

  handleComputeOnIsolate(BuildContext context) {
    setState(() {
      computeFuture = Future.delayed(Duration.zero, () async {
        int result = await compute(fib, 45);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Compute Isolate Done. result: $result")));
      });
    });
  }
}

class _ExampleAnimationWidget extends StatefulWidget {
  @override
  _ExampleAnimationWidgetState createState() => _ExampleAnimationWidgetState();
}

class _ExampleAnimationWidgetState extends State<_ExampleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<BorderRadius?> borderAnimation;
  late Animation<Color?> beginColorAnimation;
  late Animation<Color?> endColorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(150),
      end: BorderRadius.circular(0.0),
    ).animate(controller);

    beginColorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(controller);

    endColorAnimation = ColorTween(
      begin: Colors.blueAccent,
      end: Colors.redAccent,
    ).animate(controller);

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            child: const FlutterLogo(
              size: 200,
            ),
            alignment: Alignment.center,
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  beginColorAnimation.value!,
                  endColorAnimation.value!,
                ],
              ),
              borderRadius: borderAnimation.value,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('beginColorAnimation', beginColorAnimation));
  }
}
