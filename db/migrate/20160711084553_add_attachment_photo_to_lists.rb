class AddAttachmentPhotoToLists < ActiveRecord::Migration
  def self.up
    change_table :lists do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :lists, :photo
  end
end
