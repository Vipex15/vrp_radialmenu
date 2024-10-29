// App.tsx
import { useEffect, useState } from "react";
import { fetchNui } from "../utils/utils";
import {
	Router,
	Routes,
	Route,
	IDCard,
} from "./imports"; /* These are just a bunch of imports that are used in the app.
Found in the imports.ts file.*/

// This is the main component that will be rendered.
const App: React.FC = () => {
	return (
		<Router>
			<div className="absolute right-32 top-20 w-[20%] h-[15%] bg-gray-200 rounded-lg shadow-lg">
				<Routes>
					<Route path="/" element={<IDCard />} />
				</Routes>
			</div>
		</Router>
	);
};

export default App;
