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

class MyHomePage extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Demo'),
      ),
      body:FutureBuilder(
        future: _getListData(hasData: false),
        builder: (context,snapshot){
          
          if(snapshot.hasError){
            return displayInfoMessage(snapshot.error);
          }


          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var listItems=snapshot.data;
          if(listItems.length==0){
            return displayInfoMessage('There is no data for you, please add some one');
          }
          return ListView.builder(
            itemBuilder: (context,index)=>oneItemUI(index,listItems),
            itemCount: listItems.length,
          );
        },
      )
    );
  }


  //in FutureBuilder there is one problem is you need to fetch data again, then it does not allow
  //its meaning less

  Future<List<String>> _getListData({bool hasError=false,bool hasData=true})async {
    await Future.delayed(Duration(seconds:5));


    if(hasError){
      return Future.error('An error occured while fetching data.');
    }

    if(!hasData){
      return List<String>();
    }
    return List<String>.generate(10,(index)=>'$index title');

    //async state
    //1 loading
    //2 data fetched
    //3 error occured
    //4 no data
  }


   Widget oneItemUI(int index,List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text(items[index])),
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

