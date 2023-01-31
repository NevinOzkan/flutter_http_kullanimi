import 'package:flutter/material.dart';
import 'package:flutter_http_kullanimi/Kisiler.dart';
import 'package:flutter_http_kullanimi/KisilerCevap.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Kisiler> parseKisilerCevap(String cevap) {
    /*var jsonVeri = json.decode(cevap);
    var kisilerCevap = KisilerCevap.fromJson(jsonVeri);

    List<Kisiler> kisilerListesi = kisilerCevap.kisilerListesi;*/
    return KisilerCevap.fromJson(json.decode(cevap)).kisilerListesi;
  }

  Future<List<Kisiler>> tumKisiler() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php");
    var cevap = await http.get(url);
    return parseKisilerCevap(cevap.body);
  }

  Future<List<Kisiler>> kisilerAra(String aramaKelimesi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php");
    var veri = {"kisi_ad": aramaKelimesi};
    var cevap = await http.post(url, body: veri);
    return parseKisilerCevap(cevap.body);
  }

  Future<void> kisileriGoster() async {
    var liste = await kisilerAra("a");

    for (var k in liste) {
      print("************");
      print("Kişi id: ${k.kisi_id}");
      print("Kişi ad: ${k.kisi_ad}");
      print("Kişi tel: ${k.kisi_tel}");
    }
  }

  @override
  void initState() {
    super.initState();
    kisileriGoster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
