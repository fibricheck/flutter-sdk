import 'package:flutter/material.dart';

import '/0_design_system/fc_colors.dart';
import '/0_design_system/fc_dimens.dart';

class DemoMetricsWidget extends StatefulWidget {
  final String timeRemaining;
  final String heartBeat;

  const DemoMetricsWidget({Key? key, required this.timeRemaining, required this.heartBeat}) : super(key: key);

  @override
  State<DemoMetricsWidget> createState() => _DemoMetricsWidgetState();
}

class _DemoMetricsWidgetState extends State<DemoMetricsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(FCDimens.margin1, FCDimens.margin2, FCDimens.margin1, FCDimens.margin1),
          child: Builder(builder: (context) {
            if (widget.timeRemaining != "-1") {
              return Text(
                "Time remaining: ${widget.timeRemaining}",
                style: const TextStyle(
                  color: FCColors.darkGray,
                ),
              );
            } else {
              return const Text(
                "Finished!",
                style: TextStyle(
                  color: FCColors.darkGray,
                ),
              );
            }
          }),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(FCDimens.margin1, FCDimens.margin2, FCDimens.margin1, FCDimens.margin1),
          child: Text(
            "Heartbeat: ${widget.heartBeat}",
            style: const TextStyle(
              color: FCColors.darkGray,
            ),
          ),
        ),
      ],
    );
  }
}
