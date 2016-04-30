class AddEmailConstraintToUsers < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up {
        execute %{
          ALTER TABLE
          users
          ADD CONSTRAINT
          email_must_be_valid_email
          CHECK ( email ~* '[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]+' )
        }
      }
      direction.down {
        execute %{
          ALTER TABLE
          users
          DROP CONSTRAINT
          email_must_be_valid_email
        }
      }
    end
  end
end
