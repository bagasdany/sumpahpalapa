<?php

namespace App\Exports;

use App\Models\Languages;
use App\Models\Products;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class ProductsExport implements FromCollection, WithHeadings
{
    protected $request;

    public function __construct($request)
    {
        $this->request = $request;
    }

    public function collection()
    {
        $lang = Languages::where('default', 1)->pluck('id');

        $products = Products::with([
            'actualDiscount',
            'categoryLanguage' => function ($q) use ($lang) {
                $q->where('id_lang', $lang);
            },
            'shopLanguage' => function ($q) use ($lang) {
                $q->where('id_lang', $lang);
            },
            'unitLanguage' => function ($q) use ($lang) {
                $q->where('id_lang', $lang);
            },
            'brands.category.language' => function ($q) use ($lang) {
                $q->where('id_lang', $lang);
            },
            'language' => function ($q) use ($lang) {
                $q->where('id_lang', $lang);
            }])->when($this->request->type == 1, function ($q, $v) {
                $q->whereBetween('id', [$this->request->start, $this->request->end]);
            })->when($this->request->type == 2, function ($q, $v) {
                $q->whereBetween('created_at', [$this->request->start, Carbon::parse($this->request->end)->addDay()]);
        })->get();

        return $products->map(function ($item) {
            if ($item->actualDiscount) {
                if ($item->actualDiscount->discount_type == 1) {
                    $discount = ($item->price / 100) * $item->actualDiscount->discount_amount;
                } else {
                    $discount = $item->actualDiscount->discount_amount;
                }
            }
            $discount = isset($discount) ? '$' . round($discount, 2) : "0";

            return $this->productModel($item, $discount);
        });
    }

    public function headings(): array
    {
        return [
            '#',
            'Name',
            'Quantity',
            'Pack quantity',
            'Price',
            'Discount',
            'Show type',
            'Status',
            'Created Date',
            'Unit',
            'Category',
            'Shop',
            'Brand',
        ];
    }

    private function productModel($item, $discount = 0): array
    {
        return [
            'id' => $item->id,
            'name' => $item->language->name,
            'quantity' => $item->quantity,
            'pack_quantity' => $item->pack_quantity,
            'price' => '$'.$item->price,
            'discount_price' => $discount,
            'show_type' => $item->show_type,
            'active' => $item->active ? 'active' : 'not active',
            'created_at' => Carbon::parse($item->created_at)->format('d/m/Y H:i:s'),
            'unit' => $item->unitLanguage->name,
            'category' => $item->categoryLanguage->name,
            'shop' => $item->shopLanguage->name,
            'brand' => $item->brands->category->language->name,
        ];
    }
}

