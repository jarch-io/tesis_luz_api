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

		$history = $this->db->select('id_request_history AS id, id_status_request AS status, comment AS message, from_type AS type, from_id AS agent, create_at AS createAt, update_at AS updateAt')
							->where('id_request', $request->id_request)
							->order_by('update_at', 'desc')
							->get('request_history')
							->result_array();

		$requestObject['history'] = $history;

		return $requestObject;
	}

	public function listar(array $querys = array())
	{
		$requests = $this->db->select('*');
		
		if(isset($querys['filter']) && !empty($filters = $querys['filter'])) {
			if(isset($filters['adviser']) && $filters['adviser'] == '_NULL_') $requests->where('id_employee IS NULL', null, false);
			if(isset($filters['adviser']) && $filters['adviser'] == '_ME_') $requests->where('id_employee', $this->authUser->employeeId);

			if(isset($filters['isClosed'])) $requests->where('is_closed =', (int) $filters['isClosed']);
		}

		$requests = $requests->get('request')
						->result_array();

		$listRequest = array();

		$states = array();

		$customers = array();

		foreach ($requests as $request) {
			$requestObject = array(
				'id' => (int) $request['id_request'],
				'isClosed' => (bool) $request['is_closed'],
				'rating' => (int) $request['satisfactory_rating'],
				'createAt' => $request['create_at'],
				'updateAt' => $request['update_at']
			);

			if(!is_null($request['id_request_status']) && !isset($states[$request['id_request_status']])) {
				$status = $this->db->where('id_status', $request['id_request_status'])
						->get('status_request')
						->result_array()[0];

				$states[$status['id_status']] = $status;
			}

			$status = $states[$request['id_request_status']];

			$requestObject['status'] = array(
				'id' => (int) $status['id_status'],
				'name' => $status['name'],
				'detail' => $status['detail'],
				'position' => (int) $status['position']
			);

			if(!isset($customers[$request['id_customer']])) {
				$customer = $this->db->where('id_customer', $request['id_customer'])
							->get('customer')
							->result_array()[0];

				$isCompany = $customer['type'] == 'company';

				$customerExact = $this->db->where($isCompany ? 'id_company' : 'id_person',  $isCompany ? $customer['id_company'] : $customer['id_person'])
									->get($isCompany ? 'company' : 'person')
									->result_array()[0];

				$customers[$customer['id_customer']] = array(
					'id' => (int) $customer['id_customer'],
					'type' => $customer['type'],
					'firstName' => $customerExact['firstname'] ?? '',
					'lastName' => $customerExact['lastname'] ?? '',
					'email' => $customerExact['email'] ?? '',
					'phone' => $customerExact['phone'] ?? '',
					'telephone' => $customerExact['telephone'] ?? '',
					'name' => $customerExact['name'] ?? '',
					'brandName' => $customerExact['brand_name'] ?? ''
				);
			}

			$requestObject['customer'] = $customers[$request['id_customer']];

			$listRequest[] = $requestObject;
		}

		return $listRequest;
	}

	public function assign(int $requestId, array $adviser)
	{
		if($adviser['id'] == '__ME__') return array();

		$this->db->set('id_employee', $adviser['id'] == '_ME_' ? 1 : $adviser['id'])
					->set('update_at', date('Y-m-d H:i:s'))
					->where('id_request', $requestId)
					->update('request');

		return array();
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

	public function addComment(int $requestId, array $comment)
	{
		try {
			$this->db->trans_start();

			if(isset($comment['status'])) {
				$updatedValues = array('id_request_status' => $comment['status']);

				$updatedValues['update_at'] = date('Y-m-d H:i:s');

				if($comment['status'] == 7) {
					$updatedValues['is_closed'] = 1;
				}

				$this->db->where('id_request', $requestId)
							->update('request', $updatedValues);
			}

			$this->db->insert('request_history', array(
				'id_status_request' => isset($comment['status']) ? $comment['status'] : null,
				'id_request' => $requestId,
				'comment' => $comment['message'] ?? '',
				'from_type' => 'adviser',
				'from_id' => $this->authUser->employeeId,
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