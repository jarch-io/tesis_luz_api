<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Service extends CI_Controller {

	public function list()
	{
		try{
			$this->load->model('Service_model', '', TRUE);

			$response = array(
				'code' => 200,
				'services' => $this->Service_model->list()
			);
		}catch(\Exception $e) {
			$response = array(
				'code' => $e->getCode(),
				'message' => $e->getMessage()
			);
		}finally{
			$this->response = $response;
		}
	}
}
