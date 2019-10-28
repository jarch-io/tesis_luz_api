<?php
require_once 'MainMiddleware.php';

class EmployeeMiddleware extends MainMiddleware
{

	public function run()
	{
		try{
			parent::run();

			if($this->ci->authUser->roleCode != 'employee_role') throw new \Exception("No tienes permisos para realizar esta accion.", 403);
			
		}catch(\Exception $e){
			switch ($e->getCode()) {
				case 401:
					redirect('/v1/auth/uhfgdhjgnvcmdjfghnvcmk85');
					break;
				case 403:
					redirect('/v1/auth/vbnjhfghjuhng455');
					break;
				default:
					redirect('/v1/auth/uhfgdhjgnvcmdjfghnvcmk85');
					break;
			}		
		}
	}
}