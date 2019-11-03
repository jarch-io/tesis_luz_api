<?php
require_once 'MainMiddleware.php';

class EmployeeMiddleware extends MainMiddleware
{

	public function run()
	{
		try{
			parent::run();

			if(!preg_match("/employee_role|admin_role/", $this->ci->authUser->roleCode)) throw new \Exception("No tienes permisos para realizar esta accion.", 403);
			
		}catch(\Exception $e){
			$this->code = $e->getCode();
			$this->message = $e->getMessage();
			parent::resolveResponse();		
		}
	}
}