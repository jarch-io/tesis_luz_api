<?php
class Track_model extends CI_Model {

	public function register(array $tracker)
	{
		try{
			$this->db->trans_start();

			if(empty($tracker)) throw new \Exception("Ingrese informacion de tracking.", 400);

			$track = $this->db
						->where(array(
							'page_key' => $tracker['pageKey'],
							'session_key' => $tracker['sessionKey']
						))
						->get('tracker_page')
						->result_array();

			if(empty($track)) {
				$this->db->insert('tracker_page', array(
					'page_key' => $tracker['pageKey'],
					'session_key' => $tracker['sessionKey'] ?? '',
					'request_id' => $tracker['requestId'] ?? null,
					'create_at' => date('Y-m-d H:i:s')
				));
			}

			if($this->db->trans_status() === FALSE) throw new \Exception("No se puedo crear un nuevo registro.", 500);

			$this->db->trans_commit();

			return true;
		}catch(\Exception $e){
			$this->db->trans_rollback();
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}

	
}