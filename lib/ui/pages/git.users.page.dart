import 'package:enset_app/bloc/users.bloc.dart';
import 'package:enset_app/ui/pages/git.user.repositories.page.dart';
import 'package:enset_app/ui/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../widgets/main.drawer.widget.dart';

class GitUserPage extends StatelessWidget {
  const GitUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state is SearchUsersSuccessState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Users",
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                    Text(
                      "${state.currentPage}/${state.totalPages}",
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    )
                  ],
                );
              } else {
                return Text(
                  "Users Page",
                  style: TextStyle(color: Theme.of(context).indicatorColor),
                );
              }
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        String kw = textEditingController.text;
                        context.read<UsersBloc>().add(SearchUsersEvent(
                            keyword: kw, page: 0, pageSize: 20));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state is SearchUsersLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchUsersErrorState) {
                return Column(
                  children: [
                    Text(
                      state.errorMessage,
                      style: CustomThemes.errorTextStyle,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          UsersBloc usersBloc = context.read<UsersBloc>();
                          usersBloc.add(usersBloc.currentEvent);
                        },
                        child: Text("Retry"))
                  ],
                );
              } else if (state is SearchUsersSuccessState) {
                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      context.read<UsersBloc>().add(NextPageEvent(
                          keyword: state.currentKeyword,
                          page: state.currentPage + 1,
                          pageSize: state.pageSize));
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GitRepositories(
                                            user: state.users[index])));
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            state.users[index].avatarUrl),
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(state.users[index].login),
                                    ],
                                  ),
                                  CircleAvatar(
                                    child: Text("${state.users[index].score}"),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 2,
                          );
                        },
                        itemCount: state.users.length),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ));
  }
}
