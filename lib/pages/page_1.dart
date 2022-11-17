import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String _wallpaperFileHome = 'Unknown';
  String _wallpaperFileLock = 'Unknown';

  String url =
      'https://images.hdqwalls.com/download/the-witcher-season-2-2022-5k-u1-1080x1920.jpg';

  // List<String> url = [
  //   'https://images.hdqwalls.com/download/the-witcher-season-2-2022-5k-u1-1080x1920.jpg',
  //   'https://images.hdqwalls.com/download/the-witcher-season-2-2022-5k-u1-1080x1920.jpg',
  // ];

  var album_name = 'Wallpaper';

  void saveimage() async {
    await GallerySaver.saveImage(url, albumName: album_name);
  }

  late bool goToHome;

  @override
  void initState() {
    super.initState();
    goToHome = false;
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }

  Future<void> setWallpaperFromFileHome() async {
    setState(() {
      _wallpaperFileHome = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: goToHome,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
    setState(() {
      _wallpaperFileHome = result;
    });
  }

  Future<void> setWallpaperFromFileLock() async {
    setState(() {
      _wallpaperFileLock = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: goToHome,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
    setState(() {
      _wallpaperFileLock = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 41, 46),
      body: GridView.builder(
        itemCount: url.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: FullScreenWidget(
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(url, fit: BoxFit.cover),
                  Positioned(
                    right: 30,
                    bottom: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(40, 40),
                        shape: CircleBorder(),
                        backgroundColor: Colors.grey.shade600.withOpacity(0.1),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Color.fromARGB(255, 32, 41, 46),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 120, vertical: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)))),
                                    onPressed: setWallpaperFromFileHome,
                                    child: _wallpaperFileHome == 'Loading'
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Home Page",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                  ),
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 120, vertical: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)))),
                                    onPressed: setWallpaperFromFileLock,
                                    child: _wallpaperFileLock == 'Loading'
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            'Lock Screen',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(Icons.picture_in_picture,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 20,
                    child: DownloadButton(context),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton DownloadButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(40, 40),
        shape: CircleBorder(),
        backgroundColor: Colors.grey.shade600.withOpacity(0.1),
      ),
      child: Icon(Icons.download, color: Colors.white.withOpacity(0.7)),
      onPressed: () {
        saveimage();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Wallpaper downloaded!'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
