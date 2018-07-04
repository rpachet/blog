class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :file, PostUploader
end
