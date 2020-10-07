import 'package:school_app/locator.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/services/post_fire_store_services.dart';
import 'package:school_app/ui/widgets/post_item.dart';
import 'package:school_app/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        print('//// has more is ' +
            locator<PostFireStoreService>().hasMorePosts.toString());
        locator<PostFireStoreService>().requestMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: !model.busy
                    ? Icon(Icons.add)
                    : Center(child: CircularProgressIndicator()),
                onPressed: model.navigateToCreateView,
              ),

              body: StreamBuilder(
                stream: model.stream,
                builder: (BuildContext _context, AsyncSnapshot _snapshot) {
                  if (_snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('waiting'));
                  }
                  if (!_snapshot.hasData) {
                    return Center(child: Text('no content'));
                  } else {
                    return RefreshIndicator(
                      onRefresh: model.refresh,
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        controller: scrollController,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: _snapshot.data.length + 1,
                        itemBuilder: (BuildContext _context, int index) {
                          if (index < _snapshot.data.length) {
                            Post post = _snapshot.data[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => model.editPost(index),
                                child: PostItem(
                                  post: post,
                                  onDeleteItem: () => model.deletePost(post),
                                ),
                              ),
                            );
                          } else if (locator<PostFireStoreService>().hasMorePosts) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(child: Text('no more item')),
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ));
  }
}
