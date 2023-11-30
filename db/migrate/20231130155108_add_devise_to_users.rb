# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:users, :email)
      change_table :users do |t|
        ## Database authenticatable
        t.string :email, null: false, default: ""

        ## Recoverable
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at

        ## Rememberable
        t.datetime :remember_created_at

        ## Trackable
        # t.integer  :sign_in_count, default: 0, null: false
        # t.datetime :current_sign_in_at
        # t.datetime :last_sign_in_at
        # t.string   :current_sign_in_ip
        # t.string   :last_sign_in_ip

        ## Confirmable
        unless column_exists?(:users, :confirmation_token)
          t.string   :confirmation_token
        end
        unless column_exists?(:users, :confirmed_at)
          t.datetime :confirmed_at
        end
        unless column_exists?(:users, :confirmation_sent_at)
          t.datetime :confirmation_sent_at
        end
        unless column_exists?(:users, :unconfirmed_email)
          t.string   :unconfirmed_email
        end

        ## Lockable
        unless column_exists?(:users, :failed_attempts)
          t.integer  :failed_attempts, default: 0, null: false
        end
        unless column_exists?(:users, :unlock_token)
          t.string   :unlock_token
        end
        unless column_exists?(:users, :locked_at)
          t.datetime :locked_at
        end

        # Uncomment below if timestamps were not included in your original model.
        # t.timestamps null: false
      end
    end

    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end

    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
    # Add other indexes if needed
  end

  def down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
