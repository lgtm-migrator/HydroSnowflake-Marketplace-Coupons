pragma solidity ^0.5.0;

import '../ein/token/ERC721/SnowflakeERC721.sol';
import '../ein/token/ERC721/SnowflakeERC721Burnable.sol';
import '../ein/token/ERC721/SnowflakeERC721Mintable.sol';
import '../interfaces/marketplace/ItemInterface.sol';

/*

ERC 721 ---> Coupon Interface ---> Coupon contract (w/ data + function implementations)
        ---> Item Interface ---> Item contract (w/data + function implementations)


//Use addresses to represent other ownership states; unlimited/claimable once

*/


contract Item is SnowflakeERC721, SnowflakeERC721Burnable, SnowflakeERC721Mintable, ItemInterface {


    //Mapping connecting ERC721 items to actual struct objects
    mapping(uint => Item) public itemListings;

    constructor(_snowflakeAddress) SnowflakeERC721(_snowflakeAddress) SnowflakeERC721Burnable(_snowflakeAddress) SnowflakeERC721Mintable(_snowflakeAddress) public {
        //stuff here
    }


   struct Item {
        uint uuid;
        uint quantity;
        ItemType itemType;
        ItemStatus status;
        ItemCondition condition;
        string title;
        string description;
        uint256 price;
        uint[] delivery; //Simply holds the ID for the delivery method, done for saving space
        uint[] tags;
        uint returnPolicy;

    }

    function getItem(uint id) public view returns (
        uint uuid,
        uint quantity,
        ItemType itemType,
        ItemStatus status,
        ItemCondition condition,
        string memory title,
        string memory description,
        uint256 price,
        uint returnPolicy
    ){

        Item memory item = itemListings[id];
        return (item.uuid, item.quantity, item.itemType, item.status, item.condition, item.title, item.description, item.price, item.returnPolicy);
    }

    function getItemDelivery(uint id, uint index) public view returns (uint) { 
        return itemListings[id].delivery[index]; 
    }

    function getItemTag(uint id, uint index) public view returns (uint) {
        return itemListings[id].tags[index];
    }



}



