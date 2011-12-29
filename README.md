SpreeMercadoPago
================

	Extensión para incluir la pasarela de pagos Mercado Pago en Spree.


Credenciales Mercado Pago
-------
	Necesitamos obtener las credenciales de Mercado Pago	
	http://developers.mercadopago.com/ar/integracion-checkout


Config
-------

	Clonar:
	git clone git@github.com:gamartin/spree_mercado_pago.git

	Dependencias:
	bundle install 

	Crear aplicacion "dummy"  de ejemplo
	bundle exec rake test_app

	Migrations y datos de ejemplo
	cd spec/dummy
	rake db:bootstrap o
	rake db:bootstrap RAILS_ENV=test para correr specs

	Configurar Cuenta MP en app:
	rails s 
	Navegar a:
	http://localhost:3000/admin/payment_methods/new
	Introducir credenciales Mercado Pago


