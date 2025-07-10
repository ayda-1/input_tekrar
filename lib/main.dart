import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyProject());
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İnput Tekrar"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: TextFormFieldKullanimi(),
    );
  }
}

class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() =>
      _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {
  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        //bun u init state içinde yapma sebebimiz habire dinjlerse sıkıntı vr ztn burda tanımlı ondn
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
      });
    });
  }

  //dispose sayfa kapandıgında controllerları siler.
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,

            //Seçili gelme olayı
            autofocus: true,
            //Satır sayısı
            maxLines: maxLineCount,
            //Girilecek karakter sayısı (TC)
            maxLength: 11,
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green.shade300,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger) {},
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca
            onSubmitted: (String gelenDeger) {},
          ),
        ),
        TextField(),
      ],
    );
  }
}

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String _email, _password, _userName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          //validate işlemini ne zaman çalıştıracagınıbelirler
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //texteditingcontrolllara ihtiyacduymaz cünkü onSaved vardır
              TextFormField(
                onSaved: (gelenUserName) {
                  _userName = gelenUserName!;
                },
                //varsayilan değeri tanımlar
                // initialValue: "aydanur karaduman",
                decoration: InputDecoration(
                  //hata mesajı rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Kullanici Adi",
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenUserName) {
                  if (girilenUserName!.isEmpty) {
                    return "Kullanıcı Adı boş olamaz!";
                  }
                  if (girilenUserName.length < 4) {
                    return "5 Karakterden az olamaz!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (gelenEmail) {
                  _email = gelenEmail!;
                },
                //varsayilan değeri tanımlar
                // initialValue: "aydanur karaduman",
                decoration: InputDecoration(
                  //hata mesajı rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenEmail) {
                  if (!EmailValidator.validate(girilenEmail!)) {
                    return "Geçerli bir mail giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                onSaved: (gelenPassword) {
                  _password = gelenPassword!;
                },
                //varsayilan değeri tanımlar
                // initialValue: "aydanur karaduman",
                decoration: InputDecoration(
                  //hata mesajı rengini değiştirir
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Şifre",
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenUserName) {
                  if (girilenUserName!.isEmpty) {
                    return "Şifre boş olamaz!";
                  }
                  if (girilenUserName.length < 6) {
                    return "Şifre en az 6 karakter olmalıdır!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),

              SizedBox(
                width: 100,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    bool _isValidate = _formKey.currentState!.validate();
                    if (_isValidate) {
                      //textformfielddan gelen verileri kaydetme işlemi
                      _formKey.currentState!.save();
                      String result =
                          "username:$_userName\nemail:$_email\nşifre:$_password";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.pink,
                          content: Text(
                            result,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                      //save işlemi olduktan sonra text form fieldları temizler
                      _formKey.currentState!.reset();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.green, width: 3),
                    ),
                  ),

                  child: Text("Onayla"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
