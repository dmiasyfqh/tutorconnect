import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  String? _selectedSubject;

  // List of subjects to be used in the dropdown
  List<String> subjects = [
    "CSC402", "CSC413", "CSC429", "CTU552", "HBU111", "MAT421", "STA416",
    "CSC404", "CSC510", "ELC501", "HBU121", "ICT450", "ITT400", "MAT423",
    "CSC435", "CSC520", "CTU554", "HBU131", "ICT504", "ICT602", "TMC401",
    "CSC577", "CSC578", "CSC660", "ELC650", "ICT551", "MGT400", "TMC451",
    "CSC575", "CSC661", "CSP600", "ENT600", "HRM533", "ISP642", "TMC501",
    "CSC579", "CSC584", "CSP650", "EET699", "ICT652"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Post a Question"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Searchable dropdown for subject selection
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                  showSearchBox: true,
                ),
                items: subjects, // Use the list of subjects here
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Choose subject",
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search subject", // Placeholder text
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // TextField for the question
              TextFormField(
                controller: _questionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Write your question...",
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Row for icons
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      String questionText = _questionController.text;
                      String selectedSubject = _selectedSubject ?? "None";

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Question posted successfully!')),
                      );

                      _questionController.clear();
                      setState(() {
                        _selectedSubject = null;
                      });
                    }
                  },
                  child: const Text("Post Question"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
