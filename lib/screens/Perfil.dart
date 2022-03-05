import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/CircleName.dart';
import 'package:linkfood/components/bottomNavigator.dart';
import 'package:linkfood/components/buttons.dart';
import 'package:linkfood/controller/UserController.dart';
import 'package:linkfood/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  UserController _userController = UserController();
  GetIt getIt = GetIt.instance;
  ImagePicker imagePicker = ImagePicker();
  late User _user;

  File? tmp;
  File? image;
  bool toggle = false;
  bool changed = false;
  bool loading = false;
  String id = '';
  String urlImage = '';

  _getImage() async {
    final PickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      File img = File(PickedFile.path);

      //await CompressImage.compress(
      //  imageSrc: img.absolute.path, desiredQuality: 40);
      setState(() {
        image = img;
        changed = true;
      });

      String fileName = image!.path.split('/').last;

      _uploadImage(fileName: fileName, file: img);
    }
  }

  _uploadImage({required String fileName, required File file}) {
    _userController.uploadThumbnail(file: file, fileName: fileName);
  }

  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
    _user = getIt<User>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: primary,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [header(constraints), body()],
          );
        },
      ),
      bottomNavigationBar: bottomNavigatior(index: 2, context: context),
    );
  }

  Widget header(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: 180,
      child: Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: 130,
            color: primary,
          ),
          Positioned(
            top: 75,
            left: 32,
            child: _chooseImage(),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: [
          loading != false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
          Text(
            _user.name,
            style: TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: btText(
                lable: 'Sair',
                context: context,
                call: () {
                  _logout();
                }),
          )
        ],
      ),
    );
  }

  Widget _chooseImage({name, thumbnail}) {
    return GestureDetector(
        onTap: () {
          _getImage();
        },
        child: image == null
            ? _cachedImage(name: name, thumbnail: thumbnail)
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )));
  }

  Widget _cachedImage({thumbnail, name}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(width: 4, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return CircularProgressIndicator();
              },
              imageUrl: _user.thumbnail,
              errorWidget: (context, url, error) {
                return circleNamed(_user.name);
              }),
        ));
  }
}
