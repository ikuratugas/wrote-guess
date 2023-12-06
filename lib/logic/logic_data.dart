import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';

// this is a Provider (state management) Class
class OdataListKata extends ChangeNotifier {
  // #ketika baru masuk, ada tombol start pada pojok kanan, kenapa harus pakai itu
  // #karena entah kenapa di Hive tidak bisa render list datanya saat pertama terbuka, bisa sebenanrya tapi tidak bisa berfungsi button tiap-tiap jawabannya (intinya ada Error di Debug Console)
  // #jadi harus pakai pemicu, so.. i used button for that
  bool _isStartButton = true;
  bool get isStartButton => _isStartButton;
  void changeValueStartButton() {
    _isStartButton = !_isStartButton;
  }

  //=====================TTS package to give speak text if we click the button play=======
  // give the sound to the playbutton
  final FlutterTts flutterTts = FlutterTts();
  berbicara(String teksnya) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(_nilaislider);
    await flutterTts.speak(teksnya);
  }

  // change the pitch of the speak
  double _sliderValue = 1;
  double get slideValue => _sliderValue;
  double _nilaislider = 1;
  void setSliderValue(double val) {
    //!!! i need this 0.5 cause if don't the pitch sound didn't change because is 0.0 val
    val < 1.0 ? _nilaislider = 0.5 : _nilaislider = 1.0;
    _sliderValue = val;
    notifyListeners();
  }
  //=====================/TTS============================================================

//----------------------------------------PAGE_GUESS----------------------------
  //PAGE_GUESS -- not evertyhing cause sometimes is linked with PAGE_CHANGE, like shufflelist function

  // untuk menampung data Hive di simpan dalam list ini (_datanya), dan untuk penampil pada widget LisView PageGuess dan PageChange
  List<dynamic> _datanya = [];
  List<dynamic> get datanya => _datanya;

  // untuk menampung jawaban user paga PageGuess.dart
  List<TextEditingController> _controllers = [];
  List<TextEditingController> get controllers => _controllers;

  // local database menggunakan Hive, so need this
  final _hivecobasoal = Hive.box('hive_cobasoal'); //
  Box<dynamic> get hivecobasoal => _hivecobasoal;

  //after start Button clicked it will call this functoin to refresh data on the Hive
  //to refresh the list, when i after add, delete, edit, and when start button. will refresh
  Future<void> refreshData() async {
    final data = _hivecobasoal.keys.map((e) {
      final item = _hivecobasoal.get(e);
      return {
        'key': e, // for delete, this key really important
        'katakata': item['katakata'], // is for the answer
        'salah1': item['salah1'], // is if we be try and wrong so salah pertama
        'salah2': item['salah2'], // salah kedua
        'salah3': item['salah3'], // salah yang ketiga
        'totalsalah': item['totalsalah'], // for fun CheckIni()
        'isTampilButton': item['isTampilButton'], // value for Button "jawab"
        'jwbbenar': item['jwbbenar'], //if true, make checklist icon
      };
    }).toList(); // since is map. change to or convert it to list

    // to make controller have same length with hive data length
    _controllers =
        List.generate(_datanya.length, (index) => TextEditingController());
    _datanya = data.reversed.toList(); //#sort terbalik (reversed)

    // notify listener is must be if you have change the widget. Required this if your using Provider
    notifyListeners();
  }

  // for score in apppbar pageguess (2/3, trueanswer/falseanswer )
  int _scoreTotal = 0;
  int get scoreTotal => _scoreTotal;
  int _scoreBenar = 0;
  int get scoreBenar => _scoreBenar;

  // check the answer user input in PageGuess
  void checkIniHive(
      String val1, String val2, int index, TextEditingController jawabannya) {
    var datasoal = _datanya[index];

    if (val1 == val2) {
      datasoal['totalsalah'] = -1;
      datasoal['jwbbenar'] = true;
      datasoal['isTampilButton'] = false;

      //ini nilai pengubah scorenya
      _scoreBenar += 1;
      _scoreTotal += 1;
    } else {
      datasoal['salah1'] = true;
      if (datasoal['totalsalah'] == 1) {
        datasoal['salah2'] = true;
      } else if (datasoal['totalsalah'] == 2) {
        jawabannya.text = val2;
        datasoal['salah3'] = true;
        datasoal['isTampilButton'] = false;
        _scoreTotal += 1;
      }
    }
    datasoal['totalsalah']++;
    notifyListeners();
  }

  // when user click reset button in appbar of page_guess
  void resetListDataSoalHive() {
    List<dynamic> resetList = [];
    for (var i = 0; i < _datanya.length; i++) {
      resetList.add({
        'katakata': _datanya[i]['katakata'],
        'salah1': false,
        'salah2': false,
        'salah3': false,
        'totalsalah': 0,
        'jwbbenar': false,
        'isTampilButton': true,
      });
    }
    _scoreTotal = 0;
    _scoreBenar = 0;
    refreshData();
  }

  // have to using this algorithm since controller list and datanya list have different place
  // so to make same index for 2 difference list when shuffling using this
  void shuffleListHive() {
    refreshData();

    final random = Random();
    for (var i = 0; i < _hivecobasoal.length; i++) {
      final randomIndex = random.nextInt(_datanya.length);

      final tempNama = _hivecobasoal.getAt(i);
      final tempNomor = controllers[i];

      _hivecobasoal.putAt(i, _hivecobasoal.getAt(randomIndex));
      controllers[i] = controllers[randomIndex];

      _hivecobasoal.putAt(randomIndex, tempNama);
      controllers[randomIndex] = tempNomor;
    }

    resetListDataSoalHive();
    // no need refreshData cause is inside resetLitsdataSoalHive()
    // and for notify listener inside of refreshData
  }

