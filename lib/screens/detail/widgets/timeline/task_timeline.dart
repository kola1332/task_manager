import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../models/task.dart';

class TaskTimeline extends StatelessWidget {
  final Desk desk;
  final bool isLast;
  const TaskTimeline({required this.desk, required this.isLast});

  @override
  Widget build(BuildContext context) {
    desk.slot ??=
        '''${desk.newTime!.hour < 10 ? '0${desk.newTime!.hour}' : desk.newTime!.hour}:${desk.newTime!.minute < 10 ? '0${desk.newTime!.minute}' : desk.newTime!.minute} - ${(desk.newTime!.hour + 1) < 10 ? '0${desk.newTime!.hour + 1}' : desk.newTime!.hour}:${desk.newTime!.minute < 10 ? '0${desk.newTime!.minute}' : desk.newTime!.minute}''';
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            _buildTimeline(desk.tlColor, isLast),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  desk.newTime!.format(context),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                    // ?
                     _buildCart(
                        desk.bgColor ??= Colors.grey.shade300,
                        desk.title,
                        desk.slot ??= '',
                      )
              ],
            )),
          ],
        ));
  }

  Widget _buildCart(Color bgColor, String title, String slot) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            slot,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(Color? color, bool isLast) {
    color ??= Colors.grey.withOpacity(0.3);
    return isLast
        ? SizedBox(
            height: 80,
            width: 20,
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                indicatorXY: 0,
                width: 15,
                indicator: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: color)),
                ),
              ),
              afterLineStyle: LineStyle(
                thickness: 2,
                color: color,
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 70,
                width: 20,
                child: TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    indicatorXY: 0,
                    width: 15,
                    indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 5, color: color)),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    thickness: 2,
                    color: color,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
                child: TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    indicatorXY: 0,
                    width: 15,
                    indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 5, color: color)),
                    ),
                  ),
                  afterLineStyle: LineStyle(
                    thickness: 2,
                    color: color,
                  ),
                ),
              ),
            ],
          );
  }
}
