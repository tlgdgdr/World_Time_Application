import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;//location name for the ui
  String time;//the time in that location
  String flag;//url to an asset flag icon
  String url;//location url for api endpoint
  bool isDaytime;

  WorldTime({this.location,this.flag,this.url});//constructor

  Future<void> getTime() async {

    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);


      //create a DateTime object
      DateTime now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 7 && now.hour <19 ? true : false;
      //set the time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
    }


  }
}
