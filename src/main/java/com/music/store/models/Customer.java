package com.music.store.models;

import lombok.Data;

@Data
public class Customer implements Comparable<Customer> {

	private int id;
	private String name;
	private String lastName;
	private String firstName;
	private String phone;
	private String addressLine1;
	private String addressLine2;
	private String city;
	private String state;
	private String postalCode;
	private String country;
	private int salesRepEmployeeNumber;
	private double creditLimit;

	public Customer() {
		super();
	}

	public Customer(int id, String name, String lastName, String firstName,
			String phone, String addressLine1, String addressLine2,
			String city, String state, String postalCode, String country,
			int salesRepEmployeeNumber, double creditLimit) {
		super();
		this.id = id;
		this.name = name;
		this.lastName = lastName;
		this.firstName = firstName;
		this.phone = phone;
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.city = city;
		this.state = state;
		this.postalCode = postalCode;
		this.country = country;
		this.salesRepEmployeeNumber = salesRepEmployeeNumber;
		this.creditLimit = creditLimit;
	}

	public int compareTo(Customer o) {
		return this.name.toLowerCase().compareTo(o.getName().toLowerCase());
	}
}
