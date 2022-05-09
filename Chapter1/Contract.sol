
// 모든 solidity 소스코드는 솔리디티 버전을 명시해야 하는데, 
// 이후에 새로운 컴파일러 버전이 나와도 기존 코드가 깨지지 않도록 예방한다.
pragma solidity ^0.4.19; 

// 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속한다.
contract ZombiFactory{

    // 상태변수는 컨트랙트 저장소에 영구적으로 저장된다. 즉, 이더리움 블록체인에 기록된다.
    // DB에 데이터를 쓰는 것과 동일하다.

    // 이 변수는 블록체인에 영구적으로 저장된다.
    uint dnaDigits = 16;

    // solidity는 덧셈, 뺄셈, 곱셈, 나눗셈, 모듈러 연산 모두 지원한다.
    uint dnaModulus = 10 ** dnaDigits; // 지수연산도 지원한다.

    // solidity에서는 struct도 제공한다.
    struct Zombie{
        string name;
        uint dna;
    }
    // Zombie 구조체는 name(string형)과 dna(uint형)이라는 2가지 특성을 가진다.

    // solidity에서 배열은 정적 배열과 동적 배열이 있다.

    // 2개의 원소를 담을 수 있는 고정 길이의 배열
    uint2[2] fixedArray; 

    // 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다.
    uint[] dynamicArray;

    // 이와 같이 구조체의 배열도 생성할 수 있다. 
    Person[] people; 
    // 구조체의 동적 배열을 생성하면 마치 DB처럼 contract에 구조화된 데이터를 저장하는 데 유용하다.


    // 아래와 같이 public으로 배열을 선언할 수도 있는데,
    // 솔리디티는 이런 배열을 위해 getter 메소드를 자동으로 생성한다. 
    Person[] public people; 
    // 다른 컨트랙트들이 이 배열을 읽을 수는 있지만 쓸 수는 없게 된다.
    // 다른 컨트랙트에 공개 데이터를 저장할 때 유용한 패턴이다.
      
    // Zombie 구조체의 zombies라는 이름을 가진 public array
    Zombie[] public zombies; 

    // Solidity 에서의 함수 선언
    function eatHamburgers(string _name, uint _amount){

    }
    // 함수의 인자명을 언더스코어로 시작해서 전역 변수와 구별하는 것이 관례이다.
      
    eatHamburgers("vitalik", 100);
    // 위와 같이 함수를 호출할 수 있다.

    function createZombie(string _name, uint _dna){
        zombies.push(Zombie(_name, _dna));
    }

    // 새로운 좀비 생성
    Zombie satoshi = Zombie("Satoshi",172);
    
    // 이 좀비를 배열에 추가한다.
    people.push(satoshi);

    // 위의 두 코드를 조합해 깔끔하게 한 줄로 표현할 수도 있다.
    people.push(Zombie("Vitalik",16));

    // solidity에서 함수는 기본적으로 public으로 선언된다.
    // 이는 컨트랙트 공격에 취약할 수 있어, 기본적으로 함수를 private으로 선언한 후,
    // 공개할 함수만 public으로 선언하는 것이 좋다.

    // private 함수 선언
    uint[] numbers;

    // private 함수 명도 언더스코어로 시작하는 것이 관례이다.
    function _addToArray(uint _number) private {
        numbers.push(_number);
    }


    function _createZombie(string _name, uint _dna) private{
        zombies.push(Zombie(_name, _dna));
    }

    // 반환값
    // 함수에서 어떤 값을 반환 받으려면 다음과 같이 선언해야 한다.
    string greeting = "What's up dog";
    function sayHello() public returns (string) {
        return greeting;
    }
    // 위의 함수 sayHello()는 solidity에서 상태를 변화시키지 않는다.
    // 즉 어떤 값을 변경하거나 무엇인가를 쓰지 않는다.
    // 이 경우, 함수를 view로 선언한다. 이는 함수가 데이터를 보기만 하고 변경하지 않는다는 뜻이다.
    function sayHello() public view returns (string) {}

    // solidity는 pure함수도 가지고 있다.
    // 이는 함수가 앱에서 어떤 데이터도 접근하지 않는 것을 의미한다.
    function _multiply(uint _a, uint _b) private pure returns (uint) {
        return a*b;
    }
    // 이 함수는 앱에서 읽는 것도 하지 않지만, return 값이 함수에 전달된 인자에 따라서 달라진다.

    function _generateRandomDna(string _str) private view returns (uint){
        
    } 

    // 형 변환 
    uint8 a = 5;
    uint b = 6;

    uint8 c = a*b; // a*b가 uint8이 아닌 uint를 반환하기 때문에 에러
    uint8 c = a * uint8(b); // b를 uint8으로 형 변환해서 코드가 제대로 동작하도록 함

    // Ethereum은 SHA3의 한 버전인 keccak256을 내장 해시 함수로 가지고 있다.
    // 해시 함수는 기본적으로 입력 스트링을 랜덤 256비트 16진수로 매핑한다.
    function _generateRandomDna(string _str) private view returns (uint) {
        // _str을 이용한 keccak256 해시값을 받아서 의사 난수 16진수를 생성하고
        // 이를 uint로 형 변환한 다음, rand라는 uint에 결과값 저장
        uint rand = uint(keccak256(_str)); 
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    // 이벤트 
    // 이벤트는 컨트랙트가 블록체인 상의 앱 사용자 단에서 액션이 발생했을 때 의사소통하는 방법이다.
    // 컨트랙트는 특정 이벤트가 일어나는지 귀를 기울이고 그 이벤트가 발생하면 행동을 취한다.

    // 이벤트 선언
    event IntegersAdded(uint x, uint y, uint result);

    function add(uint _x, uint _y) public {
        uint result = _x+_y;
        
        // 이벤트를 실행하여 앱에게 add 함수가 실행되었음을 알린다.
        IntegersAdded(_x, _y, result);
        return result;
    }

    // 그러면 앱의 사용자 단에서는 해당 이벤트가 일어나는지 귀를 기울이게 된다.
    // 아래는 자바스크립트로 구현한 방식
    YourContract.IntegersAdded(function(error, result)){
        // 결과와 관련된 행동
    }


    event NewZombie(uint zombieId, string name, uint dna);

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna))-1;
        NewZombie(id,_name,_dna);
    }


    // https://share.cryptozombies.io/ko/lesson/1/share/DUKE?id=Y3p8MTkyNDA2
}