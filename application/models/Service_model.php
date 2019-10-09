<?php
class Service_model extends CI_Model {

	public function list(array $fields = array('id_service as id', 'title', 'details as description', 'images', 'price', 'status'), array $where = array('status' => '1'))
	{
		return $this->db
					->select(implode(",", $fields))
					->where($where)
					->get('service')
					->result();
	}
}