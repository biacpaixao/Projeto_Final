from pymongo import Connection
c = Connection(host = "localhost", port = 27017)


from pymongo.database import Database
from pymongo.errors import AutoReconnect
from pymongo.errors import CollectionInvalid
import datetime

db = Database(c, 'proj')

#resultado = db.customer.find({'watch_list.wl_id' : 12}, {'watch_list' : 1});
#for res in resultado:
#	for wl in res['watch_list']:
#		if wl['wl_id'] == 12:
#			res_final = db.security.find({'_id' : wl['id_security']})
		
		

#resultado = db.customer.find({}, {'c_l_name' : 1, 'c_f_name': 1, 'taxrate.tx_rate' : 1});		
#for r in resultado:
#	r['qntd_taxas'] = 0
#	for taxa in r['taxrate']:
#		r['qntd_taxas'] = r['qntd_taxas'] + taxa['tx_rate']
		

#MAP
resultado = db.customer.find({}, {'customer_account' : 1})
db.temp.drop()
for res in resultado:
	for ca in res['customer_account']:
		db.temp.insert({'broker_id': ca['broker_id']})

#REDUCE
resultado = db.temp.distinct('broker_id')
for res in resultado:
	if db.temp.find({'broker_id' : res}).count() >= 2:
		resultadoFinal = db.broker.find_one({'_id' : res})