//----------------------------------------PAGE_CHANGE----------------------------
  // untuk menampung inputan user in Add Dialog and Edit, must using TextEditingController
  final _tambahkata = TextEditingController();
  TextEditingController get tambahkata => _tambahkata;

  // this for Edit so this will be as index the list we want edit
  int? _indexEdit;
  int? get indexEdit => _indexEdit;

  // this for Dialog/Alert in PageChange
  String? _peringatanTextfield;
  String? get peringatanTextfield => _peringatanTextfield;
  String? _fieldkosong;
  String? get fieldkosong => _fieldkosong;

  void setEmptytambahkata() => _tambahkata.text = "";
  void setEmptyperingatantextfield() => _peringatanTextfield = "";

  //check if when input on dialog add/edit it's blank if yess then in adddialog and editdialog will appear message "wajib diisi". check to the add method and edit
  void isFieldkosong(String val) => _peringatanTextfield = val;

  //will return boolean, is for if the answer been on the list or not
  bool isAdaKataHive() {
    for (final data in datanya) {
      if (data['katakata'].toString() == tambahkata.text) {
        return true;
      }
    }
    return false;
  }

  Future<void> addWordHive(String menambah) async {
    if (_peringatanTextfield!.isEmpty) {
      _peringatanTextfield = "wajib diisi";
    } else if (isAdaKataHive()) {
      _peringatanTextfield = "kata sudah ada";
    } else {
      setEmptytambahkata();
      setEmptyperingatantextfield();
      final datanya = {
        "katakata": menambah,
        "salah1": false,
        "salah2": false,
        "salah3": false,
        "totalsalah": 0,
        "isTampilButton": true,
        "jwbbenar": false
      };
      await _hivecobasoal.add(datanya);
    }

    refreshData();
    // no need notify listener cuase is inside refreshData();
  }

  void ediDialHive(int index) {
    // because we using reversed list in _datanya, so when we
    // if i want tap, the index is  will be same with i tap, so using this
    _indexEdit = _datanya.length - 1 - index;
  }

  void ediWordHive(String mengganti) {
    if (_peringatanTextfield!.isEmpty) {
      _peringatanTextfield = "wajib diisi";
    } else if (isAdaKataHive()) {
      _peringatanTextfield = "kata sudah ada";
    } else {
      final digantidengan = {
        "katakata": mengganti,
        "salah1": false,
        "salah2": false,
        "salah3": false,
        "totalsalah": 0,
        "isTampilButton": true,
        "jwbbenar": false
      };
      _hivecobasoal.putAt(_indexEdit!, digantidengan);
      setEmptytambahkata();
      setEmptyperingatantextfield();
    }
    refreshData();
  }

  void delWordHive(int wantdel) async {
    await hivecobasoal.delete(wantdel);
    refreshData();
    notifyListeners();
  }

  //               ================BONUS====================
  // this code not use. is for debugging, if i want delete all the data
  void hapussemuaHive() async {
    await _hivecobasoal
        .deleteFromDisk(); //#hive menghapus semua isi data box-nya
  }
}
