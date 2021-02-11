class Player{
  String _name;
  int _score;
  String _image = 'images/user.png';

void set name(String name) => _name = name;
String get name => _name;

void set score(int score) => _score = score;
int get score => _score;

void set image(String image) => _image = image;
String get image => _image;
}