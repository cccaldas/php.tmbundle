<?php

// For "Insert Call to Parent"

// Typing "parent" and pressing tab on the following line should result in no special action

class Model_Dao_Client
{
	public function getClient($foo, $bar = 123, array $arr = array(1, 2), Something_Else $blah = null)
    {
        // Typing "parent" and then pressing tab should result in:
        // parent::test($foo, $bar, $arr, $blah);
    }    

	public function getClients()
    {
        // parent::test4();
    }

	public static function staticFunction1($param1, $param2) {
		
	}
}