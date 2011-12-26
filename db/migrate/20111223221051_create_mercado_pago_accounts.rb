class CreateMercadoPagoAccounts < ActiveRecord::Migration
  def change
    create_table :mercado_pago_accounts do |t|
      t.string :email
      t.string :name
      t.string :surname
      t.timestamps
    end
  end
end
