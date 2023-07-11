import 'package:dio/dio.dart';

import '../constants.dart';
import '../main.dart';
import '../models/contacts.dart';

class Controller {
  final dio = Dio();

  Future fetchData() async {
    Response response;
    List<Contact> listContact = [];
    int? dbsize = await dbhelper.size(database);
    if (dbsize! > 0) {
      listContact = await dbhelper.getContact(database);

      return listContact;
    } else {
      response = await dio.get(Constants.apipath);
      if (response.statusCode == 200) {
        int id = 0;
        for (var contact in response.data['results']) {
          Contact ct = Contact(
              first: contact['name']['first'],
              last: contact['name']['last'],
              birthDate: contact['dob']['date'],
              email: contact['email'],
              id: id,
              country: contact['location']['country'],
              state: contact['location']['state'],
              city: contact['location']['city'],
              streetName: contact['location']['street']['name'],
              streetNumber: contact['location']['street']['number'],
              phone: contact['phone'],
              pictureLink: contact['picture']['medium']);

          await dbhelper.insertContact(ct, database);
          id++;
        }

        listContact = await dbhelper.getContact(database);

        return listContact;
      } else {
        throw Exception('Failed to fetch contacts');
      }
    }
  }
}
