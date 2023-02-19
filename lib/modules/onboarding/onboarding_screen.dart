import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//talma el states m4 ktera (we m4 mo3akada ) 5leha statefull 2shal be kteer
class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController=PageController();
  bool isLast=false;
  List<OnboardingModel> boarding=[
    OnboardingModel("assets/images/first.png", "First Screen Title", "This is the body of first screen of shop application "),
    OnboardingModel("assets/images/second.png", "Second Screen Title", "This is the body of second screen of shop application "),
    OnboardingModel("assets/images/third.png", "Third Screen Title", "This is the body of third screen of shop application "),
  ];

  void submit(){
    CacheHelper.saveData(key: "finishBoarding", value: true).then((value)
    {
      if(value==true)
      // ma howa el save data bet return future bool 2enta nassi walla eh !
      {
        navigateToAndReplace(
          context,
          LoginScreen(),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,actions: [
        TextButton(onPressed: (){
          submit();

        }, child: Text("skip",style: TextStyle(color: mainColor,fontWeight: FontWeight.w900)),)
      ]),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              onPageChanged: (index){
                if(index==boarding.length-1)
                  {
                    setState((){
                      isLast=true;

                    });

                  }
                else
                {
                  setState((){
                    isLast=false;

                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>onboradingItem(boarding[index],context),
              itemCount: 3,
              controller: boardController, // bat7akem fe el page 3n tare2 el controller fa 2a2dar 2stfad mn el mawdo3 dh fe 2y 7etta
            )),
            const SizedBox(height: 30,),
            Row(children: [
              SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: mainColor,
                      dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
              ),
              const Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLast!=true)// is last == true we 2na get dost 23mel dh ...
                  {
                    boardController.nextPage(
                    duration: const Duration(milliseconds: 750,), curve: Curves.fastLinearToSlowEaseIn);
                  }
                else
                  {
                    submit();
                  }

                },child: const Icon(Icons.arrow_right_alt)),
            ],)
          ],
        ),
      ),
    );
  }
}
class OnboardingModel{
  final String image;
  final String title;
  final String body;

  OnboardingModel(this.image, this.title, this.body);
}

Widget onboradingItem(OnboardingModel model,context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image))),
      Text(model.title,style:Theme.of(context).textTheme.headlineLarge,),
      const SizedBox(height: 15,),
      Text(model.body),
    ],
  );
}

