import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const UndertaleEBookApp());
}

class UndertaleEBookApp extends StatelessWidget {
  const UndertaleEBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Undertale 電子書',
      theme: ThemeData(
        fontFamily: 'PixelFont',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final AudioPlayer player = AudioPlayer();

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.loop);
    player.play(AssetSource('audio/menu.mp3'));
  }

  Future<void> _playBgmForPath(String path) async {
    await player.stop();
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource(path));
  }

  Future<void> _playBgmDirectly(String key) async {
    String path;
    switch (key) {
      case 'menu':
        path = 'audio/menu.mp3';
        break;
      case 'sans':
        path = 'audio/sans.mp3';
        break;
      case 'papyrus':
        path = 'audio/papyrus.mp3';
        break;
      case 'toriel':
        path = 'audio/toriel.mp3';
        break;
      case 'alphys':
        path = 'audio/alphys.mp3';
        break;
      case 'undyne':
        path = 'audio/undyne.mp3';
        break;
      case 'mettaton':
        path = 'audio/mettaton.mp3';
        break;
      case 'asgore dreemurr':
        path = 'audio/asgore.mp3';
        break;
      case 'flowey':
        path = 'audio/flowey.mp3';
        break;
      case 'asriel dreemurr':
        path = 'audio/asriel.mp3';
        break;
      case 'chara':
        path = 'audio/chara.mp3';
        break;
      default:
        path = 'audio/menu.mp3';
    }
    await _playBgmForPath(path);
  }

  Future<void> _openCharacterPage(Character character) async {
    await _playBgmDirectly(character.name.toLowerCase());

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CharacterDetailPage(character: character)),
    );

    await _playBgmForPath('audio/menu.mp3');
  }

  Future<void> _openAreaPage(Area area) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AreaDetailPage(area: area)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Undertale 電子書"),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amberAccent,
            tabs: [
              Tab(text: "角色"),
              Tab(text: "地區"),
              Tab(text: "音樂"),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            TabBarView(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  children: characters.map((c) {
                    return GestureDetector(
                      onTap: () => _openCharacterPage(c),
                      child: Card(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(c.image, height: 80),
                              Text(c.name,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                ListView.separated(
                  itemCount: areas.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final area = areas[index];
                    return ListTile(
                      leading: Image.asset(area.image, width: 60),
                      title: Text(area.name,
                          style: const TextStyle(color: Colors.white)),
                      onTap: () => _openAreaPage(area),
                    );
                  },
                ),
                ListView(
                  children: [
                    for (var music in bgmList)
                      ListTile(
                        title: Text(music.title,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(music.composer,
                            style: const TextStyle(color: Colors.white54)),
                        onTap: () async {
                          await _playBgmForPath(music.path);
                        },
                      )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Character {
  final String name;
  final String image;
  final String description;
  final String bgm;

  const Character({
    required this.name,
    required this.image,
    required this.description,
    required this.bgm,
  });
}

class Area {
  final String name;
  final String image;

  const Area({required this.name, required this.image});
}

class MusicTrack {
  final String title;
  final String composer;
  final String path;

  const MusicTrack(this.title, this.composer, this.path);
}

class CharacterDetailPage extends StatelessWidget {
  final Character character;
  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(character.image)),
            const SizedBox(height: 10),
            Text(character.description,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class AreaDetailPage extends StatelessWidget {
  final Area area;
  const AreaDetailPage({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(area.name)),
      body: Center(
        child: Image.asset(area.image),
      ),
    );
  }
}

const characters = [
  Character(
      name: "Sans",
      image: "assets/images/sans.png",
      bgm: "audio/sans.mp3",
      description: "基本介紹：懶散幽默的骷髏，常常戴著笑臉面具。\n"
          "性格特徵：喜歡開玩笑，行事輕鬆，但在必要時刻展現出強大的實力與智慧。\n"
          "劇情參與：守護地下世界秘密，與主角進行關鍵對決，是遊戲中最受歡迎的角色之一。\n"
          "名言：『It's a beautiful day outside. Birds are singing, flowers are blooming... On days like these, kids like you... Should be burning in hell.』"),
  Character(
      name: "Papyrus",
      image: "assets/images/papyrus.png",
      bgm: "audio/papyrus.mp3",
      description: "基本介紹：Sans 的弟弟，身材高大且熱情洋溢的骷髏。\n"
          "性格特徵：自信滿滿，略帶中二病，總是全力追求成為皇家騎士的夢想。\n"
          "劇情參與：是主角初期的重要角色，經常設計挑戰和陷阱，最終與主角建立深厚友誼。\n"
          "名言：『I WILL BE THE ONE! I WILL CAPTURE A HUMAN!』"),
  Character(
      name: "Toriel",
      image: "assets/images/toriel.png",
      bgm: "audio/toriel.mp3",
      description: "基本介紹：溫柔的山羊媽媽，地下世界的守護者。\n"
          "性格特徵：充滿母愛和智慧，保護來到地下世界的孩子，盡力避免他們受傷。\n"
          "劇情參與：是主角旅程初期的指引者與守護者，對主角懷有深厚感情。\n"
          "名言：『Do not be afraid, my child. I will protect you.』"),
  Character(
      name: "Alphys",
      image: "assets/images/alphys.png",
      bgm: "audio/alphys.mp3",
      description: "基本介紹：宅宅的科學家，負責地下世界的科技發展。\n"
          "性格特徵：內向害羞，對自己喜歡的人很害羞，但內心善良且願意幫助朋友。\n"
          "劇情參與：參與機器人Mettaton的創造，並在主線劇情中提供技術支援。\n"
          "名言：『I-I-I'm not sure if you're ready for the truth...』"),
  Character(
      name: "Undyne",
      image: "assets/images/undyne.png",
      bgm: "audio/undyne.mp3",
      description: "基本介紹：勇猛的魚人戰士，地下世界的正義守護者。\n"
          "性格特徵：充滿激情與決心，絕不輕易放棄，具有強烈的正義感。\n"
          "劇情參與：負責追捕主角，是遊戲中的強大敵人之一，後來成為朋友。\n"
          "名言：『COME ON, HUMAN! FIGHT ME!』"),
  Character(
      name: "Mettaton",
      image: "assets/images/mettaton.png",
      bgm: "audio/mettaton.mp3",
      description: "基本介紹：華麗的機器人偶像，擁有多種型態。\n"
          "性格特徵：愛慕虛榮且熱愛表演，喜歡吸引眾人的目光。\n"
          "劇情參與：主導地下世界的娛樂節目，是遊戲中重要的反派角色之一。\n"
          "名言：『LET'S GET THIS SHOW ON THE ROAD!』"),
  Character(
      name: "Asgore Dreemurr",
      image: "assets/images/asgore.png",
      bgm: "audio/asgore.mp3",
      description: "基本介紹：地下世界的國王，充滿矛盾的領導者。\n"
          "性格特徵：溫柔且悲傷，雖不得不做出殘酷決定，但心中渴望和平。\n"
          "劇情參與：遊戲終盤的重要角色，與主角進行最終對決之一。\n"
          "名言：『Do you want to live in this world… without mercy?』"),
  Character(
      name: "Flowey",
      image: "assets/images/flowey.png",
      bgm: "audio/flowey.mp3",
      description: "基本介紹：表面可愛的花朵，實則心狠手辣。\n"
          "性格特徵：狡猾、無情，操控著黑暗的力量，試圖掌控地下世界。\n"
          "劇情參與：遊戲中多次試圖阻止主角，是主要反派之一。\n"
          "名言：『In this world, it’s kill or be killed.』"),
  Character(
      name: "Asriel Dreemurr",
      image: "assets/images/asriel.png",
      bgm: "audio/asriel.mp3",
      description: "基本介紹：悲劇英雄，Flowey 的真實身份。\n"
          "性格特徵：純真而善良，但命運讓他成為悲劇人物。\n"
          "劇情參與：遊戲重要劇情推手，承載著深刻的故事情感。\n"
          "名言：『Isn’t it a beautiful day outside?』"),
  Character(
      name: "Chara",
      image: "assets/images/chara.png",
      bgm: "audio/chara.mp3",
      description: "基本介紹：第一位掉落到地下世界的孩子，神秘且強大。\n"
          "性格特徵：冷酷且充滿謎團，影響著遊戲的多種結局。\n"
          "劇情參與：作為隱藏角色，揭露地下世界背後的黑暗真相。\n"
          "名言：『You’re going to carry out my will, right?』"),
];

const areas = [
  Area(name: "Ruins", image: "assets/images/area_ruins.jpg"),
  Area(name: "Snowdin", image: "assets/images/area_snowdin.jpg"),
  Area(name: "Waterfall", image: "assets/images/area_waterfall.jpg"),
  Area(name: "Hotland", image: "assets/images/area_hotland.jpg"),
  Area(name: "NewHome", image: "assets/images/area_newhome.jpg"),
  Area(name: "Core", image: "assets/images/area_core.jpg"),
];

const bgmList = [
  MusicTrack('Once Upon a Time', 'Toby Fox', 'audio/once_upon_a_time.mp3'),
  MusicTrack('Ruins', 'Toby Fox', 'audio/ruins.mp3'),
  MusicTrack('Snowdin Town', 'Toby Fox', 'audio/snowdin_town.mp3'),
  MusicTrack('Waterfall', 'Toby Fox', 'audio/waterfall.mp3'),
  MusicTrack('CORE', 'Toby Fox', 'audio/core.mp3'),
  MusicTrack('Hopes and Dreams', 'Toby Fox', 'audio/hopes_and_dreams.mp3'),
  MusicTrack("Undertale Main Theme", "Toby Fox", "audio/menu.mp3"),
  MusicTrack("Sans Battle Theme", "Toby Fox", "audio/MEGALOVANIA.mp3"),
  MusicTrack("Papyrus Battle Theme", "Toby Fox", "audio/papyrus.mp3"),
  MusicTrack("Toriel's Theme", "Toby Fox", "audio/toriel.mp3"),
  MusicTrack("Alphys' Theme", "Toby Fox", "audio/alphys.mp3"),
  MusicTrack("Undyne's Theme", "Toby Fox", "audio/undyne.mp3"),
  MusicTrack("Mettaton's Theme", "Toby Fox", "audio/mettaton.mp3"),
  MusicTrack("Asgore's Theme", "Toby Fox", "audio/asgore.mp3"),
  MusicTrack("Flowey's Theme", "Toby Fox", "audio/flowey.mp3"),
  MusicTrack("Asriel's Theme", "Toby Fox", "audio/asriel.mp3"),
  MusicTrack("Chara's Theme", "Toby Fox", "audio/chara.mp3"),
];
