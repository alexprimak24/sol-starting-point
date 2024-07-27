import { useEffect, useState } from "react";
import "./App.css";
import { Web3 } from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import { loadContract } from "./utils/load-contract";

function App() {
  // const web3 = new Web3("http://127.0.0.1:7545");
  // web3.eth
  //   .getBalance("0xF8561Dc64E577B0CF53dd3FC11329e80B1A8343e")
  //   .then(console.log);
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null,
  });
  const [account, setAccount] = useState(null);

  useEffect(() => {
    const loadProvider = async () => {
      //with metamask we have an access to window.ethereum & to window.web3
      //metamask injects a global API into website
      //this API allows websites to request users, accounts, read data to blockchain,
      //sign messages and transactions
      const provider = await detectEthereumProvider();
      const contract = await loadContract("Faucet");
      debugger;
      if (provider) {
        provider.request({ method: "eth_requestAccounts" });
        setWeb3Api({
          web3: new Web3(provider),
          provider,
          contract,
        });
      } else {
        console.error("Please install metamask");
      }
    };
    loadProvider();
  }, []);

  useEffect(() => {
    const getAccount = async () => {
      const _account = await web3Api.web3.eth.getAccounts();
      setAccount(_account[0]);
    };
    web3Api.web3 && getAccount();
  }, [web3Api.web3]);
  console.log(web3Api.web3);
  return (
    <div className="faucet-wrapper">
      <div className="faucet">
        <span>Account:</span>
        <div>
          {account ? (
            account
          ) : (
            <button
              className="button is-small"
              onClick={() =>
                web3Api.provider.request({ method: "eth_requestAccounts" })
              }
            >
              Connect Wallet
            </button>
          )}
        </div>
        <div className="balance-view is-size-2 mb-4">
          Current Balance: <strong>10</strong>Eth
        </div>
        <button className="button is-primary is-light mr-2">Donate</button>
        <button className="button is-link is-light">Withdraw</button>
      </div>
    </div>
  );
}

export default App;
