import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

// Splash Screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekend Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SocialChoiceScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.orange.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Weekend Spark',
                    style: GoogleFonts.pacifico(
                      fontSize: 48,
                      color: Colors.pinkAccent.shade700,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Never run out of fun ideas!',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.pinkAccent.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Spacer(),

              Text(
                'Made with ❤️ by Iqraa',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.pinkAccent.shade200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Drawer buildAppDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade100, Colors.orange.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink.shade200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 48, color: Colors.black),
                SizedBox(height: 10),
                Text(
                  'Weekend Spark',
                  style: GoogleFonts.pacifico(
                      fontSize: 24,
                      color: Colors.black87,
                      shadows: [Shadow(blurRadius: 2, color: Colors.black26)]),
                ),
                SizedBox(height: 5),
                Text(
                  'Never run out of fun ideas!',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Drawer Items
          ListTile(
            leading: Icon(Icons.home, color: Colors.pink),
            title: Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context); // close drawer
              // Navigate home if needed
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: Colors.pink),
            title: Text('Saved Ideas', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Navigate to SavedIdeasScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedIdeasScreen()),
              );
            },
          ),
          Divider(thickness: 1, color: Colors.pink.shade200),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.pink),
            title: Text('About App', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Weekend Spark',
                applicationVersion: '1.0.0',
                applicationIcon:
                Icon(Icons.lightbulb_outline, size: 48, color: Colors.pink),
                children: [
                  Text(
                      'Weekend Spark helps you discover fun ideas for your weekends. Choose whether you are spending time alone, with your partner, friends, or family, and never run out of things to do!'),
                ],
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.pink),
            title: Text('Share App', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Optional: implement share logic later
              // Share.share('Check out Weekend Spark! [App Link]');
            },
          ),
          ListTile(
            leading: Icon(Icons.star_rate, color: Colors.pink),
            title: Text('Rate App', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Optional: link to app store/play store
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.pink),
            title: Text('Feedback', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Optional: open feedback form/email
            },
          ),
          Divider(thickness: 1, color: Colors.pink.shade200),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Made with ❤️ by Iqraa',
              style: TextStyle(color: Colors.pink.shade700, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}


// Social Choice Screen
class SocialChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildAppDrawer(context),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black), // White menu icon
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Weekend Spark',
          style: GoogleFonts.pacifico(fontSize: 26, color: Colors.black), // White title
        ),
        backgroundColor: Colors.pink.shade200, // Slightly darker for better contrast
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.black), // White favorite icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedIdeasScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.orange.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Who are you spending the weekend with?',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // White text for readability
                    shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                _choiceButton(
                    context, 'Alone', Icons.self_improvement, Colors.pink.shade200,
                    width: 180),
                SizedBox(height: 15),
                _choiceButton(context, 'Partner', CupertinoIcons.heart_circle_fill,
                    Colors.purple.shade200, width: 180),
                SizedBox(height: 15),
                _choiceButton(context, 'Friends', Icons.group, Colors.cyan.shade200,
                    width: 180),
                SizedBox(height: 15),
                _choiceButton(context, 'Family', Icons.family_restroom_sharp,
                    Colors.teal.shade200, width: 180),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _choiceButton(
      BuildContext context, String text, IconData icon, Color color,
      {double width = 140}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IdeaScreen(socialChoice: text)),
        );
      },
      icon: Icon(icon, size: 22, color: Colors.black), // White icon
      label: Text(text,
          style: TextStyle(fontSize: 16, color: Colors.black)), // White text
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12),
        fixedSize: Size(width, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }
}

// Idea Screen with Swipe + Background Animation
class IdeaScreen extends StatefulWidget {
  final String socialChoice;
  IdeaScreen({required this.socialChoice});

