<?php
require_once 'MainMiddleware.php';

class AdminMiddleware extends MainMiddleware
{

	public function run()
	{
		try{
			parent::run();

			if($this->ci->authUser->roleCode != 'admin_role') throw new \Exception("No tienes permisos para realizar esta accion.", 403);
			
		}catch(\Exception $e){
			$this->code = $e->getCode();
			$this->message = $e->getMessage();
			parent::resolveResponse();
		}
	}
}