import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(

                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search with country name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                  ),
                  onChanged: (value){
                    setState(() {

                    });
                  },

                ),
              ),
              Expanded(
                  child:FutureBuilder(
                    future: statesServices.countriesListApi(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot!.hasData){
                            return ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index){
                                return Shimmer.fromColors(

                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(

                                        leading:Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        title: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                );

                              },
                            );
                      }
                      else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(

                                    child: ListTile(

                                      leading: Image(
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        test:  snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],

                                    )));
                                      },
                                  )
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    child: ListTile(

                                      leading: Image(
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                        height: 50,
                                        width: 50,
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        test:  snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],

                                      )));
                                    },
                                  )
                                ],
                              );
                            }
                            else{
                              return Container();
                            }
                            // return Column(
                            //   children: [
                            //         ListTile(
                            //
                            //           leading: Image(
                            //             image: NetworkImage(
                            //             snapshot.data![index]['countryInfo']['flag']
                            //             ),
                            //             height: 50,
                            //             width: 50,
                            //           ),
                            //           title: Text(snapshot.data![index]['country']),
                            //           subtitle: Text(snapshot.data![index]['cases'].toString()),
                            //         )
                            //   ],
                            // );
                          },
                        );
                      }

                    },
                  )
              ),
            ],
          ),
        ),
    );
  }
}
