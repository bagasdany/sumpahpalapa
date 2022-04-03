<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Clients extends Model
{
    protected $table = "clients";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function balance(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(ClientBalance::class, 'client_id');
    }
}
