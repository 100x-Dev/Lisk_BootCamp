// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UserProfile {
    struct User {
        string fullName;
        uint8 age;
        string email;
        uint256 registrationTime;
        bool isRegistered;
    }

    mapping(address => User) private userProfiles;

    function register(
        string calldata _fullName,
        uint8 _age,
        string calldata _email
    ) external {
        require(
            !userProfiles[msg.sender].isRegistered,
            "You are already registered"
        );
        require(_age > 0, "Age must be greater than zero");

        userProfiles[msg.sender] = User({
            fullName: _fullName,
            age: _age,
            email: _email,
            registrationTime: block.timestamp,
            isRegistered: true
        });
    }

    function updateProfile(
        string calldata _fullName,
        uint8 _age,
        string calldata _email
    ) external {
        require(
            userProfiles[msg.sender].isRegistered,
            "You are not registered"
        );
        require(_age > 0, "Age must be greater than zero");

        User storage currentUser = userProfiles[msg.sender];
        currentUser.fullName = _fullName;
        currentUser.age = _age;
        currentUser.email = _email;
    }

    function getProfile()
        external
        view
        returns (
            string memory fullName,
            uint8 age,
            string memory email,
            uint256 registrationTime
        )
    {
        require(
            userProfiles[msg.sender].isRegistered,
            "You are not registered"
        );
        User storage currentUser = userProfiles[msg.sender];
        return (
            currentUser.fullName,
            currentUser.age,
            currentUser.email,
            currentUser.registrationTime
        );
    }

    function isRegistered(address account) external view returns (bool) {
        return userProfiles[account].isRegistered;
    }
}
