// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
// import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/vendor/SafeMathChainlink.sol";
// import "https://github.com/smartcontractkit/chainlink/blob/develop/ecotracts/src/v0.8/ChainlinkClient.sol";

// import "https://github.com/smartcontractkit/chainlink/blob/develop/evm-contracts/src/v0.4/vendor/Ownable.sol";
// import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";

// import "https://github.com/smartcontractkit/chainlink/blob/develop/evm-contracts/src/v0.4/interfaces/AggregatorInterface.sol";
// import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import"./Insurance.sol";

contract checkingWeather is cropInsurance{
    using Chainlink for Chainlink.Request;


    uint256 constant private ORACLE_PAYMENT = 0.1 * 10**18; // 0.1 LINK
    address public constant LINK_POLYGON = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB ; //address of LINK token on Kovan
    

    // for polygon mainnet
    // setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
    // oraclePaymentAmount = _oraclePaymentAmount;
    


    
    string constant WORLD_WEATHER_ONLINE_URL = "http://api.worldweatheronline.com/premium/v1/weather.ashx?";
    string constant WORLD_WEATHER_HISTORY_URL = "http://api.worldweatheronline.com/premium/v1/past-weather.ashx?";
    string constant WORLD_WEATHER_ONLINE_KEY = "61b3e78b7c214048b09121906222310";
    string constant WORLD_WEATHER_ONLINE_PATH = "data.current_condition.0.humidity";

    string cropLocation = "ny"; 

    uint public rainTemp; 

    address private oracle;
    bytes32 private jobId;
    uint fee;

    constructor() {
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        oracle = 0x0bDDCD124709aCBf9BB3F824EbC61C87019888bb;
        jobId = "2bb15c3f9cfc4336b95012872ff05092";
        fee = 0.01 * 10 ** 18; // (Varies by network and job)
    }
    
 
    function submitRequest(string memory _url ) private returns(bytes32 requestId) {
        // request to get current rainfall;
        Chainlink.Request memory req = buildChainlinkRequest( jobId, address(this), this.fulfill.selector);

        req.add("get", _url); //sends the GET request to the oracle
        req.add("path", WORLD_WEATHER_ONLINE_PATH);
        req.addInt("times", 100);

        return sendChainlinkRequestTo( oracle, req, fee);


    }

    function fulfill(bytes32 _requestId, uint256 rainmm) public recordChainlinkFulfillment(_requestId){

        rainTemp = rainmm;

    }


    function CreateRequest(string memory _cropLocation , string memory _date) public returns(uint){
        string memory url = string(abi.encodePacked(WORLD_WEATHER_ONLINE_URL, "key=",WORLD_WEATHER_ONLINE_KEY,"&q=",_cropLocation,"&format=json&date=",_date));
        uint _requestId = uint(submitRequest(url));
        return _requestId;
    }

    function getHumidity() public view returns(uint){
        return rainTemp;
    }

    // function fulfill()

}
