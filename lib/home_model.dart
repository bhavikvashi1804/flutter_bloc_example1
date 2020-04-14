
import 'dart:async';

import './home_state.dart';
import './home_event.dart';

enum HomeViewState{Busy,DataRetrieved,NoData}


class HomeModel{
  
  final StreamController<HomeState> _stateContoller=StreamController<HomeState>();
  List<String> _items;


  Stream<HomeState> get homeState=>_stateContoller.stream;



  void dispatch(HomeEvent event){
    if(event is FetchData){
      _getListData(hasData: event.hasData,hasError: event.hasError);
      
    }
    print('Event displach $event');

  }



   Future _getListData({bool hasError=false,bool hasData=true})async {


    _stateContoller.add(BusyHomeState());

    await Future.delayed(Duration(seconds:5));


    if(hasError){
      return _stateContoller.addError('An error occured while fetching data.');
    }

    if(!hasData){
      return _stateContoller.add(DataFetchedHomeState(data: List<String>()));
    }
    _items =List<String>.generate(10,(index)=>'$index title');
    _stateContoller.add(DataFetchedHomeState(data: _items));

    //async state
    //1 loading
    //2 data fetched
    //3 error occured
    //4 no data
  }



}