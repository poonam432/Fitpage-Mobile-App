import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'landing_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  TabController? tabController;

  void loadingData()async {
    String data = await DefaultAssetBundle.of(context).loadString("lib/domain/scan_model.json");
    jsonResult = jsonDecode(data);
    setState(() {
    });
  }

  dynamic jsonResult;
  @override
  void initState()  {
    loadingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colorMap = {
      'green': Colors.green,
      'red' : Colors.red
    };

    Color getColorFromName(String colorName) {
      return colorMap[colorName.toLowerCase()] ?? Colors.black;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Fitpage App',style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: Colors.black,
           ),
        child:jsonResult == null?const CircularProgressIndicator():  ListView.builder(
            itemCount: jsonResult.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LandingView(index: index,jsonResult: jsonResult,)),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${jsonResult[index]['name']}",style: const TextStyle(color: Colors.white,decoration: TextDecoration.underline),),
                      Text("${jsonResult[index]['tag']}",style: TextStyle(color: getColorFromName("${jsonResult[index]['color']}"),decoration: TextDecoration.underline),),
                      const SizedBox(height: 30.0),
                      const DottedLine(
                        dashLength: 2,
                        dashGapLength: 2,
                        lineThickness: 1,
                        dashColor: Colors.white,
                        dashGapColor: Colors.black,
                        direction: Axis.horizontal,
                        lineLength: 350,
                        dashRadius: 4.0,
                      ),
                    ],),
                ),
              );
            }
        ),));
      // This trailing comma makes auto-formatting nicer for build methods.
  }
}
