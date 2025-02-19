import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_dropdown_with_select_all/multiselect_dropdown_with_select_all.dart';
import 'package:provider/provider.dart';
import '../../Application/AdminProviders/FeedbackCategoryProvider.dart';
import '../../Application/AdminProviders/FeedbackProvider.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/spinkit.dart';

class Feedbackcategory extends StatefulWidget {
  const Feedbackcategory({super.key});

  @override
  State<Feedbackcategory> createState() => _FeedbackcategoryState();
}

class _FeedbackcategoryState extends State<Feedbackcategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            children: [
              const Spacer(),
              const Text(
                'Feedback',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Feedbackcategory()));
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          titleSpacing: 0.0,
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
            labelColor: Colors.white, // Active tab text color
            unselectedLabelColor: Colors.white70, // Inactive tab text color
            labelStyle: TextStyle(fontSize: 14), // Active tab font size
            unselectedLabelStyle: TextStyle(fontSize: 12), // Inactive tab font size
            tabs: [
              Tab(text: "Feedback"),
              Tab(text: "Entry"),
              Tab(text: "Categories"),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 7, 68, 126),
        ),
        body: const TabBarView(
          children: [FeedbackList2(),FeedbackEntry(), FeedBackList(), ],
        ),
      ),
    );
  }
}

class FeedbackEntry extends StatefulWidget {
  const FeedbackEntry({super.key});
  @override
  State<FeedbackEntry> createState() => _FeedbackEntryState();
}

