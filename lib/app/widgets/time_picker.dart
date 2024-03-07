import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({ this.title, this.onChanged, this.defaultStringDate});

  final String? title;
  final ValueChanged<TimeOfDay?>? onChanged;
  final String? defaultStringDate;


  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  String _hour = '00';
  String _minute = '00';
  String _period = 'AM';
  TimeOfDay? _timeOfDay;

  TimeOfDay stringToTimeOfDay(String date) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(date));
  }

  _setDateState(TimeOfDay date) {
    String s = date.format(context).toString();

    RegExp regExp = new RegExp(
      r"\b((1[0-2]|0?[1-9]):([0-5][0-9]) ([AaPp].[Mm].))",
      multiLine: true,
    );
    final match = regExp.firstMatch(s);
    setState(() {
      _hour = match!.group(2)!;
      _minute = match.group(3)!;
      _period = match.group(4)!;
      _timeOfDay = date;
    });
    widget.onChanged!(date);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(widget.defaultStringDate != null) {
      TimeOfDay defaultDate = stringToTimeOfDay(widget.defaultStringDate!);
      String s = defaultDate.format(context).toString();
      
      RegExp regExp = new RegExp(
        r"\b((1[0-2]|0?[1-9]):([0-5][0-9]) ([AaPp].[Mm].))",
        multiLine: true,
      );
      final match = regExp.firstMatch(s);

      _hour = match!.group(2)!;
      _minute = match.group(3)!;
      _period = match.group(4)!;
      _timeOfDay = defaultDate;
    }
  }

  @override
  Widget build(BuildContext context) {

    _selectTime() async { 

      final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _timeOfDay ?? TimeOfDay(hour: 0, minute: 0), cancelText: 'CANCELAR');

        if(picked !=null) {
          _setDateState(picked);
        }
    }
    
   Widget _buildNumber({String? number}) {
     String? text =number!.length == 1 ? number.padLeft(2, '0') : number;
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: secundaryColors1,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text( text, style: TextStyle(fontSize: 36)));
    }

    return Container(
      child: InkWell(
        onTap: _selectTime,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 6),
            child: Text(widget.title ?? '', style: TextStyle(fontSize: 18),),
          ),
            Row(children: [
              Icon(Icons.schedule, size: 32,),
              SizedBox(width: 8),
              Container(child: Row(
                children: [
                  _buildNumber(number: _hour),
                    SizedBox(width: 4),
                  Text(":",style: TextStyle(fontSize: 38)),
                    SizedBox(width: 4),

                  _buildNumber(number: _minute),
                SizedBox(width: 10),

                  Text(_period, style: TextStyle(fontSize: 20))
                ],
              )),
       
            ]),
          ],
        )),
    );
  }
}