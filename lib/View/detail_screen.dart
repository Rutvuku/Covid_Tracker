import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases ,totalDeaths, totalRecovered,active,critical,todayRecovered,test;
  DetailScreen({
    required this.name,
    required this.todayRecovered,
    required this.critical,
    required this.active,
    required this.image,
    required this.test,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          backgroundColor: Colors.grey,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height*0.067 ),
                        ReusableRow(title: 'cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'deaths', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'today Recovered', value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'active', value: widget.active.toString()),
                        ReusableRow(title: 'critical', value: widget.critical.toString()),
                        ReusableRow(title: 'tests', value: widget.test.toString()),


                      ],
                    ),
                  ),
                ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),

            ],
            alignment: AlignmentDirectional.topCenter,
          )
        ],
      ),
    );
  }
}
