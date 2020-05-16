import 'package:flutter/material.dart';
import 'package:demo_api/services/userservice.dart';

class FutureBuilderData extends StatefulWidget {

  @override
  _FutureBuilderDataState createState() => _FutureBuilderDataState();
}

class _FutureBuilderDataState extends State<FutureBuilderData> {
  var dataToCall = 5;

  @override
  Widget build(BuildContext context) {
    var apiData = getUsersData(dataToCall);

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.82,
          child: FutureBuilder(
            future: apiData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Card(
                            elevation: 10,
                            semanticContainer: true,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: borderColor(
                                      snapshot.data[index].completed),
                                ),
                              ),
                              child: Container(
                                child: ListTile(
                                  onTap: () {
                                    print(snapshot.data[index].id);
                                  },
                                  title: Text(
                                    snapshot.data[index].title,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data[index].completed}"
                                        .toUpperCase(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Align(
                              alignment: Alignment(1, 1),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "${snapshot.data[index].id}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
        Container(
          height: 50,
          // ----Load More Button ---- //
          child: RaisedButton(
            onPressed: () {
              setState(() {
                dataToCall = dataToCall + 5;
                FutureBuilderData();
              });
            },
            child: Center(
              child: Text("Load More..."),
            ),
          ),
        ),
      ],
    );
  }

// ---- Card Border Color ---- //
  Color borderColor(bool completed) {
    return completed == true ? Colors.green : Colors.red;
  }
}
