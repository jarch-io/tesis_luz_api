<?php

class Track_model extends CI_Model {

	public function __construct()
	{
		parent::__construct();
	}

	public function requests(array $querys = array())
	{
		$where = array();

		$report = $this->db->select('DATE(create_at) AS createAt, page_key AS pageKey, COUNT(id_tracker) AS count')
							->where($where)
							->from('tracker_page')
							->group_by('pageKey')
							->group_by('DATE(create_at)')
							->order_by('create_at')
							->get()
							->result_array();

		$categories = array();
		$series = array();

		foreach ($report as $row) {
			$categories[] = $row['createAt'];
		}

		$categories = array_values(array_unique($categories));

		foreach ($report as $row) {
			if(!isset($series[$row['pageKey']])) $series[$row['pageKey']] = array(
				'name' => $row['pageKey'],
				'data' => array_fill(0, count($categories), 0)
			);

			$series[$row['pageKey']]['data'][array_search($row['createAt'], $categories)] = (int) $row['count'];
		}

		return array(
			'categories' => $categories,
			'series' => array_values($series)
		);
	}
}