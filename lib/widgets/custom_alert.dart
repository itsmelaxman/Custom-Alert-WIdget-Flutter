import 'package:flutter/material.dart';

enum ALertType { basic, rounded, fullWidth }

class CustomAlertWidget extends StatefulWidget {
  const CustomAlertWidget(
      {Key? key,
      this.content,
      this.title,
      this.child,
      this.backgroundColor,
      this.width,
      this.type = ALertType.basic,
      this.alignment,
      this.contentChild,
      this.bottombar,
      this.contentTextStyle = const TextStyle(color: Colors.black87),
      this.titleTextStyle = const TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      )})
      : super(key: key);

  final Widget? child;
  final String? title;
  final Widget? contentChild;
  final String? content;
  final TextStyle titleTextStyle;
  final Color? backgroundColor;
  final TextStyle contentTextStyle;
  final double? width;
  final ALertType type;
  final Alignment? alignment;
  final Widget? bottombar;

  @override
  _CustomAlertWidgetState createState() => _CustomAlertWidgetState();
}

class _CustomAlertWidgetState extends State<CustomAlertWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: animation,
        child: Column(
          children: <Widget>[
            Container(
              width: widget.type == ALertType.fullWidth
                  ? MediaQuery.of(context).size.width
                  : widget.width ?? MediaQuery.of(context).size.width * 0.885,
              constraints: const BoxConstraints(minHeight: 50),
              margin: widget.type == ALertType.fullWidth
                  ? const EdgeInsets.only(left: 0, right: 0)
                  : const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: widget.type == ALertType.basic
                      ? BorderRadius.circular(3)
                      : widget.type == ALertType.rounded
                          ? BorderRadius.circular(10)
                          : BorderRadius.zero,
                  color: widget.backgroundColor != null
                      ? widget.backgroundColor
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.10), blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: widget.alignment ?? Alignment.topLeft,
                    child: widget.title != null
                        ? Text(widget.title!, style: widget.titleTextStyle)
                        : (widget.child ?? Container()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: widget.alignment ?? Alignment.topLeft,
                    child: widget.content != null
                        ? Text(widget.content!, style: widget.contentTextStyle)
                        : (widget.contentChild ?? Container()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.bottombar ?? Container(),
                ],
              ),
            ),
          ],
        ),
      );
}
