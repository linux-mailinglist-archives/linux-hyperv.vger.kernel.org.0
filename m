Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090F16DB676
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Apr 2023 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDGW2t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGW2r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 18:28:47 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020019.outbound.protection.outlook.com [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27D93C2;
        Fri,  7 Apr 2023 15:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNiChBE077tK69c/9Mg5Hfx56yb5CVo9tlHhv2n1OACfXsZHyPPhxp7NtQvqyJw/QfCPHIEKV/60uDcZ5pnhrQqZjfeve6lhGMfXruK6hKy6JnHtQ5bqaXsQASzrUygn5SUjIS+s79qV74GCu1i/S50pNSok8N/rREfSFmRyyHGz3Z1hhuBOHcua0ZSEwiYnLbd3HyWMXXQ0reDihgdU4kP1ZAySyIe0aUmAw/L4qVRDn+wwnKLFzSvcLEUBfYVxDKHkdmskLn9/LYSYptOlXPKttKtaEgDFe6JFdKwEWh4MER1il9F5NuIt7ZxEVwLd+7APdjnFMLGRc2dZ2sY0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS0yUQzC2DmPXHFWCfBFDcvMH4y22ojxblAc9BBAtgw=;
 b=nCPyEXRhwDc5+0VzK0AAsNWJRswrJntnM2spA9qrZcwtEfwvC9GchPRAvnAzxDsYpXeOeX2ZoG9NTuZ+yFEuCbQX3V+uWjyK/C8obd88zJdZ6BW1G+qDZ2y8a9fa56IBi2fQZn2RVguUB9GetMcZalZvyMpYmgJ5s5J/n4JuhYwNJj914RFGpjzeWFJF2JOJ0MPc76rQ+cjF7voDC1dc/3yi2eWlEs4NKzF1VMwGKSKBhHFjBNw9wghggjURd4tRK7E4/g06q4ym/w7t0YeQ/kg3dP/EzRzh9YBojDGFspZYsdXOSxIP1/GF86IJspAI1mEImcwhIN53PTWnY1SzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS0yUQzC2DmPXHFWCfBFDcvMH4y22ojxblAc9BBAtgw=;
 b=DoJEzUELXdz2AMUTqbGmWLvcVtfL+NEJPtlo14P6/At5Oq6dhxJtEKUUy+ycFg+r/B/YsJpjulHTJIEBQ+XTZP+5fVffQe48fRB3bWaDH61867ftRUIzmtN5DBoCRJpM0y/yiHcmbDEmcWgOq6Vk9VVVvml9u7fh+Du+nDfpXw4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3112.namprd21.prod.outlook.com (2603:10b6:208:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.20; Fri, 7 Apr
 2023 22:28:42 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 22:28:42 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Olaf Hering <olaf@aepfle.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: Use nested hypercall for post message and
 signal event
Thread-Topic: [PATCH] Drivers: hv: Use nested hypercall for post message and
 signal event
Thread-Index: AQHZZoNBcj3NgoofJEmlKiJme92Gf68atREAgACq2YCABQ24cA==
Date:   Fri, 7 Apr 2023 22:28:42 +0000
Message-ID: <BYAPR21MB168809AA23D4CF7DA748CE55D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680564178-31023-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20230404084530.2b9ca791.olaf@aepfle.de>
 <e2a7504a-738d-f271-0a23-6d831af75936@linux.microsoft.com>
In-Reply-To: <e2a7504a-738d-f271-0a23-6d831af75936@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4ef4b7a9-9ef7-432e-b6bb-0f4edd0a0f27;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T22:07:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3112:EE_
x-ms-office365-filtering-correlation-id: 9b1d908c-9069-4c78-a7fb-08db37b7716b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jkv+ZRf60dFq8qC7zt/U38xV2C5tYZZzsqcPIvfRsrgiXY/HFpRFlidY/YAzkvzc9nIiy4dfOz5LNa0MddLvZ7euRC3OhbZE9tqkEeBueClquBx5WpKf1rxXfLCrPnbj7AGv/EICvjqWbJtWY5+LPFaUVwj6QrGY/iMrKB5lK0fMDKwXxq2225W2qHqqNGwZX2dIn2O7gJo0A9xOc7kL8joHuvSq6nhzfZ7qLx0a9H+JD9HTO6Opy9hBe2MeLIpVZ1aUJIyNqBQBPBGmhR966YoYLxphirYSz2dMymU85TejZdxVDv2KB3KcXkciISyH/yjYRwFmtTIxcxVNBOZ/1J+Fw+wLseoT80fITYbcfcM2YXRZX+5nyrScfzBwolh6NRhy4pUhoMfOLcMzx7Vo4AAd3CXFTovZGNv18YlG/g0aGBPgb/kn9bL6zy8IVnOlTnrI7ogLcHqOiaUyuQF0YtgtbdFPL8qr1KyUQtN07HVRUvnhuSnBmvwC4H7zHxI+bRLmeDLBJlgWJbGJvabAyQNW1QWeTAaiBNQT3BHIUAxHzfcJDhkszwkPuyvbCWHZHtp9jf5bmZRgdcFEpiT4KcpdyLumCZAQZSbaxodnIfxiRbZJcDSoiwFud2OhZwijUQxO1GExVcx2kWu3RRVx8EZDNUJHCNtzVhiza5ZZTsw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(110136005)(86362001)(316002)(53546011)(66476007)(8936002)(2906002)(8676002)(786003)(52536014)(8990500004)(41300700001)(7696005)(38070700005)(4326008)(71200400001)(64756008)(66446008)(66556008)(66946007)(55016003)(76116006)(33656002)(478600001)(5660300002)(10290500003)(54906003)(38100700002)(82960400001)(107886003)(122000001)(6506007)(9686003)(26005)(186003)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ZISStHNVJkSHhFRnQxRW93anZHQXIrK0l1SmhTazZBOU9jV3k3eEl3U2o4?=
 =?utf-8?B?ZG1QN3hnMHk0ZURwaTF1OHRodkJ5R3VOSlZMWlJScGpXZ0Zyb09UQXhrWWZr?=
 =?utf-8?B?UUlGaU1NaFRzWFJCUUNQaGRXRHZFZkdrTVcrN241Y1lXNVlFbXZKVnB4RFhv?=
 =?utf-8?B?Q3BSU1NZakttVnk1RGNMVVlhU0RFNG9PM01VQW9tUVVTOWVZTkc2YWRaSHp0?=
 =?utf-8?B?QUdybFVmWVZVUktmVitIc3QrbEZHM21nWEcvbDI0R1cySVNuZUEvTVd0OXpp?=
 =?utf-8?B?VEVJWFFoL3RHTlRyS0FIZVhZNmFnZTZsdzAvY3VKdHk4VklKTDcxLzZaV3Fy?=
 =?utf-8?B?ZDdsZXdsYnNFSk5yUGNtVzc5OEdYTW9UNmN3WE9UMnZCcG9MaFBGRDVsUHdT?=
 =?utf-8?B?OUpvZ3hILzFJRktTQXdRN1dXSS9QWks1ZjY1Z2FNNGo0MFhOQ3BieW5WcTN5?=
 =?utf-8?B?MXU3MTlaUFlIQnBBMUlncitLRDhQSkxYb0o4MGlpSnFjUmdZcGFPbVZ4MEQ2?=
 =?utf-8?B?Wm9RMkRUVm9JV09mdlp2c3RnUG1pMVNaRE9GQ1BNazFieDJlK2RvMjdrYnVI?=
 =?utf-8?B?OEFjMks3aUlMcitGU0h5OFMzM0NvMkpMQldCeDViVU93Yk1MelpNMzZBVEZG?=
 =?utf-8?B?UEZYQStrY3VJUGlxU2UxMHFNRng0cUh0T3Q4WnBxaDBHWkltSWMwQmg1djAz?=
 =?utf-8?B?ZnhCR0M3eHI5WkY4enlTekRiUThmYzZEV1FYdTE3R2IxZHBHb01PMXFNMGpl?=
 =?utf-8?B?eWhkejFCU24vNFc3bmZYMnAzZVUwSXk3ME13WGozOTNMMkhRWmNrbjUwRGI4?=
 =?utf-8?B?czFGUUx3S1F6RzJnQlhjOHZlT2FDdlRub1FibkZJeDRoVkV2eThidGZ2NHIz?=
 =?utf-8?B?VXV1NmRCbGxYczUyWGNhbkI5Y2lsN094dFpIbS9yZjdMSkUzQzRSeDdnUHlk?=
 =?utf-8?B?YVF6VnROZE54L0UzMnhDVU9SZWNNc1BIb040U2FoM0FPQjFXNjlHVWVuR1ZC?=
 =?utf-8?B?L0dseWk0S2FyZXo1UHlyV0ROREVaZHZhN1ZMem5mekV0cFJneFowMmlaVzRU?=
 =?utf-8?B?WFJsYk54TWFVZ3pXZ0xCNzRGTnhZS1Byb0RzWFJubHFiRVZXc3lvcTVTV2NO?=
 =?utf-8?B?QVhsR0xKbzl6L2ttbVFjNktCdXV2MVlZRnVoZmRVM3FKbnN0NWUxSnJNZy9o?=
 =?utf-8?B?cXBTUlEvZWZmU2tGZlZZQUpza0Q5MS9jTUM4QmNMSURhUlVUcktiWDhzOTlN?=
 =?utf-8?B?UFlwU3kyVUg2Q0tKVWZyUEFUanp5WWVvNmhBZWFxQXpBaEJNbFZHbFM1WFlo?=
 =?utf-8?B?ODUvSGVOSytFWlllRm5jZjlFWHZIa2twVi9XK1o0UmJyNkxQTjUyL0xidElr?=
 =?utf-8?B?NW9tVzA3cExsQk14Qm1FOUp1WW96R0ZIcTU3aTB2UGhUZDJSUlo0RGlXZUtO?=
 =?utf-8?B?ZFdwUDB2eC9ZSWNqNVJyNFFpTmZGU1NvWWJHc3JsZ2c2eXo2RGVlY0dmTDdv?=
 =?utf-8?B?ZS9xRE8rK21TTXdIK0tLd3BFYmRYT3ZoTzUyUUEvcUJqbDR4S2g5ek52MmVX?=
 =?utf-8?B?Qk11b0llV3dTc3VtUkczdlgvdkxaL0FEUmlSN2tzelp2UVdyVXJGREdRczU3?=
 =?utf-8?B?cW9WNTVEbHFqY2thTW54QnFaNGZqeSszVFFaejQ1d05FNWFLWWc3dWd2Mm5Y?=
 =?utf-8?B?cW1Pc0plbVRCMUNMTGVIWlYxNVI4RE9aeG14aWUvVEo4UnVLdUxmclNiZ2lK?=
 =?utf-8?B?cE1vNXJBWW14bUN0R05QYVgzZUVlMThqNE5Sc1AxTDk5SmtMVDd5dDFIVSth?=
 =?utf-8?B?SXh3dUhmSXlaeElHOXpvYXorMHpHUklEUVZodnplV0NrR3c5NjlLeFBlSHFF?=
 =?utf-8?B?bGtuRStJdHhzamFkOVdmKzNFRGRuT2ZqTmUwcTN4aGpadm4yVFp6UXFUZHR6?=
 =?utf-8?B?cmcwTnZEUHJLc1NZMzU4RXlVWExRWTdCZDdRN1JkLzRPdjgvVEVwa2tyUlAw?=
 =?utf-8?B?MzlDZE40YlhMUlB1aVloVkdzVStLL2UxYno5Sm5QYUpsVEwxOCs1cXRXUzdo?=
 =?utf-8?B?aEF6Z293OFNvenBZM0Y0UXd3NGR6NnAyTE5sQ1pobGVtQXpHbVdUTU8venVG?=
 =?utf-8?B?VU5HWDI0WVU1U3ByNVBGMmpjWng1UWRIV3Bvd0FnWlR2MVNCNUpWdWtoNFlJ?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1d908c-9069-4c78-a7fb-08db37b7716b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 22:28:42.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOj6rfcrdEMk/eHKS6ESIEcey/7QZoKiOjb5g1/b+kTmhxO5SDVuI5TfyGfv/sLZ2WdgtYxr28v27zUhH9VtHnBMK9vTftA6ETi68QQ+XLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3112
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUdWVzZGF5LCBBcHJpbCA0LCAyMDIzIDk6NTcgQU0NCj4gDQo+IE9uIDQvMy8yMDIzIDEx
OjQ1IFBNLCBPbGFmIEhlcmluZyB3cm90ZToNCj4gPiBNb24sICAzIEFwciAyMDIzIDE2OjIyOjU4
IC0wNzAwIE51bm8gRGFzIE5ldmVzDQo+IDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNv
bT46DQo+ID4NCj4gPj4gT25seSByZWxldmFudCBmb3IgeDg2OyBuZXN0ZWQgZnVuY3Rpb25hbGl0
eSBpcyBub3QgYXZhaWxhYmxlIGluIEFSTTY0Lg0KPiA+DQo+ID4+ICsjaWYgZGVmaW5lZChDT05G
SUdfWDg2XzY0KQ0KPiA+PiArCWVsc2UgaWYgKGh2X25lc3RlZCkNCj4gPg0KPiA+IFNob3VsZCB0
aGVyZSBiZSBhIGh2X25lc3RlZCBpbiB0aGUgQVJNNjQgY29kZSBwYXRoPw0KPiA+IExvb2tzIGxp
a2UgYzRiZGY5NGY5N2M4NiBwcm92aWRlZCBzdWNoIHRoaW5nLCBzbyB0aGUgS2NvbmZpZyBjb25k
aXRpb25hbCBjb3VsZCBiZQ0KPiByZW1vdmVkLg0KPiA+DQo+ID4gT2xhZg0KPiANCj4gVGhpcyB3
aWxsIG5vdCBjb21waWxlIG9uIEFSTTY0IHdpdGhvdXQgdGhlIGd1YXJkLCBiZWNhdXNlIGh2X2Rv
X25lc3RlZF9oeXBlcmNhbGwNCj4gYW5kIGh2X2RvX2Zhc3RfbmVzdGVkX2h5cGVyY2FsbDggYXJl
IG5vdCBkZWZpbmVkLg0KPiBUaGVzZSBhcmUgaW5saW5lIGZ1bmN0aW9ucyBvbmx5IGRlZmluZWQg
aW4gdGhlIHg4NiBtc2h5cGVydi5oIGhlYWRlci4NCj4gDQo+IFRoZSBhbHRlcm5hdGl2ZSB0byB0
aGVzZSBndWFyZHMgd291bGQgYmUgZGVmaW5pbmcgZHVtbXkgaW5saW5lIGZ1bmN0aW9ucyBmb3Ig
dGhlDQo+IG5lc3RlZCB2ZXJzaW9ucyBvZiBodl9kb19oeXBlcmNhbGwgaW4gdGhlIEFSTTY0IG1z
aHlwZXJ2LmguDQo+IEkgY291bGQgdGFrZSB0aGF0IGFwcHJvYWNoIGlmIGl0IGlzIHByZWZlcmFi
bGUuDQoNCkhhdmluZyB0byBkbyAiaWYgKGh2X25lc3RlZCkiIGFuZCAiI2lmZGVmIENPTkZJR19Y
ODZfNjQiIGF0IG11bHRpcGxlIGNhbGwNCnNpdGVzIGlzIGluZGVlZCByYXRoZXIgbWVzc3kuICBJ
IHdvbmRlciBpZiBpdCBpcyBmZWFzaWJsZSB0byBmb2xkIGFsbCB0aGlzIGxvZ2ljIGludG8NCnRo
ZSB4ODYgdmVyc2lvbiBvZiBodl9kb19oeXBlcmNhbGwoKSBhbmQgZnJpZW5kcywgc28gdGhhdCB0
aGUgY2FsbCBzaXRlcyBhcmUgbm90DQphZmZlY3RlZD8gIFRoYXQncyB3aGF0IHdhcyBkb25lIHdp
dGggaHZfZ2V0L3NldF9yZWdpc3RlcigpLiAgQW5kIGl0IHdvdWxkDQphbGxvdyB0aGUgQVJNNjQg
c2lkZSB0byBiZSB1bmNoYW5nZWQuDQoNCkhlcmUncyBhbiBhcHByb2FjaDoNCjEpICBDcmVhdGUg
YSBnbG9iYWwgYml0bWFwIHdpdGggb25lIGJpdCBmb3IgZWFjaCBoeXBlcmNhbGwgY29kZSB0aGF0
IEh5cGVyLVYNCmFjY2VwdHMuICBUaGUgbWF4IGlzIHNvbWV0aGluZyBsZXNzIHRoYW4gNTEyLCAg
c28gdGhpcyBiaXRtYXAgaXMgbGVzcyB0aGFuIDY0DQpieXRlcy4gIEluaXRpYWxpemUgdGhlIGJp
dG1hcCB0byBhbGwgemVyb3MuDQoyKSAgRHVyaW5nIGVhcmx5IGluaXRpYWxpemF0aW9uLCBpZiBo
dl9uZXN0ZWQgaXMgc2V0IHRvICJ0cnVlIiwgc2V0IHRoZSBiaXQgaW4NCnRoZSBiaXRtYXAgY29y
cmVzcG9uZGluZyB0byBoeXBlcmNhbGxzIHRoYXQgbmVlZCB0aGUgSFZfSFlQRVJDQUxMX05FU1RF
RA0KZmxhZyBhZGRlZC4NCjMpIEluIGh2X2RvX2h5cGVyY2FsbCgpLCB1c2UgdGhlIGh5cGVyY2Fs
bCBjb2RlIHRvIGluZGV4IGludG8gdGhlIGJpdG1hcCBhbmQNCnJldHJpZXZlIHRoZSBiaXQuICBV
c2UgdGhhdCBiaXQgdG8gZGVjaWRlIHdoZXRoZXIgdG8gc2V0IEhWX0hZUEVSQ0FMTF9ORVNURUQu
DQpOb3RlIHRoYXQgaHZfbmVzdGVkIGRvZXNuJ3QgZXZlbiBuZWVkIHRvIGJlIHRlc3RlZCBiZWNh
dXNlIHRoZSBiaXRtYXAgd2lsbA0KYmUgYWxsIHplcm9zIHdoZW4gaHZfbmVzdGVkIGlzICJmYWxz
ZSIuDQoNClRoZSBvbmUgc25hZyBpcyBleHRlbmRlZCBoeXBlcmNhbGxzLCBmb3Igd2hpY2ggdGhl
IGh5cGVyY2FsbCBjb2RlIGlzIGEgbXVjaA0KYmlnZ2VyIHZhbHVlLCBhbmQgd2UgbWlnaHQgbm90
IHdhbnQgdG8gbWFrZSB0aGUgYml0bWFwIHRoYXQgYmlnLiAgTWF5YmUNCnRoZXkgaGF2ZSB0byBi
ZSBzcGVjaWFsLWNhc2VkIHRvIGJlIG5vbi1uZXN0ZWQuDQoNClRoaXMgYXBwcm9hY2ggYXNzdW1l
cyB0aGF0IGEgaHlwZXJjYWxsIGlzIGFsd2F5cyBlaXRoZXIgbmVzdGVkIG9yIG5vbi1uZXN0ZWQN
CmZyb20gYWxsIGNhbGwgc2l0ZXMuDQoNCklmIHRoZSBiaXRtYXAgYXBwcm9hY2ggaXMgdG9vIG9i
c2N1cmUsIHRlc3RpbmcgaHZfbmVzdGVkIGFuZCBkb2luZyBhIHN3aXRjaA0Kc3RhdGVtZW50IHRv
IGhhbmRsZSB0aGUgY2FzZXMgdGhhdCBuZWVkIEhWX0hZUEVSQ0FMTF9ORVNURUQgd291bGQNCmFs
c28gd29yay4gIFRoZSBwZXJmb3JtYW5jZSBwcm9iYWJseSB3b3VsZG4ndCBiZSBhcyBnb29kLCBi
dXQgaXQgcHJvYmFibHkNCmRvZXNuJ3QgbWF0dGVyLiAgQWdhaW4sIHRoaXMgd291bGQgYmUgbGlr
ZSBodl9nZXQvc2V0X3JlZ2lzdGVyKCkuDQoNCldpdGggdGhpcyBhcHByb2FjaCwgaHZfZG9fbmVz
dGVkX2h5cGVyY2FsbCgpIGFuZCBmcmllbmRzIGFyZSBub3QgbmVlZGVkLA0KYnV0IEkgZG9uJ3Qg
a25vdyB3aGF0IG90aGVyIHVzYWdlIHBhdHRlcm5zIGZvciBodl9kb19uZXN0ZWRfaHlwZXJjYWxs
KCkNCm1pZ2h0IGJlIHBsYW5uZWQuICBUaGVzZSBvdGhlciB1c2FnZSBwYXR0ZXJucyBtaWdodCBt
YWtlIHRoaXMgaWRlYSBub3Qgc28NCndvcmthYmxlLg0KDQpNaWNoYWVsDQo=
