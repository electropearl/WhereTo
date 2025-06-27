import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_widget.dart' show FilterWidget;
import 'package:flutter/material.dart';

class FilterModel extends FlutterFlowModel<FilterWidget> {
  ///  Local state fields for this component.

  List<String> vibeFilter = [];
  void addToVibeFilter(String item) => vibeFilter.add(item);
  void removeFromVibeFilter(String item) => vibeFilter.remove(item);
  void removeAtIndexFromVibeFilter(int index) => vibeFilter.removeAt(index);
  void insertAtIndexInVibeFilter(int index, String item) =>
      vibeFilter.insert(index, item);
  void updateVibeFilterAtIndex(int index, Function(String) updateFn) =>
      vibeFilter[index] = updateFn(vibeFilter[index]);

  List<String> venueFilter = [];
  void addToVenueFilter(String item) => venueFilter.add(item);
  void removeFromVenueFilter(String item) => venueFilter.remove(item);
  void removeAtIndexFromVenueFilter(int index) => venueFilter.removeAt(index);
  void insertAtIndexInVenueFilter(int index, String item) =>
      venueFilter.insert(index, item);
  void updateVenueFilterAtIndex(int index, Function(String) updateFn) =>
      venueFilter[index] = updateFn(venueFilter[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  List<String>? get choiceChipsValues1 => choiceChipsValueController1?.value;
  set choiceChipsValues1(List<String>? val) =>
      choiceChipsValueController1?.value = val;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  List<String>? get choiceChipsValues2 => choiceChipsValueController2?.value;
  set choiceChipsValues2(List<String>? val) =>
      choiceChipsValueController2?.value = val;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
