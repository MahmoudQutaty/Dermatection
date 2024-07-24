
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dermatechtion/modules/patient/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/my_button.dart';
import '../../controllers/provider/auth.dart';
import '../../controllers/provider/prediction.dart';
import '../../shared/styles/colors.dart';
import 'signin_or_signup_screen.dart';
import 'package:http/http.dart' as http;


class TakePhoto extends StatefulWidget {
  const TakePhoto({Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File? _image;

  String imagePath="";
  String imageBase64 = "";

  Future getImage(ImageSource source) async {
    final _image = await ImagePicker().pickImage(source: source);
    if (_image == null) {
      return;
    }
    imagePath = _image.path;

    print(imagePath);

    File imageFile = File(imagePath);

    Uint8List imageBytes = await imageFile.readAsBytes();

    imageBase64 = base64.encode(imageBytes);

    final imageTemporary = File(_image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }



  // Post image to phpMyAdmin

  Future<void> postImage(File imageFile, String token) async {

    showDialog(context: context, builder:(context)=> Center(child: CircularProgressIndicator(),));

    String url = "http://192.168.43.168:8000/api/image";

    try{
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add the image file to the request
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();
      var multipartFile = http.MultipartFile('name', imageStream, imageLength,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);

      // Add the Bearer token to the request headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Send the request
      var response = await request.send();

      print('Image uploaded successfully');


    }catch (e)
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
      print("Error: $e");
    }
  }




  // post image to the cnn model server

  Future<Map<String,dynamic>> fetchResponseDermascopy(var base64Image) async{
    showDialog(context: context, builder:(context)=> Center(child: CircularProgressIndicator(),));
    var data = {"Image": base64Image};
    print('Starting request');
    var url = 'http://192.168.43.168:5000/classifiyDermascopy';
    Map<String,String> headers = {
      'Content_type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'Keep-Alive',
    };
    var body = json.encode(data);
    try{
      var response = await http.post(Uri.parse(url),body: body,headers: headers);
      print("hi");
      final Map<String,dynamic> responseData = json.decode(response.body);


      MyPredictionProvider.bcc = responseData['Basal cell carcinoma'];
      MyPredictionProvider.akiec = responseData['Actinic keratoses'];
      MyPredictionProvider.df = responseData['Dermatofibroma'];
      MyPredictionProvider.mel = responseData['Melanoma'];
      MyPredictionProvider.nv = responseData['Melanocytic nevi'];
      MyPredictionProvider.vasc = responseData['Vascular lesions'];
      MyPredictionProvider.bkl = responseData['Benign keratosis'];

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard(),
          ),(
          route) => false
      );


      print(responseData);
      return responseData;
    }catch (e) {
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
      throw Exception('Exception Error: $e');
    }
  }


  Future<Map<String,dynamic>> fetchResponseCamera(var base64Image) async{
    showDialog(context: context, builder:(context)=> Center(child: CircularProgressIndicator(),));
    var data = {"Image": base64Image};
    print('Starting request');
    var url = 'http://192.168.43.168:3000/classifiyCamera';
    Map<String,String> headers = {
      'Content_type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'Keep-Alive',
    };
    var body = json.encode(data);
    try{
      var response = await http.post(Uri.parse(url),body: body,headers: headers);
      print("hi");
      final Map<String,dynamic> responseData = json.decode(response.body);


      MyPredictionProvider.ak_bcc = responseData['Actinic Keratosis/ BCC'];
      MyPredictionProvider.eczema = responseData['Eczema'];
      MyPredictionProvider.nf= responseData['Nail Fungus'];
      MyPredictionProvider.plp = responseData['Psoriasis Lichen Planus'];
      MyPredictionProvider.sk = responseData['Seborrheic Keratoses'];
      MyPredictionProvider.tr = responseData['Tinea Ringworm'];
      MyPredictionProvider.wm = responseData['Warts Molluscum'];
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard(),
          ),(
          route) => false
      );

      print(responseData);
      return responseData;
    }catch (e) {
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
      throw Exception('Exception Error: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body:ChangeNotifierProvider<MyPredictionProvider>(
            create: (context) =>
                MyPredictionProvider()
            ,
            child: Consumer<MyPredictionProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: kDefaultPadding * 4,
                        ),
                        Text(
                          'Take a photo of your skin...',
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey[300]),
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 3,
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 300,
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40),
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 110),
                              child: Center(child: Text(
                                "Your Photo will display here",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor
                                ),)),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(39),
                              child: _image != null
                                  ? Image.file(
                                _image!,
                                fit: BoxFit.fill,
                                height: 300,
                                width: double.infinity,
                              )
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (provider.image != null) Image.network(provider.image.path),
                            customButton(
                                title: 'Camera',
                                icon: Icons.camera,
                                onClick: () => getImage(ImageSource.camera)),
                            const SizedBox(
                              width: 30.0,
                            ),
                            customButton(
                                title: 'Gallery',
                                icon: Icons.image_outlined,
                                onClick: () =>getImage(ImageSource.gallery)),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        myButton(
                          function: () async {
                            if (_image == null) {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    title: const Center(
                                        child: Text('Oooop\'s')),
                                    content: const Text(
                                        "Please take a photo to predict")
                                );
                              });
                            }
                            else
                            {
                              if (MyPredictionProvider.modelData == "camera") {
                                fetchResponseCamera(imageBase64);
                              }else if (MyPredictionProvider.modelData == "dermascopy")
                                {
                                  fetchResponseDermascopy(imageBase64);

                                }
                              //print(imageBase64);
                              postImage(_image!,Auth.userToken);


                            }
                          },
                          title: 'Check my Skin',
                        ),
                      ],
                    ),
                  );
                }
            )
        )
    );
  }

  Widget customButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Container(
      width: 140,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kTextColor)),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

