import request from '@/utils/request'

// list word books
export function listWordBookByPage(data) {
  return request({
    url: '/wordBook/list/page/vo',
    method: 'post',
    headers: { repeatSubmit: false },
    data
  })
}

// add word book
export function addWordBook(data) {
  return request({
    url: '/wordBook/add',
    method: 'post',
    headers: { repeatSubmit: false },
    data
  })
}

// update word book
export function updateWordBook(data) {
  return request({
    url: '/wordBook/update',
    method: 'put',
    headers: { repeatSubmit: false },
    data
  })
}

// delete word book
export function deleteWordBook(id) {
  return request({
    url: '/wordBook/' + id,
    method: 'delete'
  })
}

// import words into word book
export function importWords(bookId, data) {
  return request({
    url: '/wordBook/' + bookId + '/words/import',
    method: 'post',
    headers: { repeatSubmit: false },
    data
  })
}
