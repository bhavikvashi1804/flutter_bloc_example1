import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> _pageData;

  bool get _fetchData=>_pageData==null;
  //returns true if _pageData =  null means data is loading

  @override
  void initState() { 
    _getListData().then((value) => setState((){
      _pageData=value;
    }));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Demo'),
      ),
      body:_fetchData?
      Center(
        child: CircularProgressIndicator(),
      ): 
      ListView.builder(
        itemBuilder: (context,index)=>oneItemUI(index),
        itemCount: _pageData.length,
      ), 
    );
  }

  Future<List<String>> _getListData()async {
    await Future.delayed(Duration(seconds:5));
    return List<String>.generate(10,(index)=>'$index title');

    //async state
    //1 loading
    //2 data fetched
    //3 error occured
    //4 no data
  }


   Widget oneItemUI(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text(_pageData[index])),
      ),
      color: Colors.amber,
      margin: EdgeInsets.all(5),
      
    );
  }
}

