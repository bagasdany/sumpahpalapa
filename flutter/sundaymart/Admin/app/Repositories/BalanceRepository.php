<?php

namespace App\Repositories;

use App\Models\ClientBalance as Model;
use App\Models\AdminBalance;

class BalanceRepository extends CoreRepository implements Interfaces\BalanceRepoInterface
{

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function getUsersBalance($array)
    {
        $balance = $this->findBalanceOwner($array['type'], $array['id']);
        if (!$balance) {
            return ['status' => false, 'message' => 'Balance not found'];
        }
        return ['status' => true];
    }

    // top-up user balance
    public function topUpUserBalance($array)
    {
       $balance = $this->findBalanceOwner($array['type'], $array['id']);
       if (!$balance) {
           return false;
       }
       $result = $balance->update(['balance' => $balance->balance + $array['amount']]);
       return $result ? $balance : false;
    }

    // Find balance owner Client or Admin
    private function findBalanceOwner($type, $id){
        switch ($type){
            case 'admin':
                return AdminBalance::firstWhere(['admin_id' => $id, 'status' => true]);
            case 'client':
                return $this->startCondition()->firstWhere(['client_id' => $id, 'status' => true]);
            default:
                return null;
        }
    }
}
