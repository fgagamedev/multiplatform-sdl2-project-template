Name: package_name
Version: 1
Release: 1%{?dist}
Summary: Short description       

Group: Amusements/Games
License: GPL
URL: package_github_page
Source0: package_name.tar.gz

%description
Long package description

%prep
%setup -q


%build
./build.sh release


%install
rm -rf $RPM_BUILD_ROOT
./run.sh release


%files
%doc


%changelog
