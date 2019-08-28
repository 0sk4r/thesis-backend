# frozen_string_literal: true

module Api
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[create edit]

    # API for managing posts

    # Authentication headers:
    # "access-token": "wwwww",
    # "token-type":   "Bearer",
    # "client":       "xxxxx",
    # "expiry":       "yyyyy",
    # "uid":          "zzzzz"

    # GET /api/posts/ Get list of posts with pagination
    # response with:
    # {
    # List of posts
    #     "posts": [
    #       {
    #           "id": Integer, #Post id
    #           "title": String, #Post title
    #           "content": String, #Post content
    #           "user_id": Integer, #User ID for creator
    #           "created_at": Date, #Date of creation
    #           "updated_at": Date, #Date of update
    #           "image": {
    #               "url": String #URL to thumbnail image
    #           },
    #           "category_id": Integer, #ID of category
    #           "user": {
    #               "id": Integer, #User ID
    #               "name": String, #Name of user
    #               "nickname": String, #Nickname of user
    #               "image": {
    #                   "url": String #URL for user avatar
    #               },
    #               "email": String, #User email
    #           },
    #           "category": {
    #               "id": Integer, #Category ID
    #               "name": String, #Category Name
    #           }
    #       },
    #     ...
    #   ],
    #   #Pagination info
    #   "meta": {
    #       "total": Integer, #Total count of posts
    #       "per_page": Integer #Number of posts per page
    #   }
    # }
    def index
      # Get paginated posts
      @posts = Post.all.order(created_at: :desc).includes(:user, :category).page(params[:page])
      # Serialize posts
      @posts_json = ActiveModelSerializers::SerializableResource.new(@posts).as_json
      # Create response with total items value and per page value
      @response = { posts: @posts_json, meta: { total: @posts.total_count, per_page: @posts.default_per_page } }
      render json: @response, include: %w[user category]
    end

    # GET /api/posts/:id Get selected post
    # :id post id to show
    # response with:
    #   {
    #     "id": Integer, #Post ID
    #     "title": String, #Post title
    #     "content": String, #Post conent
    #     "created_at": Date, #Post creation date
    #     "image": {
    #         "url": String #URL for post thumbnail
    #     },
    #     "likes": Integer, #Number of likes for post
    #     "dislikes": Integer, #Number of dislikes
    #     "comment_count": Integer, #Number of comments
    #     #Info about user that created post
    #     "user": {
    #         "id": Integer, #User ID
    #         "name": String, #User name
    #         "nickname": String, #User nick
    #         "image": {
    #             "url": String #URL to avatar
    #         }
    #     },
    #     #Category info
    #     "category": {
    #         "id": Integer, #Category ID
    #         "name": String #Category name
    #     },
    #     #Lists of comments
    #     "comment": [
    #         {
    #             "id": Integer, #Comment id
    #             "content": String, #Comment content
    #             "created_at": Date, #Comment creation date
    #             #Info about user that created comment
    #             "user": {
    #                 "id": Integer, #User id
    #                 "name": String, #User name
    #                 "nickname": String, #User nickname
    #                 "image": {
    #                     "url": String #URL for avatar
    #                 }
    #             }
    #         },
    #         ...
    #     ]
    # }
    def show
      @post = Post.includes(:user).find(params[:id])

      render json: @post, include: ['user', 'category', 'comment.user']
    end

    # POST /api/posts/ Create new post
    # Require authentications headers
    # params:
    # title: String Post title
    # content: Text Post content
    # category_id: Integer Id of parent category
    # image: File Thumbnail for post
    # Response with created post:
    # post: {
    #   category_id: Integer, #Category ID
    #   content: String, #Post content
    #   created_at: Date, #Post creation date
    #   id: Integer, #Post ID
    #   image: {url: String}, #Url for thumbnail
    #   title: String, #Post title
    #   updated_at: Date, #Update date
    #   user_id: Integer, #User ID
    #   }
    def create
      post = Post.new(post_params)

      if post.save
        render json: { "message": 'Post successfully created', "post": post }
      else
        render status: 422, json: { "errors": post.errors.full_messages.join('. ') }
      end
    end

    # GET /api/posts/:id/edit Edit post
    # Authentication headers required
    # :id Post id to edit
    # Response with data about post with :id:
    # {category: {id: Integer #category id, name: String #category name},
    # comment_count: Integer, #Comment count
    # content: String #Post content,
    # created_at: Date #Post creation date,
    # dislikes: Integer #Dislike count,
    # id: Integer #Post id,
    # image: {url: String #URL for thumbnail},
    # likes: Integer #Like count,
    # title: String #Post title}
    def edit
      @post = Post.find(params[:id])

      if @post.user_id != current_user.id
        render status: 401, json: { "errors": 'You are not allowed to do this.' }
      else
        render json: @post, include: ['category']
      end
    end

    # PUT /api/posts/:id
    # Require authentications headers
    # params:
    # title: String Post title
    # content: Text Post content
    # category_id: Integer Id of parent category
    # image: File Thumbnail for post
    # Response with created post:
    # post: {
    #   category_id: Integer, #Category ID
    #   content: String, #Post content
    #   created_at: Date, #Post creation date
    #   id: Integer, #Post ID
    #   image: {url: String}, #Url for thumbnail
    #   title: String, #Post title
    #   updated_at: Date, #Update date
    #   user_id: Integer, #User ID
    #   }
    def update
      @post = Post.find(params[:id])

      @post.update(post_params)

      if @post.save
        render json: { "message": 'Post successfully updated', "post": @post }
      else
        render status: 422, json: { "errors": @post.errors.full_messages.join('. ') }
      end
    end

    # Search for posts by :key
    def search
      results = Post.search_title(params[:key])
      render json: results
    end

    private

    def post_params
      params.permit(:content, :title, :image, :category_id).merge(user_id: current_user.id)
    end
  end
end
