<?php
class UserEmployee_model extends CI_Model {

	public function __construct()
	{
		parent::__construct();
	}

	public function create(array $employee)
	{
		try{
			$this->db->insert('employee_user', array(
				'id_employee' => $employee['idEmployee'],
				'username' => $employee['username'],
				'password' => $employee['password'],
				'hash' => password_hash($employee['password'], PASSWORD_DEFAULT),
				'status' => $employee['status'],
				'id_role' => $employee['idRole'],
				'create_at' => date('Y-m-d H:i:s'),
				'update_at' => date('Y-m-d H:i:s')
			));

			return array(
				'id' => $this->db->insert_id()
			);
		}catch(\Exception $e){
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}

	public function login(array $employee)
	{
		try{
			$user = $this->db->select('employee_user.id_user AS id, employee_user.id_employee AS idEmployee, employee_user.username, employee_user.hash, person.id_person AS idPerson, person.firstname, person.lastname, person.email, area.id_area AS idArea, area.name AS areaName, position_office.id_position AS idPosition, position_office.name AS positionName, user_role.id_role AS idRole, user_role.nombre AS nameRole, user_role.code AS roleCode')
							->where('employee_user.username', $employee['username'])
							->where('employee_user.status', 1)
							->from('employee_user')
							->join('employee', 'employee.id_employee = employee_user.id_employee')
							->join('person', 'person.id_person = employee.id_person')
							->join('user_role', 'user_role.id_role = employee_user.id_role')
							->join('area', 'area.id_area = employee.id_area')
							->join('position_office', 'position_office.id_position = employee.id_position')
							->get()
							->result_array();

			if(empty($user) || !password_verify($employee['password'], $user[0]['hash'])) throw new \Exception("Username o password invalid.", 401);

			return $user[0];
		}catch(Exception $e) {
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}

	public function listar(array $querys = array())
	{
		if(isset($querys['search'])) return $this->_search($querys);
	}

	private function _search(array $querys = array())
	{
		try {
			$results = $this->db->select('person.firstname, person.lastname, employee.id_employee, person.email')
					->like('person.firstname', $querys['search'])
					->or_like('person.firstname', $querys['search'])
					->or_like('person.email', $querys['search'])
					->or_like('person.document_number', $querys['search'])
					->from('employee_user')
					->join('employee', 'employee.id_employee = employee_user.id_employee')
					->join('person', 'person.id_person = employee.id_person')
					->get()
					->result_array();

			return $results;
		}catch(\Exception $e) {
			throw new \Exception($e->getMessage(), $e->getCode());
		}
	}
}