class AddDefaultStatusToExperiences < ActiveRecord::Migration[6.1]
  def change
    add_column :experiences, :status, :string, default: 'building'
  end
end
