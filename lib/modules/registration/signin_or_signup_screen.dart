import 'dart:convert';

import 'package:dermatechtion/modules/chat/select_user_screen.dart';
import 'package:dermatechtion/modules/registration/camera_or_dermascopy.dart';
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../controllers/provider/auth.dart';
import '../chat/models/app.dart';
import '../customer_service/waiting_screen.dart';
import '../dermatologist/d_dashboard.dart';
import '../patient/dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

import 'take_photo_screen.dart';

class InOrUp extends StatefulWidget {
  const InOrUp({Key? key}) : super(key: key);

  @override
  State<InOrUp> createState() => _InOrUpState();
}

class _InOrUpState extends State<InOrUp> {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    final mailControllerIn = TextEditingController();
    final passwordControllerIn = TextEditingController();

    GlobalKey<FormState> formState= GlobalKey<FormState>();


    return Scaffold(
      body: Form(
        key: formState,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100,),
                  Image.asset('lib/assets/images/DermaTection.png'),
                  myButton(function: () {
                    showDialog(context: context, builder: (context){
                      return SignInAlertDialog(mailControllerIn: mailControllerIn, passwordControllerIn: passwordControllerIn);
                    });
                  }, title: 'Sign In', height: 60),

                  myButton(function: () {
                    showDialog(context: context, builder: (context){
                      return SignUpAlertDialog(nameController: nameController, phoneController: phoneController, mailController: mailController, passwordController: passwordController);
                    });
                  }, title: 'Sign Up', height: 60),
                ],
              ),
            ),
          ),

        ),
      )
    );
  }
}

