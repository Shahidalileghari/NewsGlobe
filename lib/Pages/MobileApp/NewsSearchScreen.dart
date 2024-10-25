// import 'package:flutter/material.dart';
// import 'package:news_app/Models/NewsChannelHeadlinesModel.dart';
// import 'package:news_app/viewModel/NewsViewModel.dart';
// import 'package:news_globe/NewsRepositories/NewsRepositories.dart';
//
// import '../../Models/NewsChannelHeadlinesModel.dart';
// import '../../presentation/NewsViewModel.dart';
//
// class NewsSearchScreen extends StatefulWidget {
//   @override
//   _NewsSearchScreenState createState() => _NewsSearchScreenState();
// }
//
// class _NewsSearchScreenState extends State<NewsSearchScreen> {
//   NewsViewModel newsViewModel = NewsViewModel();
//   List<NewsRepositories>? articles;  // Store the articles from the API
//   List<NewsRepositories>? filteredArticles;  // Store the filtered articles based on search
//   TextEditingController searchController = TextEditingController();  // Controller for search bar
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();  // Fetch news when the app starts
//   }
//
//   // Fetch the news articles from the API
//   Future<void> _fetchNews() async {
//     NewsChannelHeadlinesModel newsData = await newsViewModel.fetchNewsChannelHeadlinesAPIs();
//     setState(() {
//       articles = newsData.articles;
//       filteredArticles = articles;  // Initially, show all articles
//     });
//   }
//
//   // Function to filter articles based on search query
//   void _filterArticles(String query) {
//     List<NewsRepositories>? results = [];
//     if (query.isEmpty) {
//       results = articles;  // Show all articles when search is empty
//     } else {
//       results = articles?.where((article) {
//         // final titleLower = article.t.toLowerCase() ?? '';
//         final searchLower = query.toLowerCase();
//         return titleLower.contains(searchLower);
//       }).toList();
//     }
//
//     setState(() {
//       filteredArticles = results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: 'Search news...',
//             border: InputBorder.none,
//           ),
//           onChanged: _filterArticles,  // Call the search method whenever the text changes
//         ),
//       ),
//       body: filteredArticles == null
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: filteredArticles?.length ?? 0,
//         itemBuilder: (context, index) {
//           final article = filteredArticles![index];
//           return ListTile(
//             title: Text(article.title ?? 'No Title'),
//             subtitle: Text(article.description ?? 'No Description'),
//           );
//         },
//       ),
//     );
//   }
// }
