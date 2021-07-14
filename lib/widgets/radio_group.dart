import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Orientation Options

class FlutterRadioGroup extends StatefulWidget {
  final List<String> titles;
  final String? label;
  final TextStyle labelStyle;
  final int? defaultSelected;
  final Function(int?)? onChanged;
  final bool labelVisible;
  final Color? activeColor;
  final TextStyle titleStyle;

  /// Define parameter widget
  const FlutterRadioGroup(
      {Key? key,
      required this.titles,
      this.label,
      this.labelStyle = const TextStyle(fontSize: 12),
      this.onChanged,
      this.defaultSelected = 0,
      this.labelVisible = true,
      this.activeColor,
      this.titleStyle = const TextStyle(fontSize: 14)})
      : super(key: key);

  @override
  FlutterRadioGroupState createState() => FlutterRadioGroupState();
}

/// Set state as Public to access update index radio group
class FlutterRadioGroupState extends State<FlutterRadioGroup> {
  int? _defaultValue = 0;

  /// Set default selected 0
  @override
  void initState() {
    super.initState();
    _defaultValue = widget.defaultSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelVisible,
          child: Text(
            widget.label ?? "",
            style: widget.labelStyle,
          ),
        ),

        /// Display widget from Selected Orientation, default is Vertical
        _vertical(),
      ],
    );
  }

  /// Vertical View
  Widget _vertical() {
    return Column(
      children: Iterable<int>.generate(widget.titles.length)
          .map((index) => RadioListTile(
                title: Text(
                  widget.titles[index],
                  style: widget.titleStyle,
                ),
                value: index,
                groupValue: _defaultValue,
                activeColor:
                    widget.activeColor ?? Theme.of(context).primaryColor,
                onChanged: (int? value) {
                  setState(() {
                    _defaultValue = value;
                    widget.onChanged!(_defaultValue);
                  });
                },
              ))
          .toList(),
    );
  }

  /// Update index programmatically
  void setIndexSelected(int index) {
    setState(() {
      if (index < widget.titles.length) _defaultValue = index;
    });
  }
}
