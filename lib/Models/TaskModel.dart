class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false,
      required this.userId});


  TaskModel.fromJson(Map<String, dynamic>json) :this(
        title: json['title'],
        description: json['description'],
        date: json['date'],
        id: json['id']
        , isDone: json['isDone'],
      userId:json['userId']

  );
  Map<String,dynamic>tojson(){
    return{
      "title":title,
      "description":description,
      "date":date,
      "isDone":isDone,
      "id":id,
      "userId":userId,
    };

  }
}
