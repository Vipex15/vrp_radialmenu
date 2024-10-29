import React, {
	Context,
	createContext,
	useContext,
	useEffect,
	useState,
} from "react";
import { useNuiEvent, fetchNui } from "../utils/utils";
import { isEnvBrowser } from "../utils/misc";

const VisibilityCtx = createContext<VisibilityProviderValue | null>(null);

interface VisibilityProviderValue {
	setVisible: (visible: boolean) => void;
	visible: boolean;
}

// This should be mounted at the top level of your application, it is currently set to
// apply a CSS visibility value. If this is non-performant, this should be customized.
export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
	children,
}) => {
	const [visible, setVisible] = useState(false);

	useNuiEvent<boolean>("setVisible", setVisible);

	// Handle pressing escape/backspace
	useEffect(() => {
		const keyHandler = (e: KeyboardEvent) => {
			if (["Backspace", "Escape"].includes(e.code)) {
				fetchNui('exit')
			}
		}
		window.addEventListener("keydown", keyHandler);
		return () => window.removeEventListener("keydown", keyHandler);
	}, []);

	return (
		<VisibilityCtx.Provider
			value={{
				visible,
				setVisible,
			}}
		>
			<div
				style={{ visibility: visible ? "visible" : "hidden", height: "100%" }}
			>
				{children}
			</div>
		</VisibilityCtx.Provider>
	);
};

export const useVisibility = () =>
	useContext<VisibilityProviderValue>(
		VisibilityCtx as Context<VisibilityProviderValue>
	);
