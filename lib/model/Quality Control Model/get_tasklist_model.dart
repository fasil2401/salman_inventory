
import 'dart:convert';

GetTaskListModel getTaskListModelFromJson(String str) => GetTaskListModel.fromJson(json.decode(str));

String getTaskListModelToJson(GetTaskListModel data) => json.encode(data.toJson());

class GetTaskListModel {
    GetTaskListModel({
        this.result,
        this.modelobject,
    });

    int? result;
    List<TaskListModel>? modelobject;

    factory GetTaskListModel.fromJson(Map<String, dynamic> json) => GetTaskListModel(
        result: json["result"],
        modelobject: json["Modelobject"] == null ? [] : List<TaskListModel>.from(json["Modelobject"]!.map((x) => TaskListModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "Modelobject": modelobject == null ? [] : List<dynamic>.from(modelobject!.map((x) => x.toJson())),
    };
}

class TaskListModel {
    TaskListModel({
        this.taskCode,
        this.container,
        this.vendorId,
        this.vendor,
        this.grnDocId,
        this.grnNumber,
        this.description,
    });

    String? taskCode;
    String? container;
    String? vendorId;
    String? vendor;
    String? grnDocId;
    String? grnNumber;
    String? description;

    factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        taskCode: json["Task Code"],
        container: json["Container#"],
        vendorId: json["VendorID"],
        vendor: json["Vendor"],
        grnDocId: json["GRN DocID"],
        grnNumber: json["GRN Number"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "Task Code": taskCode,
        "Container#": container,
        "VendorID": vendorId,
        "Vendor": vendor,
        "GRN DocID": grnDocId,
        "GRN Number": grnNumber,
        "Description": description,
    };
}
