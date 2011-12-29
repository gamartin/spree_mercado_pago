class AddCollectionIdStatusMercadoPagoAccount < ActiveRecord::Migration
  def up
    add_column :mercado_pago_accounts, :collection_id, :string
    add_column :mercado_pago_accounts, :collection_status, :string
  end

  def down
    remove_column :mercado_pago_accounts, :collection_id
    remove_column :mercado_pago_accounts, :collection_status
  end
end
