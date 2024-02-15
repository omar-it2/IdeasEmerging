import 'package:emergingideas/ideas_bloc/ideas_bloc.dart';
import 'package:emergingideas/model/ideas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdeasBloc(),
      child: const MaterialApp(
        title: 'Ideas',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final TitledController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<IdeasBloc>().add(OnIdeasRead());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<IdeasBloc, IdeasState>(
          listener: (context, state) {
            if (state is IdeasFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                  ),
                ),
              );
            }
          },
      builder: (context, state) {
        if (state is IdeasLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is IdeasInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                color: Colors.grey.shade100,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    IdeasModel _idea = (state as IdeasSucsses).ideas[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                            Text(_idea.title),
                            Text(_idea.email),
                            Text(_idea.description),
                            Text(_idea.img_link),
                            ElevatedButton(onPressed: (){
                              context.read<IdeasBloc>().add(OnIdeasDelete( id: _idea.id));
                              context.read<IdeasBloc>().add(OnIdeasRead());
                            }, child: Text("delete")),
                            ElevatedButton(onPressed: (){
                              context.read<IdeasBloc>().add(OnIdeasEdit( idea: IdeasModel.fromJson({
                                'id':_idea.id,
                                'title':"omar change title",
                                "img_link":"img_link",
                                'description':"description",
                                'email':"email"
                              })));
                              context.read<IdeasBloc>().add(OnIdeasRead());
                            }, child: Text("Edit"))
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount:state is IdeasFailed? 0:(state as IdeasSucsses).ideas.length,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.grey.shade200,
          
          
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller:emailController ,
          
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.grey.shade200,
          
          
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller:TitledController ,
          
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  ElevatedButton(onPressed: (){
                   IdeasModel _idea= IdeasModel.fromJson({
                     'id':0,
                     'title':TitledController.text.trim(),
                     "img_link":"https://",
                     'description':"_idea.description",
                     'email':emailController.text.trim()
                    });
                    context.read<IdeasBloc>().add(OnIdeasCreate(idea: _idea));
                    context.read<IdeasBloc>().add(OnIdeasRead());
          
                  }, child: Text("create"))
                ],),
              ),
              Center(
                child: Container(
          
                  child: Text(state is IdeasFailed? state.error:(state as IdeasSucsses).ideasSucsses),
                ),
              )
            ],
          ),
        );
      },

    ));
  }
}
