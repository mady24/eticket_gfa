

import 'package:flutter/material.dart';

//pages
import 'package:eticket_gfa/agence.dart';
import 'package:eticket_gfa/ticket.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/agence": (BuildContext context) => new Agences(),
    "/ticket": (BuildContext context) => new Ticket(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'Eticket',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: new Agences(),
      routes: routes,
    ));
  }
}
