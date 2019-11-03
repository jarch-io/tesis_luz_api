<?php
class Request_model extends CI_Model {

	public function __construct()
	{
		parent::__construct();

		$this->secretMessage = 'platon E anaxoras';
	}

	public function getById(int $requestId)
	{
		$request = $this->db->where(array('id_request' => $requestId))
							->get('request')
							->result_object()[0];

		$requestItems = $this->db->select('service.id_service, service.title, service.images, request_item.price, request_item.quantity, request_item.discount, request_item.amount, request_item.create_at, request_item.update_at, request_item.id_item')
							->where('request_item.id_request', $requestId)
							->from('request_item')
							->join('service', 'service.id_service = request_item.id_service')
							->get()
							->result_array();

		$requestObject = array(
			'id' => (int) $request->id_request,
			'ticket' => $request->code,
			'created' => $request->create_at,
			'updated' => $request->update_at,
			'isClosed' => (bool) $request->is_closed,
			'rating' => (int) $request->satisfactory_rating,
			'services' => array(),
			'offers' => array(),
			'progress' => array(),
			'customer' => array(),
			'adviser' => array(),
			'dates' => array(
				'lastAccess' => '',
				'requestCreate' => ''
			),
			'history' => array(),
			'preferenceStore' => array(
				'currency' => array(
					'symbol' => 'S/',
					'code' => 'PEN'
				)
			)
		);

		if(!is_null($request->id_employee)) {
			$employee = $this->db->select('employee.id_employee AS id, person.firstname AS firstName, person.lastname AS lastName, person.email, person.telephone, person.phone')
							->where('employee.id_employee', $request->id_employee)
							->from('employee')
							->join('person', 'person.id_person = employee.id_person')
							->get()
							->result_array()[0];

			$requestObject['adviser'] = $employee;
		}

		foreach ($requestItems as $service) {
			$requestObject['services'][] = array(
				'id' => (int) $service['id_item'],
				'quantity' => (int) $service['quantity'],
				'create' => $service['create_at'],
				'update' => $service['update_at'],
				'service' => (int) $service['id_service'],
				'title' => $service['title'],
				'image' => $service['images'],
				'price' => (float) $service['price'],
				'discount' => (float) $service['discount']
			);
		}

		$customer = $this->db->where('id_customer', $request->id_customer)
							->get('customer')
							->result_object()[0];
		$isCompany = $customer->type == 'company';

		$customerExact = $this->db->where($isCompany ? 'id_company' : 'id_person',  $isCompany ? $customer->id_company : $customer->id_person)
							->get($isCompany ? 'company' : 'person')
							->result_object()[0];

		$requestObject['customer'] = array(
			'id' => (int) $customer->id_customer,
			'type' => $customer->type,
			'create_at' => $customer->create_at,
			'update_at' => $customer->update_at,
			'firstName' => $customerExact->firstname ?? '',
			'lastName' => $customerExact->lastname ?? '',
			'phone' => $customerExact->phone ?? '',
			'telephone' => $customerExact->telephone ?? '',
			'documentType' => $customerExact->document_type ?? '',
			'document' => $customerExact->document ?? '',
			'address' => $customerExact->street ?? '',
			'email' => $customerExact->email ?? '',
			'name' => $customer->name ?? ''
		);

		$requestObject['history'] = $this->getHistory($requestId);

		$statusList = $this->db->order_by('position')
								->where('status', 1)
								->get('status_request')
								->result_array();

		$progress = array();

		foreach ($statusList as $status) {
			$progress[] = array(
				'id' => $status['id_status'],
				'name' => $status['name'],
				'detail' => $status['detail'],
				'isCurrent' => $status['id_status'] == $request->id_request_status
			);
		}

		$requestObject['progress'] = $progress;

		return $requestObject;
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
					'state' => 1,
					'create_at' => date('Y-m-d H:i:s'),
					'update_at' => date('Y-m-d H:i:s')
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
					'document_number' => $customer['document'] ?? '',
					'state' => 1,
					'create_at' => date('Y-m-d H:i:s'),
					'update_at' => date('Y-m-d H:i:s')
				));
			}

			$customerId = $this->db->insert_id();

			$this->db->insert('customer', array(
				'type' => $customer['isCompany'] ? 'company' : 'person',
				'id_company' => $customer['isCompany'] ? $customerId : null,
				'id_person' => $customer['isCompany'] ? null : $customerId,
				'status' => 1,
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
			));

			$customerMainId = $this->db->insert_id();

			//$requestCode = $this->encrypt->encode(date('U') . $this->security->get_random_bytes(5), $this->secretMessage);
			$requestCode = str_shuffle(date('U') . 'dmskadm4g5f4gSADASDAD345345!$#$%&%&$');

			$this->db->insert('request', array(
				'code' => $requestCode,
				'id_customer' => $customerMainId,
				'id_request_status' => 1,
				'quote_id' => $request['quote']['id'],
				'detail' => $request['additionals']['comment'] ?? '',
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
			));

			$requestId = $this->db->insert_id();

			foreach ($request['quote']['items'] as $service) {
				$this->db->insert('request_item', array(
					'id_service' => $service['service'],
					'id_request' => $requestId,
					'quantity' => $service['quantity'],
					'price' => $service['price'],
					'discount' => 0,
					'amount' => $service['quantity'] * $service['price'],
					'create_at' => date('Y-m-d H:i:s'),
					'update_at' => date('Y-m-d H:i:s')
				));
			}

			$passwordCustomer = '';

			if($request['additionals']['sendPassword']) {
				$passwordCustomer = str_shuffle('dmskadm4g5f4gSADASDAD345345!$#$%&%&$');
			}

			$this->db->insert('request_history', array(
				'id_status_request' => 1,
				'id_request' => $requestId,
				'comment' => $request['additionals']['comment'] ?? 'Solicitud creada.',
				'from_type' => 'customer',
				'from_id' => $customerMainId,
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
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

	public function getHistory(int $requestId)
	{
		return $this->db->select('request_history.id_request_history AS id, request_history.id_status_request AS status, status_request.name AS statusName, status_request.detail, request_history.comment AS message, request_history.from_type AS type, request_history.from_id AS agent, request_history.create_at AS createAt, request_history.update_at AS updateAt')
							->where('request_history.id_request', $requestId)
							->order_by('request_history.update_at', 'desc')
							->from('request_history')
							->join('status_request', 'status_request.id_status = request_history.id_status_request', 'left')
							->get()
							->result_array();
	}

	public function setRating(int $requestId, int $rating)
	{
		$this->db->set('satisfactory_rating', $rating)
					->where('id_request', $requestId)
					->update('request');

		return true;
	}

	public function addComment(int $requestId, array $comment)
	{
		try {
			$this->db->trans_start();

			if(isset($comment['cancel']) && $comment['cancel']) {
				$this->db->set('id_request_status', 5)
							->set('update_at', date('Y-m-d H:i:s'))
							->where('id_request', $requestId)
							->update('request');
			}

			$this->db->insert('request_history', array(
				'id_status_request' => !$comment['cancel'] ? null : 5,
				'id_request' => $requestId,
				'comment' => $comment['message'] ?? '',
				'from_type' => 'customer',
				'from_id' => $comment['fromId'],
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
			));

			if($this->db->trans_status() === FALSE) throw new \Exception("No se puedo agregar el comentario.", 500);

			$this->db->trans_commit();

			return $this->getHistory($requestId);
		}catch(\Exception $e){
			$this->db->trans_rollback();
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}
}