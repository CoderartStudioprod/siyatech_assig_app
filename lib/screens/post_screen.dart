import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siyatech_assig_app/utils/Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart'; // Import intl package
import '../blocs/post_bloc.dart';
import '../repositories/hacker_news_repository.dart';
import '../widgets/News_list_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 3,
        title: Text(
          'Top NewsFeed',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => PostBloc(repository: HackerNewsRepository())
          ..add(PostLoadRequested()),
        child: PostList(),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoadSuccess) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: state.hasReachedMax ? posts.length : posts.length + 1,
            itemBuilder: (context, index) {
              if (index >= posts.length) {
                context.read<PostBloc>().add(PostLoadRequested());
                return Center(child: CircularProgressIndicator());
              }
              final post = posts[index];
              return NewsItem(
                title: post.title,
                author: post.by,
                category: post.type,
                commentlistID: post.kids,
                time: post.time,
                urllaunch: () => Constant().launchURL(post.url),
              );
            },
          );
        } else if (state is PostLoadFailure) {
          return Center(child: Text('Failed to load posts: ${state.error}'));
        } else {
          return Center(
              child: Column(
            children: [
              CircularProgressIndicator(),
              Text('Loading Data'),
            ],
          ));
        }
      },
    );
  }
}
