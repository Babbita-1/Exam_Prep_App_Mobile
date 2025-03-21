import express from 'express';
import * as practiceController from '../controllers/practiceTestController.js';
import { adminOnly, protect } from '../middleware/authMiddleware.js';

const router = express.Router();

// Get a single test by ID (for students/admins)
router.get('/test/:testId', protect, practiceController.getTestById);

// Get test by subject (use subjectId)
router.get('/subject/:subjectId', protect, practiceController.getTestsBySubject);

// Fetch all test (for guests)
router.get('/all', practiceController.getAllTests);

// Get all tests for Admin
router.get('/all', protect, adminOnly, practiceController.getAllTests);

// Fetch tests for a specific grade (for authenticated users)
router.get('/grade/:gradeLevel', protect, practiceController.getTestsByGrade);
router.get('/:subjectId', protect, practiceController.getTestsBySubject);

// Create a new test (Admin Only)
router.post('/create/:subjectId', protect, adminOnly, practiceController.createTest);

// Submit a test attempt (Authenticated Users Only)
router.post('/submit/:testId', protect, practiceController.submitTest);

export default router;
