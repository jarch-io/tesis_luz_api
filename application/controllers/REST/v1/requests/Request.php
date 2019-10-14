<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Request extends CI_Controller {

	public function create()
	{
		try{
			$this->load->model('Request_model', '', TRUE);
			$this->load->library('form_validation');

			$request = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$this->form_validation->set_data($request['request']);

			$this->form_validation->set_rules(array(
				array(
					'field' => 'customer[firstname]',
					'rules' => 'max_length[100]'
				),
				array(
					'field' => 'customer[lastname]',
					'rules' => 'max_length[100]'
				),
				array(
					'field' => 'customer[email]',
					'rules' => 'valid_email|max_length[100]'
				),
				array(
					'field' => 'customer[phone]',
					'rules' => 'max_length[20]'
				),
				array(
					'field' => 'customer[telephone]',
					'rules' => 'max_length[100]'
				),
				array(
					'field' => 'customer[ubigeo]',
					'rules' => 'numeric'
				),
				array(
					'field' => 'customer[street]',
					'rules' => 'required|max_length[255]'
				),
				array(
					'field' => 'customer[documentType]',
					'rules' => 'max_length[5]|in_list[dni,ce,pass]'
				),
				array(
					'field' => 'customer[documentNumber]',
					'rules' => 'max_length[25]'
				),
				array(
					'field' => 'additionals[acceptTerms]',
					'rules' => 'required'
				),
				array(
					'field' => 'additionals[sendPassword]',
					'rules' => 'required'
				),
				array(
					'field' => 'additionals[emailChannel]',
					'rules' => 'required'
				),
				array(
					'field' => 'additionals[phoneChannel]',
					'rules' => 'required'
				),
				array(
					'field' => 'additionals[comment]',
					'rules' => 'max_length[200]'
				)
			));

			if($this->form_validation->run() === false) {
				$errors = $this->form_validation->error_array();
				throw new \Exception("Por favor verifique la información enviada.", 400);
			}

			$response = array(
				'code' => 201,
				'request' => $this->Request_model->create($request['request'])
			);
		}catch(\Exception $e){
			$response = array(
				'code' => $e->getCode(),
				'message' => $e->getMessage()
			);

			if(isset($errors)) $response['errors'] = $errors;
		}finally {
			$this->response = $response;
		}
	}

	public function getById(int $requestId)
	{
		try{
			$this->load->model('Request_model', '', TRUE);

			$response = array(
				'code' => 200,
				'request' => $this->Request_model->getById($requestId)
			);
		}catch(\Exception $e){
			$response = array(
				'code' => $e->getCode(),
				'message' => $e->getMessage()
			);

			if(isset($errors)) $response['errors'] = $errors;
		}finally {
			$this->response = $response;
		}
	}

	public function addComment(int $requestId)
	{
		try{
			$this->load->model('Request_model', '', TRUE);

			$comment = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$response = array(
				'code' => 201,
				'history' => $this->Request_model->addComment($requestId, $comment['comment'])
			);
		}catch(\Exception $e){
			$response = array(
				'code' => $e->getCode(),
				'message' => $e->getMessage()
			);

			if(isset($errors)) $response['errors'] = $errors;
		}finally {
			$this->response = $response;
		}
	}

	public function nullable()
	{
		$this->response = true;
	}
}
