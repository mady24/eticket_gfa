import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eticket_gfa/Args.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  @override
  _Ticket createState() => _Ticket();
}

class _Ticket extends State<Ticket> {

Future<void> addTicket(Args data) async {
    final String data1 =
        '{"IDAgence":"${data.idAgence}","IDUser":"1","dateT":"${DateTime.now()}","timeT":"00:00:00"}';
    final response = await http
        .get(Uri.parse('http://api.eticket.sn/index.php/addTicket/$data1'));
    var data2 = response.body;
    log('$data2');
    
  }
  onPressed(Args data) {
    addTicket(data);
//      Navigator.of(context).pushNamed('/bank/tickets');
    //}
  }
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Args;
    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.all(20.0),
        child:Column(
          children: [
            Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 120.0, vertical: 20.0),
                  child: Image.network(
                    'http://admin.eticket.sn/img/ecobank.png',
                    height: 120.0,
                    width: 120.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      "Ecobank",
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 2.0,decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
            Text('Opérations de Caisse', style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*10),),
            SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
            ElevatedButton(onPressed: ()=>onPressed(arguments),style: ButtonStyle(minimumSize: MaterialStateProperty.all((MediaQuery.of(context).size/100)*20)), child: Padding(padding: const EdgeInsets.all(10.0),child: Text('Dépot',style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*10),))),
            SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
            ElevatedButton(onPressed: ()=>onPressed(arguments),style: ButtonStyle(minimumSize: MaterialStateProperty.all((MediaQuery.of(context).size/100)*20)), child: Text('Retrait',style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*10),))
          ])
        ),
      ),
    );
  }
}
