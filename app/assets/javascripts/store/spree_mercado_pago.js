
function process_callback(json) {

  var pend_url = json.back_url+'/'+json.collection_id+'/'+json.collection_status+'/'+json.external_reference+'/'+json.preference_id;
    
  if (json.collection_status=='approved'){
    ;
  } else if(json.collection_status=='pending'){
    alert ('El usuario no completó el pago'); //cuando le das imprimir pagofacil u otro
	window.location = pend_url; //redirects to homepage
	
    get(json.back_url, json, 'json');
  } else if(json.collection_status=='in_process'){    
    alert ('El pago está siendo revisado');
    alert(json.back_url);
  } else if(json.collection_status=='rejected'){
    alert ('El pago fué rechazado, el usuario puede intentar nuevamente el pago');
    alert(json.back_url);

  } else if(json.collection_status==null){
    alert ('El usuario no completó el proceso de pago, no se ha generado ningún pago');//cierra ventana 1er o 2do paso

  }
}
