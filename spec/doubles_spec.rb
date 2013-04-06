require 'rspec'
require 'doubles'

describe Doubles do

  let(:doubles) { Doubles.new('/my_special_dir/', 'file_name_1.rb file_name_2.rb') }
  context 'initializer' do
    before do
      doubles
    end
    it { doubles.current_path.should == '/my_special_dir/' }
    it { doubles.args.should == 'file_name_1.rb file_name_2.rb' }
  end


  context 'convert_rb' do
    [
        [# no change
            'link_to \'hello "sad" world\', test_path',
            'link_to \'hello "sad" world\', test_path'
        ], [# change
            'link_to "hello sad world", test_path, class: "what"',
            'link_to \'hello sad world\', test_path, class: \'what\''
        ], [# should not change doubles inside singles
            'link_to \'hello "sad" world\', test_path, class: "what"',
            'link_to \'hello "sad" world\', test_path, class: \'what\''
        ], [# should not change doubles as they have interpolation
            'link_to "hello #{var_1} world", test_path',
            'link_to "hello #{var_1} world", test_path'
        ], [# should not change doubles with interpolation but change second doubles
            'link_to "hello #{var_1}, world", test_path, class: "what"',
            'link_to "hello #{var_1}, world", test_path, class: \'what\''
        ], [# should ignore doubles inside of interpolation
            'link_to "hello #{var_1+" "+var_2} world", test_path',
            'link_to "hello #{var_1+" "+var_2} world", test_path'
        ], [# not change remarked out line
            '# link_to "hello world", test_path',
            '# link_to "hello world", test_path'
        ], [# not change after remark
            'link_to "hello world", test_path # "what"',
            'link_to \'hello world\', test_path # "what"'
        ], [# ignore # (without { }) inside double quotes
            'link_to "hello # world", test_path',
            'link_to \'hello # world\', test_path'
        ], [# ignore # (without { }) inside single quotes
            'link_to \'hello # world\', test_path',
            'link_to \'hello # world\', test_path'
        ]
    ].each do |line, result|
      it line do
        doubles.convert_rb(line).should == result
      end
    end


  end


end
