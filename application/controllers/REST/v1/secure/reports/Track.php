<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Track extends MY_Controller {

	public function __construct()
	{
		parent::__construct();
	}

	protected function middleware()
	{
		return array('admin|except:nullable');
	}

	public function requests()
	{
		try {
			$this->load->model('reports/Track_model', '', TRUE);
			$querys = json_decode($this->security->xss_clean($this->input->get('query')), true);
			
			$response = array(
				'code' => 200,
				'data' => $this->Track_model->requests(is_null($querys) ? array() : $querys)
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
