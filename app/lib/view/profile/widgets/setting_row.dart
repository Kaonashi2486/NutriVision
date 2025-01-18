import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SettingRow extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  final int
      len; // Added len parameter to control how much the container should expand
  final List<String?>
      additionalData; // Added a parameter to pass the data to display when expanded

  const SettingRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.len,
    required this.additionalData,
  }) : super(key: key);

  @override
  _SettingRowState createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  bool isExpanded = false;
  late ItemScrollController
      _itemScrollController; // Controller to handle scroll position
  late ItemPositionsListener
      _itemPositionsListener; // Listener to track item positions

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded; // Toggle the expansion
        });
        widget.onPressed(); // Call the onPressed callback
      },
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.icon,
                  height: 15,
                  width: 15,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 15),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                widget.additionalData?.isNotEmpty ?? false
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image.asset(
                          "assets/icons/p_next.png",
                          height: 12,
                          width: 12,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container() // Return an empty container if the list is empty or null
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded
                ? widget.len * 40.0
                : 0, // Adjust height based on expansion
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: isExpanded
                ? (ScrollablePositionedList.builder(
                    itemCount: widget.additionalData.length,
                    itemBuilder: (context, index) {
                      return EditableTextWidget(
                        additionalData: widget.additionalData,
                        index: index,
                      );
                    },
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                  ))
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class EditableTextWidget extends StatefulWidget {
  final List<String?> additionalData;
  final int index;

  const EditableTextWidget({
    Key? key,
    required this.additionalData,
    required this.index,
  }) : super(key: key);

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.additionalData[widget.index]?.isNotEmpty ?? false
            ? widget.additionalData[widget.index]
            : '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 2, 2, 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _isEditing
                ? Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                      onSubmitted: (newValue) {
                        setState(() {
                          widget.additionalData[widget.index] =
                              newValue.isEmpty ? null : newValue;
                          _isEditing = false;
                        });
                      },
                    ),
                  )
                : Expanded(
                    child: Text(
                      widget.additionalData[widget.index]?.isEmpty ?? true
                          ? 'empty'
                          : widget.additionalData[widget.index] ?? 'empty',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                  if (!_isEditing) {
                    widget.additionalData[widget.index] =
                        _controller.text.isEmpty ? null : _controller.text;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
