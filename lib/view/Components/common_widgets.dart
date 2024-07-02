import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CommonWidgets {
  static Widget elevatedButton(BuildContext context,
      {required Function() onTap,
      String? text,
      required ButtonTypes type,
      bool isDisabled = false,
      bool isLoading = false}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? AppColors.lightGrey
                : type == ButtonTypes.Primary
                    ? Theme.of(context).primaryColor
                    : type == ButtonTypes.Secondary
                        ? Theme.of(context).backgroundColor
                        : Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: type == ButtonTypes.Outlined ? 1.0 : 0.0,
                    color: type == ButtonTypes.Outlined
                        ? Theme.of(context).primaryColor
                        : Colors.white),
                borderRadius: BorderRadius.circular(8))),
        onPressed: isDisabled ? null : onTap,
        child: isLoading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    type == ButtonTypes.Primary
                        ? Colors.white
                        : type == ButtonTypes.Secondary
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor,
                  ),
                ))
            : Text(
                '$text',
                style: TextStyle(
                  color: isDisabled
                      ? mutedColor
                      : type == ButtonTypes.Primary
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                ),
              ));
  }

  static Widget popShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "",
              style: TextStyle(
                color: mutedColor,
              ),
            ),
          ));
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 5,
        ),
      ),
    );
  }

  static Widget textField(BuildContext context,
          {Function()? ontap,
          Function(String)? onChanged,
          String? filterId,
          String? label,
          int? maxLines,
          int? maxLength,
          bool isTextNotAllowed = false,
          bool isEnabled = true,
          bool filled = true,
          bool autofocus = true,
          bool expands = false,
          FocusNode? focus,
          TextEditingController? controller,
          IconData? icon,
          required bool suffixicon,
          required bool readonly,
          Function(dynamic)? onchanged,
          required TextInputType keyboardtype}) =>
      SizedBox(
        // height: 35.0,
        child: TextField(
          expands: expands,
          maxLines: expands ? null : maxLines ?? 1,
          controller: controller,
          enabled: isEnabled,
          readOnly: readonly,
          focusNode: focus,
          autofocus: autofocus,
          onTap: ontap,
          onChanged: onchanged,
          maxLength: maxLength,
          keyboardType:
              maxLines != null ? TextInputType.multiline : keyboardtype,
          textInputAction:
              maxLines != null ? TextInputAction.newline : TextInputAction.done,
          inputFormatters: keyboardtype ==
                  TextInputType.numberWithOptions(decimal: false)
              ? [
                  FilteringTextInputFormatter.deny(RegExp('[\\.,]')),
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ]
              : keyboardtype ==
                          TextInputType.numberWithOptions(decimal: true) ||
                      keyboardtype == TextInputType.number
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ]
                  : isTextNotAllowed
                      ? [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9,.\-_/]+$')),
                        ]
                      : [],
          style: TextStyle(fontSize: 12, color: mutedColor),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            isCollapsed: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mutedColor, width: 0.1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mutedColor, width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mutedColor, width: 0.1),
            ),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
            suffixIcon: suffixicon == true
                ? Icon(
                    icon != null ? icon : Icons.arrow_drop_down_circle_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 15,
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            suffixIconConstraints:
                BoxConstraints.tightFor(height: 30, width: 30),
          ),
        ),
      );

  static Widget dropDown(BuildContext context,
      {String? title,
      required dynamic selectedValue,
      required List<dynamic> values,
      required Function(dynamic) onChanged,
      bool isName = true}) {
    return DropdownButtonFormField2(
      isDense: true,
      alignment: Alignment.centerLeft,
      value: values.firstWhere((element) => element == selectedValue),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: mutedColor, width: 0.1),
        ),
        labelText: title,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        ),
        // suffixIcon: Icon(
        //   Icons.arrow_drop_down_circle_outlined,
        //   color: Theme.of(context).primaryColor,
        //   size: 15,
        // ),
        // suffixIconConstraints: BoxConstraints.tightFor(height: 30, width: 30),
      ),
      isExpanded: true,
      iconStyleData: IconStyleData(
          icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Theme.of(context).primaryColor,
        size: 15,
      )),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      )),
      // buttonPadding: const EdgeInsets.only(left: 0, right: 0),

      items: values
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: AutoSizeText(
                isName ? '${item.name}' : '${item}',
                minFontSize: 10,
                maxFontSize: 14,
                maxLines: 1,
                style: const TextStyle(
                  color: mutedColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      onSaved: (value) {},
    );
  }

  static common4TabHeader(
    BuildContext context,
    String firstHead,
    String secondHead,
    String thirdHead,
    String fourthHead,
    int flex1,
    int flex2, {
    String fifthHead = '',
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                firstHead,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                secondHead,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                thirdHead,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: flex2,
              child: Center(
                child: Text(
                  fourthHead,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (fifthHead.isNotEmpty)
              Expanded(
                flex: flex2,
                child: Center(
                  child: Text(
                    fifthHead,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static commonDialog(BuildContext context, String title, Widget content,
      {List<Widget>? actions, Function()? ontapOfClose}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.all(10),
          actions: actions != null && actions.isNotEmpty ? actions : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: AppColors.mutedColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: ontapOfClose == null
                        ? () {
                            Navigator.pop(context);
                          }
                        : ontapOfClose,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.mutedColor,
                      child: Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: AppColors.lightGrey,
              ),
            ],
          ),
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: content),
        );
      },
    );
  }

  static commonDateFilter(
      BuildContext context,
      int dateIndex,
      bool isToDate,
      bool isFromDate,
      DateTime fromDate,
      DateTime toDate,
      Function(dynamic) onChangedOfDate,
      Function() selectDate) {
    return Column(
      children: [
        DropdownButtonFormField2(
          isDense: true,
          value: DateRangeSelector.dateRange[dateIndex],
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dates',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
            // contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.mutedColor)),
          ),
          isExpanded: true,
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.only(left: 20, right: 10),
          ),
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white)),
          items: DateRangeSelector.dateRange
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: onChangedOfDate,
          onSaved: (value) {},
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Flexible(
              child: textField(
                context,
                suffixicon: true,
                readonly: true,
                keyboardtype: TextInputType.datetime,
                controller: TextEditingController(
                  text: DateFormatter.dateFormat.format(fromDate).toString(),
                ),
                label: 'From Date',
                isEnabled: isFromDate,
                icon: Icons.calendar_month,
                ontap: selectDate,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: textField(
                context,
                suffixicon: true,
                readonly: true,
                keyboardtype: TextInputType.datetime,
                controller: TextEditingController(
                  text: DateFormatter.dateFormat.format(toDate).toString(),
                ),
                label: 'To Date',
                isEnabled: isToDate,
                icon: Icons.calendar_month,
                ontap: selectDate,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<DateTime?> getCalender(
      BuildContext context, DateTime initialDate) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.primary,
              surface: AppColors.white,
              onSurface: AppColors.primary,
            ),
            dialogBackgroundColor: AppColors.mutedBlueColor,
          ),
          child: child!,
        );
      },
    );
    return newDate;
  }

  static Widget buildPdfView(Uint8List bytes) {
    return PDFView(
      pdfData: bytes,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageSnap: false,
      pageFling: false,
      fitPolicy: FitPolicy.WIDTH,
    );
  }

  static InkWell commonListTile(
      {required BuildContext context,
      required String code,
      required String name,
      required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "$code - ",
                minFontSize: 10,
                maxFontSize: 12,
                style: TextStyle(
                  height: 1.5,
                  color: commonBlack,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  name,
                  minFontSize: 10,
                  maxFontSize: 12,
                  style: TextStyle(
                    height: 1.5,
                    color: mutedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
