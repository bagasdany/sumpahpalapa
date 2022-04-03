<?php

namespace App\Http\Middleware;

use App\Models\ClientShop;
use Closure;
use Hash;
use Illuminate\Http\Request;
use Storage;

class TrustLicensee
{
    protected $except = [
        'api/auth/shop/licensee',
        'api/auth/shop/activate',
        'api/auth/shops/deactivated*',
        'api/auth/shops/activated*',
        'licence',
    ];

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\JsonResponse
     */
    public function handle(Request $request, Closure $next)
    {

        if (!isset($_SERVER['SERVER_ADDR'])) {
            return $next($request);
        } else {
            $result = $this->except();
            foreach ($this->except as $excluded_route) {
                if ($request->is($excluded_route) || $result) {
                    return $next($request);
                }
            }
            return response()->json(['status' => false, 'license' => false, 'message' => 'Need activation key']);
        }
    }

    private function except(){
        if (Storage::disk('local')->has('licensee')) {
            $file = Storage::disk('local')->get('licensee');
            $key = \Str::of($file)->before(':');
            $server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';

            $result = ClientShop::where('active', 1)->first();
            if ($result && $result->hash && $result->ip_address == $server_ip) {
                $res = Hash::check($key, $result->hash);
                if ($res) {
                    return true;
                }
            }
        }
        return false;
    }
}
