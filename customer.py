db.customer.insert({'_id' : 'c000', 
					'c_l_name' : 'Scremin', 
					'c_f_name' : 'Alberto', 
					'c_tier' : 1, 
					'c_dob' : new Date(1989,1,9),
					'status_type' : 'ACTV', 
					'address' : {
								'ad_line': 'rua do aa',
								'ad_line2': 'numero 62',
								'ad_ctry': 'Brasil',
								'zipcode': {
											'zc_code' : '204951',
											'zc_town' : 'Niteroi',
											'zc_div' : 'Brasil'
											}
								},
					'taxrate' : [{
									'tx_id' : 123,
									'tx_name' : 'OLA',
									'tx_rate' : 0.9
					},
								{
									'tx_id' : 3,
									'tx_name' : 'OALA',
									'tx_rate' :	0.3				
					}],
					'customer_accounts' : [	{
												'ca_id' : 123,
												'ca_name': 'ALOHA',
												'ca_tax_st': 'deaa',
												'ca_bal': 12323,
												'account_permission' : {
																			'ap_acl' : 123,
																			'ap_l_name': 'LAL',
																			'ap_f_name': 'FOOF'
												},
												'broker_id': 1234
											},
											{
											'ca_id' : 1232,
												'ca_name': 'AL3OHA',
												'ca_tax_st': 'de56aa',
												'ca_bal': 123123,
												'account_permission' : {
																			'ap_acl' : 12323,
																			'ap_l_name': 'L31AL',
																			'ap_f_name': 'FO23OF'
												},
												'broker_id': 1934
											}
										],
					'watch_list' : [{
									'wl_id': 12,
									'id_security': 42
									},
									{
									'wl_id': 122,
									'id_security': 423
									}									
								]

});


db.customer.insert({'_id' : 'c001', 
					'c_l_name' : 'Scremin', 
					'c_f_name' : 'Luci', 
					'c_tier' : 1, 
					'c_dob' : new Date(2110,2,9),
					'status_type' : 'CNCL', 
					'address' : {
								'ad_line': 'b',
								'ad_line2': 'num 6342',
								'ad_ctry': 'Brasil',
								'zipcode': {
											'zc_code' : '202951',
											'zc_town' : 'Rio de Janeiro',
											'zc_div' : 'Brasil'
											}
								},
					'taxrate' : [{
									'tx_id' : 123,
									'tx_name' : 'OLA',
									'tx_rate' : 0.9
					},
					],
					'customer_accounts' : [	{
												'ca_id' : 1235,
												'ca_name': 'ALOHFFFA',
												'ca_tax_st': 'deaffffa',
												'ca_bal': 13,
												'account_permission' : {
																			'ap_acl' : 123,
																			'ap_l_name': 'LAL',
																			'ap_f_name': 'FOOF'
												},
												'broker_id': 134
											},
											{
											'ca_id' : 121132,
												'ca_name': 'AL3OH4A',
												'ca_tax_st': 'de56a44a',
												'ca_bal': 66626,
												'account_permission' : {
																			'ap_acl' : 1232223,
																			'ap_l_name': 'L31231AL',
																			'ap_f_name': 'FO25123OF'
												},
												'broker_id': 1934
											}
										],
					'watch_list' : [{
									'wl_id': 123,
									'id_security': 424
									},
									{
									'wl_id': 1122,
									'id_security': 4223
									}									
								]

});