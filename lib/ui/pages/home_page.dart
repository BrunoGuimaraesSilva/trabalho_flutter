import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/components/components.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _setValueState(String value) async {
    final SharedPreferences prefs = await _prefs;
    final bool savedText = prefs.getString('texto') != null ? true : false;
    if (!savedText) {
      prefs.setString('texto', value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.calculate_outlined),
          SizedBox(
            width: 8,
          ),
          Text('Cálculo de IMC'),
        ]),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Icon(Icons.people),
          ),
          ListTile(
            title: const Text('Contato'),
            onTap: () {
              _openContactPage();
            },
          ),
        ],
      )),
      body: ListView(children: [
        FieldText(
          controller: _weightController,
          keyboard: TextInputType.number,
          label: 'Peso (Kg)',
        ),
        FieldText(
          controller: _heightController,
          keyboard: TextInputType.number,
          label: 'Altura (M)',
        ),
        Button(
          value: 'Calcular',
          pressedAction: _calculatePressed,
        )
      ]),
    );
  }

  void _calculatePressed() {
    double weight =
        double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0;
    double height =
        double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0;

    _calcImc(weight, height);
  }

  void _calcImc(double weight, double height) {
    if (weight == 0) {
      _showMessage('Peso Inválido');
      return;
    }

    if (height == 0) {
      _showMessage('Altura Inválida');
      return;
    }

    double imcResult = weight / (height * height);

    String message = 'IMC é de $imcResult, você tem';

    if (imcResult < 18.5) {
      _showMessage('$message abaixo do peso');
    }
    if (imcResult > 18.4 && imcResult < 25) {
      _showMessage('$message saudável');
    }
    if (imcResult > 24.9 && imcResult < 30) {
      _showMessage('$message com exesso de peso');
    }
    if (imcResult > 29.9 && imcResult < 35) {
      _showMessage('$message obesidade (grau 1)');
    }
    if (imcResult > 29.9 && imcResult < 41) {
      _showMessage('$message obesidade severa (grau 2)');
    }
    if (imcResult > 40) {
      _showMessage('$message obesidade mórbida (grau 3)');
    }
  }

  void _showMessage(String value) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Resultado'),
            content: Text(value),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () {
                      _openContactPage();
                      _setValueState(value);
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _openContactPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ContactPage()));
  }
}
