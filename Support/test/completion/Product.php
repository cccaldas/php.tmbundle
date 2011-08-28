<?php

class Model_Dao_Product
{
	public function getProducts($foo, $bar = 123, array $arr = array(1, 2), Something_Else $blah = null)
    {
        // Typing "parent" and then pressing tab should result in:
        // parent::test($foo, $bar, $arr, $blah);
    }    

	public function getProduct()
    {
        // parent::test4();
    }
}

// Typing "parent" and pressing tab here will generate a parent call for test4(), which is a known
// issue and limitation of the current implementation

?>