import 'package:flutter/material.dart';
import 'package:shop_app_flutter/screens/login.dart';
import 'package:shop_app_flutter/shared/components.dart';
import 'package:shop_app_flutter/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter shop app',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoply'),
        actions: [
          IconButton(
              onPressed: () {
                navigateToAndFinish(
                    context: context, screen: const LoginScreen());
              },
              icon: const Text('SKIP'))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: PageView(
              controller: _controller,
              children: [
                getPageViewItem(PageViewModel(
                    'Easy',
                    'Order online anytime from the comfort of your house',
                    'assets/images/store.png')),
                getPageViewItem(PageViewModel(
                    'Quality',
                    'Get the best products available on the market',
                    'assets/images/monitoring.png')),
                getPageViewItem(PageViewModel(
                    'Sales',
                    'Always get competitive prices by your orders',
                    'assets/images/sale.png')),
              ],
            )),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const SlideEffect(
                spacing: 8.0,
                dotColor: Colors.grey,
                activeDotColor: primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.page == 2) {
            //this is the last page of onboarding, go to login screen
            navigateToAndFinish(context: context, screen: const LoginScreen());
          } else {
            //go to next page of onboarding
            _controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward_ios),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
