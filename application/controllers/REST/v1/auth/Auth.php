<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller {

	public function login()
	{
		try{
			$this->load->model('secure/UserEmployee_model', '', TRUE);
			$employee = json_decode($this->security->xss_clean($this->input->raw_input_stream), true);

			$employeeUser = $this->UserEmployee_model->login($employee['user']);

			$response = array(
				'code' => 200,
				'message' => 'Authorized',
				'auth' => array(
					'token' => AUTHORIZATION::generateToken(array(
						'userId' => $employeeUser['id'],
						'roleCode' => $employeeUser['roleCode'],
						'employeeId' => $employeeUser['idEmployee']
					))
				),
				'user' => array(
					'person' => array(
						'id' => $employeeUser['idPerson'],
						'firstname' => $employeeUser['firstname'],
						'lastname' => $employeeUser['lastname'],
						'email' => $employeeUser['email']
					),
					'position' => array(
						'area' => $employeeUser['areaName'],
						'name' => $employeeUser['positionName']
					)
				)
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

	public function forbidden()
	{
		$this->response = array(
			'code' => 403,
			'message' => "No puede realizar esta accion."
		);
	}

	public function unauthorized()
	{
		$this->response = array(
			'code' => 401,
			'message' => ""
		);
	}

	public function nullable()
	{
		$this->response = true;
	}
}
