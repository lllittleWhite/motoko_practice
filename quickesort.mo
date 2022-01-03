import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Bool "mo:base/Bool";


func arrPrint(arr : [var Int]) {
    var b = "";
    for (i in arr.vals()) {
        b := b # Int.toText(i) # ",";
    };
    Debug.print(b);
};

func quicksort(array : [var Int]) {
    func sort (arr : [var Int], low : Nat, high : Nat) {
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

var a : [Int] = [5,2,3,11,-1];
var c : [var Int] = Array.thaw(a);
quicksort(c);
arrPrint(c);
