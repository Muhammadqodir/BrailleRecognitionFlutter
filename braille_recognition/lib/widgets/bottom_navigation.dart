import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key, required this.items, required this.openPage});

  List<Item> items;
  Function openPage;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: Row(
          children: widget.items
              .map(
                (e) => Expanded(
                  child: OnTapScaleAndFade(
                    onTap: () {
                      widget.openPage(widget.items.indexOf(e));
                      setState(() {
                        selected = widget.items.indexOf(e);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          selected == widget.items.indexOf(e)
                              ? e.icon_active
                              : e.icon,
                          width: selected == widget.items.indexOf(e) ? 26 : 24,
                          height: selected == widget.items.indexOf(e) ? 26 : 24,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        selected == widget.items.indexOf(e)
                            ? SvgPicture.asset("icons/circle_gradient.svg")
                            : const SizedBox(height: 4)
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Item {
  String title;
  String icon;
  String icon_active;
  Item(this.title, this.icon, this.icon_active);
}
