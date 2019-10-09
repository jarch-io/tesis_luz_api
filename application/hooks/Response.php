<?php

class Response
{
	private $_CI;
	private $_output;
	private $_response;

	public function __construct()
	{
		$this->_CI = &get_instance();
		$this->_output = $this->_CI->output;
		$this->_response = (object) $this->_CI->response;
	}

	public function JSON()
	{
		$this->_output->set_content_type('application/json')
					->set_output(json_encode($this->_response))
					->set_status_header(isset($this->_response->code) ? $this->_response->code : 200);
	}
}