import 'dart:async';
import 'package:emergingideas/model/ideas_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






class IdeasRepository  {

  @override
  Future<List<IdeasModel>> getIdeas() async {
    final response =  await http.get(Uri.parse("https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com"));

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      List<IdeasModel> ideas=[];
      for(var item in jsonDecode(responseString))
      ideas.add(IdeasModel.fromJson(item));
      return ideas;
    } else {
      throw Exception();
    }
  }
  @override
  Future<String> deleteIdeas(int id) async {
    String url="https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com&id=$id";
    final response =  await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return jsonDecode(responseString)[0]['message'];
    } else {
      throw Exception();
    }
  }
  @override
  Future<String> editeIdeas(IdeasModel _idea) async {
    String url="https://emergingideas.ae/test_apis/edit.php?id=${_idea.id}&email=${_idea.email}&img_linke=${_idea.img_link}&title=${_idea.title}&description=${_idea.description}";
    final response =  await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return jsonDecode(responseString)[0]['message'];
    } else {
      throw Exception();
    }
  }
  @override
  Future<String> createIdeas(IdeasModel _idea) async {
    String url="https://emergingideas.ae/test_apis/create.php";

    final response = await http.post(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({

      'title':_idea.title,
      "img_link":_idea.img_link,
      'description':_idea.description,
      'email':_idea.email
    }));

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return jsonDecode(responseString)[0]['message'];
    } else {
      throw Exception();
    }
  }



}