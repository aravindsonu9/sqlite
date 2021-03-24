
class DBmodel{
  final int id;
  final String text;
  final String desc;
  static const String TABLENAME ="DataTable";
  DBmodel({this.id,this.text,this.desc});

  Map<String,dynamic>toMap(){
    return{'id':id,'text':text,'desc':desc
    };
  }
}