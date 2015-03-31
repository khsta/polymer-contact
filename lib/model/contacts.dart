part of web_links;

class Contact implements Comparable {
  String name;
  String email;
  String adress;

  Contact(this.name, this.email, this.adress) {
   
  }

  Contact.fromJson(Map<String, Object> contactMap) {
    name = contactMap['name'];
    email=contactMap['email'];
    adress=contactMap['adress'];
  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['name'] = name;
    contactMap['email'] = email;
    contactMap['adress'] = adress;
    return contactMap;
  }

 
  
  /**
   * Compares two links based on their names.
   * If the result is less than 0 then the first link is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact contact) {
    if (email != null && contact.email != null) {
      return email.compareTo(contact.email);
    } else {
      throw new Exception('email absent');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  init() {
    var c1 = new Contact('khaoula', 'k@la.ca','exchange');
      this..add(c1);
  }
  
  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in _list) {
      if (newContact.email == contact.email) return false;
    }
    _list.add(newContact);
    return true;
  }


  Contact find(String email) {
    for (Contact contact in _list) {
      if (contact.email == email) return contact;
    }
    return null;
  }

  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
  
  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in _list) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!_list.isEmpty) {
      throw new Exception('contacts are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      add(contact);
    }
  }
}
