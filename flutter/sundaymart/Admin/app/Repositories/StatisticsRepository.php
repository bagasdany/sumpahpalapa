<?php

namespace App\Repositories;

use App\Models\Orders;
use App\Models\OrdersComment;
use App\Models\Products;
use App\Traits\ApiResponse;
use App\Models\Admin as Model;
use Symfony\Component\Process\Process;

class StatisticsRepository extends CoreRepository implements Interfaces\StatisticsRepoInterface
{
    use ApiResponse;

    protected function getModelClass()
    {
        return Model::class;
    }

    public function serverInfo()
    {
        return \Cache::remember('server-info', 84600, function (){
            // get MySql version from DataBase
            $mysql = \DB::selectOne( \DB::raw('SHOW VARIABLES LIKE "%innodb_version%"'));

            // get NodeJs version via terminal command
            $node = Process::fromShellCommandline("node -v");
            $node->run();

            // get NPM version via terminal command
            $npm = Process::fromShellCommandline("npm -v");
            $npm->run();

            // get composer version via terminal command
            $composer = Process::fromShellCommandline("composer -V");
            $composer->run();

            return $this->successResponse("success", [
                'PHP Version' => phpversion(),
                'Laravel Version' => app()->version(),
                'OS Version' => php_uname(),
                'MySql Version' => $mysql->Value,
                'NodeJs Version' => $node->getOutput() == "" ? \Str::of($node->getErrorOutput())->before("\n") : $node->getOutput(),
                'NPM Version' => $npm->getOutput() == "" ? \Str::of($npm->getErrorOutput())->before("\n") : $npm->getOutput(),
                'Composer Version' => $composer->getOutput()  == "" ? $composer->getErrorOutput() : $composer->getOutput(),
            ]);
        });
    }

    public function orderStatistics($array = []){

        $shop = $array['shop_id'] ?? null;

        // Get order Comment to calculate rating by star
        $comments = OrdersComment::select('id', 'star')->whereHas('order', function ($q) use ($shop) {
            $q->when($shop, function ($q) use ($shop) {
                $q->where('id_shop', $shop);
            });
        })->where('star', '>', 0)->get();

        // Get delivered orders
        $orders = Orders::select('order_status', 'id', 'id_shop')->when(isset($array['shop_id']), function ($q, $v) use ($array){
                $q->where('id_shop', $array['shop_id'] );
            })->get();

        // GET missed Products
        $products = Products::where('quantity', '<', 1)
            ->when(isset($array['shop_id']), function ($q, $v) use ($array){
                $q->where('id_shop', $array['shop_id'] );
            });

        $orders = [
            'processing' => $orders->where('order_status', 1)->count(),
            'ready' => $orders->where('order_status', 2)->count(),
            'on_a_way' => $orders->where('order_status', 3)->count(),
            'delivered' => $orders->where('order_status', 4)->count(),
            'canceled' => $orders->where('order_status', 5)->count(),
            'total_sum' => round($orders->sum('total_sum'), 2),
            'missed_products' => $products->count(),
            'reviews_avg' => round($comments->avg('star'),2),
            'reviews_count' => $comments->count()
        ];

        return $this->successResponse('Success', $orders);
    }

    public function commissionStatistics($array){

        return true;
    }
}
