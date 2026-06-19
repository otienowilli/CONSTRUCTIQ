'use client'

import { useState, useEffect } from 'react'
import { Building2, Calculator, FileText, Cpu, TrendingUp, Users } from 'lucide-react'

export default function Dashboard() {
  const [stats, setStats] = useState({
    projects: 0,
    active_projects: 0,
    calculations: 0,
    reports: 0,
  })

  useEffect(() => {
    // Fetch dashboard stats
    // This would call the API in production
    setStats({
      projects: 12,
      active_projects: 5,
      calculations: 48,
      reports: 23,
    })
  }, [])

  const statCards = [
    {
      title: 'Total Projects',
      value: stats.projects,
      icon: Building2,
      color: 'bg-blue-500',
    },
    {
      title: 'Active Projects',
      value: stats.active_projects,
      icon: TrendingUp,
      color: 'bg-green-500',
    },
    {
      title: 'Calculations',
      value: stats.calculations,
      icon: Calculator,
      color: 'bg-purple-500',
    },
    {
      title: 'Reports',
      value: stats.reports,
      icon: FileText,
      color: 'bg-orange-500',
    },
  ]

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <Cpu className="h-8 w-8 text-blue-600" />
              <h1 className="text-3xl font-bold text-gray-900">CONSTRUCTIQ</h1>
            </div>
            <div className="flex items-center space-x-4">
              <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                New Project
              </button>
              <div className="flex items-center space-x-2">
                <Users className="h-5 w-5 text-gray-600" />
                <span className="text-sm text-gray-700">Admin User</span>
              </div>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {statCards.map((stat, index) => (
            <div key={index} className="bg-white rounded-lg shadow p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600 mb-1">{stat.title}</p>
                  <p className="text-3xl font-bold text-gray-900">{stat.value}</p>
                </div>
                <div className={`${stat.color} p-3 rounded-lg`}>
                  <stat.icon className="h-6 w-6 text-white" />
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Quick Actions */}
        <div className="bg-white rounded-lg shadow p-6 mb-8">
          <h2 className="text-xl font-bold text-gray-900 mb-4">Quick Actions</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button className="p-4 border-2 border-gray-200 rounded-lg hover:border-blue-500 hover:bg-blue-50 transition">
              <Calculator className="h-8 w-8 text-blue-600 mb-2" />
              <h3 className="font-semibold text-gray-900">Material Calculator</h3>
              <p className="text-sm text-gray-600">Calculate material requirements</p>
            </button>
            <button className="p-4 border-2 border-gray-200 rounded-lg hover:border-green-500 hover:bg-green-50 transition">
              <Building2 className="h-8 w-8 text-green-600 mb-2" />
              <h3 className="font-semibold text-gray-900">Site Analysis</h3>
              <p className="text-sm text-gray-600">Analyze construction site</p>
            </button>
            <button className="p-4 border-2 border-gray-200 rounded-lg hover:border-purple-500 hover:bg-purple-50 transition">
              <FileText className="h-8 w-8 text-purple-600 mb-2" />
              <h3 className="font-semibold text-gray-900">Generate Report</h3>
              <p className="text-sm text-gray-600">Create project report</p>
            </button>
          </div>
        </div>

        {/* Recent Activity */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-4">Recent Activity</h2>
          <div className="space-y-4">
            <div className="flex items-center space-x-4 p-3 bg-gray-50 rounded-lg">
              <div className="bg-blue-100 p-2 rounded">
                <Calculator className="h-5 w-5 text-blue-600" />
              </div>
              <div className="flex-1">
                <p className="text-sm font-medium text-gray-900">Concrete calculation completed</p>
                <p className="text-xs text-gray-600">Project: Building A - 2 hours ago</p>
              </div>
            </div>
            <div className="flex items-center space-x-4 p-3 bg-gray-50 rounded-lg">
              <div className="bg-green-100 p-2 rounded">
                <Building2 className="h-5 w-5 text-green-600" />
              </div>
              <div className="flex-1">
                <p className="text-sm font-medium text-gray-900">New project created</p>
                <p className="text-xs text-gray-600">Road Construction Phase 2 - 5 hours ago</p>
              </div>
            </div>
            <div className="flex items-center space-x-4 p-3 bg-gray-50 rounded-lg">
              <div className="bg-purple-100 p-2 rounded">
                <FileText className="h-5 w-5 text-purple-600" />
              </div>
              <div className="flex-1">
                <p className="text-sm font-medium text-gray-900">Weekly report generated</p>
                <p className="text-xs text-gray-600">Project: Bridge Construction - 1 day ago</p>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}