  @override
  _IdeaScreenState createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> with SingleTickerProviderStateMixin {
  Color backgroundColor = Colors.white;
  Color targetColor = Colors.white;
  String currentIdea = '';
  List<String> savedIdeas = [];
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  Map<String, List<String>> ideas = {
    'Alone': [
      "Try a new recipe from YouTube",
      "Meditate for 15 minutes",
      "Start a mini DIY project",
      "Read a chapter from a book you love",
      "Do a 30-min home workout",
      "Watch a documentary you’ve never seen",
      "Learn a few phrases in a new language",
      "Create a mini art project",
      "Write in a journal about your week",
      "Try a new online course for 30 mins",
      "Rearrange your room or workspace",
      "Listen to a new music genre",
      "Take a relaxing bath with candles",
      "Experiment with photography at home",
      "Do a short meditation & breathing session",
      "Sketch something you see outside",
      "Build a small indoor plant setup",
      "Write a short story in 20 minutes",
      "Try a new coffee or tea recipe",
      "Make a vision board for your week",
      "Listen to a podcast you’ve never tried",
      "Do 15 min of yoga",
      "Take a walk and notice things you usually ignore",
      "Organize your bookshelf by color",
      "Try a new hairstyle or outfit combination",
      "Learn origami and fold 10 shapes",
      "Do a mini room makeover",
      "Create a mini indoor scavenger hunt",
      "Try speed reading a short article",
      "Write a short poem",
      "Take a 30-min nap and track dreams",
      "Make a handmade greeting card",
      "Organize your digital photos",
      "Do a 5-min gratitude journal session",
      "Try a new app or tool you’ve never used",
      "Plan your dream vacation in detail",
      "Try mindful coloring",
      "Take a solo bike ride",
      "Sketch a portrait",
      "Read an inspiring article",
      "Experiment with digital drawing",
      "Try a mini puzzle challenge",
      "Do a short dance session alone",
      "Try a new meditation technique",
      "Create a DIY candle",
      "Write a letter to your future self",
      "Try a new board game alone",
      "Learn a card trick",
      "Listen to a new music album",
      "Do a short coding challenge",
      "Try a 15-min HIIT workout",
      "Watch a foreign film with subtitles",
      "Try a new smoothie recipe",
      "Practice calligraphy",
      "Try a new hairstyle tutorial",
      "Plan a creative week ahead",
      "Do a mini home spa session",
      "Organize your wardrobe",
      "Try journaling about your goals",
      "Take a relaxing bath",
      "Read a short story",
      "Learn a few words in a new language",
      "Try a DIY craft project",
      "Write down 10 things you love about yourself",
      "Listen to a new podcast episode",
      "Try a new dessert recipe",
      "Do a short yoga routine",
      "Write a short story",
      "Draw something from imagination",
      "Create a playlist for the week",
      "Experiment with photography angles",
      "Do a mini workout",
      "Try a new hairstyle",
      "Organize your desk",
      "Take a 5-min meditation break",
      "Do a 20-min sketching session",
      "Try a new online course",
      "Experiment with new music instruments",
      "Plan a weekend activity for yourself",
      "Try a DIY home decoration",
      "Read an educational article",
      "Do a 15-min home workout",
      "Write a poem",
      "Try a new hairstyle",
      "Listen to a new music genre",
      "Do a random act of kindness online",
      "Try a mini gardening project",
      "Build a small puzzle",
      "Learn origami",
      "Create a mini scrapbook",
      "Try a new coffee recipe",
      "Do a 10-min meditation",
      "Sketch your dream room",
      "Plan a solo adventure",
      "Experiment with makeup",
      "Try a new recipe",
      "Do a home cleaning challenge",
      "Create a mini photo album",
      "Write a short story",
      "Listen to a motivational speech",
      "Try a new painting technique",
      "Do a mini workout",
      "Learn a few words in sign language",
      "Take a short walk outdoors",
      "Try a DIY craft",
      "Write a letter to yourself",
    ],
    'Partner': [
      "DIY couples spa night at home",
      "Cook a new meal together",
      "Picnic in the park",
      "Board game or puzzle night",
      "Plan a themed movie marathon",
      "Go stargazing together",
      "Dance to your favorite songs",
      "Create a scrapbook of memories",
      "Try painting together",
      "Take a virtual tour of a museum",
      "Plan a weekend road trip",
      "Bake desserts together",
      "Do a couple workout challenge",
      "Try a new hobby together",
      "Write love notes to each other",
      "Build a blanket fort together",
      "Try making homemade candles",
      "Go for a sunrise walk",
      "Make a music playlist for each other",
      "Try a DIY photoshoot",
      "Learn a new dance together",
      "Write a short poem for each other",
      "Plan a surprise indoor picnic",
      "Play truth or dare",
      "Have a tech-free evening together",
      "Cook a themed dinner together",
      "Do a home movie marathon",
      "Make homemade chocolates",
      "Try couples yoga",
      "Create a couples vision board",
      "Plant a small garden together",
      "Do a mini scavenger hunt at home",
      "Bake bread together",
      "Create a time capsule",
      "Go on a scenic drive",
      "Try a new cocktail recipe",
      "Do a puzzle together",
      "Have a movie night with homemade snacks",
      "Try new board games",
      "Write a love letter",
      "Plan a weekend adventure",
      "Take an online class together",
      "Try karaoke at home",
      "Paint pottery together",
      "Plan a mini surprise",
      "Have a game tournament",
      "Make a DIY home decoration",
      "Dance in the living room",
      "Try a fun challenge together",
      "Make a bucket list",
      "Plan a dream vacation",
      "Go cycling together",
      "Try couple meditation",
      "Make a scrapbook",
      "Do a home workout together",
      "Cook breakfast in bed",
      "Have an indoor picnic",
      "Plan a themed costume night",
      "Try a new dessert",
      "Create a DIY photo album",
      "Do a couples painting session",
      "Plan a road trip",
      "Make DIY gifts for each other",
      "Try indoor camping",
      "Do a 30-min dance session",
      "Take silly photos together",
      "Make homemade pizza",
      "Create a playlist for the week",
      "Do a fun workout challenge",
      "Plan a weekend adventure",
      "Try a new board game",
      "Bake cookies together",
      "Do a home spa day",
      "Write a love note",
      "Plan a mini movie marathon",
      "Do a creative craft together",
      "Try a new recipe",
      "Have a backyard picnic",
      "Make a DIY candle together",
      "Go for a walk in nature",
      "Do a yoga session",
      "Try painting",
      "Make a scrapbook",
      "Plan a small road trip",
      "Cook a themed dinner",
      "Take online dance classes",
      "Do a puzzle challenge",
      "Write a short poem",
      "Try a couple fitness challenge",
      "Make homemade chocolates",
      "Plan a surprise date",
      "Do karaoke together",
      "Create a couple’s bucket list",
      "Try pottery painting",
      "Do a scavenger hunt"
    ],
    'Friends': [
      "Backyard stargazing with snacks",
      "Karaoke night at home",
      "Cook pizza together",
      "Try an online escape room",
      "Play board games or card games",
      "Plan a mini photo scavenger hunt",
      "DIY craft night",
      "Virtual trivia night",
      "Outdoor picnic or hike",
      "Movie marathon with themed snacks",
      "Host a small backyard BBQ",
      "Try new recipes together",
      "Dance party at home",
      "Plan a small surprise for each friend",
      "DIY cocktail/mocktail night",
      "Go on a sunset bike ride",
      "Build a blanket fort together",
      "Have a themed costume night",
      "Play a fun group game",
      "Do a group workout challenge",
      "Plan a weekend adventure",
      "Try karaoke in the living room",
      "Have a board game tournament",
      "Make homemade snacks",
      "Do a photo challenge",
      "Host a trivia night",
      "Have a movie night marathon",
      "Plan a scavenger hunt outdoors",
      "Do a DIY craft together",
      "Plan a picnic in the park",
      "Try new recipes together",
      "Make friendship bracelets",
      "Do a backyard challenge",
      "Try a new sport together",
      "Play a group video game",
      "Do a fun baking challenge",
      "Make a collaborative playlist",
      "Have a backyard campfire",
      "Do a group painting session",
      "Plan a surprise for a friend",
      "Try a new cocktail/mocktail recipe",
      "Host a small talent show",
      "Try online trivia",
      "Have a themed snack night",
      "Do a dance challenge",
      "Make DIY decorations",
      "Plan a mini road trip",
      "Do a photography challenge",
      "Play charades",
      "Have a fun movie marathon",
      "Do a fun DIY project",
      "Plan a group picnic",
      "Try a new outdoor game",
      "Have a movie quiz night",
      "Do a small volunteer activity",
      "Host a fun game night",
      "Do a mini obstacle course",
      "Try a new craft",
      "Make a group vision board",
      "Plan a weekend activity",
      "Do a cooking challenge",
      "Try a new dessert recipe",
      "Do a fun scavenger hunt",
      "Make a playlist together",
      "Plan a fun sleepover",
      "Do a short hike",
      "Play mini golf",
      "Try a new board game",
      "Have a themed photo session",
      "Do a group yoga session",
      "Plan a karaoke night",
      "Do a group workout",
      "Try a new party game",
      "Make homemade pizza",
      "Have a picnic indoors",
      "Do a DIY craft night",
      "Plan a weekend trip",
      "Host a talent show",
      "Try new snack recipes",
      "Do a small group challenge",
      "Make a scrapbook together",
      "Plan a fun adventure",
      "Do a fun painting session",
      "Have a movie marathon",
      "Try a new recipe",
      "Do a mini puzzle challenge",
      "Play a group game"
    ],
    'Family': [
      "Family movie night with homemade popcorn",
      "Cook a meal together as a family",
      "Board game night with prizes",
      "DIY craft project for everyone",
      "Plan a backyard camping night",
      "Family karaoke night",
      "Go for a nature walk together",
      "Plant a small garden together",
      "Bake cookies and decorate them",
      "Create a family scrapbook",
      "Do a puzzle together",
      "Organize a small family treasure hunt",
      "Plan a weekend picnic",
      "Family workout or dance session",
      "Read a story aloud together",
      "Family talent show",
      "Make homemade greeting cards for friends",
      "Have a themed dress-up day",
      "Family photography challenge",
      "Write letters to each other and read them",
      "Plan a mini science experiment at home",
      "Create a family music playlist",
      "Host a backyard mini Olympics",
      "Do a random act of kindness together",
      "Decorate rooms together for fun",
      "Family movie marathon with snacks",
      "Plan a fun outdoor game",
      "Do a baking challenge together",
      "Make DIY decorations",
      "Family picnic at the park",
      "Try a new hobby together",
      "Family dance-off",
      "Plant a tree together",
      "Do a puzzle challenge",
      "Plan a weekend adventure",
      "Create a vision board together",
      "Family craft night",
      "Bake bread together",
      "Do a small science experiment",
      "Family storytelling night",
      "Try a new recipe together",
      "Make homemade pizza",
      "Plan a scavenger hunt",
      "Family game night",
      "Create a photo album together",
      "Do a backyard camping",
      "Have a picnic indoors",
      "Family workout challenge",
      "Plan a movie night",
      "Do a fun DIY craft",
      "Make friendship bracelets",
      "Plan a family surprise",
      "Try a new sport together",
      "Do a small volunteering project",
      "Family music night",
      "Try new dessert recipes",
      "Plan a weekend road trip",
      "Family trivia night",
      "Do a short hike together",
      "Family painting session",
      "Plan a themed dinner",
      "Do karaoke together",
      "Create homemade gifts",
      "Plan a fun learning activity",
      "Make a family playlist",
      "Do a backyard challenge",
      "Family movie quiz",
      "Do a group puzzle",
      "Plan a creative weekend",
      "Have a small talent show",
      "Do a mini photography session",
      "Family yoga session",
      "Plan a fun indoor game",
      "Do a cooking challenge",
      "Family storytelling",
      "Make a scrapbook",
      "Plan a movie marathon",
      "Try a new hobby",
      "Family DIY project",
      "Plan an outdoor activity",
      "Do a fun science project",
      "Family obstacle course",
      "Plan a themed party",
      "Do a baking project",
      "Family drawing session",
      "Try a new game together",
      "Do a mini scavenger hunt",
    ],
  };

  List<Color> colors = [
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.yellow.shade100,
    Colors.teal.shade100,
    Colors.red.shade100,
  ];

  late BannerAd _bannerAd;
  bool _isBannerLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _generateIdea();
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-4447065641640234~5064554875'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() => _isBannerLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint(error.toString());
        },
      ),
    )..load();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  InterstitialAd? _interstitialAd;
  int _saveCount = 0;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/1033173712' // Android test interstitial
      // : 'ca-app-pub-3940256099942544/4411468910', // iOS test interstitial
          ? 'ca-app-pub-4447065641640234/3631911481'
          : 'ca-app-pub-4447065641640234/8661352246',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Interstitial loaded');
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('Interstitial failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadInterstitialAd(); // preload next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _generateIdea() {
    final random = Random();
    final list = ideas[widget.socialChoice]!;
    final idea = list[random.nextInt(list.length)];
    final color = colors[random.nextInt(colors.length)];

    _colorAnimation =
    ColorTween(begin: backgroundColor, end: color).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward(from: 0);

    // Determine readable text color based on background
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final textColor = brightness == Brightness.dark ? Colors.white : Colors
        .black87;

    setState(() {
      currentIdea = idea;
      backgroundColor = color;
      _currentTextColor = textColor; // new variable for dynamic text color
    });
  }


  // void _saveIdea() async {
  //   if (currentIdea.isEmpty) return;
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> savedIdeas =
  //       prefs.getStringList('ideas_${widget.socialChoice}') ?? [];
  //
  //   if (!savedIdeas.contains(currentIdea)) {
  //     savedIdeas.add(currentIdea);
  //     await prefs.setStringList('ideas_${widget.socialChoice}', savedIdeas);
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Idea saved!'), backgroundColor: Colors.green),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Idea already saved!'),
  //           backgroundColor: Colors.orange),
  //     );
  //   }
  // }



  // void _shareIdea() {
  //   Share.share('Weekend Idea: $currentIdea');
  // }

  void _saveIdea() async {
    if (currentIdea.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> savedIdeas =
        prefs.getStringList('ideas_${widget.socialChoice}') ?? [];

    if (!savedIdeas.contains(currentIdea)) {
      savedIdeas.add(currentIdea);
      await prefs.setStringList('ideas_${widget.socialChoice}', savedIdeas);

      _saveCount++;
      if (_saveCount % 5 == 0) {
        _showInterstitialAd();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Idea saved!'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Idea already saved!'), backgroundColor: Colors.orange),
      );
    }
  }
  void _shareIdea() {
    Share.share('Weekend Idea: $currentIdea');

    // Show ad after sharing
    _showInterstitialAd();
  }

  void _viewSavedIdeas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedIdeasScreen(),
      ),
    );
  }



  Color _currentTextColor = Colors.black87; // default text color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorAnimation.value ?? backgroundColor,
      appBar: AppBar(
        title: Text('Weekend Spark', style: GoogleFonts.pacifico(
            fontSize: 26, color: _currentTextColor)),
        backgroundColor: _colorAnimation.value ?? backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: _currentTextColor),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite ,color: _currentTextColor),
              onPressed: _viewSavedIdeas),
        ],
      ),

      /// 👇 GOOGLE AD CONTAINER
      bottomNavigationBar: _isBannerLoaded
          ? Container(
        height: _bannerAd.size.height.toDouble(),
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: AdWidget(ad: _bannerAd),
      )
          : SizedBox.shrink(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            elevation: 8,
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      currentIdea,
                      key: ValueKey<String>(currentIdea),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _currentTextColor, // dynamic text color
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _actionButton(
                          Icons.save, 'Save', Colors.green.shade300, _saveIdea,
                          textColor: _currentTextColor),
                      _actionButton(Icons.share, 'Share', Colors.blue.shade300,
                          _shareIdea, textColor: _currentTextColor),
                    ],
                  ),
                  SizedBox(height: 15),
                  _actionButton(
                      Icons.shuffle, 'Next Idea', Colors.pink.shade200,
                      _generateIdea,
                      width: double.infinity, textColor: _currentTextColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color,
      VoidCallback onTap,
      {double width = 140, Color? textColor}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 22, color: textColor ?? Colors.black87),
      label: Text(label,
          style: TextStyle(fontSize: 16, color: textColor ?? Colors.black87)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }
}

