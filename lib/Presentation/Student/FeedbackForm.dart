import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/FeedbackEntryProvider.dart';
import '../../Domain/Student/FeedbackModel.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Feedback Entry'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackForm()));
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 45.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Entry",
              ),
              Tab(text: "List"),
            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: TabBarView(
          children: [FeedbackFormEntry(), FeedbackFormList()],
        ),
      ),
    );
  }
}

class FeedbackFormEntry extends StatefulWidget {
  const FeedbackFormEntry({super.key});

  @override
  State<FeedbackFormEntry> createState() => _FeedbackFormEntryState();
}

class _FeedbackFormEntryState extends State<FeedbackFormEntry> {
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
      final feedbackProvider =
      Provider.of<FeedbackProvider>(context, listen: false);
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
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Row(
      //     children: [
      //       Text(
      //         'Feedback Entry',
      //         style: TextStyle(color: Colors.white, fontSize: 18),
      //         textAlign: TextAlign.center,
      //       ),
      //       Spacer(),
      //     ],
      //   ),
      //   titleSpacing: 0.0,
      //   centerTitle: true,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         bottomRight: Radius.circular(25),
      //         bottomLeft: Radius.circular(25)),
      //   ),
      //   backgroundColor: Color.fromARGB(255, 7, 68, 126),
      // ),
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
                    items: feedbackProvider.categories
                        .map((FeedbackModel category) {
                      return DropdownMenuItem(
                        value: category.value,
                        child:
                        Text(category.text ?? ''), // Full text in dropdown
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return feedbackProvider.categories
                          .map((FeedbackModel category) {
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
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 68, 126),
                    ),
                    child: const Text('Reset',
                        style: TextStyle(color: Colors.white)),
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
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}

class FeedbackFormList extends StatefulWidget {
  const FeedbackFormList({super.key});

  @override
  State<FeedbackFormList> createState() => _FeedbackFormListState();
}

class _FeedbackFormListState extends State<FeedbackFormList> {
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    final feedbackProvider =
    Provider.of<FeedbackProvider>(context, listen: false);
    _loadFeedbackList(feedbackProvider);
  }

  Future<void> _loadFeedbackList(FeedbackProvider feedbackProvider) async {
    try {
      await feedbackProvider.fetchFeedbackList();
      setState(() {
        _isError = false; // Reset error state on successful data fetch
      });
    } catch (e) {
      setState(() {
        _isError = true; // Mark error state if data fetch fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FeedbackProvider>(
        builder: (context, feedbackProvider, child) {
          if (_isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(height: 8),
                  Text('Failed to load feedback list',
                      style: TextStyle(color: Colors.red)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadFeedbackList(feedbackProvider),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (feedbackProvider.feedbackList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: feedbackProvider.feedbackList.length,
              itemBuilder: (context, index) {
                final feedback = feedbackProvider.feedbackList[index];
                var size = MediaQuery.of(context).size;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 2500),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 7, 68, 126)),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("${index + 1}.",
                                        style: TextStyle(
                                            fontSize:
                                            12)), // Display Serial Number
                                    SizedBox(width: 5),
                                    // Category text with ellipsis if it overflows
                                    Container(
                                      width: size.width * .8, // Set a max width
                                      child: Text(
                                        feedback.categoryName ?? 'No Name',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                          Color.fromARGB(255, 7, 68, 126),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis, // Truncate with ellipsis
                                        maxLines:
                                        1, // Ensure text is only on one line
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Text("Feedback: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: TextWrapper(
                                        text: feedback.matter ?? 'No Matter',
                                        fSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    _formatDate(feedback.createDate),
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
