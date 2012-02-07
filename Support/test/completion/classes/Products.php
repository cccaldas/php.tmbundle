<?php

define('PRODUCTS_CONSTANT_VARIABLE_1', false);
define ('PRODUCTS_CONSTANT_VARIABLE_2', false);
define ("PRODUCTS_CONSTANT_VARIABLE_3", false);
define("PRODUCTS_CONSTANT_VARIABLE_4", false);

class Model_DAO_Products extends DAO {
	
	public static const PRODUCTS_DAO_STATIC_CONSTANT_1 = "value 1";
	public static const PRODUCTS_DAO_STATIC_CONSTANT_2 = "value 2";
	public static const PRODUCTS_DAO_STATIC_CONSTANT_3 = "value 3";
	public static const PRODUCTS_DAO_STATIC_CONSTANT_4 = "value 4";
	
	public static function productsDAOInlineStaticFunction1() { }
	
	public static function productsDAOStaticFunction1($param1=false, $param2="param_value") {
			
	}
	
	public static function productsDAOStaticFunction2($param1, $param2) {
		
	}
	
	public static function productsDAOStaticFunction3() {
		
	}
}