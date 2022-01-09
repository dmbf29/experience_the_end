class AddStatusToExperiences < ActiveRecord::Migration[6.1]
  def change
    add_column :experiences, :status, :string
  end
end
