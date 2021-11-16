//
//      ┏┛ ┻━━━━━┛ ┻┓
//      ┃　　　　　　 ┃
//      ┃　　　━　　　┃
//      ┃　┳┛　  ┗┳　┃
//      ┃　　　　　　 ┃
//      ┃　　　┻　　　┃
//      ┃　　　　　　 ┃
//      ┗━┓　　　┏━━━┛                  
//        ┃　　　┃             神兽保佑                     
//        ┃　　　┃             代码无BUG！                  
//        ┃　　　┗━━━━━━━━━┓   @project
//        ┃　　　　　　　    ┣┓  @author kai
//        ┃　　　　         ┏┛  @parse  动画demo
//        ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛   @date 2021/11/14/15:27     
//          ┃ ┫ ┫   ┃ ┫ ┫                
//          ┗━┻━┛   ┗━┻━┛

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KaiAnimationButton extends StatefulWidget {
  const KaiAnimationButton(
      {Key? key,
      required this.text,
      required this.innerCircleColor,
      required this.outerRingColor,
      this.style,
      required this.onTap,
      required this.innerWidth,
      required this.outerRingWidth,
      required this.outerRingHeight})
      : super(key: key);
  final String text; //框内文本
  //文本style
  final TextStyle? style;

  //内圈渐变颜色 begin->end
  final List<Color?> innerCircleColor;

  //内圈宽度 begin->end
  final List<double?> innerWidth;

  //外圈渐变颜色 begin->end
  final List<Color?> outerRingColor;

  //外圈宽 begin -> end
  final List<double?> outerRingWidth;

  //外圈高 begin -> end
  final List<double?> outerRingHeight;

  //点击事件
  final VoidCallback? onTap;

  @override
  _KaiAnimationButtonState createState() => _KaiAnimationButtonState();
}

class _KaiAnimationButtonState extends State<KaiAnimationButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  //颜色变换
  late Animation _colorAnimation;

  //第二层container动画
  late AnimationController _twoController;
  late Animation<double> _twoWidthAnimation;
  late Animation<double> _twoHeightAnimation;
  late Animation<double> _twoSideAnimation;

  //颜色变换
  late Animation _twoColorAnimation;

  //timer
  // late Timer _timer;

  @override
  void initState() {
    print(widget.onTap.toString());
    super.initState();

    //controller控制器控制动画时长
    //vsync设置一个TickerProvider 当前State混入了SingleTickerProviderState就是一个TickerProvider
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    //变换颜色
    _colorAnimation = new ColorTween(
            begin: widget.innerCircleColor[0] != null
                ? widget.innerCircleColor[0]
                : Color.fromRGBO(205, 201, 201, 98),
            end: widget.innerCircleColor[1] != null
                ? widget.innerCircleColor[1]
                : Color.fromRGBO(238, 233, 233, 1))
        .animate(_controller);

    //第二层动画 宽高变化、颜色变化、边框宽度变化
    _twoController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _twoWidthAnimation = new Tween(
            begin: widget.outerRingWidth[0] != null
                ? widget.outerRingWidth[0]
                : 190.0,
            end: widget.outerRingWidth[1] != null
                ? widget.outerRingWidth[1]
                : 240.0)
        .animate(_twoController)
          ..addListener(() {
            setState(() {
              if (_twoController.status.toString() ==
                  'AnimationStatus.completed') {
                _twoController.reset();
              }
            });
          });
    _twoHeightAnimation = new Tween(
            begin: widget.outerRingHeight[0] != null
                ? widget.outerRingHeight[0]
                : ScreenUtil().setHeight(80),
            end: widget.outerRingHeight[1] != null
                ? widget.outerRingHeight[1]
                : ScreenUtil().setHeight(120))
        .animate(_twoController)
          ..addListener(() {
            setState(() {
              if (_twoController.status.toString() ==
                  'AnimationStatus.completed') {}
            });
          });
    _twoSideAnimation = new Tween(begin: 4.0, end: 0.1).animate(_twoController)
      ..addListener(() {
        setState(() {
          if (_twoController.status.toString() ==
              'AnimationStatus.completed') {}
        });
      });
    //第二层颜色
    _twoColorAnimation = new ColorTween(
            begin: widget.outerRingColor[0] != null
                ? widget.outerRingColor[0]
                : Color.fromRGBO(238, 233, 233, 0),
            end: widget.outerRingColor[1] != null
                ? widget.outerRingColor[1]
                : Color.fromRGBO(205, 201, 201, 98))
        .animate(_twoController);

    //Tween设置动画的区间值 并且调用.animate方法传入控制器（时间）
    _animation = new Tween(
            begin: widget.innerWidth[0] != null ? widget.innerWidth[0] : 190.0,
            end: widget.innerWidth[1] != null ? widget.innerWidth[1] : 200.0)
        .animate(_controller)
          //添加监听 监听每一帧时调用 并且刷新ui setState()
          ..addListener(() {
            // print(_controller.status);
            // if (_controller.status.toString() == 'AnimationStatus.reverse') {}
            if (_controller.status.toString() == 'AnimationStatus.forward') {
              _twoController.forward();
            }
            setState(() {});
          });
    //第一层动画 .forward()正向行驶
    _controller.forward();
    _controller.repeat(reverse: true);

    // _twoController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _twoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.outerRingWidth[1] != null
          ? this.widget.outerRingWidth[1]
          : 240,
      height: this.widget.outerRingHeight[1] != null
          ? this.widget.outerRingHeight[1]
          : ScreenUtil().setHeight(120),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // color: Colors.amberAccent,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                    color: _twoColorAnimation.value,
                    width: _twoSideAnimation.value)),
            width: _twoWidthAnimation.value,
            height: _twoHeightAnimation.value,
          ),
          Container(
            // color: Colors.amberAccent,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                // color: Colors.amberAccent,
                border: Border.all(color: _colorAnimation.value, width: 2)),
            width: _animation.value,
            height: ScreenUtil().setHeight(80),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0.0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
              onPressed: this.widget.onTap,
              child: Text(
                widget.text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
