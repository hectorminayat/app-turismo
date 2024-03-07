import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DatePicker({this.title, this.onChanged, this.defaultDate});
  final ValueChanged<DateTime?>? onChanged;
  final String? title;
  final DateTime? defaultDate;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String date = "";
  DateTime? selectedDate;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.defaultDate != null) {
      selectedDate = widget.defaultDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 6),
            child: Text(
              widget.title!,
              style: TextStyle(fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              width: width,
              height: 58.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secundaryColors1),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: Theme.of(context).accentColor,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  selectedDate == null
                      ? Container()
                      : Text(
                          "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       ElevatedButton(
    //         onPressed: () {
    //           _selectDate(context);
    //         },
    //         child: Text("Choose Date"),
    //       ),
    //       Text(
    //           "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}")
    //     ],
    //   ),
    // );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
    widget.onChanged!(selected);
  }
}
