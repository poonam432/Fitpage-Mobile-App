import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CriteriaPage extends StatefulWidget {
  const CriteriaPage({super.key, this.index, this.jsonResult, this.isVariablesPresent = false});

  final dynamic jsonResult;
  final int? index;
 final  bool isVariablesPresent;

  @override
  State<CriteriaPage> createState() => _CriteriaPageState();
}

class _CriteriaPageState extends State<CriteriaPage> {
  TextEditingController nameController = TextEditingController();

  String? value;
  @override
  void initState()  {
    nameController.text = widget.isVariablesPresent == true?"${widget.jsonResult['default_value']}" :''; // Set initial value
    nameController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      value = nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Fitpage App',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: (
            // widget.jsonResult['parameter_name'] == 'period' &&
            widget.isVariablesPresent == true)
            ? Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.jsonResult['study_type']}".toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      "Set Parameters",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            "${widget.jsonResult['parameter_name']}"
                                .capitalize!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          )),
                          Expanded(
                              child: SizedBox(
                                  height: 30.0,
                                  child: TextField(
                                    controller: nameController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      hoverColor: Colors.blue,
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                         'Value : ',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        Text(
                         value??'',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: widget.jsonResult.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.jsonResult[index]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 26.0),
                        ),
                        // Text("${jsonResult[index]['tag']}",style: TextStyle(color: getColorFromName("${jsonResult[index]['color']}"),decoration: TextDecoration.underline),),
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
                      ],
                    ),
                  );
                }));
  }
}
