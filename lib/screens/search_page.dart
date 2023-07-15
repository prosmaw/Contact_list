import 'package:flutter/material.dart';

import '../controller/controller.dart';

import '../models/contacts.dart';
import 'home_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchBarController = TextEditingController();
  String query = "";
  Controller controller = Controller();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    searchBarController.text = query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                controller: searchBarController,
                leading: const Icon(Icons.search),
                hintText: "Rechercher un contact",
                shadowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent),
                padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.only(left: 16, right: 16)),
                onChanged: (value) async {
                  setState(() {
                    query = value;
                  });
                  contacts = await controller.researching(query);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      contacts.map((ct) => ContactCard(contact: ct)).toList()),
            ],
          ),
        ),
      )),
    );
  }
}
