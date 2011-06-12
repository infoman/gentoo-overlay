#!/usr/bin/ruby

require 'rubygems'

# rdoc --ri --op ./ri --quiet --title "actionmailer-3.0.8 Documentation" lib
# rdoc --op ./rdoc --quiet --title "actionmailer-3.0.8 Documentation" lib


def create_ebuild(details)
  uri = URI.parse details.last
  spec = Gem::SpecFetcher.fetcher.fetch_spec(details.first, uri)

  category = 'dev-ruby'

  filename = File.absolute_path(File.dirname(__FILE__) + '/../' + category + '/' + spec.name + '/' + spec.name + '-' + spec.version.version + '-r100.ebuild')

  if File.exist?(filename)
    puts 'skipping existing ' + filename
    return
  end
  
  puts 'creating ' + filename
  
  if ! File::exist?(category)
    Dir::mkdir(category)
  end
  
  if ! File::exist?(category + '/' + spec.name)
    Dir::mkdir(category + '/' + spec.name)
  end

  puts spec.extensions
  
  runtime_deps = Array.new
  other_deps = Array.new

  spec.dependencies.each do |dep|
    if dep.type == :runtime
      runtime_deps.push(dep)    
    else
      other_deps.push(dep)
    end
  end


  ebuild = File.new(filename, "w")  
  ebuild.puts '# Copyright 1999-2011 Gentoo Foundation'
  ebuild.puts '# Distributed under the terms of the GNU General Public License v2'
  ebuild.puts '# $Header: $'
  ebuild.puts ''
  ebuild.puts 'EAPI=3'
  ebuild.puts ''
  ebuild.puts 'USE_RUBY="ruby18 ruby19 ree18"'
  ebuild.puts 'RUBY_FAKEGEM_TASK_DOC=""'
  ebuild.puts 'RUBY_FAKEGEM_TASK_TEST=""'
  ebuild.puts ''
  ebuild.puts 'inherit ruby-fakegem'
  ebuild.puts ''
  ebuild.puts 'DESCRIPTION="' + spec.summary + '"'
  ebuild.puts 'HOMEPAGE="' + spec.homepage + '"'
  ebuild.puts ''
  ebuild.puts 'LICENSE=""'
  ebuild.puts 'SLOT="0"'
  ebuild.puts 'KEYWORDS="~amd64"'
  ebuild.puts 'IUSE=""'
  ebuild.puts ''
  ebuild.puts 'DEPEND=""'
  ebuild.puts 'RDEPEND="${DEPEND}"'
  ebuild.puts ''
  
  if ! runtime_deps.empty?
    ebuild.puts 'ruby_add_rdepend "'
    runtime_deps.each do |dep|
      name = category + '/' + dep.name
      op = dep.requirement.requirements.first.first
      version = dep.requirement.requirements.first.last
      case op
      when '~>' then
        ebuild.puts '>=' + name + '-' + version.version
        ebuild.puts '<' + name + '-' + version.bump.version
      when '=' then
      	ebuild.puts '~' + name + '-' + version.version
      else
        ebuild.puts op + name + '-' + version.version
      end
    end
    ebuild.puts '"'
    ebuild.puts ''    
  end

if spec.name == 'ruby-debug-ide'
ebuild.puts <<EOF_EBUILD
all_ruby_prepare() {
	sed -i -e "s#\\(Debugger::PROG_SCRIPT = \\)\\(ARGV.shift\\)#\\1File.expand_path(\\2)#" bin/rdebug-ide
}

EOF_EBUILD
end

ebuild.puts <<EOF_EBUILD
each_ruby_configure() {
	RUBY_FAKEGEM_EXTENSIONS=$(${RUBY} -r yaml -e "puts Gem::Specification.from_yaml(File::open('../metadata')).extensions")
	for e in ${RUBY_FAKEGEM_EXTENSIONS}; do
		local d=$(dirname ${e})
		if [ -e ${d}/extconf.rb ]; then
			${RUBY} -C${d} extconf.rb || die
		else
			ewarn "This gem has a extension that will not be built and so may not work."
		fi
	done
}

each_ruby_compile() {
	for e in ${RUBY_FAKEGEM_EXTENSIONS}; do
		local d=$(dirname ${e})
		if [ -e ${d}/extconf.rb ]; then
			emake -C$d || die
		fi
	done
}

each_ruby_install() {
	each_fakegem_install
	for e in ${RUBY_FAKEGEM_EXTENSIONS}; do
		local d=$(dirname ${e})
		if [ -e ${d}/extconf.rb ]; then
			sitearchdir=${D}/$(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/lib emake -e -C$d install-so
		fi
	done
}

ruby_fakegem_binwrapper() {
	(
		local gembinary=$1
		local newbinary=${2:-/usr/bin/$gembinary}
		local relativegembinary=${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/bin/${gembinary}
		local binpath=$(dirname $newbinary)
		[[ ${binpath} = . ]] && binpath=/usr/bin

		local rubycmd=
		for implementation in ${USE_RUBY}; do
			use ruby_targets_${implementation} || continue
			if [ -z $rubycmd ]; then
				rubycmd="$(ruby_implementation_command ${implementation})"
			else
				rubycmd="/usr/bin/env ruby"
				break
			fi
		done

		cat - > "${T}"/gembin-wrapper-${gembinary} <<EOF
#!${rubycmd}
require 'rubygems'

version = ">= 0"

if ARGV.first =~ /^_(.*)_\\$/ and Gem::Version.correct? \\$1 then
  version = \\$1
  ARGV.shift
end

gem '${RUBY_FAKEGEM_NAME}', version
load Gem.bin_path('${RUBY_FAKEGEM_NAME}', '${gembinary}', version)

EOF

		exeinto ${binpath:-/usr/bin}
		newexe "${T}"/gembin-wrapper-${gembinary} $(basename $newbinary)
	) || die "Unable to create fakegem wrapper"
}

EOF_EBUILD

  ebuild.close
  
  system 'ebuild', filename, 'manifest'
  
  runtime_deps.each do |dep|  
    puts 'looking for ' + dep.name + ' ' + dep.requirement.requirements.first.first + ' '+ dep.requirement.requirements.first.last.version
    create_ebuild(Gem::SpecFetcher.fetcher.find_matching(dep, true).last)
  end
end

create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('rdoc'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('rake', '0.8.7'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('rails'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('sqlite3'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('ruby-debug-ide'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('ruby-debug-base19'), true).last)
create_ebuild(Gem::SpecFetcher.fetcher.find_matching(Gem::Dependency.new('ruby-debug-base19x'), true).last)

puts 'done'

