import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/main_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';
import 'package:shop_app_flutter/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'network/dio_helper.dart';

void main() {
  //initialize dio instance to use it later for api calls
  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final PageController _controller = PageController(
    initialPage: 0,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter shop app',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: BlocProvider(
        create: (context) => MainCubit(),
        child: BlocConsumer<MainCubit, MainStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var mainCubit = MainCubit.get(context)
              ..getStartScreen(context)
              ..saveToken();
            return Scaffold(
              //to fix overflow when showing keyboard
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Shoply'),
                actions: [
                  IconButton(
                      onPressed: () {
                        mainCubit.endOnBoarding(context);
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
                    mainCubit.endOnBoarding(context);
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
          },
        ),
      ),
    );
  }
}
