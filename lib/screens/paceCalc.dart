import 'package:flutter/material.dart';

import 'package:mobiili1/constants.dart';
import 'package:mobiili1/widgets/funcButton.dart';

import 'package:mobiili1/widgets/paceUi.dart';

import 'package:mobiili1/widgets/shoeInfoText.dart';
import 'package:mobiili1/widgets/showLogo.dart';

class PaceCalc extends StatefulWidget {
  const PaceCalc({Key? key}) : super(key: key);

  @override
  _PaceCalcState createState() => _PaceCalcState();
}

class _PaceCalcState extends State<PaceCalc> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minsController = TextEditingController();
  final TextEditingController _secController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  String _result = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: mainAppBarColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowLogo(),
                Container(
                  width: 360,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShoeInfoText(
                        'Pace Calculator',
                        color: darkText,
                        weight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 360,
                    height: 200,
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: darkText,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ShoeInfoText('Hour:'),
                            PaceTextField(
                              hintText: 'hh',
                              controller: _hoursController,
                              textColor: textColorLight,
                            ),
                            ShoeInfoText('Min:'),
                            PaceTextField(
                              hintText: 'mm',
                              controller: _minsController,
                              textColor: textColorLight,
                            ),
                            ShoeInfoText('Sec:'),
                            PaceTextField(
                                hintText: 'ss',
                                controller: _secController,
                                textColor: textColorLight),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ShoeInfoText('Dist:'),
                            Container(
                              width: 50,
                              child: PaceTextField(
                                  controller: _kmController,
                                  hintText: 'Kms',
                                  textColor: textColorLight),
                            ),
                            FuncButton(text: 'Calc', func: calc),
                            FuncButton(
                              text: 'Clear',
                              func: clearAll,
                              color: textColorLight,
                              textColor: darkText,
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 11),
                          child: ShoeInfoText(
                            _result != '' ? 'Pace is $_result min/km' : '',
                            weight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearAll() {
    setState(() {
      _result = '';
      _hoursController.text = '';
      _minsController.text = '';
      _secController.text = '';
      _kmController.text = '';
    });
  }

  void calc() {
    var _hours = _hoursController.text.isNotEmpty
        ? double.parse(_hoursController.text)
        : 0;
    var _mins = _minsController.text.isNotEmpty
        ? double.parse(_minsController.text)
        : 0;
    var _secs =
        _secController.text.isNotEmpty ? double.parse(_secController.text) : 0;
    var _distKm = double.parse(_kmController.text);
    setState(() {
      try {
        var totalSeconds = _hours * 3600 + _mins * 60 + _secs;
        var secondsPerDist = totalSeconds / _distKm;
        var totalMins = secondsPerDist ~/ 60;
        var remainderSeconds = (secondsPerDist.remainder(60)).round();
        if (remainderSeconds < 10 && remainderSeconds > 0) {
          _result =
              '$totalMins:0$remainderSeconds'; // jos sekunnit == 1-9, laitetaan 0 eteen. Esim. 5:06 min/km, ei 5:6 min/km.
        } else {
          _result = remainderSeconds != 0
              ? '$totalMins:$remainderSeconds'
              : '$totalMins';
        }
      } catch (exp) {
        print(exp);
      }
    });
  }
}
