import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

import 'crieteria_page.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key, this.index, this.jsonResult});

  final dynamic jsonResult;
  final int? index;

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colorMap = {
      'green': Colors.green,
      'red': Colors.red
    };
    String? replacement1;
    String? replacement2;
    Color getColorFromName(String colorName) {
      return colorMap[colorName.toLowerCase()] ??
          Colors.black;
    }

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
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.jsonResult[widget.index]['name']}".capitalize!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "${widget.jsonResult[widget.index]['tag']}",
                      style: TextStyle(
                          color: getColorFromName(
                              "${widget.jsonResult[widget.index]['color']}")),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        widget.jsonResult[widget.index]['criteria'].length,
                    itemBuilder: (context, index) {
                      // String formattedText = "${widget.jsonResult[widget.index]['criteria'][index]['text']}".replaceAllMapped(
                      //   RegExp(r'\$\d+'), (match) => replacements[match.group(0)]!,
                      // );
                      // String updatedText = "${widget.jsonResult[widget.index]['criteria'][index]['text']}".replaceAll("\$1", "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']['default_value']})").replaceAll("\$2", "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$2']['values'][0]})");
                      // List<String> textParts = replacedText.split("(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']['default_value']})");
                      String newText =
                          "${widget.jsonResult[widget.index]['criteria'][index]['text']}"
                              .replaceFirstMapped(
                        RegExp(r'(by\s+\$?\d+\s*)(%$)'),
                        (match) => "by ",
                      );

                      if (widget.jsonResult[widget.index]['name'] ==
                          "CCI Reversal") {
                        replacement1 =
                            "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']['default_value']})";
                        replacement2 =
                            "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$2']['values'][0]})";
                      } else {}

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30.0),
                            widget.jsonResult[widget.index]['criteria'][index]
                                        ['type'] !=
                                    "variable"
                                ? widget.jsonResult[widget.index]['criteria']
                                            .length >=
                                        2
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.jsonResult[widget.index]['criteria'][index]['text']}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          if (index !=
                                              widget
                                                      .jsonResult[widget.index]
                                                          ['criteria']
                                                      .length -
                                                  1) // Add text between sentences
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text('and',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                        ],
                                      )
                                    : Text(
                                        "${widget.jsonResult[widget.index]['criteria'][index]['text']}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                : widget.jsonResult[widget.index]['name'] !=
                                            "CCI Reversal" &&
                                        widget.jsonResult[widget.index]
                                                ['name'] !=
                                            "RSI Overbought"
                                    ? FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              newText,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              CriteriaPage(
                                                                isVariablesPresent:widget
                                                                    .jsonResult[
                                                                widget
                                                                    .index]['criteria'][index]['variable']['\$1']['type'] == 'indicator'?

                                                                true:false,
                                                                jsonResult: widget
                                                                            .jsonResult[
                                                                        widget
                                                                            .index]['criteria'][index]['variable']
                                                                    [
                                                                    '\$1']['values'],
                                                                index: index,
                                                              )),
                                                );
                                              },
                                              child: Text(
                                                "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']['values'][0]})",
                                                style: const TextStyle(
                                                    color: Colors.purple,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                            const Text(
                                              " %",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                    : widget.jsonResult[widget.index]['name'] ==
                                            "RSI Overbought"
                                        ? FittedBox(
                                            child: Row(
                                            children: [
                                              Text(
                                                newText,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                CriteriaPage(
                                                                  isVariablesPresent:
                                                                      true,
                                                                  jsonResult: widget
                                                                              .jsonResult[
                                                                          widget
                                                                              .index]['criteria'][index]
                                                                      [
                                                                      'variable']['\$1'],
                                                                  index: index,
                                                                )),
                                                  );
                                                },
                                                child: Text(
                                                  replacement1 ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.purple,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                              if(widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']!= null)
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            CriteriaPage(
                                                              isVariablesPresent:widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$1']['type'] == 'indicator'?

                                                              true:false,
                                                              jsonResult: widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$1']
                                                              [
                                                              'values'],
                                                              index: index,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                  "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$1']['values'][0]}) %",
                                                  style: const TextStyle(
                                                      color: Colors.purple),
                                                ),
                                              ),if(widget.jsonResult[widget.index]['criteria'][index]['variable']['\$2']!= null)
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            CriteriaPage(
                                                              isVariablesPresent:widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$2']['type'] == 'indicator'?

                                                              true:false,
                                                              jsonResult: widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$2']
                                                              [
                                                              'values'],
                                                              index: index,
                                                            )),
                                                  );
                                                },

                                                child: Text(
                                                  "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$2']['values'][0]}) %",
                                                  style: const TextStyle(
                                                      color: Colors.purple),
                                                ),
                                              ),if(widget.jsonResult[widget.index]['criteria'][index]['variable']['\$3']!= null)
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            CriteriaPage(
                                                              isVariablesPresent:
                                                             widget
                                                                .jsonResult[
                                                            widget
                                                                .index]['criteria'][index]['variable']['\$3']['type'] == 'indicator'?

                                                              true:false,
                                                              jsonResult: widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$3']
                                                              [
                                                              'values'],
                                                              index: index,
                                                            )),
                                                  );
                                                },

                                                child: Text(
                                                  "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$3']['values'][0]})",
                                                  style: const TextStyle(
                                                      color: Colors.purple),
                                                ),
                                              ),if(widget.jsonResult[widget.index]['criteria'][index]['variable']['\$4']!= null)
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            CriteriaPage(
                                                              isVariablesPresent:widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$4']['type'] == 'indicator'?

                                                              true:false,
                                                              jsonResult: widget
                                                                  .jsonResult[
                                                              widget
                                                                  .index]['criteria'][index]['variable']['\$4']
                                                             ,
                                                              index: index,
                                                            )),
                                                  );
                                                },

                                                child: Text(
                                                  "(${widget.jsonResult[widget.index]['criteria'][index]['variable']['\$4']['default_value']})",
                                                  style: const TextStyle(
                                                      color: Colors.purple),
                                                ),
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder:
                                              //               (context) =>
                                              //                   CriteriaPage(
                                              //                     isVariablesPresent:
                                              //                         false,
                                              //                     jsonResult: widget
                                              //                                 .jsonResult[
                                              //                             widget
                                              //                                 .index]['criteria'][index]['variable']['\$2']
                                              //                         [
                                              //                         'values'],
                                              //                     index: index,
                                              //                   )),
                                              //     );
                                              //   },
                                              //   child: Text(
                                              //      '%',
                                              //     style: const TextStyle(
                                              //         color: Colors.purple,
                                              //         decoration: TextDecoration
                                              //             .underline),
                                              //   ),
                                              // ),
                                            ],
                                          ))
                                        : widget.jsonResult[widget.index]
                                                        ['name'] ==
                                                "CCI Reversal"
                                            ? Row(
                                                children: [
                                                  const Text(
                                                    "CCI ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    CriteriaPage(
                                                                      isVariablesPresent:widget
                                                                          .jsonResult[
                                                                      widget
                                                                          .index]['criteria'][index]['variable']['\$1']['type'] == 'indicator'?

                                                                      true:false,
                                                                      jsonResult:
                                                                          widget.jsonResult[widget.index]['criteria'][index]['variable']
                                                                              [
                                                                              '\$1'],
                                                                      index:
                                                                          index,
                                                                    )),
                                                      );
                                                    },
                                                    child: Text(
                                                      replacement1 ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.purple,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ),
                                                  const Text(
                                                    " crosses below ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    CriteriaPage(
                                                                      isVariablesPresent:widget
                                                                          .jsonResult[
                                                                      widget
                                                                          .index]['criteria'][index]['variable']['\$2']['type'] == 'indicator'?

                                                                      true:false,
                                                                      jsonResult:
                                                                          widget.jsonResult[widget.index]['criteria'][index]['variable']['\$2']
                                                                              [
                                                                              'values'],
                                                                      index:
                                                                          index,
                                                                    )),
                                                      );
                                                    },
                                                    child: Text(
                                                      replacement2 ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.purple,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
