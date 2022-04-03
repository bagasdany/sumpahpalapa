<?php

namespace App\Http\Controllers;

use App\Traits\ApiResponse;
use Exception;
use Illuminate\Http\Request;

class UploadController extends Controller
{
    use ApiResponse;

    public function upload(Request $request)
    {
        $file = $request->file('file');
        $destinationPath = public_path().'/uploads';
        $file_name = time()."_".$file->getClientOriginalName();
        if ($file->move($destinationPath, $file_name)) {
            return response()->json([
                'success' => 1,
                'name' => $file_name,
                'msg' => "Image uploaded"
            ]);
        }

        return $this->errorResponse("Error in image uploading");
    }

    /**
     * @throws Exception
     */
    public function projectUpdate(Request $request){
        $file = $request->file('file');
        $destinationPath = base_path();
        $file_name = 'sundaymart.zip';

        try {
            $file->move($destinationPath, $file_name);
        } catch (Exception $exception){
           return $this->errorResponse($exception->getMessage());
        }
        return response()->json([
            'success' => 1,
            'name' => $file_name,
            'msg' => "File uploaded"
        ]);
    }
}