class SignUpAlertDialog extends StatefulWidget {
  const SignUpAlertDialog({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.mailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController mailController;
  final TextEditingController passwordController;

  @override
  State<SignUpAlertDialog> createState() => _SignUpAlertDialogState();
}

class _SignUpAlertDialogState extends State<SignUpAlertDialog> {

  // creaet user stream chat
  bool _loading = false;


  Future<void> onUserSelected(String id, String name, String image) async {
    setState(() {
      _loading = true;
    });

    try{
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(
            id: id,
            extraData: {
              'name': name,
              'image': image
            }),
        client.devToken(id).rawValue,
      );
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context)=> ChatHomeScreen())
      // );
    } on Exception catch (e ,st){
      logger.e('Could not connect user', e, st);
      setState(() {
        _loading = false;
      });
    }
  }



  Future<void> register(String name, String phone, String email, String password) async {
    showDialog(context: context, builder:(context)=> Center(child: CircularProgressIndicator(),));

    // Define the URL of the PHP script on your local server
    String url = 'http://192.168.43.168:8000/api/register';

    // Define the request body as a map of key-value pairs
    Map<String, String> requestBody = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };
    try{
      print("Hi");
      // Send an HTTP POST request to the server with the request body
      var response = await http.post(Uri.parse(url), body: requestBody);
      final Map<String,dynamic> userData = json.decode(response.body);

      Auth.name = userData['user']['name'];
      Auth.phone = userData['user']['phone'];
      Auth.userToken = userData['token'];
      Auth.email = userData['user']['email'];

      await onUserSelected("${Auth.name}${Auth.phone}",Auth.name,Auth.image);

      Navigator.of(context).pop();
      if(Auth.user=='patient')
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CameraOrDermascopy(),
            ),(
            route) => false
        );
      }else if(Auth.user=='dermatologist')
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DDashboard(),
            ),(
            route) => false
        );
      }
      else
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WaitingScreen(),
            ),(
            route) => false
        );
      }

      widget.nameController.text="";
      widget.phoneController.text="";
      widget.mailController.text="";
      widget.passwordController.text="";

    } catch (e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Center(child: Text('Ooop\'s An Error Occurred')),
        content: Text('$e'),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed:() {
              Navigator.of(context).pop();
            },
          )
        ],
      ),);
      print("Error: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
      title: const Center(child: Text('Sign Up'),),
      content: SingleChildScrollView(
        child: Container(
          height: 455,
          width: double.infinity,
          child: Column(
            children: [
              const Divider(),
              const SizedBox(height: 30,),
              myTextField(
                  type: TextInputType.text,
                  prefix: Icons.person,
                  validate: () {},
                  label: 'Full Name',
                  controller: widget.nameController),
              const SizedBox(height: kDefaultPadding,),
              myTextField(
                  type: TextInputType.phone,
                  prefix: Icons.phone,
                  validate: () {},
                  label: 'Phone',
                  controller: widget.phoneController),
              const SizedBox(height: kDefaultPadding,),
              myTextField(
                  type: TextInputType.emailAddress,
                  prefix: Icons.mail,
                  validate: () {},
                  label: 'Mail address',
                  controller: widget.mailController),
              const SizedBox(height: kDefaultPadding,),
              myTextField(
                  type: TextInputType.text,
                  prefix: Icons.key,
                  validate: (){},
                  obscureText:true,
                  label: 'Password',
                  controller: widget.passwordController),
              const SizedBox(height: 30,),
              myButton(function:()async{

                  await register(
                      widget.nameController.text,
                      widget.phoneController.text,
                      widget.mailController.text,
                      widget.passwordController.text
                  );

              }, title: 'Sign Up', height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInAlertDialog extends StatefulWidget {
  const SignInAlertDialog({
    Key? key,
    required this.mailControllerIn,
    required this.passwordControllerIn,
  }) : super(key: key);

  final TextEditingController mailControllerIn;
  final TextEditingController passwordControllerIn;

  @override
  State<SignInAlertDialog> createState() => _SignInAlertDialogState();
}

class _SignInAlertDialogState extends State<SignInAlertDialog> {

  bool _loading =false ;
  Future<void> onUserSelected(String id, String name, String image) async {
    setState(() {
      _loading = true;
    });

    try{
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(
            id: id,
            extraData: {
              'name': name,
              'image': image
            }),
        client.devToken(id).rawValue,
      );
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context)=> ChatHomeScreen())
      // );
    } on Exception catch (e ,st){
      logger.e('Could not connect user', e, st);
      setState(() {
        _loading = false;
      });
    }
  }
  Future<void> login(String email, String password) async {
    showDialog(context: context, builder:(context)=> Center(child: CircularProgressIndicator(),));
    // Define the URL of the PHP script on your local server
    String url = 'http://192.168.43.168:8000/api/login';

    // Define the request body as a map of key-value pairs
    Map<String, String> requestBody = {
      'email': email,
      'password': password
    };
    try{
      print("Hi");
      // Send an HTTP POST request to the server with the request body
      var response = await http.post(Uri.parse(url), body: requestBody);

      print("read done");

      // Print the response from the server
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200)
        {
          Map<String,dynamic> userData = json.decode(response.body);
          Auth.name = userData['user']['name'];
          Auth.phone = userData['user']['phone'];
          Auth.userToken = userData['token'];
          Auth.email = userData['user']['email'];
          await StreamChatCore.of(context).client.disconnectUser();

          await onUserSelected("${Auth.name}${Auth.phone}",Auth.name,Auth.image);



          if(Auth.user=='patient')
          {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard(),
                ),(
                route) => false
            );
          }else if(Auth.user=='dermatologist')
          {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const DDashboard(),
                ),(
                route) => false
            );
          }
          widget.mailControllerIn.text="";
          widget.passwordControllerIn.text="";
        } else{
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: const Center(child: Text('Ooop\'s An Error Occurred')),
          content: Text('Unautherized user!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed:() {
                Navigator.of(context).pop();
              },
            )
          ],
        ),);
      }

    }catch(e)
    {
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Center(child: Text('Ooop\'s An Error Occurred')),
        content: Text('$e'),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed:() {
              Navigator.of(context).pop();
            },
          )
        ],
      ),);
    }

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      title: const Center(child: Text('Sign In')),
      content: SingleChildScrollView(
        child: Container(
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              const Divider(),
              const SizedBox(height: 30,),
              myTextField(
                  type: TextInputType.emailAddress,
                  prefix: Icons.mail,
                  validate: () {},
                  label: 'Mail address',
                  controller: widget.mailControllerIn),
              const SizedBox(height: kDefaultPadding,),
              myTextField(
                  type: TextInputType.text,
                  prefix: Icons.key,
                  validate: () {},
                  obscureText:true,
                  label: 'Password',
                  controller: widget.passwordControllerIn),
              const SizedBox(height: 30,),
              myButton(function: () async{
                  await login(widget.mailControllerIn.text, widget.passwordControllerIn.text);
                  // await Provider.of<Auth>(context,listen: false).signIn(
                  //     mailControllerIn.text, passwordControllerIn.text
                  //);

              }, title: 'Sign In', height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
