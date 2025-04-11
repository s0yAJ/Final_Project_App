import 'package:final_proyect/Utils/U_News.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadNews();
  }

  void reloadNews() async {
    await news_api().GetAllNews();
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: Result_of_news?.first.datos?.length ?? 0,
                  itemBuilder: (context, index) {
                    final dato = Result_of_news?.first.datos?[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(dato?.foto ?? "https://us.123rf.com/450wm/bsd555/bsd5552110/bsd555211000002/177453824-sceptical-view-rgb-color-icon-scepticism-doubting-and-questioning-mindset-scientific-and.jpg?ver=6"),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        dato?.titulo ?? "Not title to show: "),
                                    subtitle: Text(
                                        dato?.contenido ?? "Not content: "),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
