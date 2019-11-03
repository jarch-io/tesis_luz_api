<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Request extends MY_Controller {

	public function __construct()
	{
		parent::__construct();
	}

	protected function middleware()
	{
		return array('employee|except:nullable');
	}

	public function status()
	{
		try {
			$this->load->model('reports/Request_model', '', TRUE);
			$querys = json_decode($this->security->xss_clean($this->input->get('query')), true);
			
			$response = array(
				'code' => 200,
				'data' => $this->Request_model->status(is_null($querys) ? array() : $querys)
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
