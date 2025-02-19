import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Application/AdminProviders/AdminPortalprovider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal>
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
              const Text('Admin Portal'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPortal()));
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
          children: [AdminPostPage(), Det()],
        ),
      ),
    );
  }
}

class AdminPostPage extends StatefulWidget {
  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController matterController = TextEditingController();
  final TextEditingController sortOrderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AdminPortalProvider>(context, listen: false);
      await p.getSortOrder(context);
      sortOrderController.text = p.sortOrder.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminPortalProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              kheight20,
              TextFormField(
                controller: titleController,
                maxLength: 80,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  if (value.length > 80) {
                    return 'Title cannot exceed 80 characters';
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: matterController,
                maxLength: 300,
                decoration: InputDecoration(
                  labelText: 'Matter',
                  labelStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Matter is required';
                  }
                  if (value.length > 300) {
                    return 'Matter cannot exceed 300 characters';
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: sortOrderController,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'Sort Order',
                  labelStyle: TextStyle(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sortorder is required';
                  }
                  if (value.length > 3) {
                    return 'Sortorder cannot exceed 3 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              kheight20,
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          print('helooooo');
                          if (_formKey.currentState!.validate()) {
                            // Check for duplicate title
                            bool isTitleDuplicate = await adminProvider
                                .isTitleDuplicate(titleController.text);
                            print('gdjjhvkjblkjbkhvhgc');
                            print(isTitleDuplicate);
                            if (isTitleDuplicate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Title already exists')),
                              );
                              return;
                            }

                            // Check for duplicate sort order
                            bool isSortOrderDuplicate = await adminProvider
                                .isSortOrderDuplicate(sortOrderController.text);
                            print(isSortOrderDuplicate);
                            if (isSortOrderDuplicate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Sort Order already exists')),
                              );
                              return;
                            }

                            // Proceed to create the post if no duplicates are found
                            bool isCreated =
                                await adminProvider.createAdminPost(
                              titleController.text,
                              matterController.text,
                              sortOrderController.text,
                            );

                            if (isCreated) {
                              // Clear the input fields upon successful creation
                              titleController.clear();
                              matterController.clear();
                              sortOrderController.clear();

                              // Reload the sort order value and update the text field
                              await adminProvider.getSortOrder(context);
                              sortOrderController.text =
                                  adminProvider.sortOrder.toString();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Saved successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Failed to add the post. Please try again.')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UIGuide.light_Purple,
                        ),
                        child: Text('Submit'),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Reset the form state
                          _formKey.currentState!.reset();

                          // Clear all input fields
                          titleController.clear();
                          matterController.clear();
                          sortOrderController.clear();

                          // Unfocus the current focus to dismiss the keyboard if open
                          FocusScope.of(context).unfocus();

                          // Reload the sort order value
                          await adminProvider.getSortOrder(context);
                          sortOrderController.text =
                              adminProvider.sortOrder.toString();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UIGuide.THEME_PRIMARY,
                        ),
                        child: Text('Reset'),
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

class Det extends StatefulWidget {
  const Det({super.key});

  @override
  State<Det> createState() => _DetState();
}

class _DetState extends State<Det> {
  // Map to track the visibility state of the eye icon for each post using String as key
  Map<String, bool> eyeOpenState = {};

  @override
  void initState() {
    super.initState();
    final adminProvider =
        Provider.of<AdminPortalProvider>(context, listen: false);
    adminProvider.getAdminPost().then((_) {
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
    final adminProvider = Provider.of<AdminPortalProvider>(context);

    return adminProvider.isLoading
        ? Center(child: spinkitLoader())
        : ListView.builder(
            itemCount: adminProvider.detail.length,
            itemBuilder: (context, index) {
              final item = adminProvider.detail[index];

              return Card(
                margin: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  child: ListTile(
                    title: SizedBox(
                        height: 25,
                        child: Text(
                          item.title ?? "No Title",
                          style: TextStyle(fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    subtitle: SizedBox(
                        height: 45,
                        child: Text(
                          item.matter ?? "No Matter",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        )),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Make sure to fit icons
                      children: [
                        // Only show the edit icon if the eye is open
                        if (eyeOpenState[item.id] == true)
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: UIGuide.button1,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPostPage(
                                    postId: item.id!,
                                    currentTitle: item.title ?? "",
                                    currentMatter: item.matter ?? "",
                                    currentSortOrder: item.sortOrder.toString(),
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
                                ? UIGuide.light_Purple
                                : UIGuide.THEME_LIGHT,
                          ),
                          onPressed: () async {
                            // Toggle the eye state and update the UI
                            bool isActive = eyeOpenState[item.id!] ?? false;

                            setState(() {
                              eyeOpenState[item.id!] = !isActive;
                            });

                            await adminProvider.activeorNotAdminPost(
                              item.id.toString(),
                              item.title.toString(),
                              item.matter.toString(),
                              eyeOpenState[item.id!]!,
                              item.sortOrder.toString(),
                            );

                            if (adminProvider.stsucode == 200 &&
                                !eyeOpenState[item.id!]!) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Deactivated Successfully!')));
                              }
                            } else if (adminProvider.stsucode == 200 &&
                                eyeOpenState[item.id!]!) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Activated Successfully!')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Something went wrong!')));
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: UIGuide.button2,
                          ),
                          onPressed: () async {
                            // Show confirmation dialog before deleting
                            bool? confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                      'Are you sure you want to delete this post?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              color: UIGuide.BLACK,
                                              fontSize: 15)),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete',
                                          style: TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontSize: 15)),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              bool success =
                                  await adminProvider.deleteAdminPost(item.id!);
                              if (success) {
                                await adminProvider.getAdminPost();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Deleted Successfully!')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to delete post.')));
                              }
                            }
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

class EditPostPage extends StatefulWidget {
  final String postId;
  final String currentTitle;
  final String currentMatter;
  final String currentSortOrder;

  const EditPostPage({
    Key? key,
    required this.postId,
    required this.currentTitle,
    required this.currentMatter,
    required this.currentSortOrder,
  }) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController titleController;
  late TextEditingController matterController;
  late TextEditingController sortOrderController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.currentTitle);
    matterController = TextEditingController(text: widget.currentMatter);
    sortOrderController = TextEditingController(text: widget.currentSortOrder);
  }

  @override
  void dispose() {
    titleController.dispose();
    matterController.dispose();
    sortOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminPortalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
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
              kheight20,
              TextFormField(
                controller: titleController,
                maxLength: 80,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: UIGuide.light_Purple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: matterController,
                maxLength: 300,
                decoration: InputDecoration(
                  labelText: 'Matter',
                  labelStyle: TextStyle(color: UIGuide.light_Purple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Matter is required';
                  }
                  return null;
                },
              ),
              kheight20,
              TextFormField(
                controller: sortOrderController,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'Sort Order',
                  labelStyle: TextStyle(color: UIGuide.light_Purple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.light_Purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sortorder is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Sort Order must be a number';
                  }
                  return null;
                },
              ),
              kheight20,
              ElevatedButton(
                onPressed: () async {
                  // Check if the entered sort order is different from the current sort order
                  bool isSortOrderChanged =
                      sortOrderController.text != widget.currentSortOrder;

                  // Validate the new sort order only if it has been changed
                  bool sortOrderExists = isSortOrderChanged &&
                      adminProvider
                          .checkSortOrderExists(sortOrderController.text);

                  if (sortOrderExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Sort Order already exists')),
                    );
                    return; // Stop further execution if validation fails
                  }

                  if (_formKey.currentState!.validate()) {
                    // Proceed to update if all inputs are valid
                    bool success = await adminProvider.updateAdminPost(
                      widget.postId,
                      titleController.text,
                      matterController.text,
                      sortOrderController.text,
                    );

                    if (success) {
                      Navigator.pop(context); // Go back to the previous screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Updated Successfully!')),
                      );
                      // Refresh the list in the previous screen
                      await adminProvider.getAdminPost();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Title already exists')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: UIGuide.light_Purple,
                ),
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
