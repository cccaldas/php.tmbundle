<?php

// For "Insert Call to Parent"

// Typing "parent" and pressing tab on the following line should result in no special action

class Model_Dao_Client
{
	public function test($foo, $bar = 123, array $arr = array(1, 2), Something_Else $blah = null)
    {
        // Typing "parent" and then pressing tab should result in:
        // parent::test($foo, $bar, $arr, $blah);
    }    

	public function test4()
    {
        // parent::test4();
    }

	public static function staticFunction1($param1, $param2) {
		
	}
}

class Model_Dao_Product
{
	public function test($foo, $bar = 123, array $arr = array(1, 2), Something_Else $blah = null)
    {
        // Typing "parent" and then pressing tab should result in:
        // parent::test($foo, $bar, $arr, $blah);
    }    

	public function test4()
    {
        // parent::test4();
    }
}

// Typing "parent" and pressing tab here will generate a parent call for test4(), which is a known
// issue and limitation of the current implementation