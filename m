Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6562777102B
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Aug 2023 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHEOi6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Aug 2023 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOi5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Aug 2023 10:38:57 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC14224;
        Sat,  5 Aug 2023 07:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBb10Up9FomHYnUctA3GUo70xDx1ayCEVaC6kXyyr9rxk5yJkak4C5E7O/Z70pGgveD0CH1kDqo92FryuyxujUSNwX5Q6gAwHDDl0ZhJXaOqTdrbAY9B3lEv80nbkzZ4sHzZqwuBOcNzxhS1JLbOdguud7vYTLn+MB9AgbyNBM085vEd4+opiic44xdRTVzpTorK4YZyqALyBwXteNC+Y1zT1NUNRL2GbpOzDLyspydobDhPr2JH+0xHF6DwQYYRtl7sHrQmOEvTcHYCunVnpr/Gj6YAjgcGXk30S/ezWcFIq6yE9l1bVsdVN3tqAb3So7jtiQDvIsFOjHcGy9H7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJfwBoSy/kIdE9ABbYth6yHy5vlIhucrKjn8/Rlw7l0=;
 b=K7AynerZ4i+Ida59rKbDrX6vnF3KHoz2Zto+muiARpBTjapT5A7Ah3YsU92UOeusl6m2E/q1SB9U+Y0udz4cOIFG8kBqsLMDT6KO/OuTxjXZQi9amLzXnuUSmx6rGIUyHwNkKHponnKsXhajJUWEAiJGudEfbuvfNnepOzBBHzzpCUvXbRMTafIIl7Hpz5JkefRHUA+KluFLIN9sO6+7MB+Ht4ar1Mj/4Phfvevccj//3vyELRs9KiBJJy7nib8uV5/HvnzFlDgvDyEllBc3vLbdZ9YICHI8aRHx6/9fG2yg3OS4Yd0D0FB7V9k9vZN8NIGsn5wEMj3yhaMEqgz7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJfwBoSy/kIdE9ABbYth6yHy5vlIhucrKjn8/Rlw7l0=;
 b=Myl8iFI0qgmNO42oTPGerGu0nsDQdcGwgDaCQcl9a6X3/KxU0BFmLfev2zNNDM8Ac0/Z9mgRZUdYXpyZAILqwiAVFfSTxGQ5bQVwL+FKnZC7efci6jaaGER9e1ZS6SadU8YQFQuEvSGnTVIemg3yvczYGfgiEufrxZjpoplukuM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3430.namprd21.prod.outlook.com (2603:10b6:8:91::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.12; Sat, 5 Aug 2023 14:38:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6699.000; Sat, 5 Aug 2023
 14:38:52 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nq/XuHuAgAQ44TA=
Date:   Sat, 5 Aug 2023 14:38:52 +0000
Message-ID: <BYAPR21MB168831FA522835E074565FF8D70EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <08bf0835-a4fa-38b5-4cbb-b2058a6a2da0@amd.com>
In-Reply-To: <08bf0835-a4fa-38b5-4cbb-b2058a6a2da0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bd42acb3-c82c-404a-acc5-3719c8821dca;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-05T14:26:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3430:EE_
x-ms-office365-filtering-correlation-id: 551f80ac-fb2c-4bd0-d359-08db95c1b0aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szTbU43NMpzmjrIjvKLOReiYm8e3qUHBa4vUSS+5ejxSSTsNJPWseWeI7MjvnRmbx+QtkIL3pcy/mnc0tV0C8YmcoHM6n3V5ryionsOpHWTqaNFz8PTNu2pUlH/5llSvYjbZl0koolhkMd403F5za0fguOU/26/ZqPlOekleCEC5kQhpXgio7HQdIdOj0lhv24ydssDopgkodmxnB0SPXAkNwG9MOAU25ZJLzmKMb2AzXr5RMdpUtTv4gSNFz8EXHeaJ4XNdK5yIOQXS0HTdX/fSIwtuq6LKcXTZUa33HlmbamKCHCVidomAXUncxFypWp0T54mQVpkZi+LasXD/pSJ7A/UdFc9qnJ0DYVlUbmmJuLUumJCb7A0/k4FlwnldGruoSWjHDX6BwTn4SkdyKMgnkIuk9FAl6PYUuFE534RTUwaSPg61qiaCrTqFFwVE4Hmr5ZLDsm346GmTRG8vHNNL13SWaMbIBW1IYcTBNl3A7evKp/U/x8AZOjOAP4COgyuDy+1yebu9Ouzrgg1McgxGyy0kCHSyaCPIukEiXueiRGkOxtUfaLHSqNqnuejvygXdQN3fUXuo3ldTkHLxoJMjaFGquvU3GIqYJ6fHVKzgtJl6q0W5tfzBimU+ck3Nq8dhGq+lPQHgM5XMRyw6+x0dtaRdKXMTJfXH2Lr+YX+JfHSMa+Pc+ZQFgg4NM1cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(186006)(1800799003)(8936002)(8676002)(7416002)(478600001)(110136005)(5660300002)(52536014)(41300700001)(786003)(76116006)(316002)(122000001)(66446008)(64756008)(66476007)(66556008)(66946007)(38100700002)(55016003)(6506007)(71200400001)(26005)(33656002)(2906002)(10290500003)(86362001)(38070700005)(8990500004)(82960400001)(82950400001)(7696005)(9686003)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVVOQnJubFFCdGpFTW5TL3NseENsNVdGSW1oRUdUYlkvNnVaYjJTSlJXTW9o?=
 =?utf-8?B?NzR4ek44Y2VNaFRta3ZVVERzcWlDbkFLN2RKZHF5aExPdHpPSGdZMVNjd2ZG?=
 =?utf-8?B?SXV0a01tT0FkU3pwdDAwWEd0ZlB5TWh6Q2ZQT09pa0hUNW5SWDVuQTBEWkdn?=
 =?utf-8?B?dmZYNGNyTHVjVldFWFlDZHFpYVVpOWVxMmZNeXdrWU1DeG9hbjFPSkNuMi95?=
 =?utf-8?B?TWVoMGU0OHdLc2JVNmZ0TXoyQUJ3dUdoRG14T0kxcFBQQ3ZsNUQ4Y0F6TStQ?=
 =?utf-8?B?aWtiY2RQZE1CbEtVMVZtUDNkZWRQU3ZnZ0Y5M1lhbUxnTnNXSjdHQVlmMzFs?=
 =?utf-8?B?d3dCcWdjK3hwT1lUa0wzS1kyQkZLQkdqMnYzc1lkenBoNFBMS1BvYk5zb0dt?=
 =?utf-8?B?QlBVM1lGQW9iYVhUa3pJT3REY045U2tWMzJxcEhqTXBYTmlweDY0Tkl6c2Fl?=
 =?utf-8?B?N1lzcEVxd0V0aU9iN2o0Z3NRVzRFaGdORjlVeGxiZzVyblhmdFZTZStocW1w?=
 =?utf-8?B?VWEwN2JRVU0vS3IweGxyWU4xVVdWamYrRFlHbTQrVkl5QW1Sa3FaVDNIaUh2?=
 =?utf-8?B?N2xkMW1wRTNidGZCUFRmajBYSGNvWEowbFlySkhoWm9YY3d6VmJLdW1BM1g5?=
 =?utf-8?B?a09zVXkwaWxwSFpuR2tYemlEOHFBK25nRzRJTzluWW1rMWgrRU54dHhOdVVp?=
 =?utf-8?B?b2k5eHd4TEFCbVJhaXYrbGdhTnpKcUlvaWt5T084QXFMQjY1Q05ITzZGN2g0?=
 =?utf-8?B?UVo5WndpSTVtWEZKMjBaNUQvSEYxMVdRV2gvMDVkd0REWHRHeEg4U1pHL0ls?=
 =?utf-8?B?UUVwSW5WTGpSQ0hQeDFnWHlaMzYzQklhQWpEZHREclhobk5xTnhrdExrY0Nj?=
 =?utf-8?B?eTZ6Y1krcnJwK3BIWHNocXpRR3RmZ1pRbmFrZUtJOWpadTZFUWNWUWZmVkpz?=
 =?utf-8?B?aU9CV2NBTWlOWkRDanRUT3ZZUndiaHphSzZRd1k2UG1BbGxyV05WTjBMY1M4?=
 =?utf-8?B?QkJCblhCYThBQk5udHBNcjFwUXBEbnBSNUc5UENkRll6aGJEMVVWYlFRRWVX?=
 =?utf-8?B?Z1VQS2FXcXp1RzUwVXZyYk9NeTdvTVpoeDQ1VWUrVnRHcnk3eWJpZHp6Q1or?=
 =?utf-8?B?cUd3V3p6eHM1WHM4dHNCc1pYSExDMkp1SUZqdTEzbDFGQ3I1aDVrdHBFeCtH?=
 =?utf-8?B?cmJ4bkZtWER6Ti9nMjVnc1N1NTYxTnNucGJkc05TOWt1dEVGdWpHMU9uK3Nm?=
 =?utf-8?B?MXV4TkpFOGcvWFVWbkJlcklhVkM1OHZuTCtRTEFEZXFFVm1kQXZhTmhnWXBP?=
 =?utf-8?B?MmJZR2J3WEplVHE3c2tEeFBCM2t3bW4vZWFnRTJ6RFh3S0x6QUI4WVBEWS85?=
 =?utf-8?B?dmZGZmoyZ3Qxd3lrUjVuZ0JFTXAySGlTMVJqNnRoOW1xYlIvTmc1Y2JiUVEw?=
 =?utf-8?B?ejUvU1NuK09UNGtjRndza1NnZUpSRElTRDdmdUVOVC93TEpuYXVWNWwxM3dV?=
 =?utf-8?B?K2gwZ2R0eXBRVDBua21rYU5mWVdqNFhubDJQczhGYm92UTFCdjd6Y2NoWTJK?=
 =?utf-8?B?ZFNWT056Z1lUSnBnSFFQMjFYQ1czR2xMR0VvWVZQL2l6MUt6K0NTeHdLY0JC?=
 =?utf-8?B?UTdMNGt4d3ZseFRsWHRsREpVMGxnWmc1VkI1RjRpdnRXZjZsTlUxcG9BbzNz?=
 =?utf-8?B?ZzRaY2JEeGxLeDZ4cEFnZHlDR2J2Ym5ZNGs2bDhaeCsyT0c1T1NZVkFubUU4?=
 =?utf-8?B?K0JoaWFDalE4U1hPNHJLRVg1dmw1NHhhbzVIcmtHY2dQeW96b0poTkhlNm8z?=
 =?utf-8?B?MEZjNEpiKzhxeTFmMS9KbVBEdGNlc0FpUWFGQUdIczA5UnY3VU5ZQnpTR2dh?=
 =?utf-8?B?c0ZlSnJlZ0NPQmtUT2lVS3ZDaHJyM3ppVklHUmVNRkRNQ01JQnFody9kWTJI?=
 =?utf-8?B?eTYvcWFqUlNOTlNHU2pEcE9Xb29BZXU2ZUoxTUJiNXJXaTloVTFPZUFwS0hV?=
 =?utf-8?B?S1dZQWQ0NjRuY3VheU5sQ1o4TDkydHIrV3BVZmZkTXB5MjdUNHpJNVhGSms1?=
 =?utf-8?B?SWdiazRFTHVNZ3plMjRlSHhaWWdyczdoQkMxVFhTMjluenZ1Y3l6K3NTaEdV?=
 =?utf-8?B?eC9HSkZHT3pBbnpYc2FqY2drUTdBQ1VESCt1WmpRNFQxZyt6UDJsY2VXcElh?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f80ac-fb2c-4bd0-d359-08db95c1b0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 14:38:52.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+ileZglcLpO9dSjWd3yuz5ll/39bfpmI2wv24QjcXbZe5MhSFb/HvVEm3aizdWL8nz0EzXexnjEr+Ta6GfXoeAz0YeSEGi27xpcvv9fGQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4gU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMiwgMjAyMyAyOjU4IFBNDQo+IA0KDQpbc25pcF0NCg0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9pdm0uYyBiL2FyY2gveDg2L2h5cGVydi9pdm0uYw0K
PiA+IGluZGV4IDI4YmU2ZGYuLjI4NTllYzMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaHlw
ZXJ2L2l2bS5jDQo+ID4gKysrIGIvYXJjaC94ODYvaHlwZXJ2L2l2bS5jDQo+ID4gQEAgLTMwOCw3
ICszMDgsOCBAQCBzdGF0aWMgYm9vbCBodl92dG9tX3NldF9ob3N0X3Zpc2liaWxpdHkodW5zaWdu
ZWQgbG9uZyBrYnVmZmVyLCBpbnQgcGFnZWNvdW50LCBibw0KPiA+ICAgCQlyZXR1cm4gZmFsc2U7
DQo+ID4NCj4gPiAgIAlmb3IgKGkgPSAwLCBwZm4gPSAwOyBpIDwgcGFnZWNvdW50OyBpKyspIHsN
Cj4gPiAtCQlwZm5fYXJyYXlbcGZuXSA9IHZpcnRfdG9faHZwZm4oKHZvaWQgKilrYnVmZmVyICsg
aSAqIEhWX0hZUF9QQUdFX1NJWkUpOw0KPiA+ICsJCXBmbl9hcnJheVtwZm5dID0gc2xvd192aXJ0
X3RvX3BoeXMoKHZvaWQgKilrYnVmZmVyICsNCj4gPiArCQkJCQlpICogSFZfSFlQX1BBR0VfU0la
RSkgPj4gSFZfSFlQX1BBR0VfU0hJRlQ7DQo+IA0KPiBEZWZpbml0ZWx5IG5lZWRzIGEgY29tbWVu
dCBoZXJlIChhbmQgYmVsb3cpIHRoYXQgc2xvd192aXJ0X3RvX3BoeXMoKSBpcw0KPiBiZWluZyB1
c2VkIGJlY2F1c2Ugb2YgbWFraW5nIHRoZSBwYWdlIG5vdCBwcmVzZW50Lg0KDQpBZ3JlZWQuDQoN
Cj4gDQo+ID4gICAJCXBmbisrOw0KPiA+DQo+ID4gICAJCWlmIChwZm4gPT0gSFZfTUFYX01PRElG
WV9HUEFfUkVQX0NPVU5UIHx8IGkgPT0gcGFnZWNvdW50IC0gMSkgew0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvc2V2LmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2V2LmMNCj4gPiBpbmRl
eCAxZWU3YmVkLi41OWRiNTVlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zZXYu
Yw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXYuYw0KPiA+IEBAIC03ODQsNyArNzg0LDcg
QEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgX19zZXRfcGFnZXNfc3RhdGUoc3RydWN0IHNucF9wc2Nf
ZGVzYyAqZGF0YSwgdW5zaWduZWQgbG9uZw0KPiA+ICAgCQloZHItPmVuZF9lbnRyeSA9IGk7DQo+
ID4NCj4gPiAgIAkJaWYgKGlzX3ZtYWxsb2NfYWRkcigodm9pZCAqKXZhZGRyKSkgew0KPiA+IC0J
CQlwZm4gPSB2bWFsbG9jX3RvX3Bmbigodm9pZCAqKXZhZGRyKTsNCj4gPiArCQkJcGZuID0gc2xv
d192aXJ0X3RvX3BoeXMoKHZvaWQgKil2YWRkcikgPj4gUEFHRV9TSElGVDsNCj4gPiAgIAkJCXVz
ZV9sYXJnZV9lbnRyeSA9IGZhbHNlOw0KPiA+ICAgCQl9IGVsc2Ugew0KPiA+ICAgCQkJcGZuID0g
X19wYSh2YWRkcikgPj4gUEFHRV9TSElGVDsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0v
cGF0L3NldF9tZW1vcnkuYyBiL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4gPiBpbmRl
eCBiZGE5ZjEyLi44YTE5NGM3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L21tL3BhdC9zZXRf
bWVtb3J5LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jDQo+ID4gQEAg
LTIxMzYsNiArMjEzNiwxMSBAQCBzdGF0aWMgaW50IF9fc2V0X21lbW9yeV9lbmNfcGd0YWJsZSh1
bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcywgYm9vbCBlbmMpDQo+ID4gICAJaWYgKFdB
Uk5fT05DRShhZGRyICYgflBBR0VfTUFTSywgIm1pc2FsaWduZWQgYWRkcmVzczogJSNseFxuIiwg
YWRkcikpDQo+ID4gICAJCWFkZHIgJj0gUEFHRV9NQVNLOw0KPiA+DQo+ID4gKwkvKiBzZXRfbWVt
b3J5X25wKCkgcmVtb3ZlcyBhbGlhc2luZyBtYXBwaW5ncyBhbmQgZmx1c2hlcyB0aGUgVExCICov
DQo+IA0KPiBJcyB0aGVyZSBhbnkgY2FzZSB3aGVyZSB0aGUgVExCIHdvdWxkbid0IGJlIGZsdXNo
ZWQgd2hlbiBpdCBzaG91bGQ/IFNpbmNlLA0KPiBmb3IgU0VWIGF0IGxlYXN0LCB0aGUgVExCIGZs
dXNoIGJlaW5nIHJlbW92ZWQgYmVsb3cgd2FzIGFsd2F5cyBwZXJmb3JtZWQuDQoNClRoZSBUTEIg
aXMgZmx1c2hlZCBhcyBsb25nIGFzIHNldF9tZW1vcnlfbnAoKSBhY3R1YWxseSBjaGFuZ2VzIHNv
bWUNClBURXMuICBJdCBkb2VzbuKAmXQgbWFrZSBhbnkgc2Vuc2UgdG8gYmUgZG9pbmcgYSBwcml2
YXRlPC0+c2hhcmVkIHRyYW5zaXRpb24NCm9uIHBhZ2VzIHRoYXQgYXJlbid0IG1hcmtlZCBQUkVT
RU5ULCBzbyBjbGVhcmluZyB0aGUgUFJFU0VOVCBiaXQgd2lsbA0KYWx3YXlzIGNoYW5nZSB0aGUg
UFRFcyBhbmQgY2F1c2UgdGhlIFRMQiB0byBiZSBmbHVzaGVkLiAgVGhlIGRlY2lzaW9uIGlzDQpt
YWRlIHNldmVyYWwgbGV2ZWxzIGRvd24gaW4gX19jaGFuZ2VfcGFnZV9hdHRyKCkgd2hlcmUgdGhl
IENQQV9GTFVTSFRMQg0KZmxhZyBpcyBzZXQuICBUaGUgZmx1c2ggaXMgZG9uZSBpbiBjaGFuZ2Vf
cGFnZV9hdHRyX3NldF9jbHIoKSBiYXNlZCBvbiB0aGF0DQpmbGFnLiAgVGhlIGRhdGEgY2FjaGUg
aXMgKm5vdCogZmx1c2hlZC4NCg0KQWxzbywgZXZlbiBpZiB0aGUgbWVtb3J5ICp3YXMqIGFscmVh
ZHkgbm90IFBSRVNFTlQsIHRoZW4gdGhlIFBURXMNCndvdWxkIG5vdCBiZSBjYWNoZWQgaW4gdGhl
IFRMQiBhbnl3YXksIGFuZCB0aGUgVExCIHdvdWxkIG5vdCBuZWVkDQp0byBiZSBmbHVzaGVkLg0K
DQpNaWNoYWVsDQoNCj4gDQo+ID4gKwlyZXQgPSBzZXRfbWVtb3J5X25wKGFkZHIsIG51bXBhZ2Vz
KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gICAJbWVt
c2V0KCZjcGEsIDAsIHNpemVvZihjcGEpKTsNCj4gPiAgIAljcGEudmFkZHIgPSAmYWRkcjsNCj4g
PiAgIAljcGEubnVtcGFnZXMgPSBudW1wYWdlczsNCj4gPiBAQCAtMjE0MywzNiArMjE0OCwyMyBA
QCBzdGF0aWMgaW50IF9fc2V0X21lbW9yeV9lbmNfcGd0YWJsZSh1bnNpZ25lZCBsb25nIGFkZHIs
IGludCBudW1wYWdlcywgYm9vbCBlbmMpDQo+ID4gICAJY3BhLm1hc2tfY2xyID0gZW5jID8gcGdw
cm90X2RlY3J5cHRlZChlbXB0eSkgOiBwZ3Byb3RfZW5jcnlwdGVkKGVtcHR5KTsNCj4gPiAgIAlj
cGEucGdkID0gaW5pdF9tbS5wZ2Q7DQo+ID4NCj4gPiAtCS8qIE11c3QgYXZvaWQgYWxpYXNpbmcg
bWFwcGluZ3MgaW4gdGhlIGhpZ2htZW0gY29kZSAqLw0KPiA+IC0Ja21hcF9mbHVzaF91bnVzZWQo
KTsNCj4gPiAtCXZtX3VubWFwX2FsaWFzZXMoKTsNCj4gPiAtDQo+ID4gICAJLyogRmx1c2ggdGhl
IGNhY2hlcyBhcyBuZWVkZWQgYmVmb3JlIGNoYW5naW5nIHRoZSBlbmNyeXB0aW9uIGF0dHJpYnV0
ZS4gKi8NCj4gPiAtCWlmICh4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX3RsYl9mbHVzaF9yZXF1aXJl
ZChlbmMpKQ0KPiA+IC0JCWNwYV9mbHVzaCgmY3BhLCB4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX2Nh
Y2hlX2ZsdXNoX3JlcXVpcmVkKCkpOw0KPiA+ICsJaWYgKHg4Nl9wbGF0Zm9ybS5ndWVzdC5lbmNf
Y2FjaGVfZmx1c2hfcmVxdWlyZWQoKSkNCj4gPiArCQljcGFfZmx1c2goJmNwYSwgMSk7DQo+ID4N
Cj4gPiAgIAkvKiBOb3RpZnkgaHlwZXJ2aXNvciB0aGF0IHdlIGFyZSBhYm91dCB0byBzZXQvY2xy
IGVuY3J5cHRpb24gYXR0cmlidXRlLiAqLw0KPiA+ICAgCWlmICgheDg2X3BsYXRmb3JtLmd1ZXN0
LmVuY19zdGF0dXNfY2hhbmdlX3ByZXBhcmUoYWRkciwgbnVtcGFnZXMsIGVuYykpDQo+ID4gICAJ
CXJldHVybiAtRUlPOw0KPiA+DQo+ID4gICAJcmV0ID0gX19jaGFuZ2VfcGFnZV9hdHRyX3NldF9j
bHIoJmNwYSwgMSk7DQo+ID4gLQ0KPiA+IC0JLyoNCj4gPiAtCSAqIEFmdGVyIGNoYW5naW5nIHRo
ZSBlbmNyeXB0aW9uIGF0dHJpYnV0ZSwgd2UgbmVlZCB0byBmbHVzaCBUTEJzIGFnYWluDQo+ID4g
LQkgKiBpbiBjYXNlIGFueSBzcGVjdWxhdGl2ZSBUTEIgY2FjaGluZyBvY2N1cnJlZCAoYnV0IG5v
IG5lZWQgdG8gZmx1c2gNCj4gPiAtCSAqIGNhY2hlcyBhZ2FpbikuICBXZSBjb3VsZCBqdXN0IHVz
ZSBjcGFfZmx1c2hfYWxsKCksIGJ1dCBpbiBjYXNlIFRMQg0KPiA+IC0JICogZmx1c2hpbmcgZ2V0
cyBvcHRpbWl6ZWQgaW4gdGhlIGNwYV9mbHVzaCgpIHBhdGggdXNlIHRoZSBzYW1lIGxvZ2ljDQo+
ID4gLQkgKiBhcyBhYm92ZS4NCj4gPiAtCSAqLw0KPiA+IC0JY3BhX2ZsdXNoKCZjcGEsIDApOw0K
PiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gICAJLyogTm90aWZ5
IGh5cGVydmlzb3IgdGhhdCB3ZSBoYXZlIHN1Y2Nlc3NmdWxseSBzZXQvY2xyIGVuY3J5cHRpb24g
YXR0cmlidXRlLiAqLw0KPiA+IC0JaWYgKCFyZXQpIHsNCj4gPiAtCQlpZiAoIXg4Nl9wbGF0Zm9y
bS5ndWVzdC5lbmNfc3RhdHVzX2NoYW5nZV9maW5pc2goYWRkciwgbnVtcGFnZXMsIGVuYykpDQo+
ID4gLQkJCXJldCA9IC1FSU87DQo+ID4gLQl9DQo+ID4gKwlpZiAoIXg4Nl9wbGF0Zm9ybS5ndWVz
dC5lbmNfc3RhdHVzX2NoYW5nZV9maW5pc2goYWRkciwgbnVtcGFnZXMsIGVuYykpDQo+ID4gKwkJ
cmV0dXJuIC1FSU87DQo+ID4NCj4gPiAtCXJldHVybiByZXQ7DQo+ID4gKwlyZXR1cm4gc2V0X21l
bW9yeV9wKCZhZGRyLCBudW1wYWdlcyk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQg
X19zZXRfbWVtb3J5X2VuY19kZWModW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMsIGJv
b2wgZW5jKQ0K
