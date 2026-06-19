/**
 * API Client for CONSTRUCTIQ Backend
 */

import axios, { AxiosInstance, AxiosRequestConfig } from 'axios'

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000/api'
const AI_ENGINE_URL = process.env.NEXT_PUBLIC_AI_ENGINE_URL || 'http://localhost:8001'

class ApiClient {
  private client: AxiosInstance
  private aiClient: AxiosInstance

  constructor() {
    this.client = axios.create({
      baseURL: API_URL,
      headers: {
        'Content-Type': 'application/json',
      },
    })

    this.aiClient = axios.create({
      baseURL: AI_ENGINE_URL,
      headers: {
        'Content-Type': 'application/json',
      },
    })

    // Add request interceptor for auth token
    this.client.interceptors.request.use((config) => {
      const token = localStorage.getItem('auth_token')
      if (token) {
        config.headers.Authorization = `Bearer ${token}`
      }
      return config
    })
  }

  // Auth
  async login(email: string, password: string) {
    const response = await this.client.post('/auth/login', { email, password })
    if (response.data.token) {
      localStorage.setItem('auth_token', response.data.token)
    }
    return response.data
  }

  async register(data: any) {
    return this.client.post('/auth/register', data)
  }

  async logout() {
    localStorage.removeItem('auth_token')
    return this.client.post('/auth/logout')
  }

  // Projects
  async getProjects() {
    const response = await this.client.get('/projects')
    return response.data
  }

  async getProject(id: string) {
    const response = await this.client.get(`/projects/${id}`)
    return response.data
  }

  async createProject(data: any) {
    const response = await this.client.post('/projects', data)
    return response.data
  }

  async updateProject(id: string, data: any) {
    const response = await this.client.put(`/projects/${id}`, data)
    return response.data
  }

  async deleteProject(id: string) {
    return this.client.delete(`/projects/${id}`)
  }

  // Materials
  async getMaterials() {
    const response = await this.client.get('/materials')
    return response.data
  }

  async getMaterial(id: string) {
    const response = await this.client.get(`/materials/${id}`)
    return response.data
  }

  // Calculator
  async calculateConcrete(data: any) {
    const response = await this.client.post('/calculator/concrete', data)
    return response.data
  }

  async calculateBrickwork(data: any) {
    const response = await this.client.post('/calculator/brickwork', data)
    return response.data
  }

  async calculatePlastering(data: any) {
    const response = await this.client.post('/calculator/plastering', data)
    return response.data
  }

  async calculatePainting(data: any) {
    const response = await this.client.post('/calculator/painting', data)
    return response.data
  }

  async calculateExcavation(data: any) {
    const response = await this.client.post('/calculator/excavation', data)
    return response.data
  }

  async calculateRoad(data: any) {
    const response = await this.client.post('/calculator/road', data)
    return response.data
  }

  async calculateRoofing(data: any) {
    const response = await this.client.post('/calculator/roofing', data)
    return response.data
  }

  // Site Analysis
  async analyzeSite(data: any) {
    const response = await this.client.post('/site-analysis', data)
    return response.data
  }

  async getSiteAnalysis(projectId: string) {
    const response = await this.client.get(`/site-analysis/${projectId}`)
    return response.data
  }

  // Machines
  async getMachines() {
    const response = await this.client.get('/machines')
    return response.data
  }

  async getMachine(id: string) {
    const response = await this.client.get(`/machines/${id}`)
    return response.data
  }

  // Reports
  async getReports(projectId?: string) {
    const url = projectId ? `/reports?project_id=${projectId}` : '/reports'
    const response = await this.client.get(url)
    return response.data
  }

  async generateReport(data: any) {
    const response = await this.client.post('/reports', data)
    return response.data
  }

  // AI Services
  async chatWithAI(message: string, userId: string, projectId?: string) {
    const response = await this.aiClient.post('/chat', {
      message,
      user_id: userId,
      project_id: projectId,
    })
    return response.data
  }

  async analyzeSoil(imageUrl: string) {
    const response = await this.aiClient.post('/analyze/soil', { image_url: imageUrl })
    return response.data
  }

  async getMaterialRecommendations(data: any) {
    const response = await this.aiClient.post('/recommendations/materials', data)
    return response.data
  }

  async estimateCost(data: any) {
    const response = await this.aiClient.post('/estimate/cost', data)
    return response.data
  }

  async analyzeRisk(data: any) {
    const response = await this.aiClient.post('/analyze/risk', data)
    return response.data
  }
}

export const api = new ApiClient()
export default api

