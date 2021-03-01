// To parse this JSON data, do
//
//     final clientBasicModel = clientBasicModelFromJson(jsonString);

import 'dart:convert';

ClientBasicModel clientBasicModelFromJson(String str) => ClientBasicModel.fromJson(json.decode(str));

String clientBasicModelToJson(ClientBasicModel data) => json.encode(data.toJson());

class ClientBasicModel {
  ClientBasicModel({
    this.clientId,
    this.name,
    this.contactMethodEmail,
    this.contactMethodEmailPk,
    this.contactMethodPhoneHome,
    this.contactMethodPhoneHomePk,
    this.contactMethodPhoneWork,
    this.contactMethodPhoneWorkPk,
    this.contactMethodMobile,
    this.contactMethodMobilePk,
    this.addressPhysicalFormatted,
    this.addressPhysical,
    this.addressPhysicalPk,
    this.addressPostalFormatted,
    this.addressPostal,
    this.addressPostalPk,
    this.dateOfBirth,
    this.gender,
  });

  String clientId;
  String name;
  String contactMethodEmail;
  int contactMethodEmailPk;
  dynamic contactMethodPhoneHome;
  dynamic contactMethodPhoneHomePk;
  String contactMethodPhoneWork;
  int contactMethodPhoneWorkPk;
  String contactMethodMobile;
  int contactMethodMobilePk;
  dynamic addressPhysicalFormatted;
  dynamic addressPhysical;
  dynamic addressPhysicalPk;
  dynamic addressPostalFormatted;
  dynamic addressPostal;
  dynamic addressPostalPk;
  DateTime dateOfBirth;
  String gender;

  factory ClientBasicModel.fromJson(Map<String, dynamic> json) => ClientBasicModel(
    clientId: json["ClientId"],
    name: json["Name"],
    contactMethodEmail: json["ContactMethodEmail"],
    contactMethodEmailPk: json["ContactMethodEmailPk"],
    contactMethodPhoneHome: json["ContactMethodPhoneHome"],
    contactMethodPhoneHomePk: json["ContactMethodPhoneHomePk"],
    contactMethodPhoneWork: json["ContactMethodPhoneWork"],
    contactMethodPhoneWorkPk: json["ContactMethodPhoneWorkPk"],
    contactMethodMobile: json["ContactMethodMobile"],
    contactMethodMobilePk: json["ContactMethodMobilePk"],
    addressPhysicalFormatted: json["AddressPhysicalFormatted"],
    addressPhysical: json["AddressPhysical"],
    addressPhysicalPk: json["AddressPhysicalPk"],
    addressPostalFormatted: json["AddressPostalFormatted"],
    addressPostal: json["AddressPostal"],
    addressPostalPk: json["AddressPostalPk"],
    dateOfBirth: DateTime.parse(json["DateOfBirth"]),
    gender: json["Gender"],
  );

  Map<String, dynamic> toJson() => {
    "ClientId": clientId,
    "Name": name,
    "ContactMethodEmail": contactMethodEmail,
    "ContactMethodEmailPk": contactMethodEmailPk,
    "ContactMethodPhoneHome": contactMethodPhoneHome,
    "ContactMethodPhoneHomePk": contactMethodPhoneHomePk,
    "ContactMethodPhoneWork": contactMethodPhoneWork,
    "ContactMethodPhoneWorkPk": contactMethodPhoneWorkPk,
    "ContactMethodMobile": contactMethodMobile,
    "ContactMethodMobilePk": contactMethodMobilePk,
    "AddressPhysicalFormatted": addressPhysicalFormatted,
    "AddressPhysical": addressPhysical,
    "AddressPhysicalPk": addressPhysicalPk,
    "AddressPostalFormatted": addressPostalFormatted,
    "AddressPostal": addressPostal,
    "AddressPostalPk": addressPostalPk,
    "DateOfBirth": dateOfBirth.toIso8601String(),
    "Gender": gender,
  };

  factory ClientBasicModel.fromMap(Map < String, dynamic > json) => ClientBasicModel(
    clientId: json["ClientId"],
    name: json["Name"],
    contactMethodEmail: json["ContactMethodEmail"],
    contactMethodEmailPk: json["ContactMethodEmailPk"],
    contactMethodPhoneHome: json["ContactMethodPhoneHome"],
    contactMethodPhoneHomePk: json["ContactMethodPhoneHomePk"],
    contactMethodPhoneWork: json["ContactMethodPhoneWork"],
    contactMethodPhoneWorkPk: json["ContactMethodPhoneWorkPk"],
    contactMethodMobile: json["ContactMethodMobile"],
    contactMethodMobilePk: json["ContactMethodMobilePk"],
    addressPhysicalFormatted: json["AddressPhysicalFormatted"],
    addressPhysical: json["AddressPhysical"],
    addressPhysicalPk: json["AddressPhysicalPk"],
    addressPostalFormatted: json["AddressPostalFormatted"],
    addressPostal: json["AddressPostal"],
    addressPostalPk: json["AddressPostalPk"],
    dateOfBirth: DateTime.parse(json["DateOfBirth"]),
    gender: json["Gender"],
  );

  Map < String, dynamic > toMap() => {
    "ClientId": clientId,
    "Name": name,
    "ContactMethodEmail": contactMethodEmail,
    "ContactMethodEmailPk": contactMethodEmailPk,
    "ContactMethodPhoneHome": contactMethodPhoneHome,
    "ContactMethodPhoneHomePk": contactMethodPhoneHomePk,
    "ContactMethodPhoneWork": contactMethodPhoneWork,
    "ContactMethodPhoneWorkPk": contactMethodPhoneWorkPk,
    "ContactMethodMobile": contactMethodMobile,
    "ContactMethodMobilePk": contactMethodMobilePk,
    "AddressPhysicalFormatted": addressPhysicalFormatted,
    "AddressPhysical": addressPhysical,
    "AddressPhysicalPk": addressPhysicalPk,
    "AddressPostalFormatted": addressPostalFormatted,
    "AddressPostal": addressPostal,
    "AddressPostalPk": addressPostalPk,
    "DateOfBirth": dateOfBirth.toIso8601String(),
    "Gender": gender,
  };
}
