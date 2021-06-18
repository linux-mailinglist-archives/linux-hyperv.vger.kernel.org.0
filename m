Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33D3AC008
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jun 2021 02:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhFRATH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Jun 2021 20:19:07 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:24416
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233259AbhFRATG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Jun 2021 20:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ/jqv1BdD0NoyO0yDF20hJNYasx3tnzT0gkDZJGDzbdfG9hJd3PQJPqK2tAqbdwbN83O3vS+0gmK+4AQeYfpKHeT5Vzv21dDaZBV8gg0uzA+0OinmDqwyQhpq68/2LHyKJL7GTmpXXgttq0tzEI/O9TCktNMUdG2WwkScKr0c9zRPDHZPPdIvcohllzbEmLQd9zgaAC7fSRdMJKZz/CcgnfSf4UDT788MCrRmwNyu1Ox529TbOOUSWhynGLTA4C/+oRfRe93samNG62JC1dLs7qHvOc8fmiIpsEeSOgORmq5rRGv23Is/vKsARGHHyrwLF+IciuLHaxxZeMDTa0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnPNunQ0CYvSsuC3ruwT3H7QdCFyeF91X7Wd8ua/xCM=;
 b=MwgKn8OWlORA4bQcO3JJFTgA0WH+2mLlEj6htzoC+kOglbCcnGezOyflSGDVpUOdPWZFnF2h2P5pRroqC6fxItC3GYq2Ghu1cTiHmUHSK3NwimaWljoG6ao/VENa6YAQs6t42MhlTlRoE916xGRcBqII1YTsDurtJQGb2JJgf5GjK7IQK32IKUznsi85rIWywxxUKbmvo1frSG0/ujvB4LSJIW2UcUUk4nMANpfx4so8bCkY+0MqBS+XPqSRIhtbpiDYqmxIOabgG6beXrhavi/ZO9CDf8gYfmhFsZOk+bN8rFH4CUJMv/nsiPNOU3CdPdJWjyOUgIWQkemaeEgtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnPNunQ0CYvSsuC3ruwT3H7QdCFyeF91X7Wd8ua/xCM=;
 b=VA5mJ+NC40jBXwwGEim46k4rrNabXOL+uDGK+D8eQkmG/Bylrk+x66xPFL7xCXdePDCC20o9g38Uf4PXJ970CybmlSRKF/BLU+EpgAlEhRems0L26/uXIeYn2Spq+swZiW6iLsaMqi6fZTFHjviJDLIJLs2DukLU1wQ0juHJw60=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0908.namprd21.prod.outlook.com (2603:10b6:302:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.4; Fri, 18 Jun
 2021 00:16:53 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168%8]) with mapi id 15.20.4264.010; Fri, 18 Jun 2021
 00:16:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Hillf Danton <hdanton@sina.com>
Subject: RE: vmemmap alloc failure in hot_add_req()
Thread-Topic: vmemmap alloc failure in hot_add_req()
Thread-Index: AQHXXvrCj8SFgzJ85UWsJfcwygODGKsTIpOdgARJ94CAAH7tAIABAHow
Date:   Fri, 18 Jun 2021 00:16:53 +0000
Message-ID: <MWHPR21MB159397B915AFE4EF1FEEF301D70D9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
 <20210612021115.2136-1-hdanton@sina.com>
 <951ddbaf-3d74-7043-4866-3809ff991cfd@redhat.com>
 <d6a82778-024a-3a01-a081-dab6c8b54d62@kernel.org>
 <98cba3fa-f787-081f-b833-cfea3a124254@redhat.com>
