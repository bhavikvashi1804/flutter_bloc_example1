import 'package:flutter/material.dart';
import './home_model.dart';
import './home_state.dart';
import './home_event.dart';

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

  final model=HomeModel();
  


  @override
  void initState() { 

    model.dispatch(FetchData());
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Demo'),
      ),
      body:StreamBuilder(
        stream: model.homeState ,
        builder: (context,snapshot){
          
          if(snapshot.hasError){
            return displayInfoMessage(snapshot.error);
          }

          var homeState=snapshot.data;

          if(!snapshot.hasData|| homeState is BusyHomeState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(homeState is DataFetchedHomeState){
            if(!homeState.hasData){
              return displayInfoMessage('There is no data for you, please add some one');
            }
          }
          return ListView.builder(
            itemBuilder: (context,index)=>oneItemUI(index,homeState.data),
            itemCount: homeState.data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          model.dispatch(FetchData());
        },
        child: Icon(Icons.refresh),
      ),
    );
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

