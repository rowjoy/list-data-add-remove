// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print, unrelated_type_equality_checks, unnecessary_string_interpolations, sized_box_for_whitespace, iterable_contains_unrelated_type, list_remove_unrelated_type

import 'package:carousel_slider/carousel_slider.dart';
import 'package:contactlis/contactmodel.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class Contactlist extends StatefulWidget {
  static const String path = "Contactlist";
  const Contactlist({Key? key}) : super(key: key);

  @override
  _ContactlistState createState() => _ContactlistState();
}

class _ContactlistState extends State<Contactlist> {
  List<Contact> contacts = [];
  List<Contact> contactsfiltted = [];
  List<ContactModel> selectedcontact = [];
  List<Contact> newlist = [];
  bool isselected = false;
  TextEditingController searchcontroller = TextEditingController();

  getcontact() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: true)).toList();
    setState(() {
      contacts = _contacts;
    });
    print(_contacts.length);
  }

  filterContacts() {
    List<Contact> _contact = [];
    _contact.addAll(contacts);
    if (searchcontroller.text.isNotEmpty) {
      _contact.retainWhere((contact) {
        String searchtrem = searchcontroller.text.toLowerCase();
        String contactname = contact.displayName!.toLowerCase();
        return contactname.contains(searchtrem);
      });
      setState(() {
        contactsfiltted = _contact;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getcontact();
    searchcontroller.addListener(() {
      filterContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool issearch = searchcontroller.text.isNotEmpty;
    print(newlist);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: CarouselSlider(
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    for (int i = 0; i < newlist.length; i++)
                      Container(
                        margin: EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: ListTile(
                            title: Text('${newlist[i].runtimeType}'),
                            subtitle: Text('${newlist[i].runtimeType}'),
                          ),
                        ),
                      ),
                  ],
                  options: CarouselOptions(
                    height: 92.0,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 5),
                  child: TextFormField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        hintText: 'Search number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: issearch == true
                        ? contactsfiltted.length
                        : contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Contact contact = issearch == true
                          ? contactsfiltted[index]
                          : contacts[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ListTile(
                            //selectedcontact ?? listtile a click korla data add hoba and aber click korla data remove hoba
                            onTap: () {
                              setState(() {
                                if (newlist.contains(contact)) {
                                  newlist.remove(contact);
                                } else {
                                  newlist.add(contact);
                                }
                              });
                            },

                            tileColor: Colors.black.withOpacity(0.5),
                            title: Text('${contact.displayName}'),
                            subtitle:
                                Text('${contact.phones!.elementAt(0).value}'),
                            trailing: newlist.contains(contact)
                                ? Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.check_box_outline_blank),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
