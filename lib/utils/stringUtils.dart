import 'package:gcc_parking/models/parking_slot.dart';

String fetchSlotStatus(SlotStatus slotStatus) {
  return slotStatus.toString().split('.').last;
}
