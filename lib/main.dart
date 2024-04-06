import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  Future<void> _handleREfresh() {
    final Completer<void> completer = Completer();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liquid Pull To Refresh"),
      ),
      body: LiquidPullToRefresh(
        backgroundColor: Colors.purple,
        color: Colors.purple.shade100,
        showChildOpacityTransition: false,
        key: _refreshIndicatorKey,
        onRefresh: () => _handleREfresh(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(8)),
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 225,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