// Saved Ideas Screen
class SavedIdeasScreen extends StatefulWidget {
  @override
  _SavedIdeasScreenState createState() => _SavedIdeasScreenState();
}

class _SavedIdeasScreenState extends State<SavedIdeasScreen> {
  Map<String, List<String>> allSavedIdeas = {};

  @override
  void initState() {
    super.initState();
    loadSavedIdeas();
  }

  Future<void> loadSavedIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = ['Alone', 'Partner', 'Friends', 'Family'];

    Map<String, List<String>> temp = {};
    for (var category in categories) {
      temp[category] = prefs.getStringList('ideas_$category') ?? [];
    }

    setState(() {
      allSavedIdeas = temp;
    });
  }

  Future<void> deleteIdea(String category, String idea) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ideas = prefs.getStringList('ideas_$category') ?? [];

    ideas.remove(idea);
    await prefs.setStringList('ideas_$category', ideas);

    setState(() {
      allSavedIdeas[category] = ideas;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idea deleted!'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Ideas'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: allSavedIdeas.values.every((list) => list.isEmpty)
          ? Center(
        child: Text(
          'No ideas saved yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
        ),
      )
          : ListView(
        padding: EdgeInsets.all(10),
        children: allSavedIdeas.entries.expand<Widget>((entry) {
          final category = entry.key;
          final ideas = entry.value;
          if (ideas.isEmpty) return []; // skip empty categories
          return [
            // Category header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent.shade700,
                ),
              ),
            ),
            // Ideas under this category
            ...ideas.map(
                  (idea) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                color: Colors.pink.shade50.withOpacity(0.9),
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading:
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  title: Text(
                    idea,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => deleteIdea(category, idea),
                  ),
                ),
              ),
            ),
          ];
        }).toList(),
      ),
    );
  }
}