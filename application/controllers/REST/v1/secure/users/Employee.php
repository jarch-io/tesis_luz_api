<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Employee extends MY_Controller {

	public function __construct()
	{
		parent::__construct();
	}

	protected function middleware()
	{
		return array('admin|except:nullable,create');
	}

	public function create()
	{
		try {
			$this->load->model('secure/UserEmployee_model', '', TRUE);
			$employee = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);
			
			$response = array(
				'code' => 201,
				'user' => $this->UserEmployee_model->create($employee)
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
		try{
			$this->load->model('secure/UserEmployee_model', '', TRUE);
			$querys = json_decode($this->security->xss_clean($this->input->get('query')), true);

			$response = array(
				'code' => 200,
				'employees' => $this->UserEmployee_model->listar(is_null($querys) ? array() : $querys)
			);
		}catch(\Exception $e) {
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
