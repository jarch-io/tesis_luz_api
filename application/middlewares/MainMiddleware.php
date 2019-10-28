<?php
/**
 * 
 */
class MainMiddleware
{
	protected $controller;
	protected $ci;

	public $roles = array();
	
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
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}
}