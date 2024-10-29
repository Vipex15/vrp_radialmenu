import React, { useState, useEffect } from "react";
import { debugData, fetchNui } from "../../utils/utils";
debugData([{ action: "setVisible", data: true }]);

/**This is the Home Page page.
 This is the first screen players see when they open the UI.*/
const IDCard: React.FC = () => {
	const [servername, setServerName] = useState<string>("Test Server");
	const [startingMoney, setStartingMoney] = useState<number>(1000);
	const [pvp, setPvp] = useState<string>("disabled");



	return (
		<>

		</>
	);
};

export default IDCard;
