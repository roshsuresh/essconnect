import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Application/StudentProviders/FeedbackEntryProvider.dart';
import '../../Domain/Student/FeedbackModel.dart';
import '../../utils/constants.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedbackProvider>(context, listen: false).fetchCategories();
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
      final feedback = FeedbackSubmissionModel(
        categoryId: _selectedCategory,
        matter: _descriptionController.text,
      );

      try {
        await feedbackProvider.submitFeedback(feedback);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully')),
        );
        _resetForm(); // Clear the form after successful submission
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback: $error')),
        );
      }
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset(); // Resets form state
    setState(() {
      _selectedCategory = null; // Clears the selected category
    });
    _descriptionController.clear(); // Clears the description text
    _descriptionFocusNode.unfocus(); // Unfocus the description field if needed
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Entry'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Category Dropdown
              Consumer<FeedbackProvider>(
                builder: (context, feedbackProvider, _) {
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: const TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedCategory,
                    items: feedbackProvider.categories.map((FeedbackModel category) {
                      return DropdownMenuItem(
                        value: category.value,
                        child: Text(category.text ?? ''), // Full text in dropdown
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return feedbackProvider.categories.map((FeedbackModel category) {
                        return Text(
                          category.value == _selectedCategory
                              ? _truncateText(category.text ?? '', 24)
                              : '',
                          style: const TextStyle(color: Colors.black),
                        );
                      }).toList();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // Description Box
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                focusNode: _descriptionFocusNode,
                maxLength: 500,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  hintText: 'Enter your feedback here...',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.black45),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Submit and Reset Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 68, 126),
                    ),
                    child: const Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 68, 126),
                    ),
                    child: const Text('Reset', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
  }
}
