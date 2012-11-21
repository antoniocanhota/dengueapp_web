class AddAttachmentFotoToDenuncias < ActiveRecord::Migration
  def self.up
    change_table :denuncias do |t|
      t.has_attached_file :foto
    end
  end

  def self.down
    drop_attached_file :denuncias, :foto
  end
end