In-Reply-To: <98cba3fa-f787-081f-b833-cfea3a124254@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=81a047f4-99b2-49ac-95d3-5220840f733f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-18T00:00:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b345256e-53e7-461b-942c-08d931ee6012
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0908FBBF438DE5B52CF46E29D70D9@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMDdH6QiyP+Vh/L7AKO0/rCguQifrrYpsGKw17MljjEylxDFtYCjxBgFZ8q0OjDMY7Ea7fkX0h4b0cOAuLRYrQpCaI+D8+4evCYzBrBMhYLRFwpuXr97WvBHIjvh4+xuxj6wo0SJqKC4/PQOWA7m38mf0FIcBw63hYd9dgRh2HAPYUXVr6PkTEVWguD4tiVT2EG7wL8TIl97UZFVqKo6YWuCxTjEH5if6tWNrOe0meuQMOsEIoU65Xf+AU3ggGpOPOdeIuWHQ1B5Cg7dUWmfBWjIeskE7wbNFK76YtkzYuR/M+vfS3T/MPHr5l+wBSuWcAwNGZpBdCmBO1kaCbjyENAUv2dTTePwtVBADbh6YZyq0/8XQQJ91AReNfNTwq26/EmBBVx1r831o5ZpPHx+JhXIbM/lJU0MAMPRYzkjc7M0T4N9MphqqbgdO8EaGD98Xg/ygCiJUyUuT7uLmC6mHGdhhKRNUUvgdvjFsUjp0t8kUu+g8fA1lhyiOn1n5LKAGWqRtdflzHhdTtLvXBUNlTRPZGc3sFrUy+l0SEN8eYnBlQH91P+uGdY/OrXyW7kF3FPK69QgCA4t+B6TGwqf8wzazxyH9Lv7hR8jdqzTB8APipqdawBrglIseJpPKbh1T5XNWoEL7pqnGTUlKGPNvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(64756008)(66446008)(66946007)(186003)(122000001)(4326008)(26005)(52536014)(76116006)(38100700002)(2906002)(7696005)(5660300002)(316002)(8936002)(8990500004)(54906003)(33656002)(110136005)(6506007)(10290500003)(71200400001)(55016002)(86362001)(8676002)(83380400001)(82960400001)(9686003)(82950400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXZuNmtuTmRiMzlqdUtQNEd5OFNNUk92MEwzUllEN3FxSHlTSlprMGZrTHVh?=
 =?utf-8?B?aXZ6ZDhMSWMvcHZoUEw4OGpFcUs1dDI0VG1MWXR5VzgrS3pZK1NhZSsxZVNo?=
 =?utf-8?B?UWtxVzd0a2owWTkzVDl3UDNqaXh3U0tBUHdGZWZLdTcyeTdSSTZ1MGJpK2NT?=
 =?utf-8?B?dkZBSThlVTdYTkc5UHBkVGtaODNmUkxJcStzVzR5bXdRV2hGMWIzVTVHRUZp?=
 =?utf-8?B?bXh5a2QwUFN3OGZwcENwa0o2a21CcFcwcjhDbjRneXNCd3BiTEora2FUMStK?=
 =?utf-8?B?TEVLQlk2NTV3OXhTemUrb0JjQ0NaK2JPSmduazFUY3VRQzh1OUl4V2RUTEM4?=
 =?utf-8?B?NHhLY1FBOWtLOFcrRGxUTGVaNWNtdWFUZk5hdzlINFhJSGJVSi9ZTThickdh?=
 =?utf-8?B?aGJYNUQ4Vm0yUWhqeWg0SjY4L1BqVEMzLzdtVTczbDhJeEJVLzV5Z2h6d1J1?=
 =?utf-8?B?aVJrSGlwR050cEFDWDl2QlQyT3BaRktMem1RQ1FEUkljdnJWMVRtSzVwQXN4?=
 =?utf-8?B?WVFVaW05WUtVeHFjSzBLWnlyUlBDbWJtQXpROVVnRUFGVVNLNmN2clJvV2hz?=
 =?utf-8?B?bzlyblR1S1oxYkt0elA2QzZQZk5pdzRydXd2enkvUjdqcUdYNkx5UzRzeEll?=
 =?utf-8?B?ZjRvSnQyRno1MklDMXkvYTJ0M3JUcVpXbEh5UmVVamNuemY5R3RhUXRyVXFP?=
 =?utf-8?B?ZWVsczlZYWRDWDY1YnEzNkk5TWZERHl0ZDdmaDZKSTFGZVBpcC9VN1k3WWJL?=
 =?utf-8?B?V0FzR3FOeXZlUTE3U0ZMNEpLc0szbjJ1cXdjamRaMDFFUkhxMFkxdzNLR3c5?=
 =?utf-8?B?U0kxRjRnbXl2TjdqSUdZeSswMWtCRmV6VXlnM3M0Z1NMMmpNYUgzQmZWRitn?=
 =?utf-8?B?UHJIRUsrbEw1b2Yya1dXMlR4M3ZiNFpSdFkxVnNGd3JsUkd0aWJyVjZFSUIv?=
 =?utf-8?B?UG8xNUp3dWxIWUlGNDd1WDE1NGRCUEpVbGJEMW1mSmZLaFRRa2twOVNEZSth?=
 =?utf-8?B?U3AzYVRSM2U3OUtBU2oydUUxZVd1K1FlNU5FY0pFeXJGL21SSk9QR296Lzlm?=
 =?utf-8?B?TExzaDlJSTBGWDYzWWlWbDBGZDFNYjJMblFQZWpiRDRKbTVaWDJ4TitDRVVm?=
 =?utf-8?B?VEVvM1BZZ0FPMDRpTWJGcEFnUWRiZStuemFwL0s3U3R1cGFmQng3MFlVcFVH?=
 =?utf-8?B?MStVWGJtQ3pRL2FsUVhBdVk0NHpnV3MrVUtUN2FncVA1SzA3WnFIejM2Vkox?=
 =?utf-8?B?RXhBM0pXU2ltYUwyL1hTYmN4d2lhOWc1OEhGSG5wRlhQeHRmRTlTdmRzeENP?=
 =?utf-8?B?VWNXSCsvYk0rakc4Ui9DaGllYk9nY0hLblY0VHBMVHdMOXgrVXJBNnJHdFBZ?=
 =?utf-8?B?U0dLQWppZXVEU2FMQ2thV0RsN3BDZjlLRjZkeXlOYXZVZ2ZzRlJZdE9sL0c2?=
 =?utf-8?B?THBRckRBRGE4TURvUCs1ODRWY041N3FpWUZkRVJETStVT0d0VHBicEhOYi9M?=
 =?utf-8?B?aFZvOFVjOEZLdHFEY3FDNkZERmllcE9KM3NSZmVUVGY3MGFBVXlMZXBLTGRh?=
 =?utf-8?B?OHRORDg2L0JnaTYvdjZiQTFuc1Y3bm5wNHBMRFRIWEpjRnpNcVlCYitJRUNk?=
 =?utf-8?B?QU94S1d2WnJZQ3NUTUhlQmltMWNwOUZ2aTdOVmhlYmpwUXFydThrbGlLTUUv?=
 =?utf-8?B?SVNVQnA5ZS8xazhYb0picXc5QjdSOFRWUlV4aGd4UWU2aEdUNkdrNFBhVTla?=
 =?utf-8?Q?apbDTQmv1Oc57ZN+K0Opq6xOdXZMUhfAQHpExnD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b345256e-53e7-461b-942c-08d931ee6012
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 00:16:53.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xxhbuo3BLFeMmO6e0wvvFA2r0ypo/fWSLs6o75psVnL1F2w2hOQ7wOvItSjv+izJWfZ9VcXLikhjrumVS6koEcnED2eEtQ0VOgMOp4S7fhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IFNlbnQ6IFRodXJzZGF5
LCBKdW5lIDE3LCAyMDIxIDE6NDMgQU0NCj4gDQo+ID4gSXQgZG9lcyBsb29rIGxpa2UgdGhpcyBr
ZXJuZWwgY29uZmlndXJhdGlvbiBoYXMNCj4gPiBDT05GSUdfTUVNT1JZX0hPVFBMVUdfREVGQVVM
VF9PTkxJTkU9eS4NCj4gDQo+IE9rYXksIHNvIHRoZW4gaXQncyBtb3N0IGxpa2VseSByZWFsbHkg
bW9yZSBvZiBhbiBpc3N1ZSB3aXRoIGZyYWdtZW50ZWQNCj4gcGh5c2ljYWwgbWVtb3J5IC0tIHdo
aWNoIGlzIHN1Ym9wdGltYWwgYnV0IG5vdCBhIHNob3cgYmxvY2tlciBpbiB5b3VyIHNldHVwLg0K
PiANCj4gKHRoZXJlIGFyZSBzdGlsbCBjYXNlcyB3aGVyZSBtZW1vcnkgb25saW5pbmcgY2FuIGZh
aWwsIGVzcGVjaWFsbHkgd2l0aA0KPiBrYXNhbiBydW5uaW5nLCBidXQgdGhlc2UgYXJlIHJhdGhl
ciBjb3JuZXIgY2FzZXMpDQo+IA0KPiA+DQo+ID4+IElmIGl0J3Mgbm90IGdldHRpbmcgb25saW5l
ZCwgeW91IGVhc2lseSBzcG9ydCBhZnRlciBob3RwbHVnIGUuZy4sIHZpYQ0KPiA+PiAibHNtZW0i
IHRoYXQgdGhlcmUgYXJlIHF1aXRlIHNvbWUgb2ZmbGluZSBtZW1vcnkgYmxvY2tzLg0KPiA+Pg0K
PiA+PiBOb3RlIHRoYXQgeDg2XzY0IGNvZGUgd2lsbCBmYWxsYmFjayBmcm9tIHBvcHVsYXRpbmcg
aHVnZSBwYWdlcyB0bw0KPiA+PiBwb3B1bGF0aW5nIGJhc2UgcGFnZXMgZm9yIHRoZSB2bWVtbWFw
OyB0aGlzIGNhbiBoYXBwZW4gZWFzaWx5IHdoZW4gdW5kZXINCj4gPj4gbWVtb3J5IHByZXNzdXJl
Lg0KPiA+DQo+ID4gTm90IHN1cmUgaWYgaXQgaXMgcmVsZXZhbnQgb3Igbm90IGJ1dCB0aGlzIHdh
cm5pbmcgY2FuIHNob3cgdXAgd2l0aGluIGENCj4gPiBtaW51dGUgb2Ygc3RhcnR1cCB3aXRob3V0
IG1lIGRvaW5nIGFueXRoaW5nIGluIHBhcnRpY3VsYXIuDQo+IA0KPiBJIHJlbWVtYmVyIHRoYXQg
SHlwZXItViB3aWxsIHN0YXJ0IHdpdGggYSBjZXJ0YWluIChjb25maWd1cmVkKSBib290IFZNDQo+
IG1lbW9yeSBzaXplIGFuZCBvbmNlIHRoZSBndWVzdCBpcyB1cCBhbmQgcnVubmluZywgdXNlIG1l
bW9yeSBzdGF0cyBvZg0KPiB0aGUgZ3Vlc3QgdG8gZGVjaWRlIHdoZXRoZXIgdG8gYWRkIChob3Rw
bHVnKSBvciByZW1vdmUgKGJhbGxvb24gaW5mbGF0ZSkNCj4gbWVtb3J5IGZyb20gdGhlIFZNLg0K
PiANCj4gU28gdGhpcyBjb3VsZCBqdXN0IGJlIEh5cGVyLVYgdHJ5aW5nIHRvIGFwcGx5IGl0cyBo
ZXVyaXN0aWNzLg0KDQpOYXRoYW4gLS0NCg0KQ291bGQgeW91IGNsYXJpZnkgaWYgeW91ciBWTSBp
cyBydW5uaW5nIGluIHRoZSBjb250ZXh0IG9mIHRoZSBXaW5kb3dzDQpTdWJzeXN0ZW0gZm9yIExp
bnV4IChXU0wpIHYyIGZlYXR1cmUgaW4gV2luZG93cyAxMD8gIE9yIGFyZSB5b3UNCnJ1bm5pbmcg
YSAidHJhZGl0aW9uYWwiIFZNIGNyZWF0ZWQgdXNpbmcgdGhlIEh5cGVyLVYgTWFuYWdlciBVSQ0K
b3IgUG93ZXJzaGVsbD8NCg0KSWYgdGhlIGxhdHRlciwgaG93IGRvIHlvdSBoYXZlIHRoZSBtZW1v
cnkgY29uZmlndXJhdGlvbiBzZXQgdXA/ICBJbg0KdGhlIFVJLCBmaXJzdCB5b3UgY2FuIHNwZWNp
ZnkgdGhlIFJBTSBhbGxvY2F0ZWQgdG8gdGhlIFZNLiAgVGhlbg0Kc2VwYXJhdGVseSwgeW91IGNh
biBlbmFibGUgdGhlICJEeW5hbWljIE1lbW9yeSIgZmVhdHVyZSwgaW4gd2hpY2gNCmNhc2UgeW91
IGFsc28gc3BlY2lmeSBhICJNaW5pbXVtIFJBTSIgYW5kICJNYXhpbXVtIFJBTSIuICBJdA0KbG9v
a3MgbGlrZSB5b3UgbXVzdCBoYXZlIHRoZSAiRHluYW1pYyBNZW1vcnkiIGZlYXR1cmUgZW5hYmxl
ZA0Kc2luY2UgdGhlIG9yaWdpbmFsIHN0YWNrIHRyYWNlIGluY2x1ZGVzIHRoZSBob3RfYWRkX3Jl
cSgpIGZ1bmN0aW9uDQpmcm9tIHRoZSBodl9iYWxsb29uIGRyaXZlci4NCg0KVGhlIER5bmFtaWMg
TWVtb3J5IGZlYXR1cmUgaXMgZ2VuZXJhbGx5IHVzZWQgb25seSB3aGVuIHlvdQ0KbmVlZCB0byBh
bGxvdyBIeXBlci1WIHRvIG1hbmFnZSB0aGUgYWxsb2NhdGlvbiBvZiBwaHlzaWNhbCBtZW1vcnkN
CmFjcm9zcyBtdWx0aXBsZSBWTXMuICBEeW5hbWljIE1lbW9yeSBpcyBlc3NlbnRpYWxseSBIeXBl
ci1WJ3Mgd2F5IG9mDQphbGxvd2luZyBtZW1vcnkgb3ZlcmNvbW1pdC4gIElmIHlvdSBkb24ndCBu
ZWVkIHRoYXQgY2FwYWJpbGl0eSwNCnR1cm5pbmcgb2ZmIER5bmFtaWMgTWVtb3J5IGFuZCBqdXN0
IHNwZWNpZnlpbmcgdGhlIGFtb3VudCBvZg0KbWVtb3J5IHlvdSB3YW50IHRvIGFzc2lnbiB0byB0
aGUgVk0gaXMgdGhlIGJlc3QgY291cnNlIG9mIGFjdGlvbi4NCg0KV2l0aCBEeW5hbWljIE1lbW9y
eSBlbmFibGVkLCB5b3UgbWF5IGhhdmUgZW5jb3VudGVyZWQgYQ0Kc2l0dWF0aW9uIHdoZXJlIHRo
ZSBtZW1vcnkgbmVlZHMgb2YgdGhlIFZNIGdyZXcgdmVyeSBxdWlja2x5LA0KYW5kIEh5cGVyLVYg
YmFsbG9vbiBkcml2ZXIgZ290IGludG8gYSBzaXR1YXRpb24gd2hlcmUgaXQgbmVlZGVkDQp0byBh
bGxvY2F0ZSBtZW1vcnkgaW4gb3JkZXIgdG8gYWRkIG1lbW9yeSwgYW5kIGl0IGNvdWxkbid0LiAg
SWYNCnlvdSB3YW50IHRvIGNvbnRpbnVlIHRvIHVzZSB0aGUgRHluYW1pYyBNZW1vcnkgZmVhdHVy
ZSwgdGhlbg0KeW91IHByb2JhYmx5IG5lZWQgdG8gaW5jcmVhc2UgdGhlIGluaXRpYWwgYW1vdW50
IG9mIFJBTSBhc3NpZ25lZA0KdG8gdGhlIFZNICh0aGUgIlJBTSIgc2V0dGluZyBpbiB0aGUgSHlw
ZXItViBNYW5hZ2VyIFVJKS4NCg0KTWljaGFlbA0KDQo+IA0KPiA+DQo+ID4+IElmIGFkZGluZyBt
ZW1vcnkgd291bGQgZmFpbCBjb21wbGV0ZWx5LCB5b3UnZCBzZWUgYW5vdGhlciAiaG90X2FkZA0K
PiA+PiBtZW1vcnkgZmFpbGVkIGVycm9yIGlzIC4uLiIgZXJyb3IgbWVzc2FnZSBmcm9tIGh5cGVy
LXYgaW4gdGhlIGtlcm5lbA0KPiA+PiBsb2cuIElmIHRoYXQgZG9lc24ndCBzaG93IHVwLCBpdCdz
IHNpbXBseSBzdWJvcHRpbWFsLCBidXQgaG90cGx1Z2dpbmcNCj4gPj4gbWVtb3J5IHN0aWxsIHN1
Y2NlZWRlZC4NCj4gPg0KPiA+IEkgZGlkIG5vdGljZSB0aGF0IGZyb20gdGhlIGNvZGUgaW4gaHZf
YmFsbG9vbi5jIGJ1dCBJIGRvIG5vdCB0aGluayBJDQo+ID4gaGF2ZSBldmVyIHNlZW4gdGhhdCBt
ZXNzYWdlIGluIG15IGxvZ3MuDQo+IA0KPiBPa2F5LCBzbyBhdCBsZWFzdCBob3RwbHVnZ2luZyBt
ZW1vcnkgaXMgd29ya2luZy4NCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gDQo+IERhdmlkIC8gZGhp
bGRlbmINCg0K
