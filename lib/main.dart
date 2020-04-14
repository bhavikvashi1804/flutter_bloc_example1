import 'dart:async';

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


enum HomeViewState{Busy,DataRetrieved,NoData}

class MyHomePage extends StatefulWidget { 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<HomeViewState> stateContoller=StreamController<HomeViewState>();
  List<String> _items;


  @override
  void initState() { 

    _getListData();
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Demo'),
      ),
      body:StreamBuilder(
        stream: stateContoller.stream,
        builder: (context,snapshot){
          
          if(snapshot.hasError){
            return displayInfoMessage(snapshot.error);
          }


          if(!snapshot.hasData|| snapshot.data==HomeViewState.Busy){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data==HomeViewState.Busy){
            return displayInfoMessage('There is no data for you, please add some one');
          }
          return ListView.builder(
            itemBuilder: (context,index)=>oneItemUI(index),
            itemCount: _items.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getListData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future _getListData({bool hasError=false,bool hasData=true})async {


    stateContoller.add(HomeViewState.Busy);

    await Future.delayed(Duration(seconds:5));


    if(hasError){
      return stateContoller.addError('An error occured while fetching data.');
    }

    if(!hasData){
      return stateContoller.add(HomeViewState.NoData);
    }
    _items =List<String>.generate(10,(index)=>'$index title');
    stateContoller.add(HomeViewState.DataRetrieved);

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
        child: Center(child: Text(_items[index])),
      ),
      color: Colors.amber,
      margin: EdgeInsets.all(5),
      
    );
  }

  Widget displayInfoMessage(String msg){
    return Center(
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.red
        ),
      ),
    );
  }
}

