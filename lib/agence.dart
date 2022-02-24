import 'dart:async';
import 'dart:convert';

import 'package:eticket_gfa/Args.dart';
import 'package:flutter/material.dart';
import 'package:eticket_gfa/Agences.dart';
import 'package:eticket_gfa/Region.dart';
import 'package:http/http.dart' as http;

class Agences extends StatefulWidget {
  @override
  _Agences createState() => _Agences();
}

class _Agences extends State<Agences> {
  List<Agence> _agence = [];
  List<Region> _region = [];
  var selectedAgence;
  var selectedRegion;
  bool disabledropdown = true;

  Future<void> fetchRegion() async {
    final response =
        await http.get(Uri.parse('http://api.eticket.sn/index.php/showRegion'));
    var data1 = response.body;
    //log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _region = data.map((RegionJson) => Region.fromJson(RegionJson)).toList();
      selectedRegion = _region[0].IDRegion;
    });
  }

  Future<void> fetchAgence(idBank,idRegion) async {
    final response = await http
        .get(Uri.parse('http://api.eticket.sn/index.php/showAgenceByBank/3'));
    //log('http://api.eticket.sn/index.php/showAgenceByBankRegion/$idBank/$idRegion');
    var data1 = response.body;
    //log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _agence = data.map((AgenceJson) => Agence.fromJson(AgenceJson)).toList();
      selectedAgence = _agence[0].IDAgence;
    });
  }

  onPressed(routeName,idBank,idAgence,idRegion) {
    Args args = Args(idBank,idAgence,idRegion);
    Navigator.of(context).pushNamed(routeName,arguments: args);
  }
  void secondselected(_value) {
    setState(() {
      selectedAgence = _value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRegion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
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
            Text(
                  'Région',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 100) * 90,
                  height: (MediaQuery.of(context).size.height / 100) * 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      isDense: false,
                      hint: Text('Choisissez votre région'),
                      value: selectedRegion,
                      onChanged: (_value) {
                        setState(() {
                          //log('$_value');
                          selectedRegion = _value!;
                          //log('$selectedRegion');
                          disabledropdown = false;
                          fetchAgence(3, selectedRegion);
                        });
                      },
                      items: _region.map((Region map) {
                        return DropdownMenuItem(
                          value: map.IDRegion,
                          child: Text(
                            map.NomRegion,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).size.width/100)*3
                              ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
         Text(
                  'Agence',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 100) * 90,
                  height: (MediaQuery.of(context).size.height / 100) * 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                    child: DropdownButton(
                      isExpanded: true,
                      isDense: false,
                      value: selectedAgence,
                      onChanged: disabledropdown
                          ? null
                          : (_value) => secondselected(_value),
                      hint: Text('Choisissez votre agence'),
                      disabledHint: Text("Choisissez d'abord une région!"),
                      items: _agence.map((Agence map) {
                        return DropdownMenuItem(
                          value: map.IDAgence,
                          child: Text(
                            map.NomAgence,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).size.width/100)*3
                              ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                ElevatedButton(
              onPressed: () => onPressed(
                  '/ticket',
                  3,
                  selectedAgence,
                  selectedRegion,
                  ),
              child: Text('Valider',style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*3),),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey)),
            ),
        ]
      )
    ));
  }
}
