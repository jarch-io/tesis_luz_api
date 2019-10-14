<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Request extends CI_Controller {

	public function getById(int $requestId)
	{
		try{
			$this->load->model('secure/Request_model', '', TRUE);

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

	public function list()
	{
		try {
			$this->load->model('secure/Request_model', '', TRUE);
			$querys = json_decode($this->security->xss_clean($this->input->get('query')), true);
			
			$response = array(
				'code' => 200,
				'requests' => $this->Request_model->listar($querys)
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

	public function assign(int $requestId)
	{
		try {
			$this->load->model('secure/Request_model', '', TRUE);
			$adviser = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);
			
			$response = array(
				'code' => 200,
				'request' => $this->Request_model->assign($requestId, $adviser['adviser'])
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
			$this->load->model('secure/Request_model', '', TRUE);

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
