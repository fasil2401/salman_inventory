

import 'dart:convert';

UserLocationListModel UserLocationListModelFromJson(String str) => UserLocationListModel.fromJson(json.decode(str));

String userLocationListModelToJson(UserLocationListModel data) => json.encode(data.toJson());

class UserLocationListModel {
    UserLocationListModel({
        this.res,
        this.model,
    });

    int? res;
    List<UserLocationModel>? model;

    factory UserLocationListModel.fromJson(Map<String, dynamic> json) => UserLocationListModel(
        res: json["res"],
        model:json["model"] == null ? []: List<UserLocationModel>.from(json["model"].map((x) => UserLocationModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "res": res,
        "model":model == null ? []: List<dynamic>.from(model!.map((x) => x.toJson())),
    };
}

class UserLocationModel {
    UserLocationModel({
        this.code,
        this.name,
        this.isConsignOutLocation,
        this.isConsignInLocation,
        this.isposLocation,
        this.isWarehouse,
    });

    String? code;
    String? name;
    dynamic isConsignOutLocation;
    dynamic isConsignInLocation;
    int? isposLocation;
    int? isWarehouse;

    factory UserLocationModel.fromJson(Map<String, dynamic> json) => UserLocationModel(
        code: json["Code"],
        name: json["Name"],
        isConsignOutLocation: json["IsConsignOutLocation"],
        isConsignInLocation: json["IsConsignInLocation"],
        isposLocation: json["ISPOSLocation"] == true ? 1 : 0,
        isWarehouse: json["IsWarehouse"] == true ? 1 : 0,
    );

    Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "IsConsignOutLocation": isConsignOutLocation,
        "IsConsignInLocation": isConsignInLocation,
        "ISPOSLocation": isposLocation,
        "IsWarehouse": isWarehouse,
    };
}
