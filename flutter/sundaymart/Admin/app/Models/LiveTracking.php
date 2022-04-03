<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LiveTracking extends Model
{
    use HasFactory;

    protected $table = 'live_tracking';

    protected $fillable = ['admin_id', 'coordinates'];

    public function deliveryBoy(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Admin::class);
    }

}
