import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrote_guess/logic/logic_data.dart';
import 'package:wrote_guess/pages/page_about.dart';

class PageChange extends StatelessWidget {
  const PageChange({super.key});

  @override
  Widget build(BuildContext context) {
    //================================ini dialaog addword============================
    void tambahDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Consumer<OdataListKata>(
                builder: (_, odatalistkata, child) => AlertDialog(
                      title: const Text("Tambah kata"),
                      actions: [
                        TextField(
                          onChanged: (value) {
                            if (value.split(' ').length > 1) {
                              odatalistkata.tambahkata.text =
                                  value.split(' ')[0];
                            }
                            odatalistkata.isFieldkosong(value);
                          },
                          controller: odatalistkata.tambahkata,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Hanya satu kata*"),
                        ),
                        if (odatalistkata.peringatanTextfield != "")
                          Text(odatalistkata.peringatanTextfield.toString()),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              odatalistkata
                                  .addWordHive(odatalistkata.tambahkata.text);

                              if (odatalistkata.peringatanTextfield == "" ||
                                  odatalistkata.peringatanTextfield == null) {
                                Navigator.pop(context);
                              }
                            },
                            child: ClipRRect(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    'Tambah',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
          });
    } //================================/batas dialog ============================

    //================================edit dialaog============================
    void editDialong() {
      showDialog(
          context: context,
          builder: (context) {
            return Consumer<OdataListKata>(
                builder: (_, odatalistkata, child) => AlertDialog(
                      title: const Text("Ubah kata"),
                      actions: [
                        TextField(
                          onChanged: (value) {
                            if (value.split(' ').length > 1) {
                              odatalistkata.tambahkata.text =
                                  value.split(' ')[0];
                            }
                            odatalistkata.isFieldkosong(value);
                          },
                          controller: odatalistkata.tambahkata,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Hanya satu kata *"),
                        ),
                        if (odatalistkata.peringatanTextfield != "")
                          Text(odatalistkata.peringatanTextfield.toString()),
                        Container(
                          margin: const EdgeInsets.only(top: 12.0),
                          child: // this GestureDetector is custom button ubah
                              GestureDetector(
                            onTap: () {
                              // odatalistkata
                              //     .ediWord(odatalistkata.tambahkata.text);

                              odatalistkata
                                  .ediWordHive(odatalistkata.tambahkata.text);

                              if (odatalistkata.peringatanTextfield == "" ||
                                  odatalistkata.peringatanTextfield == null) {
                                Navigator.pop(context);
                              } // Navigator.pop(context);
                            },
                            child: ClipRRect(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    'Ubah',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
          });
    } //================================/batas edit dialog ============================

    //================================soundpitch dialaog============================
    void soundPitchDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Consumer<OdataListKata>(
                builder: (_, odatalistkata, child) => AlertDialog(
                      title: const Text("Ganti Suara"),
                      actions: [
                        Center(
                          child: Slider(
                            label: odatalistkata.slideValue == 1.0
                                ? "tinggi"
                                : "rendah",
                            min: 0.0,
                            max: 1.0,
                            divisions: 1,
                            thumbColor: Colors.black,
                            activeColor: Colors.black,
                            value: odatalistkata.slideValue,
                            onChanged: (value) {
                              // Update the current value of the slider.
                              odatalistkata.setSliderValue(value);
                            },
                          ),
                        ),
                      ],
                    ));
          });
    } //================================/soundpitch dialog ============================

    return Consumer<OdataListKata>(
        builder: (_, odatalistkata, child) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    odatalistkata.refreshData();
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                title: const Text(
                  "Setting",
                ),
                actions: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      child: IconButton(
                        icon: const Icon(Icons.shuffle_rounded),
                        iconSize: 24,
                        onPressed: () {
                          odatalistkata.shuffleListHive();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: IconButton(
                        icon: const Icon(Icons.person_3_outlined),
                        iconSize: 24,
                        onPressed: () {
                          soundPitchDialog();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: const Icon(Icons.info),
                        iconSize: 26,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PageAbout()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: WillPopScope(
                onWillPop: () async {
                  odatalistkata.refreshData();
                  Navigator.pop(context, true);
                  return true;
                },
                child: ListView.builder(
                  itemCount: odatalistkata.datanya.length,
                  itemBuilder: ((context, index) {
                    //variabel lokal
                    final datasoal = odatalistkata.datanya[index];

                    return Dismissible(
                        background: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.yellow[200],
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            child: Image.asset(
                              'assets/trash.png',
                            ),
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          odatalistkata.delWordHive(datasoal['key']);
                        },
                        key: ValueKey(datasoal),
                        child: GestureDetector(
                          onTap: () {
                            odatalistkata.ediDialHive(index);
                            editDialong();
                            odatalistkata.setEmptyperingatantextfield();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(179, 243, 232, 171),
                                    Color.fromARGB(255, 250, 248, 233),
                                    Color.fromARGB(255, 252, 249, 205),
                                    Color.fromARGB(255, 253, 248, 215),
                                  ],
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.yellow[100],
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: MaterialButton(
                                          onPressed: () {
                                            odatalistkata.berbicara(
                                                datasoal['katakata']);
                                          },
                                          minWidth: 50,
                                          height: 50,
                                          child: Image.asset(
                                              'assets/playbutton.png',
                                              width: 30,
                                              height: 30))),
                                  title: Text(datasoal["katakata"].toString()),
                                ),
                              ),
                            ),
                          ),
                        ));
                  }),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.yellow[100],
                onPressed: () {
                  tambahDialog();
                  odatalistkata.setEmptyperingatantextfield();
                  odatalistkata.setEmptytambahkata();
                },
                child: Image.asset('assets/addword.png', width: 50, height: 50),
              ),
            ));
  }
}
