var map = function() {
	emit(this.customer_accounts.broker_id, {accounts : 1});
}

var reduce = function(key, values) {
	var sum = 0;
	values.forEach(function(doc) {
		sum += doc.values;
	});
	return {accounts : sum}
}

db.customer.mapReduce( map , reduce , { out : "mr" } );

Nesse momento teríamos o _id dos brokers associados ao número de contas que cada um possue em uma coleção distinta.

Buscar os _ids de brokers que possuem mais de uma conta.
result = db.mr.find({accounts: {$gt: 1}}, {'customer_accounts.broker_id' : 1});

Após isso precisamos referenciar manualmente os _id do broker para termos as informações deles, .