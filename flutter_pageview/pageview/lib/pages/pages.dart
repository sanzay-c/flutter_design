import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pageview/data/data.dart';
import 'package:pageview/pages/new_page.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() {
    return _PagesState();
  }
}

class _PagesState extends State<Pages> {
  PageController? _controller;
  int currentIndex = 0;
  double percentage = 0.25;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contentsList[currentIndex].backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              /* Creates a widget that expands a child of a [Row], 
                [Column], or [Flex] so that the child fills the available 
                space along the flex widget's main axis. 
              */
              flex: 5,
              child: PageView.builder(
                controller: _controller,
                itemCount: contentsList.length,
                onPageChanged: (int index) {
                  if (index >= currentIndex) {
                    setState(() {
                      currentIndex = index;
                      percentage += 0.25;
                    });
                  } else {
                    setState(() {
                      currentIndex = index;
                      percentage -= 0.25;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: currentIndex == 0 || currentIndex == 3
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              contentsList[currentIndex].title,
                              style: const TextStyle(
                                fontFamily: "SF-Pro",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 28.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              contentsList[currentIndex].title,
                              style: const TextStyle(
                                fontFamily: "SF-Pro",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                      SvgPicture.asset(contentsList[currentIndex].image),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: List.generate(
                            contentsList.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          onPressed: () {
                            _controller!.animateToPage(
                              contentsList.length - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuint,
                            );
                          },
                        ),
                      ],
                    ),
                    CupertinoButton(
                      // padding: EdgeInsets.zero,
                      child: Stack(
                        alignment: Alignment.center, // to center the icon;
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: CircularProgressIndicator(
                              value: percentage,
                              backgroundColor: Colors.white38,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: contentsList[currentIndex].backgroundColor,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (currentIndex == contentsList.length - 1) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewPageScreen()));
                        }
                        _controller!.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.white : Colors.white38,
      ),
    );
  }
}
