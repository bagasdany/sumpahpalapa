<?php

namespace App\Imports;

use App\Models\Languages;
use App\Models\Products;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithBatchInserts;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ProductsImport implements ToCollection, WithHeadingRow, WithBatchInserts
{
    /**
     * @param Collection $collection
     * @return mixed
     */
    public function collection(Collection $collection)
    {
        foreach ($collection as $row)
        {
            $product = Products::create([
                'quantity' => $row['quantity'],
                    'pack_quantity' => $row['pack_quantity'],
                    'price' => $row['price'],
                    'show_type' => $row['show_type'],
                    'active' => $row['status'],
                    'id_unit' => $row['id_unit'],
                    'id_category' => $row['id_category'],
                    'id_shop' => $row['id_shop'],
                    'id_brand' => $row['id_brand'],
                ]);

            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){
                $product->languages()->updateOrCreate(['id_lang' => $lang->id],[
                    'name' => $row['name_'.$lang->short_name] ?? null,
                    'description' => $row['description_'.$lang->short_name] ?? null
                ]);

            }
        }
        return true;
    }

    public function headingRow(): int
    {
        return 1;
    }

    public function batchSize(): int
    {
        return 500;
    }

}
