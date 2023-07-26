Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43376413B
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGZVeh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGZVeg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 17:34:36 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020020.outbound.protection.outlook.com [52.101.56.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3B268B;
        Wed, 26 Jul 2023 14:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpYofjG2Hf8sNd5VL0TchCSxvpsu80hND/cOkdCt/AdX7mI2SMaQyKVxDLQ2pvwjeVnNSbaghbzRsUWMxxVsd7y//VTesLkivN+RuZXcK6DvKkkWsxkJaDK5XpAKLqeDGXNAsrclWc0gHei26bnhVCpK1V5Lb0ely816a9PfPaVKzhVkyifGoHFw69QG2euvbboW2rw5f1lLHBpKGmRUL4/3f3ymVBPo8rngwQvs4O5/if6gCe/IJK8Pd3UMT+aoaSzVc2g5XwyS5DuLRpJAbvpOCmpVMHrHVVA7DSnPDfNo7gShQgu5QmPwFo7ugFZ7sFsd4Ym0PMLrYXHgu4VcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR3JqA2tuStq4WUWoPGPAw3bKTAR72ia5TRU7WLPkEk=;
 b=N1s+LnAokNZ5M8kra/6BnXks7QYfpEwY0rKqixNRiyHJo327Xr8761OXg+4EOSnItXgUbdIhtyWzjCuJz1bMZ5QXEnph5I9SViUlF6juvBZwFWmcQFJuGN82G7mMJ90oJ+WPrh+JzFa9RpsA1UtprnD5edosv2FUoA87OXVMNilGbtE0QqlifPoB7PGyRk7goHSTeNx0su1kQR6NJS8XTR44o2RDN9NgDtQAAG7fsdOtTMKBkhTuN1qM8zxImuqluF5EP3k5hnFetPHPeNQIjy0gAz0rPU9DmnQ8+/0j8TloYJPA9Vi7JpfANR4EkHjZgswnx3MPq/g7+d3lEIZ0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR3JqA2tuStq4WUWoPGPAw3bKTAR72ia5TRU7WLPkEk=;
 b=ZN9N3sIRhShea0ewLjPByRhZe4xEnLWzFRxZrtZ5Ih4lwak8Hr6md5X03lmYDF6YeQuKx2Z2QmemtFX4UDKRPA6AUDqdZpjz/DD1plILhNVliy3qOAY2ZGHt3tp2Gq3sjOiNVCsnTXwZn1ShdwO4TocS3pLXo9QGseFzxn9PsJE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3779.namprd21.prod.outlook.com (2603:10b6:208:3d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Wed, 26 Jul
 2023 21:34:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a%6]) with mapi id 15.20.6652.002; Wed, 26 Jul 2023
 21:34:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Gary Guo <gary@garyguo.net>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nischala Yelchuri <Nischala.Yelchuri@microsoft.com>
Subject: RE: Hyper-V vsock streams do not fill the supplied buffer in full
Thread-Topic: Hyper-V vsock streams do not fill the supplied buffer in full
Thread-Index: AQHZwAj2zyxoHYhk5ECPjRgD3kbIxg==
Date:   Wed, 26 Jul 2023 21:34:32 +0000
Message-ID: <SA1PR21MB13358086D8E23229FCE692ABBF00A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230704234532.532c8ee7.gary@garyguo.net>
 <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
