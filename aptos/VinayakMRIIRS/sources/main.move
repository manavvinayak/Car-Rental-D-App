module MyModule::P2PCarRental{

    use aptos_framework::signer;
    use std::vector;

    struct Car has store, key{
        owner: address,
        model: vector<u8>,
        rental_price: u64,
        is_available: bool,

    }


    // function to list a car

    public fun list_car(owner: &signer, model: vector<u8>, rental_price: u64){
        let car = Car{
            owner: signer::address_of(owner),
            model,
            rental_price,
            is_available:true,
        };
        move_to(owner,car);
    }


    public fun rent_car(renter: &signer, owner_address:address) acquires Car{
        let car = borrow_global_mut<Car>(owner_address);

        //Ensure the car is available for rent
        assert!(car.is_available, 1);

        // mark the car as rented
        car.is_available =false;
        }
}
