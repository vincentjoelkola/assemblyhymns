import 'package:flutter/material.dart';
import 'utility.dart';

class FontDailog extends StatefulWidget {
  final ValueChanged<double> parentAction;
  final double initialSize;
  FontDailog(this.initialSize,this.parentAction);
  @override
  _FontDailogState createState() => _FontDailogState();
}

class _FontDailogState extends State<FontDailog>
{
  double selectedSize=15.0;
  @override
  void initState() {
    selectedSize = widget.initialSize;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Font Size"),
      content:
      Container(
          height: 50,
          child:
          Slider(
            min: 15.0,
            max: 20.0,
            divisions: 6,
            value: selectedSize,
            onChangeEnd: (double value) {

            },
            onChanged: (double value) {
              setState(() {
                selectedSize = value;
              });
              widget.parentAction(selectedSize);
            },
            onChangeStart: (double value) {

            },
          )),
      actions: <Widget>
      [
        ElevatedButton(
          child: Text("Done"),
          onPressed: () {
            Utility.SetFontSize(selectedSize);
            Navigator.of(context).pop();
          },
        )
      ],

    );

  }

}
