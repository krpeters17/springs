function [ nodes , springs ] = springs_solve( nodes , springs , varargin )

% default/specified solver parameters
options = springs_default_options() ;
if numel(varargin) > 0
	for ff = fieldnames(varargin{1})'
		options.(ff{1}) = varargin{1}.(ff{1}) ;
	end
end

exe_springs_solver = fullfile('.','springs_solver','springs_solver.exe') ;
if ~exist( exe_springs_solver ,'file')
	fprintf( 'ERROR: Compiled executable not found.  Attempting to compile.\n' )
	springs_setup()
end

dir_input  = 'springs_input' ;
dir_output = 'springs_output' ;

if ~exist( dir_input ,'dir')
	mkdir( dir_input )
end
if ~exist( dir_output ,'dir')
	mkdir( dir_output )
end

springs_write( dir_input , nodes , springs , options ) ;
sys_command = sprintf( '%s %s %s --verbose 1' , exe_springs_solver , dir_input , dir_output ) ;
system(sys_command) ;
[ nodes , springs ] = springs_read( dir_output ) ;

end