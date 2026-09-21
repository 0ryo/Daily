struct Song {
    let title: String
    let artist: String
    let duration: Int // 秒数
}

struct Playlist {
    let name: String
    var songs: [Song]
    
    mutating func add(song: Song) {
        songs.append(song)
    }
    
    mutating func remove(title: String) -> Bool {
        if let index = songs.firstIndex(where: { song in
            song.title == title
        }) {
            songs.remove(at: index)
            return true
        } else {
            return false
        }
    }
    
    var totalDuration: Int {
        songs.reduce(0) { total, song in
            total + song.duration
        }
    }
    
    var songCount: Int {
        songs.count
    }
}

var playlist1 = Playlist(name: "My Playlist", songs: [])
let song1 = Song(title: "song1", artist: "artist1", duration: 240)
let song2 = Song(title: "song2", artist: "artist2", duration: 300)
let song3 = Song(title: "song3", artist: "artist1", duration: 210)
playlist1.add(song: song1)
playlist1.add(song: song2)
playlist1.add(song: song3)
print(playlist1)
print(playlist1.totalDuration)
print(playlist1.songCount)
playlist1.remove(title: "song2")
print(playlist1)
print(playlist1.totalDuration)
print(playlist1.songCount)
