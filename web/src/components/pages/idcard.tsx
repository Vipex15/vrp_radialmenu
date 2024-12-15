import React, { useState, useEffect } from "react";
import { debugData, fetchNui } from "../../utils/utils";

/**This is the Home Page page.
 This is the first screen players see when they open the UI.*/
const IDCard: React.FC = () => {
	const [playerData, setPlayerData] = useState<any>(null);


	useEffect(() => {
		fetchNui('getPlayerData').then((data: any) => {
			if (data) {
				setPlayerData(data);
			}
		})
	}, []);


	return (
		<>
			<div className="id-card">
				<div className="id-card-left">
					<img id="face-image" src="" alt="Player Face" className="photo" />
				</div>
				<div className="id-card-right">
					<h2 id="player-name">{playerData.name}</h2>
					<p><strong>First Name:</strong> <span id="first-name">John</span></p>
					<p><strong>Last Name:</strong> <span id="last-name">Doe</span></p>
					<p><strong>Age:</strong> <span id="player-age">25</span></p>
					<p><strong>Register ID:</strong> <span id="register-id">#123456789</span></p>
					<p><strong>Phone:</strong> <span id="phone">+123456789</span></p>
				</div>
			</div>
		</>
	);
};

export default IDCard;
