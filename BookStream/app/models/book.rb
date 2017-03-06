class Book < ActiveRecord::Base
    validates :name, presence: true
    validates :author, presence: true
    validates :access, presence: true
    has_attached_file :document, {preserve_files: true}
    validates_attachment :document, presence: true
    validates_attachment_file_name :document, matches: [/pdf\Z/, /mobi\Z/, /epub\Z/, /azw\Z/]
    belongs_to :user
    has_attached_file :image, {preserve_files: true}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    has_and_belongs_to_many :tags

end
