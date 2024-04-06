// EXAMPLE use case for TextFieldSearch Widget
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = 'My Home Page'}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _testList = [
    'Test Item 1',
    'Test Item 2',
    'Test Item 3',
    'Test Item 4',
  ];

  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  TextEditingController myController3 = TextEditingController();
  TextEditingController myController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
    myController2.addListener(_printLatestValue);
    myController3.addListener(_printLatestValue);
    myController4.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("text field: ${myController.text}");
    print("text field: ${myController2.text}");
    print("text field: ${myController3.text}");
    print("text field: ${myController4.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    super.dispose();
  }

  // mocking a future
  Future<List<String>> fetchSimpleData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    List<String> _list = [];
    // create a list from the text input of three items
    // to mock a list of items from an http call
    _list.add('Test' + ' Item 1');
    _list.add('Test' + ' Item 2');
    _list.add('Test' + ' Item 3');
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 16),
              SearchTextField(
                  hintText: 'Simple Future List',
                  controller: myController2,
                  future: () async {
                    return fetchSimpleData();
                  }),
              SizedBox(height: 16),
              SearchTextField(
                hintText: 'Complex Future List',
                controller: myController3,
                future: () async {
                  return fetchSimpleData();
                },
                getSelectedValue: (item) {
                  print(item);
                },
                minStringLength: 5,
                textStyle: TextStyle(color: Colors.red),
                decoration: InputDecoration(hintText: 'Search For Something'),
              ),
              SizedBox(height: 16),
              SearchTextField(
                  hintText: 'Future List with custom scrollbar theme',
                  controller: myController4,
                  scrollbarDecoration: ScrollbarDecoration(
                      controller: ScrollController(),
                      theme: ScrollbarThemeData(
                          radius: Radius.circular(30.0),
                          thickness: MaterialStateProperty.all(20.0),
                          thumbVisibility: MaterialStateProperty.all(true),
                          trackColor: MaterialStateProperty.all(Colors.red))),
                  future: () async {
                    return fetchSimpleData();
                  }),
              SizedBox(height: 16),
              SearchTextField(
                  initialList: _testList,
                  hintText: 'Simple List',
                  controller: myController),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mock Test Item Class
class TestItem {
  final String label;
  dynamic value;

  TestItem({required this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}
