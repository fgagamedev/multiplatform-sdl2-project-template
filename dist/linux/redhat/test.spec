Name: %%PACKAGE_NAME%%
Version: %%VERSION_MAJOR%%.%%VERSION_MINOR%%
Release: %%VERSION_RELEASE%%%{?dist}
Summary: %%GAME_DESCRIPTION%%

Group: Amusements/Games
License: GPL
URL: package_github_page
Source0: %{name}.tar.gz

BuildRoot: %{_tmppath}/%{name}-root

%description
Long package description

%prep
%setup -q


%build
./scripts/build.sh release


%install
mkdir %{buildroot}/var/games/%{name}/lib
cp src/${name}_release %{buildroot}/var/games/%{name}/%{name}

for extlib in `ls lib`;
do
    cp -P lib/$extlib/linux/release/* %{buildroot}/var/games/%{name}/lib;
done

mkdir %{buildroot}/var/games/%{name}/resources
cp -r resources/*  %{buildroot}/var/games/%{name}/resources/

mkdir %{buildroot}/usr/games/
cp -P dist/linux/redhat/%{name} %{buildroot}/usr/games/

%files
%attr(755,root,root) %{buildroot]}/usr/games/%{name}
%attr(755,root,root) %{buildroot]}/var/games/%{name}
%defattr(644,root,root)
%{buildroot]}/var/games/%{name}/


%changelog
