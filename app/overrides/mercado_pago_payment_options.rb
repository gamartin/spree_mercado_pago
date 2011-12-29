Deface::Override.new(:virtual_path  => "admin/payment_methods/_form",
            :insert_bottom => "#preference-settings",
            :text          => "<p></p>",
            :name          => "registration_future")
            