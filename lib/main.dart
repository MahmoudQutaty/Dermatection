
import 'package:dermatechtion/shared/styles/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'controllers/provider/auth.dart';
import 'modules/chat/models/app.dart';
import 'modules/chat/screens.dart';
import 'modules/chat/select_user_screen.dart';
import 'modules/patient/dashboard/dashboard.dart';
import 'modules/registration/who_i_am.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final client = StreamChatClient(streamKey);

  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
            create: (_)=>Auth())
      ],
      child: MyApp(client: client,)));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.client});

  final StreamChatClient client;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx,value,_)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: kPrimaryColor,
            primaryColor: kPrimaryColor,
            appBarTheme: const AppBarTheme(
                color: kPrimaryColor,
                centerTitle: true,
                elevation: 0
            )
        ),
        builder: (context, child){
          return StreamChatCore(client: client, child: child!);
        },
        //home: SelectUserScreen(),
        home: WhoIAm(),
      ),
    );
  }
}


/*


import 'package:flutter/material.dart';

import 'test/add_photo.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AddImage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Bar"),
      ),
      body: Center(),
    );
  }
}*/