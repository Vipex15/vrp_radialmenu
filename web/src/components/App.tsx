// App.tsx
import { useEffect, useState } from "react";
import { debugData, fetchNui } from "../utils/utils";
debugData([{ action: "setVisible", data: true }]);


// This is the main component that will be rendered.
const App: React.FC = () => {
	return (
		<div className="container mx-auto mr-2 p-4 overflow-hidden">
			<div className="id-card flex bg-black w-[450px] h-[200px] rounded-2xl shadow-lg overflow-hidden text-white text-lg ml-auto mr-4 mt-4">
				<div className="id-card-left w-[35%] bg-gray-800 flex justify-center items-center p-4">
					<img id="face-image" src="" alt="Player Face" className="photo w-[160px] h-[140px] object-cover rounded-lg border-4 border-white shadow-md" />
				</div>
				<div className="id-card-right w-full p-8 flex flex-col justify-center gap-1">
					<h2 id="player-name" className="text-xl font-bold text-white">Player Name</h2>
					<p className="text-md font-medium text-gray-400"><strong className="font-bold text-orange-500">First Name:</strong> <span id="first-name" className="text-white">John</span></p>
					<p className="text-md font-medium text-gray-400"><strong className="font-bold text-orange-500">Last Name:</strong> <span id="last-name" className="text-white">Doe</span></p>
					<p className="text-md font-medium text-gray-400"><strong className="font-bold text-orange-500">Age:</strong> <span id="player-age" className="text-white">25</span></p>
					<p className="text-md font-medium text-gray-400"><strong className="font-bold text-orange-500">Register ID:</strong> <span id="register-id" className="text-white">#123456789</span></p>
					<p className="text-md font-medium text-gray-400"><strong className="font-bold text-orange-500">Phone:</strong> <span id="phone" className="text-gray-500 italic">+123456789</span></p>
				</div>
			</div>
		</div>
	);
};

export default App;
