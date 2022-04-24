import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/components/components.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> _getValueState() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('texto');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('Contato'),
        ]),
      ),
      body: ListView(
        children: [
          FieldText(controller: _nameController, label: 'Nome'),
          FieldText(
            label: 'E-mail',
            controller: _emailController,
            keyboard: TextInputType.emailAddress,
          ),
          Button(
              value: "Enviar",
              pressedAction: () {
                sendEmail();
              }),
        ],
      ),
    );
  }

  void sendEmail() async {
    Future<String?> value = _getValueState();
    String name = _nameController.text;
    String email = _emailController.text;

    if (name.isEmpty) {
      _showMessage('Nome Inválido!');
      return;
    }

    if (email.isEmpty) {
      _showMessage('E-mail Inválido!');
      return;
    }

    // const usuario = "bruno.sil16441@gmail.com";
    // const senha = "alguma";

    // final smtpServer = gmailSaslXoauth2(usuario, senha);

    // if (value.isEmpty) {
    //   _showMessage('Salve o cálculo do IMC para poder enviar');
    // } else {
    //   final mensagem = Message()
    //     ..from = const Address(usuario, "Contato")
    //     ..recipients.add(usuario)
    //     ..subject = "Resultado"
    //     ..text = """Nome: $name,
    //     E-mail: $email,
    //     Mensagem: $value""";

    //   await send(mensagem, smtpServer);

    //   setState(() {
    //     _nameController.clear();
    //     _emailController.clear();
    //   });
    // }
  }

  void _showMessage(String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: Text(texto),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
