import 'package:flutter/material.dart';
import 'package:french_departments_quiz/department.dart';
import 'package:french_departments_quiz/questions.dart';
import 'package:tuple/tuple.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  List<Department> _departments;
  String _question;
  int _typeQuestion;
  Department _currentDepartment;
  String _txtForm1;
  FocusNode _txtFocusNode1;
  String _txtForm2;
  FocusNode _txtFocusNode2;

  @override
  void initState() {
    super.initState();
    _txtFocusNode1 = FocusNode();
    _txtFocusNode2 = FocusNode();
  }

  void _getNewQuestion() {
    _formKey.currentState.reset();
    setState(() {
      _currentDepartment = Questions.getRandomDepartment(_departments);
      Tuple2<String, int> ret = Questions.getRandomQuestion(_currentDepartment);
      _question = ret.item1;
      _typeQuestion = ret.item2;
      switch (_typeQuestion) {
        case 0:
          _txtForm1 = "Nom";
          _txtForm2 = "Préfecture";
          break;
        case 1:
          _txtForm1 = "Numéro";
          _txtForm2 = "Préfecture";
          break;
        case 2:
          _txtForm1 = "Numéro";
          _txtForm2 = "Nom";
          break;
        default:
          break;
      }
    });
  }

  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _txtFocusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/departments.json'),
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  _departments = Department.parseJson(snapshot.data.toString());
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(_question != null ? _question : ""),
                      ));
                } else {
                  return new Center(child: new CircularProgressIndicator());
                }
              }),
          TextFormField(
            focusNode: _txtFocusNode1,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: _txtForm1,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
              contentPadding: EdgeInsets.all(14),
            ),
            validator: (value) {
              if (value.isNotEmpty) {
                switch (_typeQuestion) {
                  case 0:
                    if (value.trim() != _currentDepartment.departmentName) {
                      return "Mauvaise réponse";
                    }
                    break;
                  case 1:
                    if (value.trim() != _currentDepartment.departmentNum) {
                      return "Mauvaise réponse";
                    }
                    break;
                  case 2:
                    if (value.trim() != _currentDepartment.departmentNum) {
                      return "Mauvaise réponse";
                    }
                    break;
                  default:
                    break;
                }
                return null;
              } else {
                return "Saisissez une réponse";
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
          ),
          TextFormField(
            focusNode: _txtFocusNode2,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: _txtForm2,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
              contentPadding: EdgeInsets.all(14),
            ),
            validator: (value) {
              if (value.isNotEmpty) {
                switch (_typeQuestion) {
                  case 0:
                    if (value.trim() != _currentDepartment.prefecture) {
                      return "Mauvaise réponse";
                    }
                    break;
                  case 1:
                    if (value.trim() != _currentDepartment.prefecture) {
                      return "Mauvaise réponse";
                    }
                    break;
                  case 2:
                    if (value.trim() != _currentDepartment.departmentName) {
                      return "Mauvaise réponse";
                    }
                    break;
                  default:
                    break;
                }
                return null;
              } else {
                return "Saisissez une réponse";
              }
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _currentDepartment != null
                        ? null
                        : () {
                            _getNewQuestion();
                          },
                    child: Text('Start'),
                  ),
                  RaisedButton(
                    onPressed: _currentDepartment == null
                        ? null
                        : () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              _getNewQuestion();
                              _txtFocusNode1.requestFocus();
                            }
                          },
                    child: Text('OK'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
