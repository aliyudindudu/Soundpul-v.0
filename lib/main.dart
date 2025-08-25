import 'package:flutter/material.dart';

// Widget bulat untuk artist populer
class _ArtistCircle extends StatelessWidget {
  final String image;
  final String name;
  final String listeners;
  const _ArtistCircle({
    required this.image,
    required this.name,
    required this.listeners,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: 96,
            height: 96,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
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
  final double? width;
  const _AlbumSquare({
    required this.image,
    required this.title,
    required this.subtitle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double w = width ?? 100;
    return SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: w,
              height: w,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle.isNotEmpty)
            // Ganti SizedBox menjadi Flexible agar subtitle tidak overflow
            Flexible(
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

class MusicHomePage extends StatefulWidget {
  MusicHomePage({Key? key}) : super(key: key);

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final Color darkGrey = const Color(0xFF232323);
  final Color lightGrey = const Color(0xFF2E2E2E);
  int _selectedIndex = 0;

  // Tambahkan controller untuk search
  final TextEditingController _searchController = TextEditingController();

  void _onBottomNavTap(int index) {
    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            selectedIndex: 4,
            onBottomNavTap: (i) {
              if (i != 4) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Ubah jadi hitam
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/images/profile/profile.jpg'),
              backgroundColor: Colors.grey,
            ),
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
                  // Avatar kiri atas jadi tombol ke ProfilePage
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          AssetImage('assets/images/profile/profile.jpg'),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          // Ganti Text menjadi TextField agar bisa diketik
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Find your favorite music',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              cursorColor: Colors.white54,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              // Bisa tambahkan aksi search di sini jika perlu
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Tambahkan tulisan Last listened to di bawah search bar
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Last listened to',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
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
                        'assets/images/music/happiness.jpg',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  FilterButton(text: 'All', selected: true),
                  SizedBox(width: 12),
                  FilterButton(text: 'Trend'),
                  SizedBox(width: 12),
                  FilterButton(text: 'Leaderboard'),
                ],
              ),
              const SizedBox(height: 16),
              // Artist List
              Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Hindia',
                          imageAsset: 'assets/images/music/hindia.jpg',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Rex Orange County',
                          imageAsset: 'assets/images/music/rexorange.jpg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Radiohead',
                          imageAsset: 'assets/images/music/radiohead.jpg',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Wave to Earth',
                          imageAsset: 'assets/images/music/wavetoearth.jpg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Sheila On 7',
                          imageAsset: 'assets/images/music/sheilaon7.jpg',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ArtistTile(
                          image: Colors.transparent,
                          name: 'Coldplay',
                          imageAsset: 'assets/images/music/coldplay.jpg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Daily Mixes (responsive, 3 cards fit screen)
              LayoutBuilder(
                builder: (context, constraints) {
                  double cardSpacing = 8;
                  double cardWidth =
                      (constraints.maxWidth - 2 * cardSpacing) / 3;
                  // Tambah tinggi agar tidak overflow di device kecil
                  return SizedBox(
                    height: cardWidth + 60, // tambah sedikit dari 48 ke 60
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DailyMixCard(
                          color: Colors.red,
                          index: '01',
                          artists:
                              'Rex Orange County, Coldplay, Ricky Montgomery, Maroon 5',
                          imagePath: 'assets/images/music/happiness.jpg',
                          width: cardWidth,
                        ),
                        SizedBox(width: cardSpacing),
                        DailyMixCard(
                          color: Colors.green,
                          index: '02',
                          artists:
                              'Tulus, Sheila On 7, Nidji, Fourtwnty, Nadhif Basalamah',
                          imagePath: 'assets/images/music/tulus.jpg',
                          width: cardWidth,
                        ),
                        SizedBox(width: cardSpacing),
                        DailyMixCard(
                          color: Colors.orange,
                          index: '03',
                          artists:
                              'Reality Club, NIKI, Sal Priadi, Payung Teduh, Noah',
                          imagePath: 'assets/images/music/realityc.jpg',
                          width: cardWidth,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
              // Popular Artist Section
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
                children: const [
                  _ArtistCircle(
                    image: 'assets/images/music/niki.jpg',
                    name: 'NIKI',
                    listeners: '22 million monthly listeners',
                  ),
                  _ArtistCircle(
                    image: 'assets/images/music/sombr.jpg',
                    name: 'Sombr',
                    listeners: '48.6 million monthly listeners',
                  ),
                  _ArtistCircle(
                    image: 'assets/images/music/tyler.jpg',
                    name: 'Tyler the Creator',
                    listeners: '43 million monthly listeners',
                  ),
                  _ArtistCircle(
                    image: 'assets/images/music/billie.jpg',
                    name: 'Billie Eilish',
                    listeners: '57 million monthly listeners',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Indonesian Music
              const Text(
                'Indonesian Music',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  double spacing = 8;
                  double albumWidth = (constraints.maxWidth - 3 * spacing) / 4;
                  return SizedBox(
                    // Tinggi tetap, tapi isi albumSquare sekarang flexible
                    height: albumWidth + 54,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: albumWidth,
                              maxWidth: albumWidth,
                            ),
                            child: _AlbumSquare(
                              image: 'assets/images/music/mantu_idaman.jpg',
                              title: 'Mantu Idaman',
                              subtitle: 'Rombongan bodong koplo, necu...',
                              width: albumWidth,
                            ),
                          ),
                          SizedBox(width: spacing),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: albumWidth,
                              maxWidth: albumWidth,
                            ),
                            child: _AlbumSquare(
                              image: 'assets/images/music/mejikuhibiniu.jpg',
                              title: 'Mejikuhibiniu',
                              subtitle: 'Tomi, Suisei, Jemsi',
                              width: albumWidth,
                            ),
                          ),
                          SizedBox(width: spacing),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: albumWidth,
                              maxWidth: albumWidth,
                            ),
                            child: _AlbumSquare(
                              image: 'assets/images/music/tabola_bale.jpg',
                              title: 'Tabola Bale',
                              subtitle: 'Sileb open up, Jacson Seran...',
                              width: albumWidth,
                            ),
                          ),
                          SizedBox(width: spacing),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: albumWidth,
                              maxWidth: albumWidth,
                            ),
                            child: _AlbumSquare(
                              image: 'assets/images/music/nidji.jpg',
                              title: 'Nidji Hits',
                              subtitle: 'Nidji, Giring, Rama',
                              width: albumWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Suggested Albums
              const Text(
                'Suggested Albums',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _AlbumSquare(
                    image: 'assets/images/music/rexorange.jpg',
                    title: 'Rex Orange County Playlist',
                    subtitle: '',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/music/arcticm.jpg',
                    title: 'Arctic Monkeys Playlist',
                    subtitle: '',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/music/pamungkas.jpg',
                    title: 'Pamungkas Playlist',
                    subtitle: '',
                  ),
                  _AlbumSquare(
                    image: 'assets/images/music/nangid.jpg',
                    title: 'Janji Ga nangid',
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
  final String? imageAsset; // tambahkan untuk gambar

  const ArtistTile({
    Key? key,
    required this.image,
    required this.name,
    this.isLogo = false,
    this.imageAsset,
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
              color: imageAsset == null ? image : null,
              borderRadius: BorderRadius.circular(12), // kotak dengan sudut 12
            ),
            child: imageAsset != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imageAsset!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
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

// DailyMixCard (DIPERBARUI)
class DailyMixCard extends StatelessWidget {
  final Color color;
  final String index;
  final String artists;
  final String imagePath;
  final double? width;

  const DailyMixCard({
    Key? key,
    required this.color,
    required this.index,
    required this.artists,
    this.imagePath = 'assets/images/placeholder.jpg',
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = width ?? 100;
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF2E2E2E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: cardWidth,
            width: cardWidth,
            fit: BoxFit.cover,
          ),
          Container(
            width: cardWidth,
            color: color,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Mix',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  index,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Gunakan Flexible agar teks tidak overflow
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
              child: Text(
                artists,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tambahkan halaman ProfilePage sesuai desain
class ProfilePage extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onBottomNavTap;
  const ProfilePage({Key? key, this.selectedIndex = 4, this.onBottomNavTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color darkGrey = const Color(0xFF232323);
    final Color lightGrey = const Color(0xFF2E2E2E);

    return Scaffold(
      backgroundColor: darkGrey,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onBottomNavTap ??
            (i) {
              if (i != 4) Navigator.pop(context);
            },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/images/profile/profile.jpg'),
              backgroundColor: Colors.grey,
            ),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 38, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto profil di kiri, data di kanan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 62,
                      backgroundImage:
                          AssetImage('assets/images/profile/profile.jpg'),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18), // Tambahkan padding top agar data turun
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Dempull',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(Icons.edit, color: Colors.white, size: 16),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'aliyudindudu@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.mail, color: Colors.red, size: 13),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.green, size: 11),
                                const SizedBox(width: 4),
                                Text(
                                  'Online',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Bio/status kecil, background abu, rounded, shadow tipis
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'Let Me Fly You To The Moon',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tombol Edit & Apply kecil
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 34,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: const Text('Edit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 80,
                      height: 34,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: const Text('Apply',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Setting & Privacy
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF444444),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Setting & Privacy',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
