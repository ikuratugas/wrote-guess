import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {
  const PageAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/thankyou.gif',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                )),
          ),
          const Center(
            child: SizedBox(
              width: 250,
              child: Text(
                "Semoga dapat membantumu untuk belajar pendengaran serta penulisan yang benar dalam bahasa inggris.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 250,
              child: Text(
                "note by Ikura",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    backgroundColor: Colors.yellow[200]),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
