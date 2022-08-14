import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({ Key? key }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
   final textScale = MediaQuery.of(context).textScaleFactor;
    return  Scaffold(
      
      body: Stack(
        children: [
          
  
          // ignore: avoid_unnecessary_containers
          Container(
            
            child: SingleChildScrollView(child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.blueAccent,
                  title: const Text("Brand Builder"),
      ),
       Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         child: Column(
           children: [
             Container(
              decoration: BoxDecoration(border: Border.all(width: 5)),
               child: Image(image: const AssetImage('assets/images/bb.png'),
                height: 200,
                          width: MediaQuery.of(context).size.width * 0.8,
                          fit: BoxFit.contain,),
             ),
             const SizedBox(height: 20,),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              Text("Title:", style: TextStyle(fontSize: 15 * textScale, fontWeight: FontWeight.bold),),
                             
                              Text('Brand Builder.com', style: TextStyle(fontSize: 15 * textScale, fontWeight: FontWeight.bold),)
                            ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text("Description:", style: TextStyle(fontSize: 15* textScale, fontWeight: FontWeight.bold),),
                                
                                 // ignore: sized_box_for_whitespace
                                 Container(
                                  
                                  width: MediaQuery.of(context).size.width*0.56,
                                  child: Text("Our development team and the client discuss about the problem domain or any idea and collects information to make the requirements clear for both parties.We use Fig Jam and Miro for interactive and informative requirement analysis. After requirement gathering, our team allocates tools and resources for software development process. Afterwards, we schedule the time needed for the  software development.", 
                                  style: TextStyle(fontSize: 15 * textScale),))
                               
                        
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Features: ",  style: TextStyle(fontSize: 15 * textScale, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Digital Marketing", style: TextStyle(fontSize: 15 * textScale,)),
                                Text('UX/UI Design', style: TextStyle(fontSize: 15 * textScale,),),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("App Development", style: TextStyle(fontSize: 15 * textScale,)),
                                Text("SEO", style: TextStyle(fontSize: 15 * textScale,))
                              ],
                            )
                          ],
                        )
           ],
         ),
       )
              ],
            ),)
            
          ),
      
      ],

      ),
    );
  }
}