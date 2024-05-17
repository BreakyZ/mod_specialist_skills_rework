foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks/"))
{
	::include(file);
}