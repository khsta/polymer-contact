import 'dart:convert';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:contacts/contacts.dart';

@CustomTag('contact-list')
class ContactList extends PolymerElement {
  @published Contacts contacts;
  InputElement name;
  InputElement email;
  InputElement adress;
  ContactList.created() : super.created();
  
  add(Event e, var detail, Node target) {
     name = shadowRoot.querySelector("#name");
     email = shadowRoot.querySelector("#email");
     adress = shadowRoot.querySelector("#adress");
    LabelElement message = shadowRoot.querySelector("#message");
    var error = false;
    message.text = '';
    if (name.value.trim() == '') {
      message.text = 'le nom est obligatoire; ${message.text}';
      error = true;
    }
    if (email.value.trim() == '') {
      message.text = 'email est obligatoire; ${message.text}';
      error = true;
    }
    if (adress.value.trim() == '') {
          message.text = 'adress est obligatoire; ${message.text}';
          error = true;
        }
    if (!error) {
      var contact = new Contact(name.value, email.value,adress.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
      } else {
        message.text = 'Contact avec cet email existe';
      }
    }
  }
  
  effacer(Event e, var detail, Node target) {
    
    
    String email = target.attributes['email-contact'];
  
    LabelElement message = shadowRoot.querySelector("#message");
    message.text = '';
    Contact contact = contacts.find(email);
    if (contact == null) {
      message.text = 'Contact avec cet email existe pas';
    } else {
      
      if (contacts.remove(contact)) {
        save();
      }
    }
  }
  modifiercontact(Event e, var detail, Node target) {
     email = shadowRoot.querySelector("#email");
     name = shadowRoot.querySelector("#name");
     adress= shadowRoot.querySelector("#adress");
      Contact newContact=new Contact(name.value,email.value, adress.value);
        LabelElement message = shadowRoot.querySelector("#message");
        message.text = '';
        Contact contact = contacts.find(email.value);
        if (contact == null) {
          message.text = 'Contact avec cet email existe pas';
        } else {
          
          if (contacts.remove(contact)) {
            contacts.add(newContact);
            save();
          }
        }
    
  }
  miseajour(Event e, var detail, Node target) {
     String email_contact = target.attributes['email-contact'];
     Contact contact = contacts.find(email_contact);
     name = shadowRoot.querySelector("#name");
     email = shadowRoot.querySelector("#email");
     adress = shadowRoot.querySelector("#adress");
      name.value = contact.name;
     email.value = contact.email;
     adress.value = contact.adress;
  }
  List<Map<String, Object>> toJson() {
    return contacts.toJson();
  }

  save() {
    window.localStorage['contacts'] = JSON.encode(toJson());
  }
  void modifier(email_modif) {
     if (newContact == null) {
       throw new Exception('fournir contact');
     }
  contacts.find(email_modif);
      
   }
}