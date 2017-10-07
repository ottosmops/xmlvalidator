<?php

namespace Ottosmops\XmlValidator;

use Ottosmops\XmlValidator\Exceptions\FileNotFoundException;
use Ottosmops\XmlValidator\Exceptions\UrlNotFoundException;
use Ottosmops\XmlValidator\Exceptions\SchemaExtensionNotAllowed;

class XmlValidator {

    public $file; // file to be validated

    public $ns;  // namespace

    public $nsuri;  // uri for the namespace (do we need this?)

    public $root; // root-element, so we can validate parts of an xml tree

    public $schema; // path to schema (xsd, rng, schematron->xsl)

    protected $xml;

    protected $nodes;

    public $messages = [];

    public function __construct($options) {
        if (!is_file($options['file'])) {
            throw new FileNotFoundException('file not found '. $options['file']);
        }
        $this->file   = $options['file'];
        $this->debug('start validating: ' . realpath($this->file));

        $this->ns     = $options['ns'];
        $this->debug('ns: ' . $this->ns);

        $this->nsuri  = $options['nsuri'];
        $this->debug('nsuri: ' . $this->nsuri);
        
        $this->root   = $options['root'];
        $this->debug('root: ' . $this->root);
        
        if (is_file($options['schema']) || self::urlExists($options['schema'])) {
             $this->schema = $options['schema'];
             $this->debug('schema: ' . $this->schema);
        } else {
            throw new FileNotFoundException('schema not found: ' . $this->schema);
        }

        $this->type   = pathinfo($this->schema, PATHINFO_EXTENSION); 
        $this->debug('type: ' . $this->type);

        if(!in_array($this->type, ['xsd', 'rng', 'xsl'])) {
            throw new SchemaExtensionNotAllowed('file-extension not allowed');
        }

        $this->loadXmlFile();
        $this->nodes = $this->loadXPath();
    }

    public function validate()
    {
        $function = 'validate' . ucfirst($this->type);
        return $this->$function();
    }
    
    public function validateXsd()
    {
        libxml_use_internal_errors(true);
        if ($this->nodes->length > 0) {
            foreach ($this->nodes as $node) {
                $part = new \DOMDocument('1.0', 'utf-8');
                $part->appendChild($part->importNode($node, true));
            }
            if (!$part->schemaValidate($this->schema)) {
                foreach(libxml_get_errors() as $error) {
                    $this->error(trim($error->message) .' (line '.$error->line. ')');
                }
                return false;
            }
        } 
        return true;
    }

    public function validateRng() 
    {
        libxml_use_internal_errors(true);
        
        $this->debug('$this->nodes->length' .': '.$this->nodes->length);

        if ($this->nodes->length > 0) {
            foreach ($this->nodes as $node) {
                $part = new \DOMDocument('1.0', 'utf-8');
                $part->appendChild($part->importNode($node, true));
            }
            if (!$part->relaxNGValidate($this->schema)) {
                foreach(libxml_get_errors() as $error) {
                    $this->error(trim($error->message) .' (line '.$error->line. ')');
                }
                $this->debug('is not valide');
                return false;
            }
        } 

        $this->debug('is valide');
        return true;
    }

    public function validateXsl() 
    {
        libxml_use_internal_errors(true);

        $domXsl = new \DOMDocument();
        $domXsl->load($this->schema); 

        $xslt = new \XSLTProcessor();
        $xslt->importStylesheet($domXsl);

        if ($this->nodes->length > 0) {
            foreach ($this->nodes as $node) {
                $part = new \DOMDocument('1.0', 'utf-8');
                $part->appendChild($part->importNode($node, true));
            }
        } 
        
        $xslValid = $xslt->transformToXml($part);

        if(strpos($xslValid, 'failed') > 0) {
            $xml = new \DOMDocument('1.0', 'utf-8');
            $xml->loadXML($xslValid);
            $node_list = $xml->getElementsByTagName('failed-assert');
            
            foreach($node_list as $node) {
                $this->error(trim($node->textContent));
            }
            $this->debug('is not valide');
            return false;
        }
        
        $this->debug('is valide');
        return true;
    }


    private function loadXPath()
    {
        $xpath = new \DOMXPath($this->xml);
        $xpath->registerNamespace($this->ns, $this->nsuri);
        $this->debug('xpath: ' . '//'. $this->ns.':'.$this->root);
        $this->nodes = $xpath->query('//'. $this->ns.':'.$this->root);

        if($this->nodes->length === 0) {
            $this->messages[] = 'warning: did not find a node';
        }

        return $this->nodes;
    }

    private function loadXmlFile()
    {
        // Load document into DOM.
        libxml_use_internal_errors(true);
        $this->xml = new \DOMDocument('1.0', 'utf-8');
        $this->xml->load($this->file);
    }

    public static function urlExists($url)
    {
        if(self::isUrl($url)) {
            $headers = get_headers($url);
        } else {
            return false;
        }

        if (!stripos($headers[0],"200 OK")) {
            throw new UrlNotFoundException('url: could not find schema');
        }
        return true;
    }

    public static function isUrl($url)
    {
        if (filter_var($url, FILTER_VALIDATE_URL) === FALSE) {
            return false;
        }
        return true;
    }

    private function debug($msg)
    {
        $this->messages[] = 'debug: ' . $msg;
    }

    private function error($msg)
    {
        $this->messages[] = 'error: ' . $msg;
    }

    public function getMessages()
    {
        return $this->messages;
    }

    public function getErrors()
    {
        return array_filter($this->messages, function($string) {
            return substr($string, 0, 5) === 'error';
        });
    } 
}
