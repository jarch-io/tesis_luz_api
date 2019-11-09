<?php
class Service_model extends CI_Model {

	public function list(array $fields = array('id_service as id', 'title', 'details as description', 'images', 'price', 'status', 'parent_id AS parentId', 'type'), array $where = array('status' => '1', 'parent_id' => null))
	{
		$services = $this->db
					->select(implode(",", $fields))
					->where($where)
					->get('service')
					->result();

		foreach ($services as $index => $service) {
			$planes = $this->db
						->select(implode(",", $fields))
						->where(array(
							'status' => 1,
							'parent_id' => $service->id
						))
						->get('service')
						->result();

			if(!empty($planes)) $services[$index]->planes = $planes;
		}

		return $services;
	}
}