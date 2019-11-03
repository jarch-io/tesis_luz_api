<?php

class Request_model extends CI_Model {

	public function __construct()
	{
		parent::__construct();
	}

	public function status(array $querys = array())
	{
		$where = array();

		if($this->authUser->roleCode == 'employee_role') {
			$where['request.id_employee'] = $this->authUser->employeeId;
			$where['request_history.from_type'] = 'adviser';
		}

		$report = $this->db->select('DATE(request_history.create_at) AS create_at, status_request.detail, COUNT(request_history.id_request_history) AS count, status_request.name')
							->where($where)
							->from('request_history')
							->join('request', 'request.id_request = request_history.id_request')
							->join('status_request', 'status_request.id_status = request_history.id_status_request')
							->group_by('status_request.detail')
							->group_by('DATE(request_history.create_at)')
							->order_by('request_history.create_at')
							->get()
							->result_array();

		$categories = array();
		$series = array();

		foreach ($report as $row) {
			$categories[] = $row['create_at'];
		}

		$categories = array_values(array_unique($categories));

		foreach ($report as $row) {
			if(!isset($series[$row['name']])) $series[$row['name']] = array(
				'name' => $row['detail'],
				'data' => array_fill(0, count($categories), 0)
			);

			$series[$row['name']]['data'][array_search($row['create_at'], $categories)] = (int) $row['count'];
		}

		return array(
			'categories' => $categories,
			'series' => array_values($series)
		);
	}
}