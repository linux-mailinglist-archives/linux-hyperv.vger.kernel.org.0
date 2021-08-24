Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B73F6778
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhHXRfU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 13:35:20 -0400
Received: from mail-centralus01namln1006.outbound.protection.outlook.com ([40.93.8.6]:7351
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241575AbhHXRbk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 13:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3ZGNuqCqruE28W0ps5Seg5clrsvUzv4QfDrCtWVBdfUm2oi8r+1Eja+ztIpz8Ih3g+wutWfAvCDY1z5eYwCpkJo44OoyNEi4yHnTaWW4meaoH+TeOb9IzqfFV0tNSrzq/16vmseuWU1tL8bFJHDwvJdWT/2IA4S/jmThuKEMMQhEKAMCKFuXkBbO4Vm0y8ZVw14IAgoRc9Is0ADKT7IEW244pW0oDJMurlfnVt+mBWD2RSii7TuzzM5PVBQnv6NNOAiHLzrcV+ZIheoOMdUun2+6Mr1BAWlf9FLnvANIyGFH2N8Bwch+4Jo3o6uCJITU7XCYMeIpnAYXkIYny1L1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuHhcZH5ywJgwCdvjSedYp/UsqNIg3iEujPCcQT8y2k=;
 b=eECmSWoyDyWuK5eF9kfyrb/AGmKdUzH8mFVzlJ2kUo4ebcXFbOp6Qtyf0NZBh5JozmF40hghxnyDtHlAYKDmGQfE0xjArgyWasm/tSZeoXTjxYhBmaucM/FIcqd4lnlFyqCjt7e4ciNIGih5I9fGGKXp1xlqtKWTYmUZRgAHVouTyn9fTXdfKt5G3+lppFWS/6sUUY8j+j80uEYW74QCd466jhvXbw58aMyCcu+nIOybYlGAwr5xFICWDe3VAlzBQ6FWbvslj3xFstFOrAMMh+D3soGJJ2FIGiCSDciIG1wH5d5X/xJsiDqxmcIrXoH6SmrPRiA/iYZNUTdwL8ACog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuHhcZH5ywJgwCdvjSedYp/UsqNIg3iEujPCcQT8y2k=;
 b=Pq11+qNt3NhH1BAR1ckfqNA/sJeU9Pmpg2bY4zE/aFX6UkaJnvP1dsNT3bBUMMIYuTou1ggb9yUrjeGjSQXVJhUi96vvLFedWE3ORf7bBfeBnTnityDwrmxl/ck/9z37YK+nJboO7YY4stpbEa91smmcXneBSUAxEPGEs4XCams=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1412.namprd21.prod.outlook.com (2603:10b6:a03:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.3; Tue, 24 Aug
 2021 17:30:48 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4436.016; Tue, 24 Aug 2021
 17:30:48 +0000
From:   Long Li <longli@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiDgHJZXiucJEOu37Y9ArQK+auClLAAgABU5cA=
Date:   Tue, 24 Aug 2021 17:30:48 +0000
Message-ID: <BY5PR21MB1506884F67EFBDB6804ECCB0CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824122504.GA3452187@bjorn-Precision-5520>
In-Reply-To: <20210824122504.GA3452187@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d36b16f6-1ee6-4e67-9d64-e8d071f7ea0e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T17:28:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b9b47bb-e7cb-4953-a04d-08d96724e9b7
x-ms-traffictypediagnostic: BY5PR21MB1412:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR21MB1412C1672E9A8B8B2CF88392CEC59@BY5PR21MB1412.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjLg6d18eP71G22TOFuS4q4ZBGkP13TzNRJauUUEKUIu5AP0nfgEsKcY+MN/tjQGvDfu3E6lekgp8tspfCUdEeOhP3oG1g5TVYPH9O3AGkG/+eLG+O0Es8pSQ4+n76kzcMA6jDMPi8wUgAJKZCL6GfysYw9+naZYk/wRkPWtz3nu0u0JB2ahZV/PodvoETMKBVUf39aKnAkSR02kDrOGKnoLPuoJlKyC2M7r89O7uV9uomOYWVw1EzzvRrmUndunaFuaTXo+BMJpjNVbX6A0yTzBpHpY1iXmQkv9/nkH+sI7MfIusNpUCGTT1ZnyIoh8s2qpogUoCdVNmTZicbUAdLkGUdFPeWrwdZTZMFSPFHmRKYBEmkdQW3lnvwLrv/XiA6shV/OfJq4FLhJtoqrO5C9GnKtOfH2iPlXVxCwVn7s0xybeHQK+oEfJiizD6Fc02MXRxAd8HPZZh+DDN438WRRe9tytDLDT0JtxObrlBEKTKR5qxYZDa5iEKkIY2JJgxtoGoyI2+IZYPBSswFEwZPvTEArJaAQ6MOjZ0fkcgNP7LNwzU0lSVK2sjscy57K7/otZF+yCCfG9WONLfUijHEIgXVuqsOgEcrh0FbpdIkJAkbEBXmQKQS4FqIXOhcZDNI790IloDHlwgVMHfZqa0LrQ5yHy6LhVwtCgJAk9woKhCgj0ZA0ccISgoj50TqgkU/Ax7Y2TbspZJ+AFqlGGuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(66946007)(9686003)(66476007)(316002)(54906003)(2906002)(7696005)(83380400001)(64756008)(55016002)(66446008)(82960400001)(82950400001)(66556008)(66574015)(38100700002)(33656002)(26005)(122000001)(508600001)(10290500003)(71200400001)(4326008)(8936002)(6506007)(5660300002)(86362001)(186003)(110136005)(7416002)(76116006)(8676002)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1lleFcxMmtOQURZUmRvczhOeFZyNkZTc1BHWkJWLzZpV0IxZzJFc0tNb1oy?=
 =?utf-8?B?K1d3VEgrUlI0bDRQRmNpYy9Da0RNTVdiT0c3N1pJMjV4SERGNDFTdFJXbWdq?=
 =?utf-8?B?cytoN1hxRkdVbk5hSlhIVE1DV0ZhSTRHUXI2a0Q4YVFiZ1FRSTVXeVJnZmxa?=
 =?utf-8?B?ZW94OWczRk5kS0FKamIzT3FreDJpUjE1VmI5VVBXbHRCV3hWT1Rqa2pJOG83?=
 =?utf-8?B?QU02UjgyVHpCTUZPVkJtNHpVRWNnNU9QcTArdFUrQ1ZTdGx5K3ZrelVyN2Ni?=
 =?utf-8?B?ZGowT1ZKek1ZaWl3bnM2djVSNTFGVERrY3dFTnk4azNYMXNacjZxRElUVHpM?=
 =?utf-8?B?dlhtVEJFb2c0cE9MWUZSN0JIMWhRZjBrZnlpSE95Q3BKSEhQY3YzcWRjdWdM?=
 =?utf-8?B?eDF1RTkyT3ZKZFZ1c2pHTkRWWEpNVXRUUkpkS3hEWGloNmNHQ1N0eUpwdTJ4?=
 =?utf-8?B?aUl6MS9EZWVvY0c5RGE5RDFUUk9iaFFtWlVwZmhkaXBMNnRWQS8rM3dob1M0?=
 =?utf-8?B?VWdueXZIOGw3QVhGbzNQSzliUzd4d3lDMHBWUFdCK0NMbEdWVlR0ZW5VbE1z?=
 =?utf-8?B?SSs0Z0w4eWNCb28xb3hTMGZqdHU1TndvQTNSN1lCMVA4dWlDRllwUk5KcG1G?=
 =?utf-8?B?U2dJNHJLamZVSU54RGZTRDRqM1hOTDliek4wUVM0NFQybmU3aWZlWnRNRlpG?=
 =?utf-8?B?STdFeFk1dm9iRG8zWFA1cE9ZV1VMcUlxWGR5MU9kTlB3ejJrQi82a2ZUSnZ4?=
 =?utf-8?B?SDdLR3dlRTMwNEFkdWRjc05SdVlacE4wY2tLNGtmbmdJRjF3TlhxdkU0d0da?=
 =?utf-8?B?Y3VxZVdkc3RKYTg0SFhrYzFIN1E0STExcmRROXpYRGg2VnYxaXU5eFpXSlZO?=
 =?utf-8?B?c2Yyd0s5aHZ3SkIxN1RGb3p0ZFpzT3BRdFA0L1UyUlFmdW1ZOEZ3STF3MjRR?=
 =?utf-8?B?ckRXZ2pwY1FHbGxoMmVuS2FhWWpNMFNNSFl4RzVYak5BU2k4QXpoMGtEbjdP?=
 =?utf-8?B?YWJmL3Y0RHgrYTZQZmVFc0toeHBZTGU4cWU1bEJtZUc0T3JUMEdFUlNtR085?=
 =?utf-8?B?NnVoUFExTWRhK1pNbzFwMnVyTWtjMyttTzNzRFFPWTREUXdjNk5DbkwwMlVx?=
 =?utf-8?B?bmNLMW4xRTRlMWNZTEtrdnNDcGlmbVBGMW8rc1Q5WEdWblRPc0QyeU9rdzFM?=
 =?utf-8?B?cHpWaFM4Y09kbTRqWVFqQ0h4YkN6Nmo4SHhBaHBWczlzWkxpVXY0azI0L2d2?=
 =?utf-8?B?TkNhUFBYM0hvcTRES2I0NnJnOEkrQ2liK3VmMWNsYUVqazRoVnB4WnNzSnhL?=
 =?utf-8?B?MjUxUHFGb0JubitucDhUN2VFWmczYTJ6aTdkWGZpcDFubEN4bndYSXVzV1pG?=
 =?utf-8?B?elZtaUVvaktFaGtDOUQxSUVtbmNjbmt6K01OZTZSdERsZTBkYlVQV202aU1a?=
 =?utf-8?B?ZGlrMVdzT3c3RHVIN2NIaGZZWW5VSnBkOTdRakVTRmFtYjFEcmRNTit3b2pO?=
 =?utf-8?B?TERWY1hhREpaa3cyelM2MmVxVXduZElwM0wvcUZQQ3h4QlRDMkRsaTExQWdx?=
 =?utf-8?B?Vy9ZVnVTbEN6djJVQ0NYSmR5OWtsRDRhUU9LSUEzNzkxUXRtLzhPWk1UQUhV?=
 =?utf-8?B?czJoMmxWcnl6Q3A1SUlKM2NMbzR0ME5oODVZRzJuVWxKTWhDYlIxMk5uMVZu?=
 =?utf-8?B?eUtQUXVsMW1XTmNjRi9KQytMUkVJRWQ5M3l2MnRjb1hYbk9pVVlnRVhaYXgr?=
 =?utf-8?Q?AM322LVZ7HE19ACQzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9b47bb-e7cb-4953-a04d-08d96724e9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 17:30:48.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptogMimf9PfHZKNgwl5ntWYrEzFh7TOaDFKunwTkXTYAckiIHyIJ/tsCiVFYHedlgS3nUrbPsPI9uvGDMAFuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1412
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGh2OiBGaXggYSBidWcgb24gcmVtb3ZpbmcgY2hp
bGQgZGV2aWNlcyBvbiB0aGUgYnVzDQo+IA0KPiAiRml4IGEgYnVnIC4uLiIgaXMgbm90IGEgdmVy
eSB1c2VmdWwgc3ViamVjdCBsaW5lLiAgSXQgZG9lc24ndCBzYXkgYW55dGhpbmcgYWJvdXQgd2hh
dA0KPiB0aGUgcGF0Y2ggKmRvZXMqLiAgSXQgZG9lc24ndCBoaW50IGF0IGEgbG9ja2luZyBjaGFu
Z2UuDQo+IA0KPiBPbiBUdWUsIEF1ZyAyNCwgMjAyMSBhdCAxMjoyMDoyMEFNIC0wNzAwLCBsb25n
bGlAbGludXhvbmh5cGVydi5jb20gd3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1p
Y3Jvc29mdC5jb20+DQo+ID4NCj4gPiBJbiBodl9wY2lfYnVzX2V4aXQsIHRoZSBjb2RlIGlzIGhv
bGRpbmcgYSBzcGlubG9jayB3aGlsZSBjYWxsaW5nDQo+ID4gcGNpX2Rlc3Ryb3lfc2xvdCgpLCB3
aGljaCB0YWtlcyBhIG11dGV4Lg0KPiANCj4gSXQncyB1bmZvcnR1bmF0ZSB0aGF0IHNsb3RzIGFy
ZSBub3QgYmV0dGVyIGludGVncmF0ZWQgaW50byB0aGUgUENJIGNvcmUuICBJJ20gc29ycnkNCj4g
eW91ciBkcml2ZXIgZXZlbiBoYXMgdG8gd29ycnkgYWJvdXQgdGhpcy4NCj4gPg0KPiA+IFRoaXMg
aXMgbm90IHNhZmUgZm9yIHNwaW5sb2NrLiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIGNoaWxkcmVu
IHRvIGJlDQo+ID4gZGVsZXRlZCB0byBhIGxpc3Qgb24gdGhlIHN0YWNrLCBhbmQgcmVtb3Zpbmcg
dGhlbSBhZnRlciBzcGlubG9jayBpcw0KPiA+IHJlbGVhc2VkLg0KPiA+DQo+ID4gRml4ZXM6IDk0
ZDIyNzYzMjA3YSAoIlBDSTogaHY6IEZpeCBhIHJhY2UgY29uZGl0aW9uIHdoZW4gcmVtb3Zpbmcg
dGhlDQo+ID4gZGV2aWNlIikNCj4gPg0KPiA+IENjOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0Bt
aWNyb3NvZnQuY29tPg0KPiA+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQu
Y29tPg0KPiA+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4N
Cj4gPiBDYzogV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiA+IENjOiBEZXh1YW4gQ3Vp
IDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiA+IENjOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gPiBDYzogIktyenlzenRvZiBXaWxjennFhHNraSIgPGt3QGxpbnV4LmNvbT4NCj4gPiBD
YzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gPiBDYzogTWljaGFlbCBL
ZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+ID4gQ2M6IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiANCj4gQSBsb3JlIGxpbmsgdG8gRGFuJ3MgcmVw
b3J0IHdvdWxkIGJlIHVzZWZ1bCBoZXJlLg0KDQpJIHdpbGwgYWRkcmVzcyB5b3VyIGNvbW1lbnRz
IGFuZCBzZW5kIHYyLg0KDQpMb25nDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8
bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLWh5cGVydi5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+IGluZGV4IGE1M2JkODcyOGQwZC4uZDRmM2NjZTE4
OTU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5j
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gPiBAQCAt
MzIyMCw2ICszMjIwLDcgQEAgc3RhdGljIGludCBodl9wY2lfYnVzX2V4aXQoc3RydWN0IGh2X2Rl
dmljZSAqaGRldiwNCj4gYm9vbCBrZWVwX2RldnMpDQo+ID4gIAlzdHJ1Y3QgaHZfcGNpX2RldiAq
aHBkZXYsICp0bXA7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAJaW50IHJldDsN
Cj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgcmVtb3ZlZDsNCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAq
IEFmdGVyIHRoZSBob3N0IHNlbmRzIHRoZSBSRVNDSU5EX0NIQU5ORUwgbWVzc2FnZSwgaXQgZG9l
c24ndCBAQA0KPiA+IC0zMjI5LDkgKzMyMzAsMTggQEAgc3RhdGljIGludCBodl9wY2lfYnVzX2V4
aXQoc3RydWN0IGh2X2RldmljZSAqaGRldiwgYm9vbA0KPiBrZWVwX2RldnMpDQo+ID4gIAkJcmV0
dXJuIDA7DQo+ID4NCj4gPiAgCWlmICgha2VlcF9kZXZzKSB7DQo+ID4gLQkJLyogRGVsZXRlIGFu
eSBjaGlsZHJlbiB3aGljaCBtaWdodCBzdGlsbCBleGlzdC4gKi8NCj4gPiArCQlJTklUX0xJU1Rf
SEVBRCgmcmVtb3ZlZCk7DQo+ID4gKw0KPiA+ICsJCS8qIE1vdmUgYWxsIHByZXNlbnQgY2hpbGRy
ZW4gdG8gdGhlIGxpc3Qgb24gc3RhY2sgKi8NCj4gPiAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmaGJ1
cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KPiA+IC0JCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZShocGRldiwgdG1wLCAmaGJ1cy0+Y2hpbGRyZW4sDQo+IGxpc3RfZW50cnkpIHsNCj4gPiAr
CQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaHBkZXYsIHRtcCwgJmhidXMtPmNoaWxkcmVuLA0K
PiBsaXN0X2VudHJ5KQ0KPiA+ICsJCQlsaXN0X21vdmVfdGFpbCgmaHBkZXYtPmxpc3RfZW50cnks
ICZyZW1vdmVkKTsNCj4gPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoYnVzLT5kZXZpY2Vf
bGlzdF9sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJCS8qIFJlbW92ZSBhbGwgY2hpbGRyZW4g
aW4gdGhlIGxpc3QgKi8NCj4gPiArCQl3aGlsZSAoIWxpc3RfZW1wdHkoJnJlbW92ZWQpKSB7DQo+
ID4gKwkJCWhwZGV2ID0gbGlzdF9maXJzdF9lbnRyeSgmcmVtb3ZlZCwgc3RydWN0IGh2X3BjaV9k
ZXYsDQo+ID4gKwkJCQkJCSBsaXN0X2VudHJ5KTsNCj4gPiAgCQkJbGlzdF9kZWwoJmhwZGV2LT5s
aXN0X2VudHJ5KTsNCj4gPiAgCQkJaWYgKGhwZGV2LT5wY2lfc2xvdCkNCj4gPiAgCQkJCXBjaV9k
ZXN0cm95X3Nsb3QoaHBkZXYtPnBjaV9zbG90KTsNCj4gPiBAQCAtMzIzOSw3ICszMjQ5LDYgQEAg
c3RhdGljIGludCBodl9wY2lfYnVzX2V4aXQoc3RydWN0IGh2X2RldmljZSAqaGRldiwNCj4gYm9v
bCBrZWVwX2RldnMpDQo+ID4gIAkJCXB1dF9wY2ljaGlsZChocGRldik7DQo+ID4gIAkJCXB1dF9w
Y2ljaGlsZChocGRldik7DQo+ID4gIAkJfQ0KPiA+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmhidXMtPmRldmljZV9saXN0X2xvY2ssIGZsYWdzKTsNCj4gPiAgCX0NCj4gPg0KPiA+ICAJcmV0
ID0gaHZfc2VuZF9yZXNvdXJjZXNfcmVsZWFzZWQoaGRldik7DQo+ID4gLS0NCj4gPiAyLjI1LjEN
Cj4gPg0K
