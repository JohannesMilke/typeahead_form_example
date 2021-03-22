import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:typeahead_form_example/data/city_data.dart';
import 'package:typeahead_form_example/data/food_data.dart';
import 'package:typeahead_form_example/widget/button_widget.dart';

class FormTypeAheadPage extends StatefulWidget {
  @override
  _FormTypeAheadPageState createState() => _FormTypeAheadPageState();
}

class _FormTypeAheadPageState extends State<FormTypeAheadPage> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();

  String? selectedCity;
  String? selectedFood;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCity(),
                    SizedBox(height: 16),
                    buildFood(),
                    SizedBox(height: 12),
                    buildSubmit(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildCity() => TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerCity,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: CityData.getSuggestions,
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controllerCity.text = suggestion!,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a city' : null,
        onSaved: (value) => selectedCity = value,
      );

  Widget buildFood() => TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerFood,
          decoration: InputDecoration(
            labelText: 'Food',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: FoodData.getSuggestions,
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controllerFood.text = suggestion!,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a food' : null,
        onSaved: (value) => selectedFood = value,
      );

  Widget buildSubmit(BuildContext context) => ButtonWidget(
        text: 'Submit',
        onClicked: () {
          final form = formKey.currentState!;

          if (form.validate()) {
            form.save();

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                    'Your Favourite City is $selectedCity\nYour Favourite Food is $selectedFood'),
              ));
          }
        },
      );
}
