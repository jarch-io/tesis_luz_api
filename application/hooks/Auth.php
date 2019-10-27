<?php

/**
 * 
 */
class Auth
{
	private $_CI;
	public function __construct()
	{
		$this->_CI = &get_instance();
	}

	public function validate()
	{
		return true;
	}
}