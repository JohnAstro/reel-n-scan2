import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String fishName;

  // This is the fishname when navigated from scan_screen
  HomePage(this.fishName);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _locationController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _speciesController;
  late final TextEditingController _weightController;
  late final TextEditingController _lengthController;
  late final TextEditingController _baitController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();

    // If navigated from scan_screen
    if (widget.fishName != "") {
      _speciesController = TextEditingController(text: widget.fishName);
    } else
      _speciesController = TextEditingController();

    _weightController = TextEditingController();
    _lengthController = TextEditingController();
    _baitController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _speciesController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _baitController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x000000),
      appBar: AppBar(
        title: Text(
          "New Catch Log",
          key: Key('new-catch-log-title'),
        ),
        backgroundColor: Color(0xff4C748B),
        leading: IconButton(
            key: Key('new-catch-log-back-button'),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LOCATION
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid =
                      RegExp(r"^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$").hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid location';
                  }
                  return null;
                },
              ),

              // DATE
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                  hintText: 'mm/dd/yyyy',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid =
                      RegExp(r"[0-9][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9]")
                          .hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid date: mm/dd/yyyy';
                  }
                  return null;
                },
              ),

              // TIME
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                  hintText: 'hour:minute',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid =
                      RegExp(r"(1[0-2]|0?[1-9]):([0-5]?[0-9])(●?[AP]M)?$")
                          .hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid time: hour:minute';
                  }
                  return null;
                },
              ),

              // SPECIES
              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(
                  labelText: 'Species',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid =
                      RegExp(r"^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$").hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid species';
                  }
                  return null;
                },
              ),

              // WEIGHT
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                  hintText: ' 0.0lbs',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid = RegExp(r"^\d*\.?\d*$()").hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),

              // LENGTH
              TextFormField(
                controller: _lengthController,
                decoration: const InputDecoration(
                  labelText: 'Length',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                  hintText: '0.0ft',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid = RegExp(r"^\d*\.?\d*$").hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid length';
                  }
                  return null;
                },
              ),

              // BAIT
              TextFormField(
                controller: _baitController,
                decoration: const InputDecoration(
                  labelText: 'Bait',
                  fillColor: Color(0xff4C748B),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NA if not applicable ';
                  }
                  bool locationValid =
                      RegExp(r"^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$").hasMatch(value);

                  if (!locationValid) {
                    return 'Please enter a valid bait';
                  }
                  return null;
                },
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(_locationController.text);
                    print(_dateController.text);
                    print(_timeController.text);
                    print(_speciesController.text);
                    print(_weightController.text);
                    print(_lengthController.text);
                    print(_baitController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff4C748B),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
