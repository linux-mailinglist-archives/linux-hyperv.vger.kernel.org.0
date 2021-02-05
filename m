Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51C311164
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBER5x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 12:57:53 -0500
Received: from mail-dm6nam12on2110.outbound.protection.outlook.com ([40.107.243.110]:7904
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233557AbhBERzD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 12:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjGA+pQW5CDwTKNzW3FiHIrbKTxvGQxwdFuL90swrAOMl160eW8sClC8nnO1ta6J3gt+aI5ogCW3zHJKxrKlxCmPz0mUwo4tFIUzhYqewwpkZdnXytGSNpkFLyuZCfIEYHBYXaZ0Yx3M+BTmrdy0H/qibxSDhH2YXpCIclc3is9fPRjbmuSw1zbUKNS9jVXGVcx5ncr5BBo8zzvoIfb2KEoDFJy9Z3sqXoJbCMwtXcBqzdg+xxapqLuhUVVZbvgOR76KeSsMGQ4WlKKXVJGSftaYPGxuhy3qzDhbfFFY9xoMzgfZab3bU9nsKItn1fqPReJ6efmV7ZCFOtrdt26GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC9F0+KDt53W+gws6ZqdHg3qRQUCVk3gVMxVB+iHR1c=;
 b=eY/vRgJ8YO1mW/Ws0n3zm//x7Fkkawumt1uknjlGYmtZBw7nGVTC6UpzDyKRUHAOK50nWHKGjY5Un5BkX68yeuxl71akpWkJ51m5DoedeIZZwP8956JsZ4YR8pMOVwFFfdym28jEKFC0Q2zkfYtP9I/XPxWMug4yz8baw9Xt6xyUokafyc3q+ALH6hsrrhWaxutzzBn3mKoskVin6uyFNtsmGLNIO43t+I2kzNSue2FQqsQZqMByGT4kyf/5xd0lwdatpwe88ZslTA6BEoh4aSo7jxtCP4Y4HXPgq2X2UQXtnEgf51NrjCrPXaOldRpkH07ThO0q9r98EsPdJKsdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC9F0+KDt53W+gws6ZqdHg3qRQUCVk3gVMxVB+iHR1c=;
 b=N5kb74xpu5TGIPgLDXQK6GkaAxAjaVL7TaM27pJEeZZMAJewWHDva8aWv8WZ0fj3X+gS9XrK2JPI1QU/W4/Z/v0Mq924mgq/0rjKun3cyMVTAn6Wn0aCUH+piCooYYRSQ0BzBcZDZAmIDT/zaxRZNnesWNkxXKIW4iDIq/gPO4o=
Received: from (2603:10b6:302:8::15) by
 MW2PR2101MB1067.namprd21.prod.outlook.com (2603:10b6:302:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.3; Fri, 5 Feb
 2021 19:36:34 +0000
Received: from MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de]) by MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de%7]) with mapi id 15.20.3846.003; Fri, 5 Feb 2021
 19:36:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Leandro Pereira <Leandro.Pereira@microsoft.com>
Subject: RE: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Topic: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Index: AdbQHxbRjXJd8DrBQaCk5mureoGP6groIEYAAA2Kt1A=
Date:   Fri, 5 Feb 2021 19:36:34 +0000
Message-ID: <MW2PR2101MB1787B5253CAA640F8B7D2860BFB29@MW2PR2101MB1787.namprd21.prod.outlook.com>
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
 <CAJZ5v0jRgeAsyZXpm-XdL6GCKWk5=yVh1s4fZ3m0++NJK-gYBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jRgeAsyZXpm-XdL6GCKWk5=yVh1s4fZ3m0++NJK-gYBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=468f7eb2-13d7-4308-9838-799f7e25e6f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-05T19:33:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd82d585-9491-424f-d220-08d8ca0d5896
