import 'package:TestChart/sample_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlChart Demo',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'fl_chart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;

  final _controller = PageController(initialPage: 0);
  final _duration = Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
  final _pages = [
    BarChartSample1()
  ];

  // bool get isDesktopOrWeb => PlatformInfo().isDesktopOS() || PlatformInfo().isWeb();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
      ),
      bottomNavigationBar:
          Container(
        padding: EdgeInsets.all(16),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: _currentPage != 0,
              child: FloatingActionButton(
                onPressed: () => _controller.previousPage(duration: _duration, curve: _curve),
                child: Icon(Icons.chevron_left_rounded),
              ),
            ),
            Spacer(),
            Visibility(
              visible: _currentPage != _pages.length - 1,
              child: FloatingActionButton(
                onPressed: () => _controller.nextPage(duration: _duration, curve: _curve),
                child: Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      )
          ,
    );
  }
}