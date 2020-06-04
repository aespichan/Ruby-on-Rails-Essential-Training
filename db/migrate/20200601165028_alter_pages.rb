class AlterPages < ActiveRecord::Migration[6.0]
  def change
    change_column("pages", "subject_id", :integer, null: true)
    change_column("sections", "page_id", :integer, null: true)
  end
end
