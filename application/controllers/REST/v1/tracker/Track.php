<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Track extends CI_Controller {

	public function register()
	{
		try{
			$this->load->model('Track_model', '', TRUE);

			$data = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$data['tracker']['sessionKey'] = $data['sessionKey'];

			$response = array(
				'code' => 201,
				'track' => $this->Track_model->register($data['tracker'])
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
