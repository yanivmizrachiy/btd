# 🤖 סקריפט אוטומטי להגדרת repository btd

Write-Host "🚀 מתחיל הגדרה אוטומטית של repository btd..." -ForegroundColor Cyan

# 1. בדוק אם יש קובץ index.html
if (Test-Path "index.html") {
    Write-Host "✅ קובץ index.html קיים" -ForegroundColor Green
} else {
    Write-Host "❌ קובץ index.html לא נמצא!" -ForegroundColor Red
    exit 1
}

# 2. בדוק חיבור ל-GitHub
Write-Host "🔍 בודק חיבור ל-GitHub..." -ForegroundColor Yellow
$repoExists = gh repo view yanivmizrachiy/btd 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Repository btd לא קיים ב-GitHub!" -ForegroundColor Red
    Write-Host "💡 צריך ליצור אותו ידנית ב-GitHub" -ForegroundColor Yellow
    exit 1
}

# 3. בדוק אם יש remote
Write-Host "🔍 בודק remote..." -ForegroundColor Yellow
$remote = git remote get-url origin 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "➕ מוסיף remote..." -ForegroundColor Yellow
    git remote add origin https://github.com/yanivmizrachiy/btd.git
}

# 4. הוסף קבצים
Write-Host "📝 מוסיף קבצים..." -ForegroundColor Yellow
git add .
git commit -m "Add redirect and README" 2>&1 | Out-Null

# 5. Push
Write-Host "⬆️ דוחף ל-GitHub..." -ForegroundColor Yellow
git push -u origin main 2>&1

# 6. הפעל GitHub Pages
Write-Host "🌐 מפעיל GitHub Pages..." -ForegroundColor Yellow
gh api repos/yanivmizrachiy/btd/pages --method PUT -f source[branch]=main -f source[path]=/ 2>&1 | Out-Null

Write-Host "✅ סיום! הקישור יהיה זמין תוך 1-2 דקות:" -ForegroundColor Green
Write-Host "🔗 https://yanivmizrachiy.github.io/btd/" -ForegroundColor Cyan

