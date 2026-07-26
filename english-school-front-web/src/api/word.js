import request from '@/utils/request'

// PUT /word/update
export function updateWord(data) {
  return request({
    url: '/word/update',
    method: 'put',
    data: data
  })
}

// DELETE /word/{id}
export function deleteWord(id) {
  return request({
    url: '/word/' + id,
    method: 'delete'
  })
}
