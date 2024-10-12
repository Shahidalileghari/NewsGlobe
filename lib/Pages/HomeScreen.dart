import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Models/NewsChannelHeadlinesModel.dart';
import '../presentation/NewsViewModel.dart';

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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const CategoryNewsScreen()));
        //     },
        //     icon: Image.asset(
        //       "asset/category_icon.png",
        //       width: 30,
        //       height: 30,
        //     )),
        title: Text(
          "News App",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<FilterItems>(
              onSelected: (FilterItems items) {
                if (FilterItems.bbcNews.name == items.name) {
                  name = "bbc-news";
                } else if (FilterItems.aryNews.name == items.name) {
                  name = "ary-news";
                } else if (FilterItems.alJazeera.name == items.name) {
                  name = "al-jazeera-english";
                } else if (FilterItems.bloomberg.name == items.name) {
                  name = "bloomberg";
                }
                setState(() {
                  selectedMenu = items;
                });
              },
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
                size: 30,
              ),
              initialValue: selectedMenu,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterItems>>[
                    const PopupMenuItem<FilterItems>(
                      value: FilterItems.bbcNews,
                      child: Text("BBC NEWS"),
                    ),
                    const PopupMenuItem<FilterItems>(
                      value: FilterItems.bbcNews,
                      child: Text("Bloomberg"),
                    ),
                    const PopupMenuItem<FilterItems>(
                      value: FilterItems.bbcNews,
                      child: Text("ary-news"),
                    ),
                    const PopupMenuItem<FilterItems>(
                      value: FilterItems.bbcNews,
                      child: Text("AlJazeera"),
                    ),
                  ])
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: height * 0.55,
            width: double.infinity,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
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
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.articles?.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .02),
                                  width: width * 0.8,
                                  height: height * 0.6,
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
                                  bottom: 22,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        alignment: Alignment.bottomCenter,
                                        height: height * 0.22,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * .7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: width * .7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: FutureBuilder<NewsCategoryModel>(
          //       future: newsViewModel.fetchNewsCategoryModel("general"),
          //       builder: (BuildContext context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(
          //             child: SpinKitFadingCircle(
          //               color: Colors.red,
          //               size: 34,
          //             ),
          //           );
          //         } else if (snapshot.hasError) {
          //           return Center(
          //             child: Text(
          //               "Error loading ${snapshot.error}",
          //               style:
          //                   const TextStyle(color: Colors.black, fontSize: 24),
          //             ),
          //           );
          //         } else if (!snapshot.hasData ||
          //             snapshot.data?.articles == null) {
          //           return const Center(
          //             child: Text("No data available"),
          //           );
          //         } else {
          //           return ListView.builder(
          //               shrinkWrap: true,
          //               itemCount: snapshot.data?.articles?.length,
          //               itemBuilder: (context, index) {
          //                 DateTime dateTime = DateTime.parse(snapshot
          //                     .data!.articles![index].publishedAt
          //                     .toString());
          //                 return Card(
          //                   color: Colors.grey,
          //                   child: Row(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(15),
          //                         child: CachedNetworkImage(
          //                           imageUrl: snapshot
          //                               .data!.articles![index].urlToImage
          //                               .toString(),
          //                           fit: BoxFit.cover,
          //                           width: width * .3,
          //                           height: height * 0.18,
          //                           placeholder: (context, url) =>
          //                               const SpinKitFadingCircle(
          //                             color: Colors.amber,
          //                             size: 50,
          //                           ),
          //                           errorWidget: (context, url, error) =>
          //                               const Icon(
          //                             Icons.error,
          //                             color: Colors.red,
          //                             size: 40,
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: Container(
          //                           height: height * 0.18,
          //                           padding: const EdgeInsets.only(left: 14),
          //                           child: Column(
          //                             children: [
          //                               Text(
          //                                 snapshot.data!.articles![index].title
          //                                     .toString(),
          //                                 maxLines: 3,
          //                                 style: GoogleFonts.poppins(
          //                                     fontWeight: FontWeight.w700,
          //                                     color: Colors.black,
          //                                     fontSize: 16),
          //                               ),
          //                               const Spacer(),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text(
          //                                     snapshot.data!.articles![index]
          //                                         .source!.name
          //                                         .toString(),
          //                                     style: GoogleFonts.poppins(
          //                                         fontWeight: FontWeight.w500,
          //                                         color: Colors.black54,
          //                                         fontSize: 16),
          //                                   ),
          //                                   Text(
          //                                     format.format(dateTime),
          //                                     style: GoogleFonts.poppins(
          //                                         fontWeight: FontWeight.w400,
          //                                         color: Colors.black),
          //                                   ),
          //                                 ],
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 );
          //               });
          //         }
          //       }),
          // ),
        ],
      ),
    );
  }
}
