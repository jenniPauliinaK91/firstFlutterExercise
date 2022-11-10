import 'package:flutter/material.dart';
import 'package:mobiili1/widgets/funcButton.dart';

import 'package:mobiili1/constants.dart';
import 'package:mobiili1/shoe.dart';
import 'package:mobiili1/db_helper.dart';
import 'package:mobiili1/widgets/paceUi.dart';
import 'package:mobiili1/widgets/shoeInfoText.dart';

class ShoePage extends StatefulWidget {
  const ShoePage({Key? key}) : super(key: key);

  @override
  _ShoePageState createState() => _ShoePageState();
}

class _ShoePageState extends State<ShoePage> {
//Text editing controllers
  final _textControllerKms = TextEditingController();
  final _textControllerName = TextEditingController();
  final _textControllerDate = TextEditingController();

// Variables
  int _summa = 0; //Käytetään kilometrien päivittämiseen
  String _selectedName = ''; //valitun kengän nimi
  int? _selectedId; // valitun kengän id
  int _kmsInt = 0; //käytetään kilometrien päivittämiseen
  String _date = ''; //uuden kengän lisäyksessä käyttöönottopäivä

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

            //resizeToAvoidBottomInset: false, ei tule bottom overflowia kun ottaa keyboardin esiin mutta SingleChildScrollView on parempi
            appBar: AppBar(
                backgroundColor: mainAppBarColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: Builder(builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                          width: 100,
                        ),
                      ),
                      Container(
                        width: 360,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ShoeInfoText(
                              'Select a Shoe',
                              color: darkText,
                              weight: FontWeight.w600,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 360,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: darkText, width: 2)),
                        child: FutureBuilder<List<Shoe>>(
                            future: DatabaseHelper.instance.getShoes(),
                            initialData: const [], //poisti error-välähdyksen avatessa appin
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Shoe>> snapshot) {
                              //  if (snapshot.hasData) { //tämäkin poisti em. errorin
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<Shoe>(
                                  icon: const Icon(
                                    Icons.arrow_downward_rounded,
                                    color: Colors.black,
                                  ),
                                  hint: Text(snapshot.data!.isNotEmpty
                                      ? 'Select shoe'
                                      : 'No shoes added'),
                                  isExpanded: true,
                                  items: snapshot.data!
                                      .map((shoe) => DropdownMenuItem<Shoe>(
                                            child: Text(shoe.name),
                                            value: shoe,
                                          ))
                                      .toList(),
                                  onChanged: (shoe) {
                                    setState(() {
                                      _selectedName = shoe!.name;
                                      _selectedId = shoe.id;
                                      _date = shoe.date;
                                      _kmsInt = shoe.kms;
                                    });
                                  },
                                ),
                              );
                              //   }
                              // return const CircularProgressIndicator();
                            }),
                      ),
                      Container(
                        width: 360,
                        height: 130,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: darkText,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ShoeInfoText(
                                  'Shoe: ',
                                ),
                                ShoeInfoText(
                                  _selectedName,
                                  weight: FontWeight.w500,
                                  color: mainButtonColor,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ShoeInfoText(
                                  'Start of use: ',
                                ),
                                ShoeInfoText(
                                  _date,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ShoeInfoText(
                                  'Kilometers run: ',
                                ),
                                ShoeInfoText(
                                  _kmsInt == 0 ? '' : '$_kmsInt',
                                  weight: FontWeight.w500,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ShoeInfoText('Add kms:',
                                weight: FontWeight.w600, color: darkText),
                            SizedBox(
                                width: 80,
                                child: PaceTextField(
                                  controller: _textControllerKms,
                                  hintText: 'km',
                                )),
                            FuncButton(text: 'Add', func: addKms)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 360,
                        child: Row(
                          children: [
                            _selectedId != null
                                ? TextButton(
                                    child: Text('Delete shoe',
                                        style: TextStyle(color: darkText)),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Scaffold(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  body: Builder(
                                                      builder: (context) =>
                                                          GestureDetector(
                                                              onTap: () {},
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    _selectedName),
                                                                content: const Text(
                                                                    "Are you sure you want to delete this shoe?"),
                                                                actions: [
                                                                  TextButton(
                                                                      child: const Text(
                                                                          'No'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }),
                                                                  TextButton(
                                                                      child: const Text(
                                                                          'Yes'),
                                                                      onPressed:
                                                                          () {
                                                                        deleteShoe();
                                                                      })
                                                                ],
                                                              ))))));
                                    })
                                : const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        width: 360,
                        margin: const EdgeInsets.only(top: 10),
                        child: ExpansionTile(
                          title: ShoeInfoText(
                            'Add new shoe',
                            color: mainButtonColor,
                            weight: FontWeight.w600,
                          ),
                          children: <Widget>[
                            TextField(
                              controller: _textControllerName,
                              decoration:
                                  const InputDecoration(hintText: 'Shoe name'),
                            ),
                            TextField(
                              controller: _textControllerDate,
                              decoration: const InputDecoration(
                                  hintText: 'Start of use (dd.mm.yyyy)'),
                              keyboardType: TextInputType.number,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: mainButtonColor),
                                onPressed: () async {
                                  try {
                                    if (_textControllerName.text != '' &&
                                        _textControllerDate.text != '') {
                                      await DatabaseHelper.instance.add(Shoe(
                                          name: _textControllerName.text,
                                          date: _textControllerDate.text,
                                          kms: 0));

                                      const text = 'New Shoe Added';
                                      const snackBar = SnackBar(
                                        content: Text(
                                          text,
                                          style:
                                              TextStyle(color: textColorLight),
                                        ),
                                        backgroundColor: mainButtonColor,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      setState(() {
                                        _textControllerDate.clear();
                                        _textControllerName.clear();
                                      });
                                    }
                                  } catch (excp) {
                                    final snackBar = SnackBar(
                                      content: Text(excp as String),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: const Text('Add'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }

  void addKms() async {
    int _uusiKms = int.parse(_textControllerKms.text);
    _summa = _uusiKms + _kmsInt;

    await DatabaseHelper.instance.update(
        Shoe(date: _date, name: _selectedName, id: _selectedId, kms: _summa));

    setState(() {
      _kmsInt = _summa;
      _textControllerKms.text = '';
    });
  }

  void showSnackBar(BuildContext context) {}

  void deleteShoe() {
    setState(() {
      DatabaseHelper.instance.remove(_selectedId!);
      _selectedName = '';
      _kmsInt = 0;
      _date = '';
      _selectedId = null;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Shoe deleted.')));
  }
}
