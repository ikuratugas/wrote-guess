import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrote_guess/logic/logic_data.dart';

class CheckAnswer extends StatelessWidget {
  const CheckAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OdataListKata>(
        builder: (_, odatalistkata, child) => ListView.builder(
              itemCount: odatalistkata.datanya.length,
              itemBuilder: ((context, index) {
                // local variabel
                final datasoal = odatalistkata.datanya[index];
                //
                return ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                // bottom is 8 for dekstop, 24 for android for padding
                                left: 48,
                                top: 4,
                                bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                    // visible: cobasoal.salah1,
                                    visible: datasoal['salah1'],
                                    replacement: const SizedBox(width: 0),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.close),
                                    )),
                                Visibility(
                                    replacement: const SizedBox(width: 0),
                                    // visible: cobasoal.salah2,
                                    visible: datasoal['salah2'],
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.close),
                                    )),
                                Visibility(
                                    replacement: const SizedBox(width: 0),
                                    // visible: cobasoal.salah3,
                                    visible: datasoal['salah3'],
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.close),
                                    )),
                                Visibility(
                                    replacement: const SizedBox(width: 0),
                                    // visible: cobasoal.jwbbenar,
                                    visible: datasoal['jwbbenar'],
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.check),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Visibility(
                              // visible: cobasoal.isTampilButton,
                              visible: datasoal['isTampilButton'],
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: // this GestureDetector is custom Button jawab, this pretty long bro..
                                    GestureDetector(
                                  onTap: () {
                                    odatalistkata.checkIniHive(
                                        odatalistkata.controllers[index].text,
                                        datasoal['katakata'],
                                        index,
                                        odatalistkata.controllers[index]);
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
                                          'Jawab',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    title: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 45,
                          // height: double,
                          child: GestureDetector(
                            onTap: () {
                              odatalistkata.berbicara(datasoal['katakata']);
                            },
                            child: ClipRRect(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    )),
                                child: Image.asset(
                                  'assets/speakman.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                                height: 45,
                                child: TextField(
                                  // onChanged for user only input oneword without space
                                  onChanged: (value) {
                                    if (value.split(' ').length > 1) {
                                      odatalistkata.controllers[index].text =
                                          value.split(' ')[0];
                                    }
                                  },
                                  readOnly: datasoal['salah3']
                                      ? true
                                      : datasoal['jwbbenar'],
                                  controller: odatalistkata.controllers[index],
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: datasoal['jwbbenar']
                                          ? Colors.green[100]
                                          : datasoal['salah3']
                                              ? Colors.red[100]
                                              : Colors.yellow[50],
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.none)),
                                      hintText: "Isi jawaban",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 8)),
                                ))),
                      ],
                    )
                    // Text(odatalistkata.katakata[index].toString()),
                    );
              }),
            ));
  }
}
