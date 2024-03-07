import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    AnimatedContainer _buildDot(int index, int currentPage) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 5),
        height: 14,
        width: currentPage == index ? 30 : 14,
        decoration: BoxDecoration(
          color: currentPage == index ? primaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(18),
        ),
      );
    }

    Widget _actionsButton(int currentPage, VoidCallback? onPressed) {
      return Container(child: 
        Align(alignment: Alignment.bottomCenter, child: Container(
          width: width,
          height: height*0.2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(children: [
                Center(
                  child: AnimatedOpacity(
                    opacity: 3 == currentPage ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child:  Container(
                        width: width *0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Empecemos"),
                            Icon(Icons.arrow_forward),
                          ]
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Theme.of(context).accentColor,
                        minimumSize: Size(width *0.75, 50),
                        shadowColor: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        onSurface: Theme.of(context).accentColor
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: 3 != currentPage ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Icon(Icons.arrow_forward),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Theme.of(context).accentColor,
                        minimumSize: Size(80, 50),
                        shadowColor: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        onSurface: Theme.of(context).accentColor
                      ),
                    ),
                  ),
                ),
              ]),
      
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3,(index) => _buildDot(index, currentPage-1),
                  ),
                ),
              ),
            ],
          ),
        ))
      
      );
    }
    
    Widget _buildImage(String image, int page, int currentPage) {
      return AnimatedOpacity(
        opacity: page == currentPage ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Container(child: 
          Image(width: width, height: height, fit: BoxFit.cover, image: AssetImage('assets/images/onboarding/$image.png')),
        ),
      );
    }

    Widget _buildText(int page, int currentPage, String title, String description) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: width,
              height: height*0.2,
            child: AnimatedOpacity(
                opacity: page == currentPage ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Column(
                children: 
                currentPage == 3 ?[
                  Text("Descubre \nRepública Dominicana", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32.0)),
                ]:[
                  Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32.0)),
                  SizedBox(height: 10),
                  Container( width: width*0.7, child: Text(description,textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0))),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.2)
        ],
      );
    }


    return GetBuilder<OnboardingController>(
      builder: (_) => Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (e) {
            print(e.velocity.pixelsPerSecond);
            
            if (e.velocity.pixelsPerSecond.dx <= -300.0) {
              _.setSlidePage();

            }
            if (e.velocity.pixelsPerSecond.dx >= 300.0) {
              _.setSlideBackPage();

            }
          },
          child: Container(
            width: width,
            height: height,
            child: Expanded(
              child: Obx(() => Stack(children: [
                Stack(children:[
                  _buildImage('onboarding_3', 3, _.currentPage.value),
                  _buildImage('onboarding_2', 2, _.currentPage.value),
                  _buildImage('onboarding_1', 1, _.currentPage.value),
                ]),
                Stack(children:[
                  _buildText(3, _.currentPage.value, "Titulo Prueba 3", "Cuepo texto prueba numero 3"),
                  _buildText(2, _.currentPage.value, "Titulo Prueba 2", "Cuepo texto prueba numero 2"),
                  _buildText(1, _.currentPage.value, "Titulo Prueba 1", "Cuepo texto prueba numero 1"),
                ]),
                _actionsButton(_.currentPage.value, () =>_.setCurrentPage())
            
              ],)),
            ),
          ),
        ),
      )

    );
    // return GetBuilder<OnboardingController>(
    //   builder: (_) => Scaffold(
    //     body: Container(
    //       width: width,
    //       height: height,
    //       child: Obx(() => PageView(
    //         controller: _.pageController,
    //         onPageChanged: _.setCurrentPage,
    //         children: [
    //           _buildPage('onboarding_1', _.currentPage.value),
    //           _buildPage('onboarding_2', _.currentPage.value),
    //           _buildPage('onboarding_3', _.currentPage.value)

    //         ],
    //       )),
    //     )));
  }
}
