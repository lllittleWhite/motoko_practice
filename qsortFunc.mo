import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Array "mo:base/Array";
import Iter "mo:base/Iter";


actor {
    func quicksort(array : [var Int]) {
        func sort (arr : [var Int], low : Nat, high : Nat) {

            Debug.print(Nat.toText(low)# "," #Nat.toText(high));

            if (low>=high) return;
            var key = arr[low];
            var l = low;
            var r = high;

            while (l < r) {
                while (arr[r] >= key and r > l) {
                    r -= 1; 
                };
                arr[l] := arr[r];
                while (arr[l] <= key and l < r) {
                    l += 1;
                };
                arr[r] := arr[l];
            };
            arr[l] := key;
            if (r>=1) sort(arr,low,r-1);
            sort(arr,l+1,high);
        };
        sort(array,0,array.size()-1);
    };

    public func qsort (arr : [Int]) : async [Int] {
        let array : [var Int] = Array.thaw(arr);
        quicksort(array);
        Array.freeze(array);
    };
};
