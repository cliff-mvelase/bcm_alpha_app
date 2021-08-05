import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
part 'apiclient.g.dart';

@RestApi(baseUrl: "ApiClient.api")
abstract class ApiClient {

  // factory ApiClient(Dio dio) {
  //  dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //   return _ApiClient(dio);
  // }

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  //Dynamic headers
  @GET("/posts")
  Future<List<Post>> getPosts();

  @GET("/posts/{id}")
  Future<Post> getPostFromId(@Path("id") int postId);

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int postId);
  
  @POST("/posts")
  Future<Post> createPost(@Body() Post post);
}

@JsonSerializable()
class Post {
  int userId;
  int postId;
  String title;
  String body;

  Post(this.userId, this.postId, this.title, this.body);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}
