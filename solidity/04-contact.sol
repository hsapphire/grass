// 用pragma将 Solidity 版本定义为 0.8.17
pragma solidity 0.8.17 ;
// 创建一个名为 MyToken 的合约
contract MyToken{
//address类型的变量，用于存储此Token的发行者。用于一些权限控制
    address private owner;

    //mapping类型的变量，用于存储每个地址对应的余额
    mapping(address=>uint256) private balances;
    //uint256 类型的变量，用于存储 Token 的总发行量。定义为 public，可以被任何人查询。
    uint256  public totalSupply ;
    constructor(){
      owner = msg.sender;
    }

    //用于铸造 Token 的函数
    function mint (address recipient ,uint256 amount) public{
        //写一个require语句，判断函数的调用者是否是代币的发行人（msg.sender在前
        require(msg.sender==owner);
        //将 balances 映射中 recipient 对应的值增加 amount 数量的代币。使用+=语法
        balances[recipient]+=amount;
        //将 totalSupply 值加上 amount ，使用+=的语法
        totalSupply+=amount;

    }
    //定义 balanceOf 函数，它有一个address类型的变量 account 作为入参；且函数可见性为public，修饰符为view，
    //返回值是一个uint256类型的未命名变量
    ////用于查询对应地址的余额
     function balanceOf(address account) public view returns (uint256) { 
        //将 balances 映射中与 account 地址对应的余额作为返回值返回
        return balances[account];
     }

    //
    //定义一个 transfer 函数，它有两个入参，address类型的 recipient 变量和uint256类型的 amount 变量，函数可见性为public
    //用于转账的函数
      function transfer(address recipient,uint256 amount) public{
        //require语句确保入参 amount 小于等于调用者msg.sender在 balances 映射中对应的余额
        require(amount<=balances[msg.sender]);
        //将转账者的 balances 余额映射减去转账金额 amount，使用-=语法
        balances [msg.sender]-=amount;
        //
        balances[recipient]+=amount;
}
    
}