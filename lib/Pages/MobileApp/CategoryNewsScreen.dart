import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Models/NewsCategoryModel.dart';
import '../../presentation/NewsViewModel.dart';
import 'NewsDetailScreen.dart';

class CategoryNewsScreen extends StatefulWidget {
  const CategoryNewsScreen({super.key});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  String name = 'general';
  List<String> categoryList = [
    "general",
    "entertainment",
    "sports",
    "business",
    "health",
    "technology"
  ];
  final format = DateFormat('dd/MM/yyyy');

  Future<void> _refreshNews() async {
    await newsViewModel.fetchNewsCategoryModel(name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            name = categoryList[index];
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: name == categoryList[index]
                                      ? Colors.blue
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Center(
                                      child: Text(
                                    categoryList[index]
                                        .toString()
                                        .toUpperCase(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.white),
                                  )),
                                )),
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: FutureBuilder<NewsCategoryModel>(
                    future: newsViewModel.fetchNewsCategoryModel(name),
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
                            style: const TextStyle(
                                color: Colors.black, fontSize: 24),
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data?.articles == null) {
                        return const Center(
                          child: Text("No data available"),
                        );
                      } else {
                        return ListView.builder(
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
                                          builder: (context) =>
                                              NewsDetailScreen(
                                                source: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                author: snapshot.data!
                                                    .articles![index].author
                                                    .toString(),
                                                description: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .description
                                                    .toString(),
                                                content: snapshot.data!
                                                    .articles![index].content
                                                    .toString(),
                                                newsDate: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString(),
                                                newsImage: snapshot.data!
                                                    .articles![index].urlToImage
                                                    .toString(),
                                                newsTitle: snapshot.data!
                                                    .articles![index].title
                                                    .toString(),
                                              )));
                                },
                                child: Card(
                                  color: Colors.white38,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          width: width * .3,
                                          height: height * 0.18,
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
                                      Expanded(
                                        child: Container(
                                          height: height * 0.18,
                                          width: 400,
                                          padding:
                                              const EdgeInsets.only(left: 14),
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              const Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
