import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OptionSelectionWidget extends StatefulWidget {
  final String collectionPath;
  final String fieldName;
  final Function(String) onSelectOption;

  OptionSelectionWidget({
    required this.collectionPath,
    required this.fieldName,
    required this.onSelectOption,
  });

  @override
  _OptionSelectionWidgetState createState() => _OptionSelectionWidgetState();
}

class _OptionSelectionWidgetState extends State<OptionSelectionWidget> {
  late FixedExtentScrollController scrollController;
  String _selectedOption = '';
  List<dynamic> _options = [];
  int indx = 0;

  @override
  void initState() {
    super.initState();
    _fetchOptions();
    scrollController = FixedExtentScrollController(initialItem: indx);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _fetchOptions() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(widget.collectionPath)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _options = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Select an option:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            _selectedOption,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CupertinoButton.filled(
                child: const Text("Open Picker"),
                onPressed: () {
                  scrollController.dispose();
                  scrollController =
                      FixedExtentScrollController(initialItem: indx);
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                            actions: [buildPicker()],
                          ));
                }),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: TextEditingController(
                text: _options.isNotEmpty ? _options[indx]["name"] : ""),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: TextEditingController(
                text: _options.isNotEmpty ? _options[indx]["description"] : ""),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: TextEditingController(
                text: _options.isNotEmpty ? _options[indx]["location"] : ""),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: TextEditingController(
                text: _options.isNotEmpty ? _options[indx]["date"] : ""),
          ),
        ],
      ),
    );
  }

  Widget buildPicker() => _options.isNotEmpty
      ? SizedBox(
          height: 350,
          child: CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 64,
            onSelectedItemChanged: (index) {
              setState(() {
                indx = index;
                _selectedOption = _options[index]["name"];
                widget.onSelectOption(_selectedOption);
              });
            },
            children: _options
                .map((option) => Center(child: Text(option["name"])))
                .toList(),
          ),
        )
      : const CircularProgressIndicator();
}
