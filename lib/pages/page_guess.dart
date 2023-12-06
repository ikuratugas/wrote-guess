import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrote_guess/components/component_checkanswer.dart';
import 'package:wrote_guess/logic/logic_data.dart';
import 'package:wrote_guess/pages/page_change.dart';

class PageGuess extends StatelessWidget {
  const PageGuess({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OdataListKata>(builder: (_, odatalistkata, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              "Score: ${odatalistkata.scoreBenar}/${odatalistkata.scoreTotal}"),
          actions: [
            Visibility(
              visible: odatalistkata.isStartButton,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      odatalistkata.changeValueStartButton();
                      odatalistkata.refreshData();
                      odatalistkata.resetListDataSoalHive();
                    },
                    child: const Text("Mulai"),
                  ),
                  // -----------------------------------------
                ),
              ),
            ),
            Visibility(
              visible: !odatalistkata.isStartButton,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: const Icon(Icons.restart_alt_outlined),
                    iconSize: 24,
                    onPressed: () {
                      odatalistkata.resetListDataSoalHive();
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !odatalistkata.isStartButton,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: const Icon(Icons.shuffle_outlined),
                    iconSize: 24,
                    onPressed: () {
                      odatalistkata.shuffleListHive();
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !odatalistkata.isStartButton,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                    icon: const Icon(Icons.edit_note_sharp),
                    iconSize: 32,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageChange()));
                      odatalistkata.resetListDataSoalHive();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const CheckAnswer(),
      );
    });
  }
}
