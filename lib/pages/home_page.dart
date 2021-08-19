import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:patterns_provider/views/item_of_posts.dart';
import 'package:provider/provider.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              ListView.builder(
                itemCount: viewModel.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPosts(context, viewModel, viewModel.items[index]);
                },
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
          Navigator.pushNamed(context, CreatePage.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}