In-Reply-To: <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ea2a89ff-9318-4207-a1d9-90bca40709ba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T21:24:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3779:EE_
x-ms-office365-filtering-correlation-id: 69525710-3629-4802-b726-08db8e2019a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ctg8/vL+VgU/NgsnCXLC7RBAhzzHIYyqy7Io46+YmfDtIjDJy93MEwUG6sxhRGMc/lpAM23NkAXN2aCh2BMUWLDXchkLtVIIUC1klhgXiuwaJ00wr284o+WR1meIobZ9WmVLDbpK2aFhexn+qSup3LUUyy7q4zglyIfe4/nnVUQkUNySrdKlS0LIvaHR/Gf3kp8EfZEpf+/BFjdgA/lywa78exeYX0UVICBFmPggQxyZER7tJDSvNo/TLbcE+82tj5AbGumVVsvjIdKGE5Al7x9Opnk9u4Pw+XNNAmv90/GiRX1ZeASsZ3CUHhKzOLdJGkd1wzOsaVWcEWuTv40gY5L7jsRHPKdj5qcSvbXwiwjMNXk/pdnetPwmWnhDP2UFlYCf3vC1Zj2WssGXjAd3ccIEaYgnrtl2sEwv5iX7mW4gRWlPYbKTLMmtCB06KL7JoGKqjLdKoSzPUIj5LkkshDfpu0ivOURYIzABCaYhLtjBonY4TNWyiEHC9RRYdX20REb1ly7zjbxcAxq6SzOKXl3IP4CVLDJ9TBPenY6Ei5oHYWfR37UHrvLc1ptbWNUYeqLfQzGEfcnD99iAZKfCO6o4xb1aKIz4vXsLJf5JTNSmXs9uiwLkgHdDbAYuqNAGPR5DaFrgReP8BNvPsEEzI1I4VbFJW8MJ/iRAwR8ltQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(55016003)(5660300002)(71200400001)(107886003)(2906002)(52536014)(8936002)(7696005)(41300700001)(8676002)(9686003)(82950400001)(6506007)(86362001)(8990500004)(66946007)(53546011)(4326008)(76116006)(110136005)(54906003)(10290500003)(82960400001)(316002)(66476007)(478600001)(38070700005)(64756008)(66556008)(66446008)(38100700002)(83380400001)(122000001)(186003)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlhONEkxUi9VaXczQVVsclBta09kUW1zYUtndDN1ak12dFRnK2JydWFJYncw?=
 =?utf-8?B?Qk1rRmlkN3BOVG5aeXV6Y2gySjBqNW1HV1d1cUlocTJtTmV5L0RhL2lZYlNr?=
 =?utf-8?B?T0pNa3Z4ZHR5VkJQQURVQ1Z2aXQ0ZTNVY3pqN3Zhaml3QzYrd25sckRDNlNL?=
 =?utf-8?B?WHQ5NXNzM1hEbndYRmJOdExxaVlPdUpsZ0JFTnFxS0JCSk9ZZVdHWDQwNkM0?=
 =?utf-8?B?cGZ4V3l4QndsOTVnUGhLOFhxMDlQUk02T3NmZmlVNXozMCt6RVVNcXROelMz?=
 =?utf-8?B?WTU5eDhnM05URFZMbi94aFI0Z2U3RkFOSlVqTzZnNWRmQzNnZWtRaGxhekFh?=
 =?utf-8?B?SzIrOUkyZGdzTEFTZGs3OUFDWkdpS0RXN1RJRVQ2VDNpS3diOWxuejZKeDZj?=
 =?utf-8?B?Lzh1bkFLeTdNZTJFb29mWEczRVp0OERBN3Y1aENqSHpZT3ppeWsxN3JUQWJO?=
 =?utf-8?B?Y3c3amI0d25rQk9DNlUrbVRXN1N2Sm5ySnZDSXZRQ1pIZXdDNTEwYWdCRDY3?=
 =?utf-8?B?N0RveGxZcWpONjRsT01TazNSTGVsZ2hOcVJHeUF0QXJlUjRDK29zMUNFbVdP?=
 =?utf-8?B?NVNHTDc5QzZUN1BpSzdXbnZjMVdZdVJucFozdEJmdjFXMG9Wc29waDd4eW4y?=
 =?utf-8?B?bFhycHZXRXFFelZuazlRSTN2WnpsMW1UeWhkdFIzc2d5Y01BRUJ0VXdQQWcz?=
 =?utf-8?B?OWtqN2dMSU5vMnY5WEhNdFdUam9sS3hueldOaW1mZlI1a3k5ZHpCZHhuc1Bt?=
 =?utf-8?B?dU9yTmFtZmxsKzkxa283MjI3SnJKOTZjWmRsNkE5QXdjTGdpK3Nlb2hJcm81?=
 =?utf-8?B?VVFSU1RndjRZbWlOTEJ3ZCtuWnZKZEtPcXV4d3BrMGtiNk5vbnpUUGN3MVdo?=
 =?utf-8?B?UjFPNjNGNmdSbWJXOWlqakNVM2Fnbkh6MDFsYlZaMzg4bDJaZWNabEtqOHEx?=
 =?utf-8?B?VkY0cjBMMHJGMGRIblVwVjlodkVaRTZaTmlRL1p3UkNXMjlJUFRVZ2FYZ3V5?=
 =?utf-8?B?c1dLWStoVzJmc3phOEFOOFEzNlFjTFpianVhaStPYm80bTY3NXJkaVE0WW5X?=
 =?utf-8?B?V2VFbUNBOGdGNWdqa1BOZXoyWDFoTk4waEVPby9ra0hweHlPTnByNUJ3YjdC?=
 =?utf-8?B?Q2I4U2cvMDhDaVlSQTIwUnNUZ0w5elpKNWVkaHZJa3l5a2QzZitSVUJPTFBt?=
 =?utf-8?B?eGlGY0Q0Y1JvYWdXUTI2MER3WitlRFNJcVFlN0dmN3ptOWZUNEVnOWxLNUh6?=
 =?utf-8?B?ektqbEpvWGZ4UldXNU1qTHlqQ1ZEVW9LaHFWcTJCNTh2NnRqQThGWFpZelJp?=
 =?utf-8?B?bnd2MzVLUjhkaWZQdFhVeXpzaGxxV0YyaVU1c21GYTFxeTdKY2xoUUFZMStU?=
 =?utf-8?B?NlgwaFBHOWhRazFxVkV3WDByU0hZRnF1OEk5ZUNod3h2Y1ZOUEFjbHJzcm4x?=
 =?utf-8?B?Sm12THplTnJSRnV0b2poT0E5cGRKYUk0WjRuMCs4MTlBdjBnUDFyUzc3L0Fy?=
 =?utf-8?B?aE4vYjA5MkpnQWZxM0FkeDl3NkhaK1RFMWtGZXBFL2xEdUNsc0tnbGZZdUhQ?=
 =?utf-8?B?RkxJK0VraDFoRld3YUViZTlkSThkVnJVRmlIREdRYld0N0E2YkZPb0svVlNE?=
 =?utf-8?B?cjk1YkFhYlBKNEd6T2tXRm5vNG9NNm1oakgraXBsejFMOWt6dDhuSTVCZWZ4?=
 =?utf-8?B?eTNEMlBOVkZDMTJzdEQrMXIzRWdpQkpjcWpqTFlHQ0tTaHUyL2wwVDcrMUcz?=
 =?utf-8?B?VC8wMHUzMlJYQzhRMW5qWGRFU1lITi9mUjF6M0RlTXZYSm1mSzNyQitONS9z?=
 =?utf-8?B?QTAzTEdrNW40NnFjRElxN2FsYi9JTCs1QXhZNEpHZk9PYWs1eUlhRkZBeFRR?=
 =?utf-8?B?RjVmdmFBSkpicE9iY2pPUkhrWGExSHIzWUgrWWZha1BSdU9IbDJlbmN3TGt6?=
 =?utf-8?B?ZjZ6TmJqSG5nalFZRFhxV2dsNXAyNy8vbXIreU5pblhwL1BRUnV4OTFLbkxl?=
 =?utf-8?B?SFNkTWhpbFYxSkJVcitiejZOY29sOTBkRUtHU1haam1iMjFYWUphaUQ0Y1NJ?=
 =?utf-8?B?OXpMa1ZEMndLNXI5eGRQaG9sUkVmQ1k5MzBYbFFOLzRrN3FVUlVlUTVGSEhp?=
 =?utf-8?Q?Jcw6eThv4Hlb53ix5GvO2IsYC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69525710-3629-4802-b726-08db8e2019a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 21:34:32.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCpqjt7X2BACb2kR41d4Qv2a4kfkZFQP3z6cGCTggRjBVhlaVJod3oSjwQBpR0HlfXWp7iQEDOQd5kJgLPczeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDYsIDIwMjMgMzow
