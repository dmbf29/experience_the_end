class DeleteColumnToExperiences < ActiveRecord::Migration[6.1]
  def change
    remove_column :experiences, :status, :string
  end
end
