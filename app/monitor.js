#!/usr/bin/env node
/**
 * OpenCode Usage Monitor - Portable Version
 * Reads opencode.db SQLite database and shows usage stats
 * Uses sql.js (pure JavaScript, no native compilation)
 */

const path = require('path');
const os = require('os');
const fs = require('fs');

// Load sql.js
let initSqlJs;
try {
    initSqlJs = require('sql.js');
} catch (e) {
    console.log('Error: sql.js not found. Install with: npm install sql.js');
    process.exit(1);
}

// Find opencode.db
function findDatabase() {
    const locations = [
        path.join(os.homedir(), '.local', 'share', 'opencode', 'opencode.db'),
        path.join(process.env.LOCALAPPDATA || '', 'opencode', 'opencode.db'),
        path.join(process.env.APPDATA || '', 'opencode', 'opencode.db'),
    ];
    
    for (const loc of locations) {
        if (fs.existsSync(loc)) {
            return loc;
        }
    }
    return null;
}

// Format numbers
function formatNumber(n) {
    if (n >= 1000000) return (n / 1000000).toFixed(2) + 'M';
    if (n >= 1000) return (n / 1000).toFixed(1) + 'K';
    return String(n);
}

// Estimate cost (rough estimates per 1K tokens)
function estimateCost(inputTokens, outputTokens) {
    // Claude Sonnet pricing as baseline
    const inputPrice = 0.003;  // $ per 1K tokens
    const outputPrice = 0.015; // $ per 1K tokens
    return (inputTokens * inputPrice + outputTokens * outputPrice) / 1000;
}

// Run query and get results
function runQuery(db, sql) {
    try {
        const result = db.exec(sql);
        if (result.length > 0 && result[0].values.length > 0) {
            return result[0].values[0];
        }
        return null;
    } catch (e) {
        return null;
    }
}

// Run query and get all rows
function runQueryAll(db, sql) {
    try {
        const result = db.exec(sql);
        if (result.length > 0) {
            return result[0].values;
        }
        return [];
    } catch (e) {
        return [];
    }
}

// Main functions
async function showSummary() {
    const dbPath = findDatabase();
    if (!dbPath) {
        console.log('Error: Could not find opencode.db');
        console.log('\nExpected locations:');
        console.log('  - ~/.local/share/opencode/opencode.db (Linux/Mac)');
        console.log('  - %LOCALAPPDATA%/opencode/opencode.db (Windows)');
        return;
    }
    
    console.log('+==========================================+');
    console.log('|       OpenCode Usage Summary             |');
    console.log('+==========================================+\n');
    
    const dbSize = fs.statSync(dbPath).size / 1024 / 1024;
    console.log('Database:', dbPath);
    console.log('Size:', dbSize.toFixed(2), 'MB\n');
    
    try {
        const SQL = await initSqlJs();
        const fileBuffer = fs.readFileSync(dbPath);
        const db = new SQL.Database(fileBuffer);
        
        // Get session count
        const sessionResult = runQuery(db, 'SELECT COUNT(*) FROM session');
        const sessionCount = sessionResult ? sessionResult[0] : 0;
        console.log('Sessions:', sessionCount);
        
        // Get message count
        const messageResult = runQuery(db, 'SELECT COUNT(*) FROM message');
        const messageCount = messageResult ? messageResult[0] : 0;
        console.log('Messages:', messageCount);
        
        // Try to get token usage from message data
        const tokenResult = runQuery(db, `
            SELECT 
                SUM(json_extract(data, '$.usage.input_tokens')),
                SUM(json_extract(data, '$.usage.output_tokens'))
            FROM message 
            WHERE data IS NOT NULL
        `);
        
        if (tokenResult && (tokenResult[0] || tokenResult[1])) {
            const inputTokens = tokenResult[0] || 0;
            const outputTokens = tokenResult[1] || 0;
            const totalTokens = inputTokens + outputTokens;
            const cost = estimateCost(inputTokens, outputTokens);
            
            console.log('\n+-- Token Usage ----------------------------+');
            console.log('| Input Tokens:  ' + formatNumber(inputTokens).padStart(12) + '             |');
            console.log('| Output Tokens: ' + formatNumber(outputTokens).padStart(12) + '             |');
            console.log('| Total Tokens:  ' + formatNumber(totalTokens).padStart(12) + '             |');
            console.log('+-------------------------------------------+');
            console.log('| Est. Cost:     $' + cost.toFixed(2).padStart(10) + ' (Sonnet)    |');
            console.log('+-------------------------------------------+');
        }
        
        // Recent sessions
        const recentRows = runQueryAll(db, `
            SELECT id, created_at, agent
            FROM session 
            ORDER BY rowid DESC 
            LIMIT 5
        `);
        
        if (recentRows.length > 0) {
            console.log('\n+-- Recent Sessions ------------------------+');
            recentRows.forEach((row, i) => {
                const id = String(row[0] || '?').substring(0, 16);
                const agent = String(row[2] || 'default').substring(0, 12);
                const date = row[1] ? new Date(row[1]).toLocaleDateString() : '?';
                console.log('| ' + (i + 1) + '. ' + id.padEnd(16) + ' ' + agent.padEnd(12) + ' ' + date);
            });
            console.log('+-------------------------------------------+');
        }
        
        db.close();
    } catch (e) {
        console.log('\nError reading database:', e.message);
    }
}

