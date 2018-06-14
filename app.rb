require 'sinatra'
require 'i18n'
require 'pony'
require 'better_errors' if development?

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

configure do
  I18n.enforce_available_locales = false
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  set :port => 3007

end

before '/:locale/*' do
  I18n.locale = params[:locale]
end

before '/' do
  I18n.locale = :es
end

before '/:locale' do
  I18n.locale = params[:locale]
end

# Filtros idioma
before '/:locale/*' do
  I18n.locale = (params[:locale].eql?('es') || params[:locale].eql?('en')) ? params[:locale] : :es
end

configure do
  set :show_exceptions, false
# set :show_exceptions, :after_handler
end

#GLOBALES
get '/' do
  @titulo = "Inicio"
  @current = 'inicio'
  erb (I18n.locale.to_s + '/vistas/index').to_sym, :layout => ("/layouts/layout").to_sym
end

get '/en' do
  @tituloEn = "Inicio"
  @current = 'inicio'
  erb (I18n.locale.to_s + '/vistas/index').to_sym, :layout => ("/layouts/layout").to_sym
end

get '/es' do
  erb (I18n.locale.to_s + '/vistas/index').to_sym, :layout => ("/layouts/layout").to_sym
end


#Cultura bim
get '/:locale/cultura_bim/empresa' do
  @titulo = 'Empresa'
  @tituloEn = 'Empresa'
  @current = 'cultura'
  erb :"#{I18n.locale}/vistas/cultura_bim/empresa", :layout => ('layouts/layout_interior').to_sym
  end

get '/:locale/cultura_bim/principios_estrategicos' do
  @titulo = 'Principios'
  @tituloEn = 'Principios'
  @current = 'cultura'
  erb :"#{I18n.locale}/vistas/cultura_bim/principios_estrategicos", :layout => ('layouts/layout_interior').to_sym
  end


#Productos
get '/:locale/productos/modelacion_bim' do
  @titulo = 'Modelacion'
  @tituloEn = 'Modelacion'
  @current = 'productos'
  erb :"#{I18n.locale}/vistas/productos/modelacion_bim", :layout => ('layouts/layout_interior').to_sym
  end

get '/:locale/productos/bim_management' do
  @titulo = 'Bim'
  @tituloEn = 'Bim'
  @current = 'productos'
  erb :"#{I18n.locale}/vistas/productos/bim_management", :layout => ('layouts/layout_interior').to_sym
  end

get '/:locale/productos/implementa_bim' do
  @titulo = 'Implementa'
  @tituloEn = 'Implementa'
  @current = 'productos'
  erb :"#{I18n.locale}/vistas/productos/implementa_bim", :layout => ('layouts/layout_interior').to_sym
  end

get '/:locale/productos/pendiente' do
  @titulo = 'Pendiente'
  @tituloEn = 'Pendiente'
  @current = 'productos'
  erb :"#{I18n.locale}/vistas/productos/pendiente", :layout => ('layouts/layout_interior').to_sym
  end

#Proyectos
get '/:locale/proyectos/proyectos' do
  @titulo = 'Proyectos'
  @tituloEn = 'Proyectos'
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyectos", :layout => ('layouts/layout_interior').to_sym
  end

get '/:locale/proyectos/proyecto1' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto1", :layout => ('layouts/layout_interior').to_sym
  end
get '/:locale/proyectos/proyecto2' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto2", :layout => ('layouts/layout_interior').to_sym
  end
get '/:locale/proyectos/proyecto3' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto3", :layout => ('layouts/layout_interior').to_sym
  end
get '/:locale/proyectos/proyecto4' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto4", :layout => ('layouts/layout_interior').to_sym
  end
get '/:locale/proyectos/proyecto5' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto5", :layout => ('layouts/layout_interior').to_sym
  end
get '/:locale/proyectos/proyecto6' do
  @current = 'proyectos'
  erb :"#{I18n.locale}/vistas/proyectos/proyecto6", :layout => ('layouts/layout_interior').to_sym
  end

#Contacto
get '/:locale/contacto/colabora' do
  @titulo = 'Colabora'
  @tituloEn = 'Colabora'
  @current = 'contacto'
  erb :"#{I18n.locale}/vistas/contacto/colabora", :layout => ('layouts/layout_interior').to_sym
end

get '/:locale/contacto/contacto' do
  @titulo = 'Contacto'
  @tituloEn = 'Contacto'
  @current = 'contacto'
  erb :"#{I18n.locale}/vistas/contacto/contacto", :layout => ('layouts/layout_interior').to_sym
end

not_found do
  status 404
  @titulo = "Página no encontrada"
  @tituloEn = "Page not found"
  erb :"#{I18n.locale}/vistas/Independientes/pagina404"
end

helpers do
  def change_language
    if request.path_info=="/"
      return "/en"

    elsif I18n.locale == :es
      return request.path_info.sub('es', 'en')

    elsif I18n.locale == :en
      return request.path_info.sub('en', 'es')

    end
  end

end
