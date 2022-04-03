<?php

namespace App\Http\Requests\Rest;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class BalanceTopUpRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id' => ['required', 'integer'],
            'type' => ['required', 'string', 'in:order,admin,client'],
            'payment_id' => ['required', 'integer'],
            'shop_id' => ['required', 'integer'],
        ];
    }

    public function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = response()->json([
            'success' => 0,
            'msg' => $errors->messages(),
        ], 422);

        throw new HttpResponseException($response);
    }
}
