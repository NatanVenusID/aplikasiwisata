import 'package:aplikasi_wisata/geolocation.dart';
import 'package:aplikasi_wisata/homepage.dart';
import 'package:aplikasi_wisata/share/listplace.dart';
import 'package:aplikasi_wisata/share/model.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';

import 'dbhelper.dart';

class FormTravel extends StatefulWidget {
  final ModelTravel modelTravel;
  FormTravel(this.modelTravel);

  @override
  _FormTravelState createState() => _FormTravelState();
}

class _FormTravelState extends State<FormTravel> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _namaLokasiControler;
  TextEditingController _deskripsiLokasiControler;
  TextEditingController _petaLokasiControler;

  @override
  void initState() {
    super.initState();
    _namaLokasiControler =
        new TextEditingController(text: widget.modelTravel.namalokasi);
    _deskripsiLokasiControler =
        new TextEditingController(text: widget.modelTravel.deskripsilokasi);
    _petaLokasiControler =
        new TextEditingController(text: widget.modelTravel.petalokasi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Travel'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _namaLokasiControler,
            decoration: InputDecoration(
                labelText: 'Nama Lokasi',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _deskripsiLokasiControler,
            maxLines: 5,
            decoration: InputDecoration(
                labelText: 'Deksripsi Lokasi',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _petaLokasiControler,
            maxLines: 2,
            decoration: InputDecoration(
                labelText: 'Peta Lokasi',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.map,
                  ),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DetailMap(
                              tosave: context,
                            )));
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Text("Choose Image"),
            color: Colors.blue,
          ),
          RaisedButton(
              color: Colors.black,
              child: (widget.modelTravel.id != null)
                  ? Text(
                      'Update',
                      style: TextStyle(color: Colors.amber),
                    )
                  : Text(
                      'Add',
                      style: TextStyle(color: Colors.amber),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                if (widget.modelTravel.id != null) {
                  db
                      .updateTravel(ModelTravel.fromMap({
                    'id': widget.modelTravel.id,
                    'namalokasi': _namaLokasiControler.text,
                    'deskripsilokasi': _deskripsiLokasiControler.text,
                    'petalokasi': _petaLokasiControler.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveTravel(
                    ModelTravel(
                      _namaLokasiControler.text,
                      _deskripsiLokasiControler.text,
                      _petaLokasiControler.text,
                    ),
                  )
                      .then((_) {
                    // Navigator.pop(context, 'save');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListTravel()));
                  });
                }
              })
        ],
      ),
    );
  }
}
