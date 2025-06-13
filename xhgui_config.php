<?php

return [
    'save.handler' => 'mongodb',
    'db.host' => 'mongodb://brt-profiler:G8TKUqe2E2Z5qvTk6rX8pfWlsvpCwe0q@34.1.198.183:27017/',
    'db.db' => 'xhprof',
    'db.options' => [],
    'profiler.enable' => function() {
        return true;
    },
    'profiler.simple_url' => null,
    'profiler.options' => [],
    'date.format' => 'M jS H:i:s',
    'detail.count' => 6,
    'page.limit' => 25,
];
