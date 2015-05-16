## ACNotificationObserver


A simply extension of NSNotificationCenter Observer.

- No need to remove observer in `dealoc`. It's boring and we always forget to do that. 
- By making the obsever a property, makes the code more readable and traceable.
- No more `... addObserver: ...` `@selector(...)` or `NSNotification` object, let's use `anObject` and `aUserInfo` directly.
    

## Usage

The observer should be a property. But don't forget to avoid retain cycle.

```objc
__weak __typeof(self)weakSelf = self;
[self.yourObserver
 listenNotificationName:YOUR_NOTIFICATION_NAME
 withActionBlock:^(id anObject, NSDictionary *aUserInfo) {

    __strong __typeof(weakSelf)strongSelf = weakSelf;

    [strongSelf yourActionWith:anObjectOrAUserInfo];

 }];
```


#### License

* WTFPL 
