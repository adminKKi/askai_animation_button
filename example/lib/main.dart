import 'package:askai_animation_button/animationButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    VoidCallback _onTap = (){
      return print('aaa');
    };

    return ScreenUtilInit(
      builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DemoPage()
      ),
      designSize: Size(750, 1334),
    );
  }
}


class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black45,
          child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('@author As.Kai'),
                    SizedBox(
                      height: 100,
                    ),
                    KaiAnimationButton(
                      text: '点击进入直播间',
                      innerCircleColor: [
                        Color.fromRGBO(205, 201, 201, 98),
                        Color.fromRGBO(238, 233, 233, 1)
                      ],
                      outerRingColor: [
                        Color.fromRGBO(238, 233, 233, 0),
                        Color.fromRGBO(205, 201, 201, 98)
                      ],
                      onTap: () {
                        print('aaa');
                      },
                      innerWidth: [190.0, 200],
                      outerRingWidth: [190.0, 240.0],
                      outerRingHeight: [
                        ScreenUtil().setHeight(80),
                        ScreenUtil().setHeight(120)
                      ],
                    ),

                  ],
                ),
              )),
        ));
  }
}
