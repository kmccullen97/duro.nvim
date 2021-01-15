function! OnDuroExit(job_id, code, event)
	silent! :q
	silent! :q
endfunction

function! OpenDuro()
  let height = float2nr((&lines - 2) / 1.1)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns / 1.1)
  let col = float2nr((&columns - width) / 2)

  " Border Window
  let border_opts = {
    \ 'relative': 'editor',
    \ 'row': row - 1,
    \ 'col': col - 1,
    \ 'width': width + 2,
    \ 'height': height + 2,
    \ 'style': 'minimal'
    \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let border = ['╭' . repeat('─', width) . '╮']
  let i = 0
  while i < height
	  call add(border, '│' . repeat(' ', width) . '│')
	  let i += 1
  endwhile
  call add(border, '╰' . repeat('─', width) . '╯')
  call nvim_buf_set_lines(border_buf, 0, -1, v:true, border)
  let s:border_win = nvim_open_win(border_buf, v:true, border_opts)
  set winhl=Normal:Floating

  " Main Window
  let opts = {
    \ 'relative': 'editor',
    \ 'row': row,
    \ 'col': col,
    \ 'width': width,
    \ 'height': height,
    \ 'style': 'minimal'
    \ }
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)
  set winhl=Normal:Floating
  call termopen('duro', { 'on_exit': 'OnDuroExit' })
  startinsert
endfunction

command! Duro :call OpenDuro()
