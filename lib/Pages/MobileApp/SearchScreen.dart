// import 'package:flutter/material.dart';
//
// import '../../Models/NewsCategoryModel.dart';
// import '../../presentation/NewsViewModel.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final _searchController = TextEditingController();
//   final newsViewModel = NewsViewModel();
//   List<Articles>? _searchResults;
//   bool _isLoading = false;
//
//   // Function to perform search
//   void _performSearch() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final results = await newsViewModel.searchNews(_searchController.text);
//       setState(() {
//         _searchResults = results.cast<Articles>();
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Search failed: $e')));
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Search News')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _performSearch,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : _searchResults != null && _searchResults!.isNotEmpty
//                     ? Expanded(
//                         child: ListView.builder(
//                           itemCount: _searchResults!.length,
//                           itemBuilder: (context, index) {
//                             final article = _searchResults![index];
//                             return Card(
//                               child: ListTile(
//                                 title: Text(article.title ?? ''),
//                                 subtitle: Text(article.description ?? ''),
//                                 leading: article.urlToImage != null
//                                     ? Image.network(article.urlToImage!)
//                                     : null,
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : Text('No results found'),
//           ],
//         ),
//       ),
//     );
//   }
// }
