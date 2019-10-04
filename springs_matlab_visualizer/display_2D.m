function h = display_2D( nodes , springs , varargin )

color_variable = 'strain' ;
color_range = [ 0.0 , 1.0 ] ;
color_map = hot(120) ;
color_map = color_map(100:-1:1,:) ;

color_ind = (springs.(color_variable)-min(color_range))/range(color_range) ;
color_ind = min(1, max(0, color_ind )) ;
color_ind = 1 + round( (size(color_map,1)-1) * color_ind ) ;

if nargin > 2
	h = varargin{1} ;
	set( h.segments , {'XData'} , mat2cell( [ nodes.position( springs.nodes(:,1) ,1) , nodes.position( springs.nodes(:,2) ,1) ] ,ones([numel(h.segments),1]),[2]) )
	set( h.segments , {'YData'} , mat2cell( [ nodes.position( springs.nodes(:,1) ,2) , nodes.position( springs.nodes(:,2) ,2) ] ,ones([numel(h.segments),1]),[2]) )
else
	h.fig = figure( ...
		'Position' , [0,0,1400,700] , ...
		'Color' , [1,1,1] ) ;
	h.ax = axes( ...
		'XLim' , [ -1 80 ] , ...
		'YLim' , [ -1 80 ] , ...
		'DataAspectRatio' , [1,1,1] , ...
		'TickDir' , 'out' , ...
		'NextPlot' , 'add' ) ;
	h.segments = plot( ...
		[ nodes.position( springs.nodes(:,1) ,1) , nodes.position( springs.nodes(:,2) ,1) ]' , ...
		[ nodes.position( springs.nodes(:,1) ,2) , nodes.position( springs.nodes(:,2) ,2) ]' , ...
		'k-' , ...
		'LineWidth' , 3 ) ;
end
set( h.segments , {'Color'} , arrayfun(@(i)color_map(i,:),color_ind,'UniformOutput',false) )
set( h.segments(springs.broken==1) , 'LineStyle' , ':' )
set( h.segments(springs.broken==1) , 'Visible' , 'off' )

% for pp = 1 : size(nodes.position,1)
% 	plot( ...
% 		nodes.position(pp,1) + [0,nodes.force(pp,1)] , ...
% 		nodes.position(pp,2) + [0,nodes.force(pp,2)] , ...
% 		'b-' , ...
% 		'LineWidth' , 1 )
% end

end