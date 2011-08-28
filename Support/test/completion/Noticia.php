<?php

class Model_Dao_Noticia extends MSSQL_Model {

	
    

    

    /**
     * Obtem um array de Categorias vinculadas ao evento informado
     *
     * @param Model_Cms_Noticia $noticia
     * @param string $orderBy
     * @param string $limit
     * @return array
     */
	public static function getCategorias($noticiaId, $orderBy="nome ASC", $limit=10) {
		$sql = "SELECT TOP $limit t3.* FROM noticia as t1, noticia_categoria_noticia as t2 , noticia_categoria t3
			WHERE  t1.id = t2.noticia AND t2.noticiaCategoria = t3.id AND t1.id={$noticiaId} ORDER BY $orderBy";
		
		return MSSQL_Database::fetch($sql);
    }

	public static function getNoticias($noticiaId, $orderBy="nome ASC", $limit=10) {
		$sql = "SELECT TOP $limit t3.* FROM noticia as t1, noticia_categoria_noticia as t2 , noticia_categoria t3
			WHERE  t1.id = t2.noticia AND t2.noticiaCategoria = t3.id AND t1.id={$noticiaId} ORDER BY $orderBy";
		
		return MSSQL_Database::fetch($sql);
    }

}
