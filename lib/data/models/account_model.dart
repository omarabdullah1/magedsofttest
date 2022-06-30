class AccountModel {
  int? status;
  List<Account>? account;

  AccountModel({this.status, this.account});

  AccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['account'] != null) {
      account = <Account>[];
      json['account'].forEach((v) {
        account!.add(Account.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (account != null) {
      data['account'] = account!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  int? id;
  String? name;
  String? email;
  String? phone;


  Account(
      {
        this.id,
        this.name,
        this.email,
        this.phone,

      });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
