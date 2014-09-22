Pod::Spec.new do |s|
  s.name         = 'SyntheticServerTest'
  s.version      = '0.8.0'
  s.summary      = 'An in-process webserver used to create "hard mocks" so that I can test from my code all the way through the network stack'
  s.author = {
    'Carl Brown' => 'carlb@pdagent.com'
  }
  s.homepage     = "http://escortmissions.com/blog/2011/10/30/http-testing-to-the-edge-on-ios-the-school-of-hard-mocks.html"
  s.license = { :type => 'Apache', :text => <<-LICENSE
			  New files and changes Copyright (C) 2011-2014 by Carl Brown of PDAgent, LLC.
			  Original Code Copyright 2008 Google Inc.
			  
			  Licensed under the Apache License, Version 2.0 (the "License"); you may not
			  use this file except in compliance with the License.  You may obtain a copy
			  of the License at
			  
			  http://www.apache.org/licenses/LICENSE-2.0
			  
			  Unless required by applicable law or agreed to in writing, software
			  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
			  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
			  License for the specific language governing permissions and limitations under
			  the License.
  LICENSE
  }
  s.source = {
    :git => 'https://github.com/carlbrown/SyntheticServerTest.git',
    :tag => '0.8.0'
  }
  s.source_files = 'TestSupport/*.{h,m}'
  s.requires_arc = true
end