
import 'dart:async';

enum HomeViewState{Busy,DataRetrieved,NoData}


class HomeModel{
  
  final StreamController<HomeViewState> _stateContoller=StreamController<HomeViewState>();
  List<String> items;


  Stream<HomeViewState> get homeState=>_stateContoller.stream;



   Future getListData({bool hasError=false,bool hasData=true})async {


    _stateContoller.add(HomeViewState.Busy);

    await Future.delayed(Duration(seconds:5));


    if(hasError){
      return _stateContoller.addError('An error occured while fetching data.');
    }

    if(!hasData){
      return _stateContoller.add(HomeViewState.NoData);
    }
    items =List<String>.generate(10,(index)=>'$index title');
    _stateContoller.add(HomeViewState.DataRetrieved);

    //async state
    //1 loading
    //2 data fetched
    //3 error occured
    //4 no data
  }



}