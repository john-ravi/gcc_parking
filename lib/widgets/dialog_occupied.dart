import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gcc_parking/models/parking_slot.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:gcc_parking/utils/networkUtils.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import 'package:gcc_parking/utils/visualUtils.dart';

class DialogOccupied extends StatefulWidget {
  final ParkingSlot parkingSlot;

  DialogOccupied(this.parkingSlot);

  @override
  _DialogOccupiedState createState() => _DialogOccupiedState(parkingSlot);
}

class _DialogOccupiedState extends State<DialogOccupied> {
  ParkingSlot parkingSlot;

  _DialogOccupiedState(this.parkingSlot);

  List<SlotStatus> listFilteredStatus;

  final shareWidget = GlobalKey();
  final previewContainer = GlobalKey();
  final textStyle = TextStyle(fontSize: 11.0);
  var controllerComments = new TextEditingController();

  @override
  void initState() {
    List<SlotStatus> list = SlotStatus.values;
    listFilteredStatus = list.toList(growable: true);
    listFilteredStatus.removeWhere((slotStatus) =>
        slotStatus == SlotStatus.pending ||
        slotStatus == SlotStatus.inactive ||
        slotStatus == SlotStatus.reserved);
    print('removed pending list $listFilteredStatus');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var format = dateFormat.format(parkingSlot.dateTimeStart);
    print('Formatted Date $format');
    var format2 = dateFormat.format(parkingSlot.dateTimeEnd);
    print('Formatted Date End $format2');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListBody(
          children: <Widget>[
            RepaintBoundary(
              key: previewContainer,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        //         color: Colors.redAccent,
                        width: 48.0,
                        height: 48.0,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/images/logo.png')))),
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            "Parking Reciept",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Promotional Offer!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Area:",
                              style: textStyle,
                            ),
                            Text(
                              " ${parkingSlot.location}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Lot:",
                              style: textStyle,
                            ),
                            Text(
                              " ${parkingSlot.lot}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Slot:",
                              style: textStyle,
                            ),
                            Text(
                              " ${parkingSlot.slotName}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Vehicle:",
                              style: textStyle,
                            ),
                            Text(
                              " ${parkingSlot.vehicle.vehiclePlateNumber}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Type: ",
                              style: textStyle,
                            ),
                            Text(
                              " Car",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Date: ",
                              style: textStyle,
                            ),
                            Text(
                              " ${dateFormat.format(DateTime.now())}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Time In: ",
                              style: textStyle,
                            ),
                            Text(
                              " ${format ?? ''}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Time Out: ",
                              style: textStyle,
                            ),
                            Text(
                              " ${format2 ?? ''}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Tariff",
                              style: textStyle,
                            ),
                            Text(
                              " Rs.${00.00}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "GST:",
                              style: textStyle,
                            ),
                            Text(
                              "00.00",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              "Total:",
                              style: textStyle,
                            )),
                            Flexible(
                                child: Text(
                              "00.00",
                              style: textStyle,
                            )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(labelText: 'Slot Status'),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<SlotStatus>(
                        isExpanded: true,
                        //enum SlotStatus { occupied, vacant, inactive, pending }
                        value: parkingSlot.slotStatus,
                        items: listFilteredStatus.map((SlotStatus value) {
                          return new DropdownMenuItem<SlotStatus>(
                            value: value,
                            child: new Text(
                              value.toString().split('.').last,
                              style: textStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (test) {
                          print("onChanged to $test");

                          parkingSlot.slotStatus = test;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            parkingSlot.slotStatus == SlotStatus.immobilized
                ? Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Comments'),
                          maxLines: 3,
                          controller: controllerComments,
                        ),
                      ),
                    ],
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (parkingSlot.slotStatus == SlotStatus.vacant) {
                          showloader(context);
                          var parkingSlotReturned =
                              await vacateSlot(parkingSlot, '');
                          removeloader();
                          if (parkingSlotReturned.vehicle.boolModelModified) {
                            parkingSlot = parkingSlotReturned;
                          }
                        } else if (parkingSlot.slotStatus ==
                            SlotStatus.immobilized) {
                          if (controllerComments.text.isNotEmpty) {
                            showloader(context);
                            if (await immobilizeVehicle(
                                parkingSlot, controllerComments.text)) {
                              showToast('Vehicle immobilised');
                              parkingSlot.vehicle.boolModelModified = true;
                            }
                            removeloader();
                            Navigator.of(context).pop(parkingSlot);
                          } else {
                            showToast('Comments cannot be empty');
                          }
                        }
                      },
                      child: Text(
                        'UPDATE',
                        style: textStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        _printScreen();
                      },
                      child: Text(
                        'Print/Pdf',
                        style: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _printScreen() async {
    const margin = 10.0 * PdfPageFormat.mm;
    final pdf = PdfDocument(deflate: zlib.encode);
    final page = PdfPage(pdf, pageFormat: PdfPageFormat.a4);
    final g = page.getGraphics();

    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    final im = await boundary.toImage();
    final bytes = await im.toByteData(format: ImageByteFormat.rawRgba);
    print("Print Screen ${im.width}x${im.height} ...");

    // Center the image
    final w = page.pageFormat.width - margin * 2.0;
    final h = page.pageFormat.height - margin * 2.0;
    double iw, ih;
    if (im.width.toDouble() / im.height.toDouble() < 1.0) {
      ih = h;
      iw = im.width.toDouble() * ih / im.height.toDouble();
    } else {
      iw = w;
      ih = im.height.toDouble() * iw / im.width.toDouble();
    }

    PdfImage image = PdfImage(pdf,
        image: bytes.buffer.asUint8List(), width: im.width, height: im.height);
    g.drawImage(image, margin + (w - iw) / 2.0,
        page.pageFormat.height - margin - ih - (h - ih) / 2.0, iw, ih);

    Printing.printPdf(document: pdf);
  }
}