MiBBTQ0KPiBUbzogR2FyeSBHdW8gPGdhcnlAZ2FyeWd1by5uZXQ+OyBEZXh1YW4gQ3VpIDxkZWN1
aUBtaWNyb3NvZnQuY29tPg0KPiBDYzogS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+
OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgV2VpIExpdSA8d2Vp
LmxpdUBrZXJuZWwub3JnPjsgbGludXgtDQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBIeXBl
ci1WIHZzb2NrIHN0cmVhbXMgZG8gbm90IGZpbGwgdGhlIHN1cHBsaWVkIGJ1ZmZlciBpbiBmdWxs
DQo+IA0KPiBIaSBHYXJ5LA0KPiANCj4gT24gV2VkLCBKdWwgNSwgMjAyMyBhdCAxMjo0NeKAr0FN
IEdhcnkgR3VvIDxnYXJ5QGdhcnlndW8ubmV0PiB3cm90ZToNCj4gPg0KPiA+IFdoZW4gYSB2c29j
ayBzdHJlYW0gaXMgY2FsbGVkIHdpdGggcmVjdm1zZyB3aXRoIGEgYnVmZmVyLCBpdCBvbmx5IGZp
bGxzDQo+ID4gdGhlIGJ1ZmZlciB3aXRoIGRhdGEgZnJvbSB0aGUgZmlyc3Qgc2luZ2xlIFZNIHBh
Y2tldC4gRXZlbiBpZiB0aGVyZSBhcmUNCj4gPiBtb3JlIFZNIHBhY2tldHMgYXQgdGhlIHRpbWUg
YW5kIHRoZSBidWZmZXIgaXMgc3RpbGwgbm90IGNvbXBsZXRlbHkNCj4gPiBmaWxsZWQsIGl0IHdp
bGwganVzdCBsZWF2ZSB0aGUgYnVmZmVyIHBhcnRpYWxseSBmaWxsZWQuDQo+ID4NCj4gPiBUaGlz
IGNhdXNlcyBzb21lIGlzc3VlcyB3aGVuIGluIFdTTEQgd2hpY2ggdXNlcyB0aGUgdnNvY2sgaW4N
Cj4gPiBub24tYmxvY2tpbmcgbW9kZSBhbmQgdXNlcyBlcG9sbC4NCj4gPg0KPiA+IEZvciBzdHJl
YW0tb3JpZW50ZWQgc29ja2V0cywgdGhlIGVwb2xsIG1hbiBwYWdlIFsxXSBzYXlzIHRoYXQNCj4g
Pg0KPiA+ID4gRm9yIHN0cmVhbS1vcmllbnRlZCBmaWxlcyAoZS5nLiwgcGlwZSwgRklGTywgc3Ry
ZWFtIHNvY2tldCksDQo+ID4gPiB0aGUgY29uZGl0aW9uIHRoYXQgdGhlIHJlYWQvd3JpdGUgSS9P
IHNwYWNlIGlzIGV4aGF1c3RlZCBjYW4NCj4gPiA+IGFsc28gYmUgZGV0ZWN0ZWQgYnkgY2hlY2tp
bmcgdGhlIGFtb3VudCBvZiBkYXRhIHJlYWQgZnJvbSAvDQo+ID4gPiB3cml0dGVuIHRvIHRoZSB0
YXJnZXQgZmlsZSBkZXNjcmlwdG9yLiAgRm9yIGV4YW1wbGUsIGlmIHlvdQ0KPiA+ID4gY2FsbCBy
ZWFkKDIpIGJ5IGFza2luZyB0byByZWFkIGEgY2VydGFpbiBhbW91bnQgb2YgZGF0YSBhbmQNCj4g
PiA+IHJlYWQoMikgcmV0dXJucyBhIGxvd2VyIG51bWJlciBvZiBieXRlcywgeW91IGNhbiBiZSBz
dXJlIG9mDQo+ID4gPiBoYXZpbmcgZXhoYXVzdGVkIHRoZSByZWFkIEkvTyBzcGFjZSBmb3IgdGhl
IGZpbGUgZGVzY3JpcHRvci4NCj4gPg0KPiA+IFRoaXMgaGFzIGJlZW4gdXNlZCBhcyBhbiBvcHRp
bWlzYXRpb24gaW4gdGhlIHdpbGQgZm9yIHJlZHVjaW5nIG51bWJlcg0KPiA+IG9mIHN5c2NhbGxz
IHJlcXVpcmVkIGZvciBzdHJlYW0gc29ja2V0cyAoYnkgYXNzZXJ0aW5nIHRoYXQgdGhlIHNvY2tl
dA0KPiA+IHdpbGwgbm90IGhhdmUgdG8gcG9sbGVkIHRvIEVBR0FJTiBpbiBlZGdlLXRyaWdnZXIg
bW9kZSwgaWYgdGhlIGJ1ZmZlcg0KPiA+IGdpdmVuIHRvIHJlY3Ztc2cgaXMgbm90IGZpbGxlZCBj
b21wbGV0ZWx5KS4gQW4gZXhhbXBsZSBpcyBUb2tpbywgd2hpY2gNCj4gPiBzdGFydGluZyBpbiB2
MS4yMS4wIFsyXS4NCj4gPg0KPiA+IFdoZW4gdGhpcyBvcHRpbWlzYXRpb24gY29tYmluZXMgd2l0
aCB0aGUgYmVoYXZpb3VyIG9mIEh5cGVyLVYgdnNvY2ssIGl0DQo+ID4gY2F1c2VzIGlzc3VlIGlu
IHRoaXMgc2NlbmFyaW86DQo+ID4gKiB0aGUgVk0gaG9zdCBzZW5kIGRhdGEgdG8gdGhlIGd1ZXN0
LCBhbmQgaXQncyBzcGxpdHRlZCBpbnRvIG11bHRpcGxlDQo+ID4gICBWTSBwYWNrZXRzDQo+ID4g
KiBza19kYXRhX3JlYWR5IGlzIGNhbGxlZCBhbmQgZXBvbGwgcmV0dXJucywgbm90aWZ5aW5nIHRo
ZSB1c2Vyc3BhY2UNCj4gPiAgIHRoYXQgdGhlIHNvY2tldCBpcyByZWFkeQ0KPiA+ICogdXNlcnNw
YWNlIGNhbGwgcmVjdm1zZyB3aXRoIGEgYnVmZmVyLCBhbmQgaXQncyBwYXJ0aWFsbHkgZmlsbGVk
DQo+ID4gKiB1c2Vyc3BhY2UgYXNzdW1lcyB0aGF0IHRoZSBzdHJlYW0gc29ja2V0IGlzIGRlcGxl
dGVkLCBhbmQgaWYgbmV3IGRhdGENCj4gPiAgIGFycml2ZXMgZXBvbGwgd2lsbCBub3RpZnkgaXQg
YWdhaW4uDQo+ID4gKiBrZXJuZWwgYWx3YXlzIGNvbnNpZGVycyB0aGUgc29ja2V0IHRvIGJlIHJl
YWR5LCBhbmQgc2luY2UgaXQncyBpbg0KPiA+ICAgZWRnZS10cmlnZ2VyIG1vZGUsIHRoZSBlcG9s
bCBpbnN0YW5jZSB3aWxsIG5ldmVyIGJlIG5vdGlmaWVkIGFnYWluLg0KPiA+DQo+ID4gVGhpcyBk
aWZmZXJlbnQgcmVhbGlzYXRpb24gb2YgdGhlIHJlYWRpbmVzcyBjYXVzZXMgdGhlIHVzZXJzcGFj
ZSB0bw0KPiA+IGJsb2NrIGZvcmV2ZXIuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBk
ZXNjcmlwdGlvbiBvZiB0aGUgcHJvYmxlbS4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGZpeCB0
aGUgaHZzX3N0cmVhbV9kZXF1ZXVlKCkgaW4NCj4gbmV0L3Ztd192c29jay9oeXBlcnZfdHJhbnNw
b3J0LmMuDQo+IFdlIGNhbiBkbyBzb21ldGhpbmcgc2ltaWxhciB0byB3aGF0IHdlIGRvIGluDQo+
IHZpcnRpb190cmFuc3BvcnRfc3RyZWFtX2RvX2RlcXVldWUoKSBpbg0KPiBuZXQvdm13X3Zzb2Nr
L3ZpcnRpb190cmFuc3BvcnRfY29tbW9uLmMNCj4gDQo+IEBEZXh1YW4gV0RZVD8NCj4gDQo+IFRo
YW5rcywNCj4gU3RlZmFubw0KDQooU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNlLi4uKQ0KDQpU
aGFua3MgR2FyeSBHdW8gZm9yIHRoZSBnb29kIGFuYWx5c2lzIQ0KDQpJIGRpZG4ndCByZWFsaXpl
IHRoYXQgaHZzX3N0cmVhbV9kZXF1ZXVlKCkgaXMgc3VwcG9zZWQgdG8NCmNvcHkgYXMgbXVjaCBk
YXRhIGFzIHBvc3NpYmxlIHRvIHRoZSB1c2Vyc3BhY2UgaW4gdGhlIGNhc2UNCm9mIEVQT0xMRVQg
bW9kZS4gDQoNClllcywgSSB0aGluayB3ZSBzaG91bGQgZml4IGh2c19zdHJlYW1fZGVxdWV1ZSgp
LiBXZSdsbCB0cnkgdG8gZ2V0DQp0aGlzIGZpeGVkIGFzYXAuDQoNClRoYW5rcywNCi0tIERleHVh
bg0K
