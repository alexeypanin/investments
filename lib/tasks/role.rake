namespace :role do
  desc 'Create default roles'
  task :create => :environment do
    %w(
      site_admin
      site_admin_pages
      ).each do |name|
        Role.find_or_create_by!(name: name)
        puts name
    end

    Role.find_each do |role|
      case role.name
      when 'site_admin'
        role.title = "Супер админ"
        role.description = "Имеет доступ ко всему"
        role.save!
      when 'site_admin_pages'
        role.title = "Управление редактируемыми страницами"
        role.save!
      end
    end
  end
end
