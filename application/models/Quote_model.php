<?php
class Quote_model extends CI_Model {

	public function getById(int $quoteId)
	{
		$quote = $this->db->where(array('quote_id' => $quoteId))
							->get('quote')
							->result_object()[0];

		$items = $this->db->select('quote_item.item_id, quote_item.quantity, service.*')
							->where('quote_item.quote_id', $quoteId)
							->from('quote_item')
							->join('service', 'service.id_service = quote_item.service_id')
							->get()
							->result_array();

		$quoteResponse = array(
			'id' => (int) $quote->quote_id,
			'status' => (bool) $quote->status,
			'created' => $quote->create_at,
			'updated' => $quote->update_at,
			'items' => array()
		);

		foreach ($items as $service) {
			$quoteResponse['items'][] = array(
				'id' => (int) $service['item_id'],
				'quantity' => (int) $service['quantity'],
				'create' => $service['create_at'],
				'update' => $service['update_at'],
				'service' => (int) $service['id_service'],
				'title' => $service['title'],
				'image' => $service['images'],
				'price' => (float) $service['price']
			);
		}

		return $quoteResponse;
	}

	public function create(array $items)
	{
		try{
			$this->db->trans_start();

			if(empty($items)) throw new \Exception("Ingrese al menos un servicio para agregar", 400);

			$this->db->insert('quote', array(
				'status' => 1,
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
			));

			$quoteId = $this->db->insert_id();

			$services = array();

			foreach ($items as $service) {
				$services[] = array(
					'quote_id' => $quoteId,
					'service_id' => $service['id'],
					'quantity' => $service['quantity'],
					'create_at' => date('Y-m-d H:i:s'),
					'update_at' => date('Y-m-d H:i:s')
				);
			}

			$this->db->insert_batch('quote_item', $services);

			if($this->db->trans_status() === FALSE) throw new \Exception("No se puedo crear un nuevo registro.", 500);

			$this->db->trans_commit();

			return $this->getById($quoteId);
		}catch(\Exception $e){
			$this->db->trans_rollback();
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}

	public function update(int $quoteId, array $updates, array $inserts = array())
	{
		try{
			$this->db->trans_start();

			if(!empty($inserts)) {
				$services = array();

				foreach ($inserts as $service) {
					$services[] = array(
						'quote_id' => $quoteId,
						'service_id' => $service['id'],
						'quantity' => $service['quantity'],
						'create_at' => date('Y-m-d H:i:s'),
						'update_at' => date('Y-m-d H:i:s')
					);
				}

				$this->db->insert_batch('quote_item', $services);
			}

			if(!empty($updates)) {
				$services = array();

				foreach ($updates as $service) {
					$this->db->where('item_id', $service['id'])
							->update('quote_item', array(
								'service_id' => $service['id'],
								'quantity' => $service['quantity'],
								'update_at' => date('Y-m-d H:i:s')
							));
				}
			}

			if($this->db->trans_status() === FALSE) throw new \Exception("No se puede actualizar el registro.", 500);

			$this->db->trans_commit();

			return $this->getById($quoteId);
		}catch(\Exception $e){
			$this->db->trans_rollback();
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}
}