import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class DatePicker extends StatefulWidget {
  final Function() onRefresh;
  final DatePickerController data;
  final String hint;
  final DateTime firstDate;
  const DatePicker(
      {Key? key,
      required this.onRefresh,
      required this.firstDate,
      required this.data,
      required this.hint})
      : super(key: key);

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? dateTime = await showOmniDateTimePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: widget.firstDate,
          lastDate: DateTime.now().add(
            const Duration(days: 3652),
          ),
          is24HourMode: true,
          isShowSeconds: false,
          minutesInterval: 1,
          secondsInterval: 1,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          constraints: const BoxConstraints(
            maxWidth: 350,
            maxHeight: 650,
          ),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1.drive(
                Tween(
                  begin: 0,
                  end: 1,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
        );

        if (dateTime != null) widget.data.date = dateTime;
        setState(() {});
        widget.onRefresh();
      },
      child: Container(
        decoration: BoxDecoration(
            color: ThemeService.textField,
            borderRadius: ThemeService.allAroundBorderRadius),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.timer),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.data.date != null)
                      Text(widget.hint,
                          style: const TextStyle(
                              color: ThemeService.secondaryText, fontSize: 7)),
                    IgnorePointer(
                      child: TextFormField(
                        style: const TextStyle(
                            color: ThemeService.primaryText,
                            fontStyle: FontStyle.italic),
                        controller: TextEditingController(
                            text: widget.data.stringValue),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              widget.data.date = DateTime.parse(value);
                              widget.onRefresh();
                            });
                          }
                        },
                        decoration: InputDecoration(
                            isCollapsed: true,
                            isDense: true,
                            hintText: widget.hint,
                            floatingLabelStyle:
                                const TextStyle(color: ThemeService.eventColor),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}