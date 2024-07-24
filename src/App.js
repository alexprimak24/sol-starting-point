import { useEffect, useState } from "react";
import "./App.css";
import { Web3 } from "web3";
import detectEthereumProvider from "@metamask/detect-provider";

function App() {
  // const web3 = new Web3("http://127.0.0.1:7545");
  // web3.eth
  //   .getBalance("0xF8561Dc64E577B0CF53dd3FC11329e80B1A8343e")
  //   .then(console.log);
  const [web3Api, setWeb3Api] = useState({ provider: null, web3: null });
  const [account, setAccount] = useState(null);

  useEffect(() => {
    const loadProvider = async () => {
      //with metamask we have an access to window.ethereum & to window.web3
      //metamask injects a global API into website
      //this API allows websites to request users, accounts, read data to blockchain,
      //sign messages and transactions
      const provider = await detectEthereumProvider();
      if (provider) {
        provider.request({ method: "eth_requestAccounts" });
        setWeb3Api({
          web3: new Web3(provider),
          provider,
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
        <h1>{account ? account : "not connected"}</h1>
        <div className="balance-view is-size-2">
          Current Balance: <strong>10</strong>Eth
        </div>
        <button className="btn mr-2">Donate</button>
        <button className="btn">Withdraw</button>
      </div>
    </div>
  );
}

export default App;
