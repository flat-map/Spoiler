# Spoiler
Spoiler is the best c language formatter for when you want to screw everything up.

## Usage
The following command will output the result of processing hoge.c to the console.
```bash
$ spoiler hoge.c
```

By executing the following command, you can write the result of hoge.c processing to fuga.c.
```bash
$ spoiler hoge.c > fuga.c
```

Of course, this is also possible:
```bash
$ spoiler hoge.c > hoge.c
```

## Requirement
* g++ 9.3.0
* flex 2.6.4
* bison 3.5.1
* make 4.2.1