class _FeedbackEntryState extends State<FeedbackEntry> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController sortOrderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Checkboxes states with all selected by default
  bool schoolSuperAdmin = false;
  bool schoolHead = false;
  bool systemAdmin = false;
  bool classTeacher = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<FeedbackCategoryProvider>(context, listen: false);
      await p.getSortOrder(context);
      sortOrderController.text = p.sortOrder.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<FeedbackCategoryProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: categoryController,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category is required';
                  }
                  if (value.length > 80) {
                    return 'Category cannot exceed 80 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('View to :'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: schoolSuperAdmin,
                    onChanged: (value) {
                      setState(() {
                        schoolSuperAdmin = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                      }
                      return Colors.white; // Color when the checkbox is unchecked
                    }),
                    checkColor: Colors.white, // Color of the tick itself
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        schoolSuperAdmin = !schoolSuperAdmin; // Toggle the checkbox state
                      });
                    },
                    child: const Text('School Super Admin'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: schoolHead,
                    onChanged: (value) {
                      setState(() {
                        schoolHead = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                      }
                      return Colors.white; // Color when the checkbox is unchecked
                    }),
                    checkColor: Colors.white, // Color of the tick itself
                  ),
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          schoolHead = !schoolHead;
                        });
                      },
                      child: const Text('School Head')),
                ],
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    systemAdmin = !systemAdmin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: systemAdmin,
                      onChanged: (value) {
                        setState(() {
                          systemAdmin = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('System Admin'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    classTeacher = !classTeacher;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: classTeacher,
                      onChanged: (value) {
                        setState(() {
                          classTeacher = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('Class Teacher'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: sortOrderController,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'Sort Order',
                  labelStyle: const TextStyle(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sort order is required';
                  }
                  if (value.length > 3) {
                    return 'Sort order cannot exceed 3 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Validate that at least one checkbox is selected
                            if (!schoolSuperAdmin &&
                                !schoolHead &&
                                !systemAdmin &&
                                !classTeacher) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Role is required')),
                              );
                              return;
                            }

                            // Check for duplicate title
                            bool isCategoryDuplicate = await adminProvider
                                .isCategoryDuplicate(categoryController.text);
                            if (isCategoryDuplicate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Category already exists')),
                              );
                              return;
                            }

                            // Check for duplicate sort order
                            bool isSortOrderDuplicate = await adminProvider
                                .isSortOrderDuplicate(sortOrderController.text);
                            if (isSortOrderDuplicate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Sort Order already exists')),
                              );
                              return;
                            }

                            // Prepare the payload
                            var payload = {
                              "category": categoryController.text,
                              "sortOrder": sortOrderController.text,
                              "schoolSuperAdmin": schoolSuperAdmin,
                              "schoolHead": schoolHead,
                              "systemAdmin": systemAdmin,
                              "classTeacher": classTeacher,
                            };

                            // Proceed to create the post
                            bool isCreated =
                            await adminProvider.createFeedback(payload);

                            if (isCreated) {
                              // Clear the input fields upon successful creation
                              categoryController.clear();
                              sortOrderController.clear();
                              schoolSuperAdmin = false;
                              schoolHead = false;
                              systemAdmin = false;
                              classTeacher = false;

                              // Reload the sort order value and update the text field
                              await adminProvider.getSortOrder(context);
                              sortOrderController.text =
                                  adminProvider.sortOrder.toString();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Saved successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Failed to add the post. Please try again.')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 7, 68, 126),
                        ),
                        child: const Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Reset the form state
                          _formKey.currentState!.reset();

                          // Clear all input fields
                          categoryController.clear();

                          // Set all checkboxes back to true
                          setState(() {
                            schoolSuperAdmin = false;
                            schoolHead = false;
                            systemAdmin = false;
                            classTeacher = false;
                          });

                          // Fetch and display the default sort order
                          await adminProvider.getSortOrder(context);
                          setState(() {
                            sortOrderController.text =
                                adminProvider.sortOrder.toString();
                          });

                          // Unfocus the current focus to dismiss the keyboard if open
                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 7, 68, 126),
                        ),
                        child: const Text('Reset',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedBackList extends StatefulWidget {
  const FeedBackList({super.key});

  @override
  State<FeedBackList> createState() => _FeedBackListState();
}

class _FeedBackListState extends State<FeedBackList> {
  // Map to track the visibility state of the eye icon for each post using String as key
  Map<String, bool> eyeOpenState = {};

  @override
  void initState() {
    super.initState();
    final adminProvider =
    Provider.of<FeedbackCategoryProvider>(context, listen: false);
    adminProvider.feedbackList().then((_) {
      // Initialize eyeOpenState based on the fetched posts
      for (var item in adminProvider.detail) {
        eyeOpenState[item.id!] = item
            .active!; // Assuming isActive is a field that indicates visibility status
      }
      setState(() {}); // Trigger a rebuild after initializing eye states
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<FeedbackCategoryProvider>(context);

    return adminProvider.isLoading
        ?  Center(
      child: spinkitLoader(),
    )
        : ListView.builder(
      itemCount: adminProvider.detail.length,
      itemBuilder: (context, index) {
        final item = adminProvider.detail[index];

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 70,
            child: ListTile(
              title: SizedBox(
                  height: 25,
                  child: Text(
                    item.category ?? "No Category",
                    style: const TextStyle(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Make sure to fit icons
                children: [
                  // Only show the edit icon if the eye is open
                  if (eyeOpenState[item.id] == true)
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        var p = Provider.of<FeedbackCategoryProvider>(context, listen: false);
                        await p.fetchFeedbackCategory(item.id!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditFeedbackPage(
                            ),
                          ),
                        );
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      eyeOpenState[item.id] == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: eyeOpenState[item.id] == true
                          ? Color.fromARGB(255, 7, 68, 126)
                          : Colors.black45,
                    ),
                    onPressed: () async {
                      // Toggle the eye state and update the UI
                      bool isActive = eyeOpenState[item.id!] ?? false;

                      setState(() {
                        eyeOpenState[item.id!] = !isActive;
                      });

                      await adminProvider.activeorNotAdminPost(
                        item.id.toString(),
                        item.category.toString(),
                        eyeOpenState[item.id!]!,
                        item.sortOrder.toString(),
                      );

                      if (adminProvider.stsucode == 200 &&
                          !eyeOpenState[item.id!]!) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Deactivated Successfully!')));
                        }
                      } else if (adminProvider.stsucode == 200 &&
                          eyeOpenState[item.id!]!) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Activated Successfully!')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went wrong!')));
                      }
                    },
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      // Show confirmation dialog before deleting
                      bool? confirmDelete = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this feedback?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 15)),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Delete',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 15)),
                                onPressed: () async {
                                  await adminProvider.deleteFeedback(context,item.id!);
                                  Navigator.of(context).pop(true);
                                  setState(() {
                                    Provider.of<FeedbackCategoryProvider>(context, listen: false);
                                    adminProvider.feedbackList().then((_) {
                                      // Initialize eyeOpenState based on the fetched posts
                                      for (var item in adminProvider.detail) {
                                        eyeOpenState[item.id!] = item
                                            .active!; // Assuming isActive is a field that indicates visibility status
                                      }
                                    });
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );

                      // if (confirmDelete == true) {
                      //   bool success =
                      //   await adminProvider.deleteFeedback(item.id!);
                      //   if (success) {
                      //     await adminProvider.feedbackList();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //             content:
                      //             Text('Deleted Successfully!')));
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //             content:
                      //             Text('Failed to delete post.')));
                      //   }
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EditFeedbackPage extends StatefulWidget {


  const EditFeedbackPage({
    Key? key,

  }) : super(key: key);

  @override
  _EditFeedbackPageState createState() => _EditFeedbackPageState();
}

class _EditFeedbackPageState extends State<EditFeedbackPage> {
  late TextEditingController categoryController;
  late TextEditingController sortOrderController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController();
    sortOrderController = TextEditingController();

    initializeData();
  }

  Future<void> initializeData() async {
    var p = Provider.of<FeedbackCategoryProvider>(context, listen: false);


    // Initialize the controllers with fetched data
    categoryController.text = p.selectedFeedbackCategory!.category.toString();
    sortOrderController.text = p.selectedFeedbackCategory!.sortOrder.toString();
  }

  @override
  void dispose() {
    categoryController.dispose();
    sortOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<FeedbackCategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          children: [
            Spacer(),
            Text(
              'Edit Feedback Category',
              style: TextStyle(color: Colors.white,fontSize: 18),
            ),
            Spacer(),
          ],
        ),
        titleSpacing: 0.0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: Color.fromARGB(255, 7, 68, 126),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: categoryController,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                onChanged: (value){
                  adminProvider.selectedFeedbackCategory!.category= value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Category is required';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    bool value= adminProvider.selectedFeedbackCategory!.schoolSuperAdmin==true?true:false;
                    adminProvider.selectedFeedbackCategory!.schoolSuperAdmin = !value;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: adminProvider.selectedFeedbackCategory!.schoolSuperAdmin==true?true:false,
                      onChanged: (value) {
                        setState(() {
                          adminProvider.selectedFeedbackCategory!.schoolSuperAdmin = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('School Super Admin'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  bool value = adminProvider.selectedFeedbackCategory!.schoolHead==true?true:false;
                  setState(() {
                    adminProvider.selectedFeedbackCategory!.schoolHead = !value;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: adminProvider.selectedFeedbackCategory!.schoolHead==true?true:false,
                      onChanged: (value) {
                        setState(() {
                          adminProvider.selectedFeedbackCategory!.schoolHead = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('School Head'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  bool value = adminProvider.selectedFeedbackCategory!.systemAdmin==true?true:false;
                  setState(() {
                    adminProvider.selectedFeedbackCategory!.systemAdmin = !value;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: adminProvider.selectedFeedbackCategory!.systemAdmin==true?true:false,
                      onChanged: (value) {
                        setState(() {
                          adminProvider.selectedFeedbackCategory!.systemAdmin = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('System Admin'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  bool value = adminProvider.selectedFeedbackCategory!.classTeacher==true?true:false;
                  setState(() {
                    adminProvider.selectedFeedbackCategory!.classTeacher = !value;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: adminProvider.selectedFeedbackCategory!.classTeacher==true?true:false,
                      onChanged: (value) {
                        setState(() {
                          adminProvider.selectedFeedbackCategory!.classTeacher = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 7, 68, 126); // Color when the checkbox is checked
                        }
                        return Colors.white; // Color when the checkbox is unchecked
                      }),
                      checkColor: Colors.white, // Color of the tick itself
                    ),
                    const Text('Class Teacher'),
                  ],
                ),
              ),
              TextFormField(
                controller: sortOrderController,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'Sort Order',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                onChanged: (value) {
                  // Parse and update sortOrder only if value is numeric
                  if (int.tryParse(value) != null) {
                    adminProvider.selectedFeedbackCategory!.sortOrder = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sort order is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Sort Order must be a number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () async {
                  // Check if at least one checkbox is selected, using ?? to handle nullable values
                  if (!(adminProvider.selectedFeedbackCategory!.schoolSuperAdmin ?? false) &&
                      !(adminProvider.selectedFeedbackCategory!.schoolHead ?? false) &&
                      !(adminProvider.selectedFeedbackCategory!.systemAdmin ?? false) &&
                      !(adminProvider.selectedFeedbackCategory!.classTeacher ?? false)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Role is required')),
                    );
                    return;
                  }

                  // Check for duplicate category if it was changed
                  if (categoryController.text != adminProvider.selectedFeedbackCategory!.category) {
                    bool isCategoryDuplicate = await adminProvider.isCategoryDuplicate(categoryController.text);
                    if (isCategoryDuplicate) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Category already exists')),
                      );
                      return;
                    }
                  }

                  // Check for duplicate sort order
                  if (int.parse(sortOrderController.text) != adminProvider.selectedFeedbackCategory!.sortOrder) {
                    bool isSortOrderDuplicate = await adminProvider.isSortOrderDuplicate(sortOrderController.text);
                    if (isSortOrderDuplicate) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Sort Order already exists')),
                      );
                      return;
                    }
                  }
                  // Update feedback category if all validations pass
                  adminProvider.updateFeedbackCategory(context);
                },
                child: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF07447E), // Button background color
                  foregroundColor: Colors.white,            // Text and icon color
                  shadowColor: Colors.black,                // Shadow color
                  elevation: 5,                             // Elevation to give it a shadow
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackList2 extends StatefulWidget {
  const FeedbackList2({Key? key}) : super(key: key);

  @override
  State<FeedbackList2> createState() => _FeedbackList2State();
}

class _FeedbackList2State extends State<FeedbackList2> {
  List<String> selectedCategoryIds = [];
  bool show = false;
  int? selectedRadio; // Variable to store the selected radio button value
  late String showreport;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FbProvider>(context, listen: false).fetchCategories();
    });
    selectedRadio =
    1; // Set the default selected radio button to the first option
  }

  void fetchFeedback(BuildContext context) {
    if (selectedCategoryIds.isNotEmpty) {
      if (selectedRadio == 1) {
        showreport = "category";
      } else {
        showreport = "date";
      }
      String categoryIds = selectedCategoryIds.join(',');
      Provider.of<FbProvider>(context, listen: false)
          .fetchFeedbackDetails(categoryIds, showreport);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fbProvider = Provider.of<FbProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Feedback List'),
      //   backgroundColor: Color.fromARGB(255, 7, 68, 126),
      // ),
      body: fbProvider.isLoading
          ?  Center(child: spinkitLoader())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 325,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Theme(
                      data: ThemeData.light().copyWith(
                      ),
                      child:MultiSelectDropdown(
                        items: fbProvider.categories
                            .map((category) => MultiSelectItem(
                            category.value!, category.text!))
                            .toList(),
                        initialSelectedValues: selectedCategoryIds,
                        hint: 'Category',
                        isMultiSelect: true,
                        selectAllflag: true,
                        colorHeading: Color.fromARGB(255, 7, 68, 126),
                        colorPlaceholder: Colors.grey,
                        colorDropdownIcon: Color.fromARGB(255, 7, 68, 126),
                        radius: 10,
                        borderColor: Color.fromARGB(255, 7, 68, 126),
                        onChanged: (values) {
                          setState(() {
                            show = false;
                            selectedCategoryIds = values;
                          });
                        },
                      ),),
                  ),
                ),
              ],
            ),
          ),
          // New Row with RadioButtons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    show=false;
                    selectedRadio = 1;
                  });
                },
                child: Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      activeColor: Color.fromARGB(255, 7, 68, 126),
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          show=false;
                          selectedRadio = value;
                        });
                      },
                    ),
                    const Text(
                      'Category-wise',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    show=false;
                    selectedRadio = 2;
                  });
                },
                child: Row(
                  children: [
                    Radio<int>(
                      value: 2,
                      activeColor: Color.fromARGB(255, 7, 68, 126),
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          show=false;
                          selectedRadio = value;
                        });
                      },
                    ),
                    const Text(
                      'Date-wise',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: size.width * .22,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 7, 68, 126)),
                    ),
                    onPressed: () {
                      if(selectedCategoryIds.isNotEmpty) {
                        show = true;
                        fetchFeedback(context);
                      }
                      else{
                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(
                            const SnackBar(
                              elevation:
                              10,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              duration: Duration(
                                  seconds:
                                  1),
                              margin: EdgeInsets.only(
                                  bottom:
                                  80,
                                  left:
                                  30,
                                  right:
                                  30),
                              behavior:
                              SnackBarBehavior
                                  .floating,
                              content:
                              Text(
                                "Please select any category!",
                                textAlign:
                                TextAlign.center,
                              ),
                            ));
                      }
                    },
                    child: const Text(
                      'View',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
              ),
              SizedBox(
                width: size.width * .23,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 7, 68, 126)),
                  ),
                  onPressed: () {
                    setState(() {
                      show = false;
                      selectedCategoryIds = [];
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          show == true
              ? Expanded(
            child: Consumer<FbProvider>(
              builder: (_, value, child) {
                return fbProvider.isLoading
                    ?  Center(child: spinkitLoader())
                    : fbProvider.errorMessage != null
                    ? Center(child: Text(fbProvider.errorMessage!))
                    :


                ListView.builder(
                  itemCount: fbProvider.viewstudentdetails.length,
                  itemBuilder: (context, categoryIndex) {

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              showreport=="category"?fbProvider.viewstudentdetails[categoryIndex].category.toString():_formatDate(fbProvider.viewstudentdetails[categoryIndex].createDate),
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                          ),
                          // SizedBox(height: 10),
                          AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:  fbProvider.viewstudentdetails[categoryIndex].feedbackList!.length,
                              itemBuilder: (context, index) {
                                final feedback = fbProvider.viewstudentdetails[categoryIndex].feedbackList![index];



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
                                            // color: Color.fromARGB(255, 234, 234, 236),
                                            border: Border.all(color: Color.fromARGB(255, 7, 68, 126)),
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].slNo}.",style: TextStyle(fontSize: 12),),
                                                    Text("Adm.No: ${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].admNo}",style: TextStyle(fontSize: 12),),
                                                    Text("Div: ${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].division}",style: TextStyle(fontSize: 12),),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text("Name       : ",style: TextStyle(fontSize: 12),),
                                                    Text(fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].student.toString(),
                                                        style: const TextStyle(fontSize: 12,
                                                            color: Color.fromARGB(255, 7, 68, 126),
                                                            fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: [

                                                    Text("Guardian : ",style: TextStyle(fontSize: 12),),
                                                    Text(fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].guardian.toString(),style: TextStyle(fontSize: 12),),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                showreport=='date'?
                                                Row(
                                                  children: [

                                                    Text("Category : ",style: TextStyle(fontSize: 12),),
                                                    Expanded(
                                                      child: Text(fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].category.toString(),style: TextStyle(fontSize: 12),
                                                      ),
                                                    ),                                                  ],
                                                ):SizedBox(width: 0,height: 0,),
                                                SizedBox(height: 4),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Feedback:", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
                                                    SizedBox(width: 4),
                                                    Expanded(
                                                      child: TextWrapper(text: fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].matter.toString(),
                                                        fSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                showreport=='category'?
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Text(
                                                    _formatDate(fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].createDate),
                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                  ),
                                                ):SizedBox(width: 0,height: 0,)
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
                          ),
                        ],
                      ),
                    );
                  },
                );


              },
            ),
          )



              : const SizedBox(height: 0, width: 0),
        ],
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
