// ignore_for_file: avoid_print

import 'package:api_projects/Api_dictionary/DictionaryModel.dart';
import 'package:api_projects/Api_dictionary/services.dart';
import 'package:flutter/material.dart';

class DictionaryHomePage extends StatefulWidget {
  const DictionaryHomePage({super.key});

  @override
  State<DictionaryHomePage> createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  DictionaryModel? mymodel;
  String message = "Start by searching for a word.";
  bool isloading = false;

  Future<void> searchWord(String word) async {
    setState(() {
      isloading = true;
      message = "Searching...";
    });
    try {
      mymodel = await Apiservices.getdata(word);
      if (mymodel == null || mymodel!.meanings.isEmpty) {
        message = "No meaning found for the word \"$word\".";
      }
    } catch (e) {
      mymodel = null;
      message = "An error occurred: ${e.toString()}";
      print(e.toString());
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffd1c7bd),
        appBar: AppBar(
          title: const Text("Dictionary"),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: Color(0xffc7b7a3),
              fontSize: 30,
              fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xff561c24),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SearchBar(
                leading: const Icon(
                  Icons.book,
                  color: Color(0xffc7b7a3),
                  size: 35,
                ),
                textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 20, color: Color(0xffc7b7a3))),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xff561c24)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                hintText: "Search the meaning of a word",
                onSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    searchWord(value);
                  } else {
                    setState(() {
                      message = "Please enter a word to search.";
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              if (isloading)
                const LinearProgressIndicator(
                  backgroundColor: Color(0xffac9c8d),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff561c24)),
                )
              else if (mymodel == null)
                Expanded(
                  child: Center(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xff561c24),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "${mymodel!.word} :",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xff561c24),
                          ),
                        ),
                        Text(
                          mymodel!.phonetics.isNotEmpty
                              ? mymodel!.phonetics[0].text ?? ""
                              : "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mymodel!.meanings.length,
                          itemBuilder: (context, i) {
                            return showMeaning(mymodel!.meanings[i]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showMeaning(Meaning meaning) {
    String wordDefinition = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefinition += "\n${index + 1}. ${element.definition}\n";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: const Color(0xffc7b7a3),
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  meaning.partOfSpeech,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xff561c24),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Definitions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff322d29)),
                ),
              ),
              Text(
                wordDefinition,
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
