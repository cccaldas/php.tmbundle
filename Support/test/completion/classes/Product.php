<?php

define('PRODUCT_STATIC_VARIABLE_1', false);
define ('PRODUCT_STATIC_VARIABLE_2', false);
define ("PRODUCT_STATIC_VARIABLE_3", false);
define("PRODUCT_STATIC_VARIABLE_4", false);


class Model_Entity_Product extends Model_Entity_Entity {
	
	public $id;
	public $name;
	public $price;
	public $description;
	
}

?>