<?php

class Model_DAO_Clients extends DAO {
	
	public static const CLIENTS_DAO_CONSTANT_1 = "value 1";
	public static const CLIENTS_DAO_CONSTANT_2 = "value 2";
	public static const CLIENTS_DAO_CONSTANT_3 = "value 3";
	public static const CLIENTS_DAO_CONSTANT_4 = "value 4";
	
	public static function clientsDAOInlineStaticFunction1() { }
	
	public static function clientsDAOStaticFunction1($param1=false, $param2="param_value") {
			
	}
	
	public static function clientsDAOStaticFunction2($param1, $param2) {
		
	}
	
	public static function clientsDAOStaticFunction3() {
		
	}
}