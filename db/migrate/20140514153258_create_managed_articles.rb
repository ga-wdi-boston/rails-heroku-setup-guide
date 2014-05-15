class CreateManagedArticles < ActiveRecord::Migration
  def change
    create_table :managed_articles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :article, index: true
      t.string :role

      t.timestamps
    end
  end
end
