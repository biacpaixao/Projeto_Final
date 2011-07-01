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

Nesse momento ter�amos o _id dos brokers associados ao n�mero de contas que cada um possue em uma cole��o distinta.

Buscar os _ids de brokers que possuem mais de uma conta.
result = db.mr.find({accounts: {$gt: 1}}, {'customer_accounts.broker_id' : 1});

Ap�s isso precisamos referenciar manualmente os _id do broker para termos as informa��es deles, .