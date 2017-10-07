# Validate XML or XML-parts against a Schema, RelaxNG or an XSL (Schematron)

[![Software License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE.md)
[![Latest Stable Version](https://poser.pugx.org/ottosmops/XmlValidator/v/stable?format=flat-square)](https://packagist.org/packages/ottosmops/XmlValidator)
[![Build Status](https://travis-ci.org/ottosmops/xmlvalidator.svg?branch=master)](https://travis-ci.org/ottosmops/xmlvalidator)
[![SensioLabsInsight](https://insight.sensiolabs.com/projects/6473aa57-9e90-448d-beb8-626e7f152f45/mini.png)](https://insight.sensiolabs.com/projects/6473aa57-9e90-448d-beb8-626e7f152f45)
[![Packagist Downloads](https://img.shields.io/packagist/dt/ottosmops/XmlValidator.svg?style=flat-square)](https://packagist.org/packages/ottosmops/XmlValidator)

This package was developed to validate Mets files for the [DFG-Viewer](http://www.dfg-viewer.de). It is possible to validate only parts of a xml-file. Validation is possible with ```xsd```, ```rng``` and ```xsl``` (Schematron). To validate only parts of an XML file, specify the root element of that part. In the tests folder is a copy of  [dmj/dfgviewer-schema](https://github.com/dmj/dfgviewer-schema).

## Usage

There is the one and only method ```validate``:
```
<?php

require('vendor/autoload.php');

use Ottosmops\XmlValidator\XmlValidator;

class test {
    public static function index() {
        $option = ['file'   => 'tests/data/valide/mets_001.xml',
                    'ns'     => 'mets',
                    'nsuri'  => 'http://www.loc.gov/METS/',
                    'root'   => 'mets',
                    'schema' => 'http://www.loc.gov/standards/mets/mets.xsd'];

        $validator = new XmlValidator($option);
        if (!$validator->validate()) {
            print("validated mets: is not valide".PHP_EOL);
            print($validator->getErrors());
        } else {
            print("validated mets: is valide".PHP_EOL);
        }
    }
}

test::index();
```

You can find more examples in the tests folder.

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
