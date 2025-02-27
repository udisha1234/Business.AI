export function successResponse(res, message, status = 200, data = {}) {
    return res.status(status).json({ success: true, message, data });
}

export function errorResponse(res, message, status = 500, error = null) {
    console.error('Error:', error);
    return res.status(status).json({ success: false, message, error });
}
