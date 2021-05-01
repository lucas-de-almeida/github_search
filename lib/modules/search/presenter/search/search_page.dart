import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search...'),
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is SearchStart) {
                    return Center(
                      child: Text('digiter um texto'),
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text('houve um erro'),
                    );
                  }
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final list = (state as SearchSucess).list;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final item = list[id];
                        return ListTile(
                          leading: item.image == null
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(item.image),
                                ),
                          title: Text(item.title ?? ""),
                          subtitle: Text(item.content),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
