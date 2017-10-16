pragma solidity ^0.4.15;

import "contracts/Owned.sol";

contract Members is Owned {
  address public coin;
  MemberStatus[] public statuses;
  mapping(address => History) public tradingHistories;

  struct MemberStatus {
    string name;
    uint256 times;
    uint256 sum;
    int8 rate;
  }

  struct History {
    uint256 times;
    uint256 sum;
    uint256 statusIndex;
  }

  modifier onlyCoin() { if (msg.sender == coin) _; }

  function setCoin(address _address) onlyOwner public {
    coin = _address;
  }

  function pushStatus(string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner public {
    statuses.push(
      MemberStatus({
        name: _name,
        times: _times,
        sum: _sum,
        rate: _rate
      })
    );
  }

  function editStatus(uint256 _index, string _name, uint256 _times, uint256 _sum, int8 _rate) onlyOwner public {
    if (_index <  statuses.length) {
      statuses[_index].name = _name;
      statuses[_index].times = _times;
      statuses[_index].sum = _sum;
      statuses[_index].rate = _rate;
    }
  }

  function updateHistory(address _member, uint256 _value) onlyCoin public {
    tradingHistories[_member].times += 1;
    tradingHistories[_member].sum += _value;

    uint256 index;
    int8 rate;

    for (uint i = 0; i < statuses.length; i++) {
      History storage history = tradingHistories[_member];
      MemberStatus storage status = statuses[i];

      if (history.times > status.times && history.sum > status.sum && rate < status.rate) {
        index = i;
        rate = status.rate;
      }
    }

    tradingHistories[_member].statusIndex = index;
  }

  function getCashbackRate(address _member) public constant returns (int8 rate) {
    rate = statuses[tradingHistories[_member].statusIndex].rate;
  }
}
