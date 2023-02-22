import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/bloc/joke_bloc/joke_bloc.dart';
import 'package:joke_app/repository/joke_repostory.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokeBloc(
        RepositoryProvider.of<JokeRepository>(context),
      )..add(LoadJokeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Joke App'),
        ),
        body: BlocBuilder<JokeBloc, JokeState>(
          builder: (context, state) {
            if (state is JokeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is JokeLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(
                        state.joke.setup,
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            state.joke.delivery,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //TODO Load New Joke
                        BlocProvider.of<JokeBloc>(context).add(LoadJokeEvent());
                      },
                      child: const Text('Load New Joke'),
                    ),
                  ],
                ),
              );
            }
            if (state is JokeErrorState) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
