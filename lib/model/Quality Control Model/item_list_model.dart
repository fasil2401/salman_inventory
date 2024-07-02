import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/attachment_model.dart';
import 'package:axolon_inventory_manager/model/common_combo_list_model.dart';

class ItemListModel {
  ItemListModel(
      {required this.itemId,
      this.commodit,
      this.variety,
      this.brand,
      this.waste,
      this.grade,
      this.size,
      this.count,
      this.lotNo,
      this.grower,
      this.stWeight,
      this.bruis,
      this.progress,
      this.cosmetic,
      this.weight,
      this.brix,
      this.pressure,
      this.remarks,
      this.files});

  String itemId;
  CommonComboModel? commodit;
  CommonComboModel? variety;
  CommonComboModel? brand;
  dynamic waste;
  String? grade;
  String? size;
  dynamic count;
  String? lotNo;
  String? grower;
  dynamic stWeight;
  dynamic bruis;
  dynamic progress;
  dynamic cosmetic;
  dynamic weight;
  dynamic brix;
  dynamic pressure;
  String? remarks;
  List<AttachmentModel>? files;
}
