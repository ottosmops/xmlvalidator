<?php

namespace Ottosmops\XmlValidator\Test;

use Ottosmops\XmlValidator\XmlValidator;

use PHPUnit\Framework\TestCase;

class XmlValidatorTest extends TestCase {

    /*
        mets_001.xml => valid
        mets_002.xml => invalid mods
        mets_003.xml => invalid mets
        mets_004.xml => invalid dv:rights
        mets_005.xml => valid mets but invalid dfg-mets (strukturdaten)
     */

    /**
     * @test
     */
    public function it_validates_xml_with_xsd()
    {
        $options = [['file'   => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'https://www.loc.gov/standards/mets/mets.xsd',],
                    ['file'   => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'mods',
                     'nsuri'  => 'https://www.loc.gov/mods/v3',
                     'root'   => 'mods',
                     'schema' => 'https://www.loc.gov/standards/mods/v3/mods-3-4.xsd',],
                    ['file'   => 'tests/data/invalid/mets_005.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'https://www.loc.gov/standards/mets/mets.xsd',],
                    ];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertTrue($validator->validate());
        }
    }

    /**
     * @test
     */
    public function it_validates_xml_with_rng()
    {
        $options = [['file'   => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'dv',
                     'nsuri'  => 'http://www.dfg-viewer.de/',
                     'root'   => 'rights',
                     'schema' => 'https://raw.githubusercontent.com/dmj/dfgviewer-schema/master/relaxng/dvrights.rng',],
                     ['file'   => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'dv',
                     'nsuri'  => 'http://www.dfg-viewer.de/',
                     'root'   => 'links',
                     'schema' => 'https://raw.githubusercontent.com/dmj/dfgviewer-schema/master/relaxng/dvlinks.rng'],
                     ];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertTrue($validator->validate());
        }
    }


    /**
     * @test
     */
    public function it_validates_xml_with_xsl()
    {
        $options = [['file'   => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'tests/data/schema/schematron/mets.xsl',],
                    ];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertTrue($validator->validate());
        }
    }

    /**
     * @test
     */
    public function it_recognized_invalid_xml_with_xsd()
    {
        $options = [['file'   => 'tests/data/invalid/mets_003.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'https://www.loc.gov/standards/mets/mets.xsd'
                    ],
                    ['file'   => 'tests/data/invalid/mets_002.xml',
                     'ns'     => 'mods',
                     'nsuri'  => 'https://www.loc.gov/mods/v3',
                     'root'   => 'mods',
                     'schema' => 'https://www.loc.gov/standards/mods/v3/mods-3-4.xsd',]
                    ];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertFalse($validator->validate());
        }
    }

    /**
     * @test
     */
    public function it_recognized_invalid_xml_with_rng()
    {
        $options = [['file'   => 'tests/data/invalid/mets_004.xml',
                     'ns'     => 'dv',
                     'nsuri'  => 'http://www.dfg-viewer.de/',
                     'root'   => 'rights',
                     'schema' => 'tests/data/schema/relaxng/dvrights.rng'
                    ]];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertFalse($validator->validate());
        }
    }

    /**
     * @test
     */
    public function it_recognized_invalid_xml_with_xsl()
    {
        $options = [['file'   => 'tests/data/invalid/mets_005.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'tests/data/schema/schematron/mets.xsl'
                    ]];
        foreach ($options as $option) {
            $validator = new XmlValidator($option);
            $this->assertFalse($validator->validate());
        }
    }

    /**
     * @test
     */
    public function it_throws_file_not_found_exception_for_missing_file()
    {
        $option = ['file'   => 'mets_005.xml',
                   'ns'     => 'mets',
                   'nsuri'  => 'https://www.loc.gov/METS/',
                   'root'   => 'mets',
                   'schema' => 'tests/data/schema/schematron/mets.xsl'
                   ];
        $this->expectException(\Ottosmops\XmlValidator\Exceptions\FileNotFoundException::class);
        $validator = new XmlValidator($option);
    }

    /**
     * @test
     */
    public function it_throws_file_not_found_exception_for_missing_schema()
    {
        $option = ['file'   => 'tests/data/invalid/mets_005.xml',
                   'ns'     => 'mets',
                   'nsuri'  => 'https://www.loc.gov/METS/',
                   'root'   => 'mets',
                   'schema' => 'schema/schematron/mets.xsl'
                   ];
        $this->expectException(\Ottosmops\XmlValidator\Exceptions\FileNotFoundException::class);
        $validator = new XmlValidator($option);
    }

    /**
     * @test
     */
    public function it_throws_schema_extension_not_allowed_if_so()
    {
        $option = ['file'     => 'tests/data/valid/mets_001.xml',
                     'ns'     => 'mets',
                     'nsuri'  => 'https://www.loc.gov/METS/',
                     'root'   => 'mets',
                     'schema' => 'tests/data/valid/mets_001.xml']; // file must exist
        $this->expectException(\Ottosmops\XmlValidator\Exceptions\SchemaExtensionNotAllowed::class);
        $validator = new XmlValidator($option);
    }

}
