
function output = predict(testX, testY, Theta1, Theta2)
	
	% Predicts the output based on a feed forward pass	
	m = size(testX, 1);
	num_labels = size(Theta2, 1);
	output = zeros(size(testX, 1), 1);

	h1 = sigmoid([ones(m, 1) testX] * Theta1');
	h2 = sigmoid([ones(m, 1) h1] * Theta2');
	[dummy, output] = max(h2, [], 2);
	
	% Calculate Accuracy
	accuracy = sum((output == testY)(:)) * 100 / m;
	fprintf("Accuracy = %f\n", accuracy); 

end;
