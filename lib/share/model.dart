class ModelTravel {
  int _id;
  String _namaLokasi;
  String _deskripsiLokasi;
  String _petaLokasi;

  ModelTravel(this._namaLokasi, this._deskripsiLokasi, this._petaLokasi,);
  ModelTravel.map(dynamic obj) {
    this._id = obj['id'];
    this._namaLokasi = obj['namalokasi'];
    this._deskripsiLokasi = obj['deskripsilokasi'];
    this._petaLokasi = obj['petalokasi'];

  }
  int get id => _id;
  String get namalokasi => _namaLokasi;
  String get deskripsilokasi => _deskripsiLokasi;
  String get petalokasi => _petaLokasi;



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['namalokasi'] = _namaLokasi;
    map['deskripsilokasi'] = _deskripsiLokasi;
    map['petalokasi'] = _petaLokasi;

    return map;
  }

  ModelTravel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._namaLokasi = map['namalokasi'];
    this._deskripsiLokasi = map['deskripsilokasi'];
    this._petaLokasi = map['petalokasi'];

  }
}
