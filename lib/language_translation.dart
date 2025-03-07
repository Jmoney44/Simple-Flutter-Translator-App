import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = [
    'Igbo',
    'English',
    'Hausa',
    'Yoruba',
    'Itsekiri',
    'Urhobo',
    'Benin',
    'Ijaw'
  ];
  var originLangauge = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == "Igbo") {
      return "ig";
    } else if (language == "Yoruba") {
      return "yo";
    } else if (language == "Hausa") {
      return "ha";
    } else if (language == "Itsekiri") {
      return "its";
    } else if (language == "Urhobo") {
      return "urh";
    } else if (language == "Benin") {
      return "bin";
    } else if (language == "Ijaw") {
      return "ijo";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text("DALA Translator"),
        centerTitle: true,
        backgroundColor: const Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLangauge,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLangauge = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Please enter your text..',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2b3c5a)),
                    onPressed: () {
                      translate(
                          getLanguageCode(originLangauge),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString());
                    },
                    child: const Text("Translate")),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\n$output",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
