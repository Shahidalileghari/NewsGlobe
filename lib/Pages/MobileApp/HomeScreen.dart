// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// import '../../Models/NewsChannelHeadlinesModel.dart';
// import '../../presentation/NewsViewModel.dart';
// import 'NewsDetailScreen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// enum FilterItems {
//   bbcNews,
//   aryNews,
//   independent,
//   routers,
//   cnn,
//   bloomberg,
//   alJazeera
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   NewsViewModel newsViewModel = NewsViewModel();
//   FilterItems? selectedMenu;
//   final format = DateFormat('dd/MM/yyyy');
//   String name = "bbcNews";
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width * 1;
//     final height = MediaQuery.sizeOf(context).height * 1;
//     return Scaffold(
//       //   title: Text(
//       //     "News App",
//       //     style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.blue,
//       //   actions: [
//       //     PopupMenuButton<FilterItems>(
//       //         onSelected: (FilterItems items) {
//       //           if (FilterItems.bbcNews.name == items.name) {
//       //             name = "bbc-news";
//       //           } else if (FilterItems.aryNews.name == items.name) {
//       //             name = "ary-news";
//       //           } else if (FilterItems.alJazeera.name == items.name) {
//       //             name = "al-jazeera-english";
//       //           } else if (FilterItems.bloomberg.name == items.name) {
//       //             name = "bloomberg";
//       //           }
//       //           setState(() {
//       //             selectedMenu = items;
//       //           });
//       //         },
//       //         icon: const Icon(
//       //           Icons.more_vert_outlined,
//       //           color: Colors.black,
//       //           size: 30,
//       //         ),
//       //         initialValue: selectedMenu,
//       //         itemBuilder: (BuildContext context) =>
//       //             <PopupMenuEntry<FilterItems>>[
//       //               const PopupMenuItem<FilterItems>(
//       //                 value: FilterItems.bbcNews,
//       //                 child: Text("BBC NEWS"),
//       //               ),
//       //               const PopupMenuItem<FilterItems>(
//       //                 value: FilterItems.bbcNews,
//       //                 child: Text("Bloomberg"),
//       //               ),
//       //               const PopupMenuItem<FilterItems>(
//       //                 value: FilterItems.bbcNews,
//       //                 child: Text("ary-news"),
//       //               ),
//       //               const PopupMenuItem<FilterItems>(
//       //                 value: FilterItems.bbcNews,
//       //                 child: Text("AlJazeera"),
//       //               ),
//       //             ])
//       //   ],
//       // ),
//       backgroundColor: Colors.blueGrey,
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 6,
//           ),
//           Expanded(
//             child: FutureBuilder<NewsChannelHeadlinesModel>(
//                 future: newsViewModel.fetchNewsChannelHeadlinesAPIs(),
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: SpinKitFadingCircle(
//                         color: Colors.red,
//                         size: 34,
//                       ),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         "Error loading ${snapshot.error}",
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 24),
//                       ),
//                     );
//                   } else if (!snapshot.hasData ||
//                       snapshot.data?.articles == null) {
//                     return const Center(
//                       child: Text("No data available"),
//                     );
//                   } else {
//                     return ListView.builder(
//                         //scrollDirection: Axis.horizontal,
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: snapshot.data?.articles?.length,
//                         itemBuilder: (context, index) {
//                           DateTime dateTime = DateTime.parse(snapshot
//                               .data!.articles![index].publishedAt
//                               .toString());
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => NewsDetailScreen(
//                                             source: snapshot.data!
//                                                 .articles![index].source!.name
//                                                 .toString(),
//                                             author: snapshot
//                                                 .data!.articles![index].author
//                                                 .toString(),
//                                             description: snapshot.data!
//                                                 .articles![index].description
//                                                 .toString(),
//                                             content: snapshot
//                                                 .data!.articles![index].content
//                                                 .toString(),
//                                             newsDate: snapshot.data!
//                                                 .articles![index].publishedAt
//                                                 .toString(),
//                                             newsImage: snapshot.data!
//                                                 .articles![index].urlToImage
//                                                 .toString(),
//                                             newsTitle: snapshot
//                                                 .data!.articles![index].title
//                                                 .toString(),
//                                           )));
//                             },
//                             child: SizedBox(
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(4),
//                                     width: 450,
//                                     height: 250,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: CachedNetworkImage(
//                                         imageUrl: snapshot
//                                             .data!.articles![index].urlToImage
//                                             .toString(),
//                                         fit: BoxFit.cover,
//                                         placeholder: (context, url) =>
//                                             const SpinKitFadingCircle(
//                                           color: Colors.amber,
//                                           size: 50,
//                                         ),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(
//                                           Icons.error,
//                                           color: Colors.red,
//                                           size: 40,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 10,
//                                     left: 10,
//                                     right: 10,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Card(
//                                         color: Colors.white38,
//                                         elevation: 5,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: SizedBox(
//                                             width: 450,
//                                             height: 50,
//                                             child: Center(
//                                               child: Text(
//                                                 snapshot.data!.articles![index]
//                                                     .title
//                                                     .toString(),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   }
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Models/NewsChannelHeadlinesModel.dart';
import '../../presentation/NewsViewModel.dart';
import 'NewsDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterItems {
  bbcNews,
  aryNews,
  independent,
  routers,
  cnn,
  bloomberg,
  alJazeera
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterItems? selectedMenu;
  final format = DateFormat('dd/MM/yyyy');
  String name = "bbcNews";
  bool hasReachedEnd = false; // Boolean to track if end of list is reached

  // Function to fetch and refresh the news
  Future<void> _refreshNews() async {
    // Fetch updated news data
    await newsViewModel.fetchNewsChannelHeadlinesAPIs();
    setState(() {
      hasReachedEnd = false; // Reset the end of list tracker on refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: ListView(
          children: [
            const SizedBox(
              height: 6,
            ),
            FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesAPIs(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.red,
                        size: 34,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error loading ${snapshot.error}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data?.articles == null) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          // Make sure the list scrolls
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.articles?.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetailScreen(
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content: snapshot.data!
                                                  .articles![index].content
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              newsImage: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                            )));
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      width: 450,
                                      height: 250,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const SpinKitFadingCircle(
                                            color: Colors.amber,
                                            size: 50,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          color: Colors.white38,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: SizedBox(
                                              width: 450,
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Check if end of the list is reached
                        if (!hasReachedEnd)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Scroll to see more news...",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ),
                        if (hasReachedEnd)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "You have reached the end",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.redAccent),
                            ),
                          )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