x-ms-traffictypediagnostic: MW2PR2101MB1067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1067E3E99FF41EC4C9A72B8CBFB29@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiCP4eA1BO52zGBuGDi7amKR3/IQ+diJMcuHxYQaRm+4zT4LGoOSSq4K0yoTFFZ8zSTdaKzzb6mKWzEEkNj6p3UXo5x/pZvGT7tpTVTtWuUzeXo3OWkkJqw8iSkvcQJXfrVVNFKGL9oDMY9uhtScX1bLlm5rVYqdkXtZJsJp3bLjSyDSOAy7Q577ZChnOLnjM2tQ891SiC89pzzjXtyWDAVUqam3uO09NXg0QY1usxtViBcTftb1XucYts7UXxsaVSP9byIwQ7gvqQ6schcMNWwTdq7k4Fz2n38BiewuKv56ozgVeBCkxbyZUnvEyoJqyc6nAGwV/4LIxnAoEj/lF6Q6TkwkLgCrnCYM0Oi2KOAnp0ZaR6E1cnMy0U92539XadWmGlM8QkvCsq2N5JM1PfYmEOH9uQF3mb9CS/dqwo7eRGhHm3moFFd2TO/K34bEOe5LmqT24V01580oTyEqyR0u6ADnk/BFidAH4c4x0GhXpQjx8b8iVo1L1c/AUGwP4CYMma73bNhubdw04XGZYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1787.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(6916009)(4326008)(82960400001)(8676002)(82950400001)(9686003)(66446008)(71200400001)(76116006)(15650500001)(66476007)(66946007)(316002)(66556008)(33656002)(10290500003)(2906002)(64756008)(186003)(54906003)(86362001)(5660300002)(7696005)(83380400001)(6506007)(8936002)(8990500004)(478600001)(53546011)(107886003)(52536014)(55016002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZGVLQWRsN2YvbEJWdlh6TEVjSmV4WlNGVThxRDREOHh6NFo3Rlh6WXNMREpC?=
 =?utf-8?B?WWtHWVBpK1FxVVIxMklhcDc5WHhMWkR3UEwrWG1iWkZEVTZ3R0c0ZzhLd0VH?=
 =?utf-8?B?aFMzODRtb0pURE9GMXFZaWo0di9HSFRiazVncGs4ODNBSU9HYzZ0QWZTWURu?=
 =?utf-8?B?RWppektWYkc1TkZjVHZ2ODZVRXdKbHpOM3IvR2trYTl1WFB1Zm1Jczd1Z3Nk?=
 =?utf-8?B?OTg3eXVMM0I1bkF2WG9VbmhqSTgwcGZXRkJTWTJzUnJEQnY0MTVQelNRUXBJ?=
 =?utf-8?B?T0szUzlsdllsUWRGL2RCWW1TSDlOQmtWaWxaQmFBZElFRjFRQUpOU3dNa0pS?=
 =?utf-8?B?cmhhcnh1cTJ3N3RIRVpYWkNYNTJVTHVrcE05Sk1taUZ5eFd3VG4yRWpmMHMw?=
 =?utf-8?B?aXN5VEJ0dEJPVENuQXJubitFci8yOGlJajYxcExPR2FqQ0tMSkM2YzYxbmFH?=
 =?utf-8?B?SlUwOHo3RXJ6c1F2OHdHSDNsbERXRk5IWFcvSUFwbGJxamszSmZydkFoQ1dI?=
 =?utf-8?B?alZkT2t2NzJxUFZrR01BRmR3WUFPQWtCaEthdTRLQTR5RWhzcU9RU2RiNGhW?=
 =?utf-8?B?cUJTdnpIMnFCc2RDWVJrck9ZMzZSanVKYmV2anRHTWdZaXpNb1NJUkY1dUc3?=
 =?utf-8?B?TitTUUFvR0tESVEvay9NTWNsdFV2c05NenZjSW8rSmRkM2dXTEVMTnlNSnRQ?=
 =?utf-8?B?QjdJSmkrWXRqNFJKTm5od1Z1R1lNOE43cTgzc1BBekE2dFJaaW44Q3pCcFYv?=
 =?utf-8?B?aDRucEJJWkljRTVKZERob0F0blFiWmpWV1M1Z3FobWpRZ05HRHU5YmNTalow?=
 =?utf-8?B?eW9iS3A1WWxBdzJGVGtCSldUdEQ4ay9PSElDU1RYL1VOcGhXTU1lWnU4eEpU?=
 =?utf-8?B?RkJXdkk1QzFOSFZjWSsvU0JqUGN4TG4zUDN6cUlqeWhpM0ZjODJPRWx4VFdQ?=
 =?utf-8?B?MkhYTUlTWFhDak9yZW5pYnIxTjg0aVdJV0RxaExaVmg0bFF2NVN1UndBT29Z?=
 =?utf-8?B?STd5NjBMNkRMRjMvY1R1NER6UTZHQTVkNHgxWlVNK2dXd1IwSnM1VGcySjJU?=
 =?utf-8?B?Y04wcnRqay90YkZjSXlOWXgwQmFMNDcwRk5UVlpPY1VXWm5lR0RUUGV5N1Iw?=
 =?utf-8?B?UlZZNmd3eDA2VUs5d0lqU25DaE9jNWN3aCsxMldvVlZsUytnSGtjMktxMnpQ?=
 =?utf-8?B?OEdYSUczcVd1TEVhbDhjZW9XSGUxWWppMXNzVldDS3J5cDJSbzFNckhxNHNX?=
 =?utf-8?B?WWtxeWFlamtkTlJ1MDRzelNIckdBeVhhd0xZeFdBWkFkSEs1QUUrUEM4aExh?=
 =?utf-8?B?VU5TRmhxUjhDUUV4QkJYdWlpV0lxU2tuZlQyWnNDeVdueFFvblB1NHNPQTFI?=
 =?utf-8?B?MWJ5TU9YemRjWEw5Y2ZsYUx1TjdMT1BFUENjUTRxRHFueGdYdEFvaUNBeUsv?=
 =?utf-8?B?ZUpZQThkVXRNSWIzVnhkRVVXV1dmNEVEYXZiK3h4L0lKT1JmQWtaK1hpOFJp?=
 =?utf-8?B?TU04Q0JvZlgxK1B2SFRZYjRjd1ErRENaQmtUcWtzTFJ3WUhSU2hFZVplekI5?=
 =?utf-8?B?NElDa0FpQ3hEenZ6QzNFU1dJOHlFV0hMdGdUWk0wREExYllQeVpRcm1DMWNK?=
 =?utf-8?B?b3l1Wm1oK2RkQnA2R051MFY0dHpOeWRMTzJTYVdkalhUZDJIR2RKcUVSelZ3?=
 =?utf-8?B?YVlBbitZcDRMdnBGYmNjb1c1eDNyb0xTVXZYZmhFSHJMRTJESW5JYUtBUytB?=
 =?utf-8?Q?Ocz1va4WESj9UP596EI5isjrzMwmE6N4mHMOt5Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1787.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd82d585-9491-424f-d220-08d8ca0d5896
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 19:36:34.1670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLnnD833t+9mh+ony3owHeQXrKGZYLkMJiJdAerwYFM7PbOfNHSSJrVoydlS5mVGOgASLtT/Xfgx+PsSbcAt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgNSwgMjAyMSA1OjA2IEFNDQo+IFRvOiBEZXh1YW4gQ3VpIDxkZWN1aUBt
aWNyb3NvZnQuY29tPg0KPiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IE1p
Y2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBSZTogSG93
IGNhbiBhIHVzZXJzcGFjZSBwcm9ncmFtIHRlbGwgaWYgdGhlIHN5c3RlbSBzdXBwb3J0cyB0aGUg
QUNQSQ0KPiBTNCBzdGF0ZSAoU3VzcGVuZC10by1EaXNrKT8NCj4gDQo+IE9uIFNhdCwgRGVjIDEy
LCAyMDIwIGF0IDI6MjIgQU0gRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBIaSBhbGwsDQo+ID4gSXQgbG9va3MgbGlrZSBMaW51eCBjYW4gaGliZXJuYXRl
IGV2ZW4gaWYgdGhlIHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IHRoZSBBQ1BJDQo+ID4gUzQgc3Rh
dGUsIGFzIGxvbmcgYXMgdGhlIHN5c3RlbSBjYW4gc2h1dCBkb3duLCBzbyAiY2F0IC9zeXMvcG93
ZXIvc3RhdGUiDQo+ID4gYWx3YXlzIGNvbnRhaW5zICJkaXNrIiwgdW5sZXNzIHdlIHNwZWNpZnkg
dGhlIGtlcm5lbCBwYXJhbWV0ZXIgIm5vaGliZXJuYXRlIg0KPiA+IG9yIHdlIHVzZSBMT0NLRE9X
Tl9ISUJFUk5BVElPTi4NCj4gPg0KPiA+IEluIHNvbWUgc2NlbmFyaW9zIElNTyBpdCBjYW4gc3Rp
bGwgYmUgdXNlZnVsIGlmIHRoZSB1c2Vyc3BhY2UgaXMgYWJsZSB0byBkZXRlY3QNCj4gPiBpZiB0
aGUgQUNQSSBTNCBzdGF0ZSBpcyBzdXBwb3J0ZWQgb3Igbm90LCBlLmcuIHdoZW4gYSBMaW51eCBn
dWVzdCBydW5zIG9uDQo+ID4gSHlwZXItViwgSHlwZXItViB1c2VzIHRoZSB2aXJ0dWFsIEFDUEkg
UzQgc3RhdGUgYXMgYW4gaW5kaWNhdG9yIG9mIHRoZSBwcm9wZXINCj4gPiBzdXBwb3J0IG9mIHRo
ZSB0b29sIHN0YWNrIG9uIHRoZSBob3N0LCBpLmUuIHRoZSBndWVzdCBpcyBkaXNjb3VyYWdlZCBm
cm9tDQo+ID4gdHJ5aW5nIGhpYmVybmF0aW9uIGlmIHRoZSBzdGF0ZSBpcyBub3Qgc3VwcG9ydGVk
Lg0KPiA+DQo+ID4gSSBrbm93IHdlIGNhbiBjaGVjayB0aGUgUzQgc3RhdGUgYnkgJ2RtZXNnJzoN
Cj4gPg0KPiA+ICMgZG1lc2cgfGdyZXAgQUNQSTogfCBncmVwIHN1cHBvcnQNCj4gPiBbICAgIDMu
MDM0MTM0XSBBQ1BJOiAoc3VwcG9ydHMgUzAgUzQgUzUpDQo+ID4NCj4gPiBCdXQgdGhpcyBtZXRo
b2QgaXMgdW5yZWxpYWJsZSBiZWNhdXNlIHRoZSBrZXJuZWwgbXNnIGJ1ZmZlciBjYW4gYmUgZmls
bGVkDQo+ID4gYW5kIG92ZXJ3cml0dGVuLiBJcyB0aGVyZSBhbnkgYmV0dGVyIG1ldGhvZD8gSWYg
bm90LCBkbyB5b3UgdGhpbmsgaWYgdGhlDQo+ID4gYmVsb3cgcGF0Y2ggaXMgYXBwcm9wcmlhdGU/
IFRoYW5rcyENCj4gDQo+IFNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+IA0KPiBJZiBBQ1BJIFM0IGlz
IHN1cHBvcnRlZCwgL3N5cy9wb3dlci9kaXNrIHdpbGwgbGlzdCAicGxhdGZvcm0iIGFzIG9uZQ0K
PiBvZiB0aGUgb3B0aW9ucyAoYW5kIGl0IHdpbGwgYmUgdGhlIGRlZmF1bHQgb25lIHRoZW4pLiAg
T3RoZXJ3aXNlLA0KPiAicGxhdGZvcm0iIGlzIG5vdCBwcmVzZW50IGluIC9zeXMvcG93ZXIvZGlz
aywgYmVjYXVzZSBBQ1BJIGlzIHRoZSBvbmx5DQo+IHVzZXIgb2YgaGliZXJuYXRpb25fb3BzLg0K
PiANCj4gSFRIDQoNClRoaXMgd29ya3Mgb24geDg2LiBUaGFua3MgYSBsb3QhDQoNCkJUVywgZG9l
cyB0aGlzIGFsc28gd29yayBvbiBBUk02ND8NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
