import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(VueRouter)

jest.mock('@/api/users', () => ({
  getStatus: jest.fn().mockResolvedValue({ data: { data: 1 } }),
  setStatus: jest.fn().mockResolvedValue({ data: { code: 1 } }),
}))
jest.mock('@/api/inform', () => ({
  getCountUnread: jest.fn().mockResolvedValue({ data: { code: 1, data: 0 } }),
}))
jest.mock('@/styles/_variables.scss', () => ({}), { virtual: true })
jest.mock('@/utils/cookies', () => ({
  setNewData: jest.fn(),
  getNewData: jest.fn(),
  getToken: jest.fn().mockReturnValue('mock-token'),
  setToken: jest.fn(),
  removeToken: jest.fn(),
  getSidebarStatus: jest.fn(),
  setSidebarStatus: jest.fn(),
  getStoreId: jest.fn(),
  setStoreId: jest.fn(),
  removeStoreId: jest.fn(),
  getUserInfo: jest.fn(),
  setUserInfo: jest.fn(),
  removeUserInfo: jest.fn(),
  getPrint: jest.fn(),
  setPrint: jest.fn(),
  removePrint: jest.fn(),
}))
jest.mock('js-cookie', () => ({ get: jest.fn().mockReturnValue(JSON.stringify({ name: 'Admin' })) }))

// Mock WebSocket to avoid URL errors in jsdom
const mockWs = { onopen: null, onmessage: null, onerror: null, onclose: null, close: jest.fn() }
;(global as any).WebSocket = jest.fn().mockImplementation(() => mockWs)

import Navbar from '@/layout/components/Navbar/index.vue'

describe('Navbar', () => {
  let store: any
  const router = new VueRouter()

  beforeEach(() => {
    store = new Vuex.Store({
      state: { app: { sidebar: { opened: true }, statusNumber: 0 } },
      getters: {},
      actions: { LogOut: jest.fn() },
      modules: {
        app: {
          namespaced: false,
          state: { sidebar: { opened: true }, statusNumber: 0 },
          mutations: { TOGGLE_SIDEBAR: jest.fn() },
          actions: { ToggleSideBar: jest.fn(), StatusNumber: jest.fn() },
        },
        user: {
          namespaced: false,
          state: { userInfo: { name: 'Admin' }, storeId: '' },
          getters: { userInfo: (s: any) => s.userInfo, storeId: (s: any) => s.storeId },
        },
      },
    })
  })

  it('renders without error', () => {
    const wrapper = shallowMount(Navbar, {
      localVue, store, router,
      stubs: { Password: true, 'el-badge': true, 'el-dialog': true, 'el-radio-group': true, 'el-button': true },
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('contains no Chinese characters', () => {
    const wrapper = shallowMount(Navbar, {
      localVue, store, router,
      stubs: { Password: true, 'el-badge': true, 'el-dialog': true, 'el-radio-group': true, 'el-button': true },
    })
    expect(wrapper.text()).not.toMatch(/[一-鿿]/)
  })
})
