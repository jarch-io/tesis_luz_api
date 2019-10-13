<?php
class Request_model extends CI_Model {

	public function __construct()
	{
		parent::__construct();

		$this->secretMessage = 'platon E anaxoras';
	}

	public function getById(int $requestId)
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

	public function create(array $request)
	{
		try{
			//$this->load->library('encrypt');
			$this->db->trans_start();

			if(empty($request)) throw new \Exception("Ingrese datos de la solicitud que desea realizar.", 400);

			$customer = $request['customer'];

			if($customer['isCompany']) {
				$this->db->insert('company', array(
					'name' => $customer['name'] ?? '',
					'brand_name' => $customer['brandName'] ?? '',
					'document_number' => $customer['ruc'] ?? '',
					'telephone' => $customer['telephone'] ?? '',
					'phone' => $customer['phone'] ?? '',
					'email' => $customer['email'] ?? '',
					'street' => $customer['street'] ?? '',
					'state' => 1
				));
			}else {
				$this->db->insert('person', array(
					'firstname' => $customer['firstname'] ?? '',
					'lastname' => $customer['lastname'] ?? '',
					'email' => $customer['email'] ?? '',
					'telephone' => $customer['telephone'] ?? '',
					'phone' => $customer['phone'] ?? '',
					'street' => $customer['street'] ?? '',
					'document_type' => $customer['documentType'] ?? '',
					'document_number' => $customer['documentNumber'] ?? '',
					'state' => 1
				));
			}

			$customerId = $this->db->insert_id();

			$this->db->insert('customer', array(
				'type' => $customer['isCompany'] ? 'company' : 'person',
				'id_company' => $customer['isCompany'] ? $customerId : null,
				'id_person' => $customer['isCompany'] ? null : $customerId,
				'status' => 1
			));

			$customerMainId = $this->db->insert_id();

			//$requestCode = $this->encrypt->encode(date('U') . $this->security->get_random_bytes(5), $this->secretMessage);
			$requestCode = str_shuffle(date('U') . 'dmskadm4g5f4gSADASDAD345345!$#$%&%&$');

			$this->db->insert('request', array(
				'code' => $requestCode,
				'id_customer' => $customerMainId,
				'id_request_status' => 1,
				'quote_id' => $request['quote']['id'],
				'detail' => $request['additionals']['comment'] ?? ''
			));

			$requestId = $this->db->insert_id();

			foreach ($request['quote']['items'] as $service) {
				$this->db->insert('request_item', array(
					'id_service' => $service['service'],
					'id_request' => $requestId,
					'quantity' => $service['quantity'],
					'price' => $service['price'],
					'discount' => 0,
					'amount' => $service['quantity'] * $service['price']
				));
			}

			$passwordCustomer = '';

			if($request['additionals']['sendPassword']) {
				$passwordCustomer = str_shuffle('dmskadm4g5f4gSADASDAD345345!$#$%&%&$');
			}

			$this->db->insert('request_history', array(
				'id_status_request' => 1,
				'id_request' => $requestId,
				'comment' => $request['additionals']['comment'] ?? '',
				'from_type' => 'customer',
				'from_id' => $customerMainId
			));

			if($this->db->trans_status() === FALSE) throw new \Exception("No se puedo crear la solicitud.", 500);

			$this->db->trans_commit();

			return array(
				'id' => $requestId,
				'code' => $requestCode,
				'password' => $passwordCustomer
			);
		}catch(\Exception $e){
			$this->db->trans_rollback();
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}
}