import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'custom_outline.dart';
import 'prediction.dart';

class AddImage extends StatefulWidget
{
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  String modelResults = "Please pick your image first";
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
  Future<Map<String,dynamic>> fetchResponse(var base64Image) async{
    var data = {"Image": base64Image};
    print('Starting request');
    var url = 'http://192.168.1.7:5000/predict';
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


      Mypredection_provider.mild = responseData['mild'];
      Mypredection_provider.moderate = responseData['moderate'];
      Mypredection_provider.normal = responseData['normal'];
      Mypredection_provider.severe = responseData['severe'];
      Mypredection_provider.poliferative = responseData['proliferativec'];


      setState(() {
        modelResults = "Normal: ${Mypredection_provider.normal}\nMild: ${Mypredection_provider.mild}\nModerate: ${Mypredection_provider.moderate}\nSevere: ${Mypredection_provider.severe}\n Proliferativec: ${Mypredection_provider.poliferative}";
      });

      print(responseData);
      return responseData;
    }
    catch (e) {
      throw Exception('Exception Error: $e');
    }
  }
  /*String? result;
  final picker = ImagePicker();
  File? img;
  String imagePath="";
  String imageBase64="";
  imagePath = img.path;

  print(imagePath);

  File imageFile = File(imagePath);

  Uint8List imageBytes = await imageFile.readAsBytes();

  imageBase64 = base64.encode(imageBytes);
  var url = "http://127.0.0.1:8000/predictApi";

  Future pickImage() async {
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,);
    setState(() {
      img = File(pickedFile!.path);
    });
  }

  upload() async
  {
    final request = http.MultipartRequest("POST", Uri.parse(url));
    final header = {"Content-Type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'fileup', img!.readAsBytes().asStream(), img!.lengthSync(),
        filename: img!
            .path
            .split('/')
            .last));
    request.headers.addAll(header);
    final myRequest = await request.send();
    http.Response res = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      print("response here:$resJson");
      result = resJson['prediction'];
    } else {
      print("Error ${myRequest.statusCode}");
    }
    setState(() {

    });
  }*/

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Constants.kWhiteColor,
      extendBody: true,
      appBar: AppBar(
        //backgroundColor: Constants.kPinkColor,
        //title: Text('Diabetic Retinopathy Detection',),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(children: [
          /*Positioned(
            top: screenHeight * 0.1,
            left: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                //color: Constants.kPinkColor,
              ),
              /*child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
              ),*/
            ),
          ),*/
          /*Positioned(
            top: screenHeight * 0.3,
            right: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.kGreenColor,
              ),
              /*child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),*/
            ),
          ),*/
          SafeArea(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05,),
              CustomOutline(
                strokeWidth: 4,
                radius: screenWidth * 0.8,
                padding: const EdgeInsets.all(4),
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Constants.kPinkColor,
                      Constants.kPinkColor.withOpacity(0),
                      Constants.kGreenColor.withOpacity(0.1),
                      Constants.kWhiteColor,
                    ],
                    stops: const[
                      0,
                      0,
                      0,
                      0,
                    ]),
                child: Center(child: _image == null ?
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomLeft,
                      image:
                      AssetImage(
                          'lib/assets/images/google.png'),
                    ),
                  ),

                ) :
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomLeft,
                      image: FileImage(_image!),
                    ),
                  ),
                ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05,),
              Center(
                  child: Text(modelResults,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.kBlackColor.withOpacity(0.85,),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                  )
              ),
              SizedBox(height: screenHeight * 0.03,),
              CustomOutline(
                strokeWidth: 3,
                radius: 20,
                padding: const EdgeInsets.all(3),
                width: 350,
                height: 45,
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Constants.kWhiteColor, Constants.kGreenColor],
                    stops: const[
                      1,
                      0,
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Constants.kPinkColor.withOpacity(0.5),
                          Constants.kGreenColor.withOpacity(0.5),
                        ],
                        stops: const[
                          0,
                          0,
                        ]),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue,),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Text('Pick Image Here', style: TextStyle(
                      fontSize: 24,
                      color: Constants.kWhiteColor,
                    ),),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomOutline(
                strokeWidth: 3,
                radius: 20,
                padding: const EdgeInsets.all(3),
                width: 350,
                height: 45,
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Constants.kWhiteColor, Constants.kGreenColor],
                    stops: const[
                      1,
                      0,
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    /*gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Constants.kPinkColor.withOpacity(0.5),
                        Constants.kGreenColor.withOpacity(0.5),
                      ],
                    ),*/
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue,),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return Center(child: CircularProgressIndicator(),);
                          });
                      fetchResponse(imageBase64);
                      Navigator.of(context).pop();
                    },
                    child: Text('Upload Image', style: TextStyle(
                      fontSize: 24,
                      color: Constants.kWhiteColor,
                    ),),
                  ),
                ),
              ),
            ],
          ),),
        ]),
      ),
    );
  }
}