import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/update_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String title, body;
  UpdatePage({this.title, this.body, Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateViewModel viewModel = UpdateViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.titleTextEditingController.text = widget.title;
    viewModel.bodyTextEditingController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new post'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<UpdateViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Title
                    Container(
                      height: 75,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: TextField(
                          controller: viewModel.titleTextEditingController,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    // Body
                    Container(
                      height: 475,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: viewModel.bodyTextEditingController,
                        style: TextStyle(fontSize: 18),
                        maxLines: 30,
                        decoration: InputDecoration(
                          labelText: 'Body',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              viewModel.isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          viewModel.apiPostUpdate(context);
        },
        child: Icon(Icons.file_upload),
      ),
    );
  }
}
