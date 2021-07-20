Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457513D004E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGTQxP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 12:53:15 -0400
Received: from mail-bn7nam10on2110.outbound.protection.outlook.com ([40.107.92.110]:30112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhGTQxO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 12:53:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI9BsI1XPXn7jBb9h2sPJDEaB6Ni082Vxk6V05e1YCjPG1uoUi+sJVY3wue86A8O8rlIgKTLsNyrSMTrCURrx5dmB8c1vCCJB5yGwTWmKNIcdzlipPLd/iQettMSXDcf+eGej15UUnAw2mLMBhZGnUF0l+jGZXZSFI9PQ/k/IwKoEz8Gm7Xzj3XEWYfz9WM+T2darAJUvBwdzEyAGVV3eq/rltyh8gu7uQnpWWJCpfw9xMNblrFs9Y67vQM2y32BWpM+5d+oCWAZBGFnjYrf4uA8YReXmX7B+BEPRh65Jvvm703i8e0+4Eh+IeeKPv6wMCPZ+ZxdnQjB7DM+O9pltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZbwDV0ZblP8081/fBd/6Yhw5oC0O0JI95FAoBe1olI=;
 b=kp+gF/vhW7wsvdBMwKPNVtInKpWFkxeREoR5+XJ1FW5M3O08oyPWTKn6YGVxQA4pyyI7j4YSn7zHEs+Pr7W/K+40+qizBmZ/XTHsbwAJqp3AV/mORzhyAPlMlPyCvYLNI8JEIYfoSzvuwmwfvTAR3/bGntyL7T9EmiYrFZPPlw6gv0fhc9YSZWdzDImFo90+QRHZrr7SxVvigjTIU8jNLocDQgKSrGKv20EXGrRgsrCK25D7yBBxYJYCUkNzh93BqX96j4T9mGZVhvkM9ezs4ctUcfdkS+wu9yVG8V/pHRcAT9qe9tMM1vwyN4zasQeLEhGhJySvG3W3Tm6Kdm9Efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZbwDV0ZblP8081/fBd/6Yhw5oC0O0JI95FAoBe1olI=;
 b=PqqhjgPlLCG78IUn7nXXromAnuIve8QvKuHLPy+ZqlQs47poOokUOW8AtE8q1hZoElfuZJ+4S6zldrgyJFPD/MxHFDsjh2uk7ihZi4SPWOi3b1wEQPcIhTGIUDIKagdXGPTq9wKfhN/8cLvM7asEfZmlG4MDcgRjIQtl+k2YjRA=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1733.namprd21.prod.outlook.com (2603:10b6:a02:c4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.6; Tue, 20 Jul
 2021 17:33:47 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.006; Tue, 20 Jul 2021
 17:33:47 +0000
From:   Long Li <longli@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Topic: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Index: AQHXfRe50VdmS4suz0yD44Lpyf2vv6tLR9UAgAAXUgCAAA60sIAAjBwAgAAjOeA=
Date:   Tue, 20 Jul 2021 17:33:47 +0000
Message-ID: <BY5PR21MB1506822C71ED70366E1B1BCBCEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
 <YPZmtOmpK6+znL0I@infradead.org>
 <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
 <115d864c-46c2-2bc8-c392-fd63d34c9ed0@acm.org>
In-Reply-To: <115d864c-46c2-2bc8-c392-fd63d34c9ed0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5857ec5a-5bbb-482a-9e30-e7c3a1368213;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T17:21:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 105fd2fe-3db7-4074-126c-08d94ba48805
x-ms-traffictypediagnostic: BYAPR21MB1733:
x-microsoft-antispam-prvs: <BYAPR21MB1733E58F5F4FE17071DB7EEDCEE29@BYAPR21MB1733.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iapDf3pk9hxpg8MEmq+DW0Q1lwWB8dubbftXX7kvO+JBUUAcQphGHiw0ligZWw5d0RI11LlXx17qWSjXJBfu1LulDioJ5GfzDhM6MjFE3WxNtCxuCIp7Z8oz5jR0uXrloH+PNkV2pbXPcPRs06x9Mem8yhGHUD2pNRmmMkEFJEAlQ78UWMQQrSFhGtrOzODw5J3uPFszQh3EfitQ03UD+A0/tRsRjQUdmfauEBxpXaXfatQBq8vHgP65KVcFihooU2y4PgfMLwI8h3uG4o8VDeQff42BLDlhI4u3VNCg3FwZwW2ag4kuxHNCFPhI+gwSam65xjztXG8D7mKQHc2dkDcH816nsOqM18KRL5Nv5JBORczOIU/m0ErlNkyW9vsajWzbgZTP7bTL+p8iJOI3FZiyW1WYeABrr4q+dsUvDcLEWSVc6MN3eigYbs5CSIfz9wWH9vB5ZHccWxEmaKtRnNGoWCVjm57UNDg/eCiNeXmIpxx0aHFVOWK349UQMw5wWFQO2/CKvdc97Ml4Nocc4ym8a3nqrRteR+g3OCSfcZR+R0lWHwO4PobV1IFcGr+MThMx+TcP5XTIQZk+lIWWAImeqoOQb08YAdfSKWYWLbDifBI9VSj5RvdKDjFhFb8RwUsIxzAExrLrx4pUlIardMjrqHu0XnN1xfFALnk4AUFrVSKgdCRoO3XYJFanZOL6NoM3K2V+L6hlVHdZwmeFzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(8936002)(110136005)(2906002)(316002)(71200400001)(26005)(5660300002)(9686003)(186003)(55016002)(82960400001)(33656002)(66946007)(4326008)(54906003)(66556008)(8990500004)(7696005)(8676002)(53546011)(508600001)(6506007)(64756008)(66446008)(76116006)(66476007)(86362001)(83380400001)(122000001)(38100700002)(10290500003)(52536014)(82950400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzVBaTBTMnNMTU9qRVVjQlhrMzBySUdoWTQyZTVmbVBBWExUbEk4TVhSRUtK?=
 =?utf-8?B?c2t5T1FWL3I0NlY2MmxpOWNSSGgzSmUxbHZ1N0ZPNExWeEFvT0w0L2FKeUxv?=
 =?utf-8?B?VnIvR01QamtPdkJzQUJVaXNZdWZLb2dGSmFsYk9CbFppcVJtaEhhaUxSUld4?=
 =?utf-8?B?WjFpNTV4RHJuYzFTMzZhV1NpUWNKeklxMHIveTY5ckFhYm1IbDJobE5qdjZR?=
 =?utf-8?B?NHg5aGZDZnJKdGlyanVTSzMrajhaZWlWQVYzNll3T0pmeTRnYWhSY3hMb0JP?=
 =?utf-8?B?alowRWp4d0pZUEpWQzJNYUpiZG5uMmltOFF2Rk14ZVdHSHZZbGJocVJYY0tQ?=
 =?utf-8?B?VHRCV0oxSWpkcTJrdmZZbXQzWnBUYUcxeWlpSkgrekVWeGNSQmQ1aXNZZ1lV?=
 =?utf-8?B?L0I5UWtLblpBWmJNN1pUUXJvVmVWSGdkL01IZFRpZXZUQjFWQlBOanplM2Yv?=
 =?utf-8?B?QzBLOEo5dDhod3V2VEhKekdQc1ZyK0M0Y0o5aGNzald6aWpVTVNhMklZU0tP?=
 =?utf-8?B?Vm5QOVZ6eERMS09BOWZlU3lBOFNPU1lhWVZ2ZTE5alM4T04vVmtKRWFkMUI4?=
 =?utf-8?B?eHBBUkZFVm5PaHpQRG0yT3hlcWJwU0F3T2NKVW13cVkxYmNjUE94UEU3V0lL?=
 =?utf-8?B?eW9YUGFENjVwdmNvVDBadzdUUlBZSkZ0cGxGdlRjSFcya0Z4T1pncE9SODBk?=
 =?utf-8?B?ZFZyOWtmTWtuQ25WdFp1WmdJaXZOV21zL1FvWHZXcFdqVzY2aVJSeTlHRmJv?=
 =?utf-8?B?VHp5UXU5WXFEeE42d1cwNUwweEtRZTNuMjBuQktCZVhYTXVnVGR3cGo5Tzgy?=
 =?utf-8?B?cXQyd3BnamxZWEtJTHJUT0xOWE96RHNwNmJiOXpOVjh3QnVEWlhKVmVidEpC?=
 =?utf-8?B?VW4zdWY5NFlaSjBOeDNUTG1mWlFiVmtaRmpKTnROS0xtSlVxZHNFYnFCQmZ5?=
 =?utf-8?B?aU5oSHhDcEhxWitNUnpyczh1MloyOGlyS29DWldqdnJWQWJrT1JGY1hjUDY3?=
 =?utf-8?B?VGpoMUVBVmpvT21ET3NFL2VlRUdocWZKeGdYWVV0MjAyNjhaQmVSTHpyWmhG?=
 =?utf-8?B?K3Iwb1Vqc3QwWWJXU0I4eUNJdDlKVG15bGU3L3d0NVhxMDJBcTVNbnhmeHN1?=
 =?utf-8?B?Rnc1cXY1eWFWQzlrQmc5THN4c2s0ek0yNTQrUkszUXZGcVZnaWh5T0w2bTVV?=
 =?utf-8?B?bXMxd0t3UTlJTlhUL3Y1cEtuYnZndWlCeHB4c2RSNXdvUkd1Tm0zdjEwaVQ0?=
 =?utf-8?B?c1hicmNzMGtEMnl0QXAzS0VvZHU3MkxhNDNHNWV4c012TTVRM3ZISVpLbEcz?=
 =?utf-8?B?bmlUM2R6dEl2dksySmRBLzdKbWROcll4TWNsdDErUHFZaWQxQWZkTkM0dVhD?=
 =?utf-8?B?RG5ELzlFMXpUS29ZUitxYU5OQUJQdG1uRDdtY1pSOEQrL05EVmU0NDdGbHhV?=
 =?utf-8?B?U3V6ZThsSll2SVpwMFFDZm43RjkzWG9QVXFZSlBJQzFLYmQ4amlPNmVGT2FX?=
 =?utf-8?B?TjNnUnU5SGoxMGRRcC92YUVUQ1BERjFZMnpGVzZsRS90L25BdThRVTNaYm1S?=
 =?utf-8?B?WXdhSGdFUVFoWHl2MW13dGpGSDU1WGhIbGFIWXl0d2JYNmJKdm5zd3lsZmF3?=
 =?utf-8?B?Z0xtWU5kNEJrc01ndjcxbjQ5eWdjeksyYy82bWJrek9DYnBDNGdodTlRYjRY?=
 =?utf-8?B?emtpSUMwYkZGQ0Y1dXZXSVJBN1VMMkppU0ZwUlVJc3Fzb3ZZT0tzcWFmeEJ1?=
 =?utf-8?Q?Gf4Q5Kkun3nDaaPeJ8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105fd2fe-3db7-4074-126c-08d94ba48805
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 17:33:47.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tqm26oFOxnQ0NE5FLqyPvWPpuhrPZQeXWAFI+nj1FdiD8VGYb2U3tQrfW1luzAtCZHN9NYo5XaGCkTKhkhjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1733
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHY0IDAvM10gSW50cm9kdWNlIGEgZHJpdmVyIHRvIHN1cHBv
cnQgaG9zdCBhY2NlbGVyYXRlZA0KPiBhY2Nlc3MgdG8gTWljcm9zb2Z0IEF6dXJlIEJsb2INCj4g
DQo+IE9uIDcvMjAvMjEgMTI6MDUgQU0sIExvbmcgTGkgd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUGF0Y2ggdjQgMC8zXSBJbnRyb2R1Y2UgYSBkcml2ZXIgdG8gc3VwcG9ydCBob3N0DQo+ID4+
IGFjY2VsZXJhdGVkIGFjY2VzcyB0byBNaWNyb3NvZnQgQXp1cmUgQmxvYg0KPiA+Pg0KPiA+PiBP
biBNb24sIEp1bCAxOSwgMjAyMSBhdCAwOTozNzo1NlBNIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUg
d3JvdGU6DQo+ID4+PiBzdWNoIHRoYXQgdGhpcyBvYmplY3Qgc3RvcmFnZSBkcml2ZXIgY2FuIGJl
IGltcGxlbWVudGVkIGFzIGENCj4gPj4+IHVzZXItc3BhY2UgbGlicmFyeSBpbnN0ZWFkIG9mIGFz
IGEga2VybmVsIGRyaXZlcj8gQXMgeW91IG1heSBrbm93DQo+ID4+PiB2ZmlvIHVzZXJzIGNhbiBl
aXRoZXIgdXNlIGV2ZW50ZmRzIGZvciBjb21wbGV0aW9uIG5vdGlmaWNhdGlvbnMgb3IgcG9sbGlu
Zy4NCj4gPj4+IEFuIGludGVyZmFjZSBsaWtlIGlvX3VyaW5nIGNhbiBiZSBidWlsdCBlYXNpbHkg
b24gdG9wIG9mIHZmaW8uDQo+ID4+DQo+ID4+IFllcy4gIFNpbWlsYXIgdG8gc2F5IHRoZSBOVk1l
IEsvViBjb21tYW5kIHNldCB0aGlzIGRvZXMgbm90IGxvb2sgbGlrZQ0KPiA+PiBhIGNhbmRpZGF0
ZSBmb3IgYSBrZXJuZWwgZHJpdmVyLg0KPiA+DQo+ID4gVGhlIGRyaXZlciBpcyBtb2RlbGVkIHRv
IHN1cHBvcnQgbXVsdGlwbGUgcHJvY2Vzc2VzL3VzZXJzIG92ZXIgYSBWTUJVUw0KPiA+IGNoYW5u
ZWwuIEkgZG9uJ3Qgc2VlIGEgd2F5IHRoYXQgdGhpcyBjYW4gYmUgaW1wbGVtZW50ZWQgdGhyb3Vn
aCBWRklPPw0KPiA+DQo+ID4gRXZlbiBpZiBpdCBjYW4gYmUgZG9uZSwgdGhpcyBleHBvc2VzIGEg
c2VjdXJpdHkgcmlzayBhcyB0aGUgc2FtZSBWTUJVUw0KPiA+IGNoYW5uZWwgaXMgc2hhcmVkIGJ5
IG11bHRpcGxlIHByb2Nlc3NlcyBpbiB1c2VyLW1vZGUuDQo+IA0KPiBTaGFyaW5nIGEgVk1CVVMg
Y2hhbm5lbCBhbW9uZyBwcm9jZXNzZXMgaXMgbm90IG5lY2Vzc2FyeS4gSSBwcm9wb3NlIHRvDQo+
IGFzc2lnbiBvbmUgVk1CVVMgY2hhbm5lbCB0byBlYWNoIHByb2Nlc3MgYW5kIHRvIG11bHRpcGxl
eCBJL08gc3VibWl0dGVkIHRvDQo+IGNoYW5uZWxzIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2FtZSBi
bG9iIHN0b3JhZ2Ugb2JqZWN0IGluc2lkZSBlLmcuIHRoZQ0KPiBoeXBlcnZpc29yLiBUaGlzIGlz
IG5vdCBhIG5ldyBpZGVhLiBJbiB0aGUgTlZNZSBzcGVjaWZpY2F0aW9uIHRoZXJlIGlzIGENCj4g
ZGlhZ3JhbSB0aGF0IHNob3dzIHRoYXQgbXVsdGlwbGUgTlZNZSBjb250cm9sbGVycyBjYW4gcHJv
dmlkZSBhY2Nlc3MgdG8gdGhlDQo+IHNhbWUgTlZNZSBuYW1lc3BhY2UuIFNlZSBhbHNvIGRpYWdy
YW0gIkZpZ3VyZSA0MTY6IE5WTSBTdWJzeXN0ZW0gd2l0aA0KPiBUaHJlZSBJL08gQ29udHJvbGxl
cnMiIGluIHZlcnNpb24gMS40IG9mIHRoZSBOVk1lIHNwZWNpZmljYXRpb24uDQo+IA0KPiBCYXJ0
Lg0KDQpDdXJyZW50bHksIHRoZSBIeXBlci1WIGlzIG5vdCBkZXNpZ25lZCB0byBoYXZlIG9uZSBW
TUJVUyBjaGFubmVsIGZvciBlYWNoIHByb2Nlc3MuDQpJbiBIeXBlci1WLCBhIGNoYW5uZWwgaXMg
b2ZmZXJlZCBmcm9tIHRoZSBob3N0IHRvIHRoZSBndWVzdCBWTS4gVGhlIGhvc3QgZG9lc24ndA0K
a25vdyBpbiBhZHZhbmNlIGhvdyBtYW55IHByb2Nlc3NlcyBhcmUgZ29pbmcgdG8gdXNlIHRoaXMg
c2VydmljZSBzbyBpdCBjYW4ndA0Kb2ZmZXIgdGhvc2UgY2hhbm5lbHMgaW4gYWR2YW5jZS4gVGhl
cmUgaXMgbm8gbWVjaGFuaXNtIHRvIG9mZmVyIGR5bmFtaWMNCnBlci1wcm9jZXNzIGFsbG9jYXRl
ZCBjaGFubmVscyBiYXNlZCBvbiBndWVzdCBuZWVkcy4gU29tZSBkZXZpY2VzIChlLmcuDQpuZXR3
b3JrIGFuZCBzdG9yYWdlKSB1c2UgbXVsdGlwbGUgY2hhbm5lbHMgZm9yIHNjYWxhYmlsaXR5IGJ1
dCB0aGV5IGFyZSBub3QNCmZvciBzZXJ2aW5nIGluZGl2aWR1YWwgcHJvY2Vzc2VzLg0KDQpBc3Np
Z25pbmcgb25lIFZNQlVTIGNoYW5uZWwgcGVyIHByb2Nlc3MgbmVlZHMgc2lnbmlmaWNhbnQgY2hh
bmdlIG9uIHRoZSBIeXBlci1WIHNpZGUuDQoNCkxvbmcNCg==
