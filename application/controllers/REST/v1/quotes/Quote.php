<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Quote extends CI_Controller {

	public function getById(int $quoteId)
	{
		try{
			$this->load->model('Quote_model', '', TRUE);

			$response = array(
				'code' => 200,
				'quote' => $this->Quote_model->getById($quoteId)
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

	public function create()
	{
		try{
			$this->load->model('Quote_model', '', TRUE);

			$quote = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$response = array(
				'code' => 201,
				'quote' => $this->Quote_model->create($quote['items'])
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

	public function update(int $quoteId)
	{
		try{
			$this->load->model('Quote_model', '', TRUE);

			$quote = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$response = array(
				'code' => 200,
				'quote' => $this->Quote_model->update($quoteId, array(), $quote['items'])
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
