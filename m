Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD37847EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjHVQrP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHVQrP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 12:47:15 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F49184;
        Tue, 22 Aug 2023 09:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCNECG+jh/QuciFFhqYUbeEJbGHYSSHd2naFgn5j5OYqAxFIrxRB4rWR9+3skUfK8NH7iRboECSZsSOjJ+/CESMRbsFT/ynKAQdmmFuyul42DMoeOW+sSXq9rasHuKBeopU0XjwLtb2pNlXpoxw0lzbtl5ePSVpHuV6l6xp6YZi2h5BJN2KxeGax7YLyfboW3BU0uOLKxhKKZu6k9lwTTLlpjcezEX8/EHqLHfkcw1pMh6PYOCS2C+6V8al0eHDpvnAiu5NnwMAFz5XC/fcgBgGVoK3FF3E7HyVapdFibPm+dvjVfNZNI/FyGZxjgu/XajG6cmcNOm6KGgbnVHzDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWXnwHU/zwPaB9+xLjF+lhOAFI1ObmewqofBr7Klp8=;
 b=i+GDmHewGH20tcMHbpUHxyIXIMEh3v7G0KRHotqlNLqFnBZawIb+mT7eGxIxtoT6Hbh+hxwxJzJQK8ztrU3VVcykWOJx6ZTo0M40HzQwCsp/696UsEdRxXwbSF3dACzlq2ZNi57uRaN6KCKVgh5n2BYiT7cnVUYYj+sz0AnY95YmlMW+QPUVf6LZsWAdFblUnNEj8JD3HW3goeOLA9nrdLSAJHTfkAJ8czlTAgobqvXpSuBZuNWEaBea+Jli36/AYOejcMf1oloMWweqOnuGbu6+J1fXdi6hoFlanyX2jj7kNFThMrEGFOIrBUBnP7sY6WJnqkRnomlUeADxbxLh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWWXnwHU/zwPaB9+xLjF+lhOAFI1ObmewqofBr7Klp8=;
 b=M4g+pA6l7puesGLPKGRM5FmmgBbvrT+uq9A+1eLLR9qIsXYxo+1zPS1MHQ67GQKyJG4cRIae7anf+Hk419iPweVWJk0les/67iiHfs890lCQYBbPdoiltPYwfXSK0uc8fdkMaxQEFrB557aQf1l7IV3HhpB5bER/pACBpyeeblo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3710.namprd21.prod.outlook.com (2603:10b6:930:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Tue, 22 Aug
 2023 16:47:10 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Tue, 22 Aug 2023
 16:47:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Topic: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Index: AQHZzuIahKDnYnDyXECZlBkiM46kOK/2i3jg
Date:   Tue, 22 Aug 2023 16:47:09 +0000
Message-ID: <SA1PR21MB13352E893E8DCAE02CED2857BF1FA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811214826.9609-1-decui@microsoft.com>
 <20230811214826.9609-2-decui@microsoft.com>
 <20230814190355.GA2672897@ls.amr.corp.intel.com>
In-Reply-To: <20230814190355.GA2672897@ls.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=74482781-d290-42a1-81bb-830bda21ee37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-22T16:20:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3710:EE_
x-ms-office365-filtering-correlation-id: 436aeb72-169f-4943-9ba3-08dba32f6d82
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+esV1zYekaUXthfoHjKFJkCaE05J4ddBz7wBayiZ01u8rzPzMQACdnwZAH0X1YhWa35XVqLWk8Uxc+PBgOhfV0/iOGxRwoa220zTpfGlU1tm/zcHnfAu1MTGgA0XeObNBb+PnWAivdEx+OZiE1PPKnsK98yKOJsIJFGH27rD6/hoGzsevZNmc6NzK/moF2G+qFJ537Bakla2BVRImBXDAEfmrC4XTW61duYfWmiNyKOhrUiJLweVIjv0UyYNcmN35TDnlfSbadObOkitEJl0CsZR7ZBXLB5iw3KGZN4Trk/WKRwuSpAxAg9nuXGRQa8/ftAopS2GEi0Lho0vd49bMuSQDVItrY8+UxTGKTJo0OmWcjF+5B0VQMlgoWoRNWEP40WQ/NIU9Lr6uqGc3TAqgx2nGCvd4CID9BVf9VL2qWtTHbtOnWs5MEk9J44WWDG+hcbhLngZuowFv/8VDeXW+IR4/vVkxauiW0nXkUfoOZxBT6xC03ZDRTcGo67CJRkFREBKB5sayWgPsU00SXN5+L6mXyQ20YakqPBUaj/sdlb/0v7kNcjomdtXZ4hAgMS9nmZGxZ4FPxhpoEtvavu4K3SkO24DpcbVw2fjM/CcSzWz1PmxWZCTadEoecpJ5DiylJ+oIKKkoaXxE62o+9T8tUASmGXvFAk+MP8CMwklMO22b8d4yFyfeAuLAiLcCL1oy62nuRgJ/n3tLgOCQaV2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(4326008)(6506007)(71200400001)(7696005)(9686003)(53546011)(10290500003)(478600001)(83380400001)(2906002)(5660300002)(7406005)(7416002)(316002)(8990500004)(64756008)(54906003)(66946007)(110136005)(66446008)(52536014)(8676002)(66476007)(76116006)(66556008)(41300700001)(8936002)(33656002)(55016003)(122000001)(38070700005)(82960400001)(86362001)(38100700002)(82950400001)(921005)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUdpTGFZTkpmaVFTenBDcktnd0lHb1UxTHdMck9pRGIvRSsvR2VPTVZYcHhO?=
 =?utf-8?B?a28xRVcxYWx6LzhJNmFtQkFVYTFrdmMzNFlHK0FlZUxmOG9kdW5qK0VUdmFC?=
 =?utf-8?B?UTFCM25vR2FPVUVHbmVyRXdhaXNNeFcvN2V0aXhwbjB5ZFVVc01POXJGb05y?=
 =?utf-8?B?VWRQUXd4RjV1cFJ3NG1nODlURE9xWndPTzdjUGVjMEVab3BzU0g0QStqejlO?=
 =?utf-8?B?M1dTYjl4NGZSVXp1Zk05R1VlODQxb2I0M3Z4Mk9rSStjUVVldGI5Qk1pUmFY?=
 =?utf-8?B?eUhCUUN3SExEWXZlSHpaampTU01SUFhpNWh4LzVPRkZBUG52K3ovaUpxeXpi?=
 =?utf-8?B?TUZhSW43ZDREaVZmRzFEZWp2ZFhxTUdremlxanlta2IzSEhIdnBwMTB3SGZK?=
 =?utf-8?B?QkRyQWgyOEtiRTJRYXhZN0pnMW9qYXcrR3JwakxLQlRvS3ZiNEVBY0s4OFVY?=
 =?utf-8?B?akh4UlRUTUJTaHlzQkZpVHhxSlg0ZUFocWFweXBEcTFsR1ByNzFmakFORGJM?=
 =?utf-8?B?VnYxdjBWNU5MQ2tGWjBobi93cDhCd1p4MFZxaUorek05Rk1KeEc3UzhSWkFB?=
 =?utf-8?B?bFlpVUVpTVlrdzcxem9iM0lCaDBWKzVCMWxHenY2NFJVb2t2S1RodnJmc1g3?=
 =?utf-8?B?QWVtWGpwVzRrRGdFaUFlVEE5YzRnQjdnSE5EdERvaGowRHhRNGxKcm9YaEJV?=
 =?utf-8?B?TzR1MzhtTXRoaHRHbGhENGtYS0FudDNtSGYwdFRWVFdlUUo0VzFlcTJBMm54?=
 =?utf-8?B?eTJvdTRqUEFNYVlQZDZ2WXJJb29RbkJMNVlqS1d4K1RMbnJLcEs0OHhqTWc4?=
 =?utf-8?B?bUN3emlrSU5tWERyeXduZWI0R3pKUTZyUjFlNmp5djVRbjZQQmNwUHlPTzZB?=
 =?utf-8?B?UnVKL044NmFvdGlZV1VsS2FORFV1Q0NhdVd1dkNUcmxucVFQRWZabW1OcjFT?=
 =?utf-8?B?ZlcwTkFsZzY0UjFsNXpGMzQ2S0V4TmloQzViVEtTWU9HcFpNNXJ5cnlkUDNq?=
 =?utf-8?B?alpxRm5kWWREOWtwb0syc3VlejBZZFFuL3VZSEt6UzJ0alJvT2ZmR3kyWDY2?=
 =?utf-8?B?VlhGQVNhNnptSzJXQ1JpNVNJOWp5R2Iydm1OSnlWTnB3L1FoQ2ROZlhCQ2Rz?=
 =?utf-8?B?QnhFQ1J5cXdKenJmYjBqNUNqS2tncjR0dFg5U0dpVkVZczZ6dk93Ym9pcjF1?=
 =?utf-8?B?VWQrT1ZyVk5iUFRIUVV0anBrSlNaRnZMNCs2TElCM2JEUUhWaVpmV0Z3cldO?=
 =?utf-8?B?Lys4UmVGcEtJZmpvVWIrSDBGTXBCWlBWN2wzODF2SGVGb2tEWnNRc20zQTNC?=
 =?utf-8?B?VllBZks4ay8vejZLWTdCdU02YWx6NVJYOTdxS1FEa0MwMmZtOWZxUXBhdDdY?=
 =?utf-8?B?TThQUWIvUEFHRkJtNXkvd0ZhbVdDZUVxd1QvYW1ISm5oNWM3cExObi9jQ3dn?=
 =?utf-8?B?cmhHZ2dDZmZJdUpDVm9YWXl4cjRoZi9wRWhqUlRzMWxwOFdURTRXaC84SlpS?=
 =?utf-8?B?c3Jld2djYi9oNERFKy9FZkljUUtHU1BNbW1HVkQ2N3NRck01TUIxck8xbEhm?=
 =?utf-8?B?K1gwbUdreTdKeEUvUVlaeE1xYms0ZUlpS2FTZlhKUmNSVlUxZFJRY0VBY1Za?=
 =?utf-8?B?eVo1azE4UnB4L0UwdGM0ZC9HZzk5dTI3aGVYeGxoSzVOVkQ0ek1zbFVpaFpt?=
 =?utf-8?B?Ty83YnorREl3VzZXcGRxelZwVzJJRE9PSko2Nnh4bzluUmRpcG5jSjhzRjVj?=
 =?utf-8?B?Wm5UaEc2RkNIdjJNUnVBSWtWbmRSVStiZjRLRTJucWdOV3prQU4zYWtCcXhU?=
 =?utf-8?B?bm5adnhreXlCNUdMSm1NaCtNT2xtNnB0NmpJSVBwQjFuei9zWlZZcFBVM1lt?=
 =?utf-8?B?L2szd1FoZFhsWnpMcGF6bXUyOEVpbC9rcmFITUZPeEYwTXBIWWpHQW0rbklt?=
 =?utf-8?B?eVJsOGhsZjRqaWoxNmV1M0NuMFp0MlZ3NEx0a0NnYi9XTEV3d05scGR5eFph?=
 =?utf-8?B?bnVpcnZuN0h2S2YvVkZEOU9DeUM4MVlUM0hoVHU0QzNBU1VYVUFFU2ZOSXFs?=
 =?utf-8?B?YXBHclhCRENZYnVQM3B6K0twZnE5UU44MGxUM2djNXpNL3lBUUl1Z2N3R0dp?=
 =?utf-8?B?WGczbmpYcUt0M0diU2dVdTVPWE9FUzdhY0FzQURsalNSSm9reWZNOWt1R0Yw?=
 =?utf-8?Q?pxw/skYIHqVPKO4xusAub6yof09PuRxF79mnJPB8FSS1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436aeb72-169f-4943-9ba3-08dba32f6d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 16:47:09.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Yh9G6qxaMWR/RnJOSh+w4y2h7vp5QxtmlZrHUx+pjoKQI3AhIHpoxIOa+C4d4TgB3iu5Dwwj4zsiRDB71GkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3710
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBJc2FrdSBZYW1haGF0YSA8aXNha3UueWFtYWhhdGFAZ21haWwuY29tPg0KPiBTZW50
OiBNb25kYXksIEF1Z3VzdCAxNCwgMjAyMyAxMjowNCBQTQ0KPiBUbzogRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT4NCj4gWy4uLl0NCj4gDQo+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0
IDAyOjQ4OjI1UE0gLTA3MDAsDQo+IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+IHdy
b3RlOg0KPiANCj4gPiBURFggZ3Vlc3QgbWVtb3J5IGlzIHByaXZhdGUgYnkgZGVmYXVsdCBhbmQg
dGhlIFZNTSBtYXkgbm90IGFjY2VzcyBpdC4NCj4gPiBIb3dldmVyLCBpbiBjYXNlcyB3aGVyZSB0
aGUgZ3Vlc3QgbmVlZHMgdG8gc2hhcmUgZGF0YSB3aXRoIHRoZSBWTU0sDQo+ID4gdGhlIGd1ZXN0
IGFuZCB0aGUgVk1NIGNhbiBjb29yZGluYXRlIHRvIG1ha2UgbWVtb3J5IHNoYXJlZCBiZXR3ZWVu
DQo+ID4gdGhlbS4NCj4gPg0KPiA+IFRoZSBndWVzdCBzaWRlIG9mIHRoaXMgcHJvdG9jb2wgaW5j
bHVkZXMgdGhlICJNYXBHUEEiIGh5cGVyY2FsbC4gIFRoaXMNCj4gPiBjYWxsIHRha2VzIGEgZ3Vl
c3QgcGh5c2ljYWwgYWRkcmVzcyByYW5nZS4gIFRoZSBoeXBlcmNhbGwgc3BlYyAoYWthLg0KPiA+
IHRoZSBHSENJKSBzYXlzIHRoYXQgdGhlIE1hcEdQQSBjYWxsIGlzIGFsbG93ZWQgdG8gcmV0dXJu
IHBhcnRpYWwNCj4gPiBwcm9ncmVzcyBpbiBtYXBwaW5nIHRoaXMgcmFuZ2UgYW5kIGluZGljYXRl
IHRoYXQgZmFjdCB3aXRoIGEgc3BlY2lhbA0KPiA+IGVycm9yIGNvZGUuICBBIGd1ZXN0IHRoYXQg
c2VlcyBzdWNoIHBhcnRpYWwgcHJvZ3Jlc3MgaXMgZXhwZWN0ZWQgdG8NCj4gPiByZXRyeSB0aGUg
b3BlcmF0aW9uIGZvciB0aGUgcG9ydGlvbiBvZiB0aGUgYWRkcmVzcyByYW5nZSB0aGF0IHdhcyBu
b3QNCj4gPiBjb21wbGV0ZWQuDQo+ID4NCj4gPiBIeXBlci1WIGRvZXMgdGhpcyBwYXJ0aWFsIGNv
bXBsZXRpb24gZGFuY2Ugd2hlbiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpDQo+ID4gaXMgY2FsbGVk
IHRvICJkZWNyeXB0IiBzd2lvdGxiIGJvdW5jZSBidWZmZXJzIHRoYXQgY2FuIGJlIHVwIHRvIDFH
Qg0KPiA+IGluIHNpemUuICBJdCBpcyBldmlkZW50bHkgdGhlIG9ubHkgVk1NIHRoYXQgZG9lcyB0
aGlzLCB3aGljaCBpcyB3aHkNCj4gPiBub2JvZHkgbm90aWNlZCB0aGlzIHVudGlsIG5vdy4NCj4g
DQo+IE5vdyBURFggS1ZNICsgVERYIHFlbXUgc3VwcG9ydHMgcGFydGlhbCBjb21wbGV0aW9uIGJl
Y2F1c2UgVEQgZ3Vlc3QNCj4gY2FuIHBhc3MNCj4gdmVyeSBsYXJnZSByYW5nZS4gZS5nLiAxR0Ig
b3JkZXIuICBJIHRlc3RlZCB0aGlzIHBhdGNoIHdpdGggKHBhdGNoZWQpIFREWA0KPiBLVk0vcWVt
dS4NCj4gDQo+IFJldmlld2VkLWJ5OiBJc2FrdSBZYW1haGF0YSA8aXNha3UueWFtYWhhdGFAaW50
ZWwuY29tPg0KPiBUZXN0ZWQtYnk6IElzYWt1IFlhbWFoYXRhIDxpc2FrdS55YW1haGF0YUBpbnRl
bC5jb20+DQoNClRoYW5rcyBJc2FrdSBmb3IgcmV2aWV3aW5nIGFuZCB0ZXN0aW5nIHRoZSBwYXRj
aCENCg0KQERhdmUsIG1heSBJIGtub3cgaWYgdGhlIDIgdXBkYXRlZCBwYXRjaGVzIGxvb2sgZ29v
ZCB0byB5b3U/DQo=
