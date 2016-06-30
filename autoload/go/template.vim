let s:current_file = expand("<sfile>")

function! go#template#create()
  let l:root_dir = fnamemodify(s:current_file, ':h:h:h')

  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  execute cd . fnameescape(expand("%:p:h"))

  if empty(glob("*.go"))
    let l:template_file = get(g:, 'g:go_template_file', "hello_world.go")
    let l:template_path = go#util#Join(l:root_dir, "templates", l:template_file)
    exe '0r ' . l:template_path
    $delete _
  else  
    let l:content = printf("package %s", go#tool#PackageName())
    call append(0, l:content)
    $delete _
  endif

  execute cd . fnameescape(dir)
endfunction
