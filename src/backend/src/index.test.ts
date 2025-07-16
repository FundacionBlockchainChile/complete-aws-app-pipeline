import request from 'supertest';
import express from 'express';
import { app } from './index';

describe('API Tests', () => {
  it('should return healthy status', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body).toEqual({ status: 'healthy' });
  });
}); 