import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'

const localVue = createLocalVue()
localVue.use(Vuex)

// Mock the API call
jest.mock('@/api/users', () => ({
  getStatus: jest.fn().mockResolvedValue({ data: { data: 1 } }),
}))

// Mock SCSS module import
jest.mock('@/styles/_variables.scss', () => ({}), { virtual: true })

// Import after mocks are set up
import Sidebar from '@/layout/components/Sidebar/index.vue'

describe('Sidebar', () => {
  let store: any

  beforeEach(() => {
    store = new Vuex.Store({
      modules: {
        app: {
          namespaced: false,
          state: { sidebar: { opened: true, withoutAnimation: false }, statusNumber: 0 },
          getters: { sidebar: (s: any) => s.sidebar },
        },
        user: {
          namespaced: false,
          state: { userInfo: { name: 'Admin' }, roles: [], storeId: '' },
          getters: { userInfo: (s: any) => s.userInfo, roles: (s: any) => s.roles },
        },
      },
    })
  })

  it('renders without error', () => {
    const wrapper = shallowMount(Sidebar, {
      localVue,
      store,
      mocks: { $router: { options: { routes: [] } }, $route: { path: '/dashboard' } },
      stubs: { 'el-scrollbar': true, 'el-menu': true, 'sidebar-item': true, 'router-link': true },
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('contains no Chinese characters', () => {
    const wrapper = shallowMount(Sidebar, {
      localVue,
      store,
      mocks: { $router: { options: { routes: [] } }, $route: { path: '/dashboard' } },
      stubs: { 'el-scrollbar': true, 'el-menu': true, 'sidebar-item': true, 'router-link': true },
    })
    expect(wrapper.text()).not.toMatch(/[一-鿿]/)
  })
})
