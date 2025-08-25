import 'package:flutter/material.dart';

// Widget bulat untuk artist populer
class _ArtistCircle extends StatelessWidget {
  final String image;
  final String name;
  final String listeners;
  const _ArtistCircle(
      {required this.image, required this.name, required this.listeners});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(
          width: 80,
          child: Text(
            listeners,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Widget kotak untuk album/playlist
class _AlbumSquare extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const _AlbumSquare(
      {required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle.isNotEmpty)
            SizedBox(
              width: 100,
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicHomePage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF232323),
      ),
    );
  }
}

class MusicHomePage extends StatelessWidget {
  MusicHomePage({Key? key}) : super(key: key);

  final Color darkGrey = const Color(0xFF232323);
  final Color lightGrey = const Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 14, backgroundColor: Colors.grey),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile & Search
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Now Playing Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Happiness',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Rex Orange County',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 24,
                            child: IconButton(
                              icon: const Icon(Icons.play_arrow,
                                  color: Colors.white, size: 32),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/happiness.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Filter Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(text: 'All', selected: true),
                  FilterButton(text: 'Trend'),
                  FilterButton(text: 'Leaderboard'),
                ],
              ),
              const SizedBox(height: 16),
              // Artist List
              Row(
                children: [
                  Expanded(child: ArtistTile(image: Colors.blueGrey, name: 'Hindia')),
                  SizedBox(width: 12),
                  Expanded(child: ArtistTile(image: Colors.grey, name: 'Rex Orange County')),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: ArtistTile(image: Colors.black, name: 'Radiohead', isLogo: true)),
                  SizedBox(width: 12),
                  Expanded(child: ArtistTile(image: Colors.blue, name: 'Wave to Earth')),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: ArtistTile(image: Colors.brown, name: 'Sheila On 7')),
                  SizedBox(width: 12),
                  Expanded(child: ArtistTile(image: Colors.indigo, name: 'Coldplay')),
                ],
              ),
              const SizedBox(height: 16),
              // Daily Mixes
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DailyMixCard(
                      color: Colors.red,
                      index: '01',
                      artists:
                          'Rex Orange County, Coldplay, Ricky Montgomery, Maroon 5',
                    ),
                    const SizedBox(width: 8),
                    DailyMixCard(
                      color: Colors.green,
                      index: '02',
                      artists:
                          'Tulus, Sheila On 7, Nidji, Fourtwnty, Nadhif Basalamah',
                    ),
                    const SizedBox(width: 8),
                    DailyMixCard(
                      color: Colors.orange,
                      index: '03',
                      artists:
                          'Reality Club, NIKI, Sal Priadi, Payung Teduh, Noah',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Mini Player

              // --- Popular Artist Section ---
              const SizedBox(height: 24),
              const Text(
                'Popular Artist',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ArtistCircle(
                    image: 'assets/images/niki.jpg',
                    name: 'NIKI',
                    listeners: '22 million monthly listener',
                  ),
                  _ArtistCircle(
                    image: 'assets/images/sombr.jpg',
                    name: 'Sombr',
                    listeners: '48.6 million monthly listener',
                  ),
                  _ArtistCircle(
                    image: 'assets/images/tyler.jpg',
                    name: 'Tyler the creator',
                    listeners: '43 million monthly listener',
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Indonesian Music',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _AlbumSquare(
                    image: 'assets/images/mantu_idaman.jpg',
                    title: 'Mantu Idaman',
                    subtitle: 'Rombongan bodong koplo, necu...',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/mejikuhibiniu.jpg',
                    title: 'Mejikuhibiniu',
                    subtitle: 'Tomi, Suisei, Jemsi',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/tabola_bale.jpg',
                    title: 'Tabola Bale',
                    subtitle: 'Sileb open up, Jacson Seran...',
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Suggested albums',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _AlbumSquare(
                    image: 'assets/images/rex.jpg',
                    title: 'Rex Orange County Playlist',
                    subtitle: '',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/arctic.jpg',
                    title: 'Arctic Monkey Play.',
                    subtitle: '',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/pamungkas.jpg',
                    title: 'Pamungkas Playlist',
                    subtitle: '',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool selected;
  const FilterButton({Key? key, required this.text, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.black : Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ArtistTile extends StatelessWidget {
  final Color image;
  final String name;
  final bool isLogo;
  const ArtistTile({
    Key? key,
    required this.image,
    required this.name,
    this.isLogo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: image,
              borderRadius: BorderRadius.circular(isLogo ? 8 : 20),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyMixCard extends StatelessWidget {
  final Color color;
  final String index;
  final String artists;
  const DailyMixCard({
    Key? key,
    required this.color,
    required this.index,
    required this.artists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Daily Mix',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    index,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 36,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                artists,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
