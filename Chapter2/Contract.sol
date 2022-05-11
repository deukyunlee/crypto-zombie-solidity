pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

// 이더리움 블록체인은 은행 계좌와 같은 계정들로 이루어져 있다.
// 계정은 이더리움 블록체인상의 통화인 이더의 잔액을 가진다.
// 주소는 특정 유저 혹은 스마트 컨트랙트가 소유한다.
// 구조체와 배열처럼 매핑은 솔리디티에서 구조화된 데이터를 저장하는 또다른 방법이다.

// 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장(key: address, value: uint)
mapping (address=> uint) public accountBalance;
// userID로 유저 이름을 저장/검색하는 데도 매핑 사용 가능(key: uint, value: string)
mapping(uint => string) userIdToName;

// 매핑은 key-value 저장소로, 데이터를 저장하고 검색하는 데 사용된다.

mapping(uint=>address) public zombieToOwner;
mapping(address=>uint) ownerZombieCount;


    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