async function showSessions() {
    const dbPath = findDatabase();
    if (!dbPath) {
        console.log('Error: Could not find opencode.db');
        return;
    }
    
    console.log('+==========================================+');
    console.log('|         OpenCode Sessions                |');
    console.log('+==========================================+\n');
    
    try {
        const SQL = await initSqlJs();
        const fileBuffer = fs.readFileSync(dbPath);
        const db = new SQL.Database(fileBuffer);
        
        const rows = runQueryAll(db, `
            SELECT 
                s.id, 
                s.created_at,
                s.agent,
                (SELECT COUNT(*) FROM message m WHERE m.session_id = s.id) as msg_count
            FROM session s
            ORDER BY s.rowid DESC
            LIMIT 20
        `);
        
        if (rows.length > 0) {
            console.log('ID                   | Agent        | Msgs | Date');
            console.log('-'.repeat(60));
            rows.forEach(row => {
                const id = String(row[0] || '?').substring(0, 20);
                const agent = String(row[2] || 'default').substring(0, 12).padEnd(12);
                const msgs = String(row[3] || 0).padStart(4);
                const date = row[1] ? new Date(row[1]).toLocaleDateString() : '?';
                console.log(id + ' | ' + agent + ' | ' + msgs + ' | ' + date);
            });
        } else {
            console.log('No sessions found.');
        }
        
        db.close();
    } catch (e) {
        console.log('Error:', e.message);
    }
}

async function showLive() {
    const dbPath = findDatabase();
    if (!dbPath) {
        console.log('Error: Could not find opencode.db');
        return;
    }
    
    console.log('+==========================================+');
    console.log('|         Live Monitoring                  |');
    console.log('+==========================================+\n');
    console.log('Watching for new messages... (Press Ctrl+C to stop)\n');
    
    let lastCount = 0;
    let lastSize = 0;
    
    // Get initial state
    try {
        const SQL = await initSqlJs();
        const fileBuffer = fs.readFileSync(dbPath);
        const db = new SQL.Database(fileBuffer);
        const result = runQuery(db, 'SELECT COUNT(*) FROM message');
        lastCount = result ? result[0] : 0;
        lastSize = fs.statSync(dbPath).size;
        db.close();
        
        console.log('Starting with', lastCount, 'messages\n');
        console.log('Time                 | Change | Total');
        console.log('-'.repeat(45));
    } catch (e) {
        console.log('Error:', e.message);
        return;
    }
    
    // Poll every 2 seconds
    const interval = setInterval(async () => {
        try {
            const currentSize = fs.statSync(dbPath).size;
            if (currentSize !== lastSize) {
                const SQL = await initSqlJs();
                const fileBuffer = fs.readFileSync(dbPath);
                const db = new SQL.Database(fileBuffer);
                const result = runQuery(db, 'SELECT COUNT(*) FROM message');
                const count = result ? result[0] : 0;
                
                if (count !== lastCount) {
                    const diff = count - lastCount;
                    const time = new Date().toLocaleTimeString();
                    console.log(time + ' | ' + (diff > 0 ? '+' : '') + diff + ' | ' + count);
                    lastCount = count;
                }
                
                lastSize = currentSize;
                db.close();
            }
        } catch (e) {
            // Ignore polling errors
        }
    }, 2000);
    
    // Handle Ctrl+C
    process.on('SIGINT', () => {
        clearInterval(interval);
        console.log('\n\nMonitoring stopped.');
        process.exit(0);
    });
}

// CLI handling
const args = process.argv.slice(2);
const command = args[0] || 'summary';

(async () => {
    switch (command) {
        case 'summary':
        case 's':
            await showSummary();
            break;
        case 'sessions':
        case 'list':
        case 'l':
            await showSessions();
            break;
        case 'live':
        case 'watch':
        case 'w':
            await showLive();
            break;
        case 'help':
        case '--help':
        case '-h':
            console.log('OpenCode Usage Monitor - Portable Version\n');
            console.log('Usage: node monitor.js <command>\n');
            console.log('Commands:');
            console.log('  summary, s   Show usage summary (default)');
            console.log('  sessions, l  List recent sessions');
            console.log('  live, w      Watch for new messages in real-time');
            console.log('  help         Show this help');
            break;
        default:
            console.log('Unknown command:', command);
            console.log('Run "node monitor.js help" for usage.');
    }
})();
