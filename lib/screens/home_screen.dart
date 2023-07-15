import 'package:dac_test/controller/controller.dart';
import 'package:dac_test/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/contacts.dart';
import 'add_contact.dart';
import 'widgets/more_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = TextEditingController();
    List<Contact> contacts = [];
    Controller controller = Controller();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                onTap: () {
                  Navigator.pushNamed(context, '/searchPage');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: controller.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    } else {
                      contacts = snapshot.data;
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: contacts
                              .map((ct) => ContactCard(contact: ct))
                              .toList());
                    }
                  })
            ],
          ),
        ),
      ),
      //button for adding contact
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContact()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  const ContactCard({
    super.key,
    required this.contact,
  });
  final Contact contact;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool moreInfo = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        contact: widget.contact,
                      )),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //profil picture, name and dropdown row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: Colors.black,
                      image: DecorationImage(
                          image: FadeInImage.assetNetwork(
                            image: widget.contact.pictureLink,
                            placeholder: 'assets/images/account_circle.png',
                            fit: BoxFit.fill,
                            placeholderFit: BoxFit.fill,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/images/account_circle.png');
                            },
                          ).image,
                          fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //user name
                  SizedBox(
                    width: (width * 50) / 100,
                    child: Text(
                      "${widget.contact.first} ${widget.contact.last}",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  //allowing more information or less using a dropdown or dropup
                  moreInfo
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              moreInfo = false;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_up,
                            size: 40,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              moreInfo = true;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // adresse and phone number
              moreInfo
                  ? MoreInformation(
                      contact: widget.contact,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
