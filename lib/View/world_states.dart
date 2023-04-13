

import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countires_lis.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
  )..repeat();
  @override

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList =<Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override

  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              FutureBuilder(
                  future: statesServices.fetchWorldStateRecords(),
                  builder:(context , AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,

                        ),
                      );
                    }
                    else{
                        return Column(
                          children: [
                            PieChart(dataMap: {
                              "Total":double.parse(snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                              "deaths":double.parse(snapshot.data!.deaths!.toString()),
                            },
                              animationDuration: const Duration(milliseconds: 1200),
                              colorList: colorList,
                              chartType: ChartType.ring,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              chartRadius: MediaQuery.of(context).size.width/3.2,

                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                    ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                    ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString())
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(

                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Center(
                                  child: Text('Track Countries',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),),
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                              },
                            )
                          ],
                        );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title , value;
  ReusableRow({Key? key, required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 15,),
          Divider()
        ],
      ),
    );
  }
}

