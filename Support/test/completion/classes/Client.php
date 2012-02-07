<?php

define('CLIENT_STATIC_VARIABLE_1', false);
define ('CLIENT_STATIC_VARIABLE_2', false);
define ("CLIENT_STATIC_VARIABLE_3", false);
define("CLIENT_STATIC_VARIABLE_4", false);

class Model_Entity_Client extends Model_Entity_Entity {
	
	public $id;
	public $code;
	public $name;
	public $phone;
}