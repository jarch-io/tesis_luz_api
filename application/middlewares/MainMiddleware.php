<?php
/**
 * 
 */
class MainMiddleware
{
	protected $controller;
	protected $ci;

	public $roles = array();

	protected $code = 500;
	protected $messages = 'Server error';
	
	public function __construct($controller, $ci)
	{
		$this->controller = $controller;
		$this->ci = $ci;
	}

	public function run()
	{
		try{
			$headers = $this->ci->input->request_headers();

			$bearer = explode(" ", isset($headers['Authorization']) ? $headers['Authorization'] : "");

			if(empty($bearer) || !isset($bearer[1])) throw new Exception("", 401);

			$user = AUTHORIZATION::validateToken($bearer[1]);

			$this->ci->authUser = $user;
		}catch(\Exception $e){
			throw new \Exception($e->getMessage(), $e->getCode() == 0 ? 401 : $e->getCode());
		}
	}

	public function resolveResponse()
	{
		$this->ci->output->set_content_type('application/json')
					->set_output(json_encode(array(
						'code' => $this->code,
						'message' => $this->message
					)))
					->set_status_header(isset($this->code) ? $this->code : 400);
		die;
	}
}