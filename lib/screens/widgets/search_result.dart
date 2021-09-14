import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

import '../../constants.dart';

class SearchResult extends StatelessWidget {
  String currentSearch;
  SearchResult({this.currentSearch});
  HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    _bloc = BlocProvider.of<HomeBloc>(context);


    List<dynamic>toShow=[];
    List<int>typeOf = [];
    for (int i = 0; i < _bloc.state.allTournaments.length; i++) {
      if (startsWith(_bloc.state.allTournaments[i].name, currentSearch)) {
        toShow.add(_bloc.state.allTournaments[i]);
        typeOf.add(1);
      }
    }
    for(int i=0;i<_bloc.state.allFifa.length;i++){
      if(startsWith(_bloc.state.allFifa[i].name, currentSearch)){
        toShow.add(_bloc.state.allFifa[i]);
        typeOf.add(0);
      }
    }
    // 0 for fifa and 1 for tournament.
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Failure) {
          return Center(
            child: Text('Failed'),
          );
        } else if (state is InitialState) {
          return Container();
        }
        return GridView.builder(

          itemCount: toShow.length,
          itemBuilder: (_, ind) {
            if(typeOf[ind] == 1){
              return TournamentTile(
                here: toShow[ind],
              );
            }
            else{
              return FifaTile(fifa: toShow[ind],);
            }

          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // width: w * (145 / kScreenW),
//height: h * (212 / kScreenH)
              childAspectRatio: (w * (160 / kScreenW)) / (h * (205 / kScreenH)),
              mainAxisSpacing: 10),
        );
      },
    );
  }
}

bool startsWith(String a, String b) {
  a = a.toLowerCase();
  b = b.toLowerCase();
  if (a.isEmpty || b.isEmpty) return true;
  if (a.length < b.length) {
    String c = a;
    a = b;
    b = c;
  }
  for (int i = 0; i < b.length; i++) {
    if (b[i] != a[i]) return false;
  }
  return true;
}
