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
            echo "validated mets: is not valide".PHP_EOL;
            print_r($validator->getErrors());
        } else {
            print("validated mets: is valide".PHP_EOL);
        }
    }
}

test::index();