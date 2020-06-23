Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C252066BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2020 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFWV7M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Jun 2020 17:59:12 -0400
Received: from mail-eopbgr1300128.outbound.protection.outlook.com ([40.107.130.128]:7091
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388129AbgFWV7L (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 17:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYTmYD4vXx4KbwhbB2n8cdcUKeLis2WjLv7U/t2728PmQBzST8bB0vuxaefvgNYRHWD59Ovb8xcnWSyg53Dk6K8Jqbb7RX4NTPCOhGwvzC+VmOkoltcFmlv6kCGC4v9w9ZAV8yC11yPjJ1V1IQcSliTAcWTZvWtmGoxoA+dKJ7iQfYfSFZaJW4ghI15/y4HVP/WDbUKHcBmWgBO0A5BLPuQc8fWWcTDjBpa4uW3sLguwk2jqeHfAIqO7q5zFBmuAHm3FNxZAVx8fE6B28me0c3kBSPquCN9aBd+PXyT/CBTbalCbJ1QodXMxIkGdN0LhusRM5pJWHe2PlHTwxosXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUw8kj4pMit4w++oiP2XnejfkjWpoQoPWXxynRs9qk=;
 b=dJCXLJ6pBUYyxhNeVRIay7nTjRx0hVQ3Fq52WzO1/Cv4WtoOc10LLXPJ0QHHRAL6vynu4fXaexw/qdc1DXk81cq7NunPzHL5WAWW8fpbv+Mk0Zj6HdxY+X7VwnUXvCwLS6O2YDTIhBx9j31KwIATvTFfsbPpkPiXsruuVg5b36C7VGCWDSFJXqwLne+kxnBLD9MqmSV1LpH1UJuB8t2wgj7xI13t4UXlIuM89pBH27fezBz9xJUlxCXkvJVOSg8/AB+1H7cDINsoIAkC9qIWzuMt4qTcLSlFyCKmjureTnbcjgqUiMcSLAoGbI/R0sJfg9gjKfmedZGwNIhnAgyogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUw8kj4pMit4w++oiP2XnejfkjWpoQoPWXxynRs9qk=;
 b=LqpcGiG/0B6knSbukSbXOQzYaZau1qRg2+6w5KpyYN9fjdESVuY1pEtjJqoJq+M/eDgj1Y027KFuVqg0BIMzr9RxiHlvm71BDRsg0VQzOZQQhFbl6MaOpHypqEOta685kAWAYl51zH87xxrsnmLEYFaLm3LyL7Vdkp/FiTMRI7E=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK2P15301MB0226.APCP153.PROD.OUTLOOK.COM (2603:1096:202:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.2; Tue, 23 Jun
 2020 21:58:58 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%7]) with mapi id 15.20.3153.009; Tue, 23 Jun 2020
 21:58:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Deepak Rawat <drawat.floss@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Wei Hu <weh@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
Thread-Topic: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
Thread-Index: AQHWSIVPTyd7nwDoi0OeDECzal8UNajldhsQgABNjYCAAPRs4A==
Date:   Tue, 23 Jun 2020 21:58:57 +0000
Message-ID: <HK0P153MB03226AB1A353EDFD62EA4ECDBF940@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <HK0P153MB03224C17D736FF164209F6DABF940@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <aa7ab349ff502390edea4fd5721dbd64a0997216.camel@gmail.com>
In-Reply-To: <aa7ab349ff502390edea4fd5721dbd64a0997216.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-23T21:58:55Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef24b0c2-13b3-48e5-a3f6-ad284d7dad1a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:6076:3614:38fb:cfca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d86f8fe1-e901-4e40-7b20-08d817c0a173
x-ms-traffictypediagnostic: HK2P15301MB0226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2P15301MB02269F9AE9183636F1FE16B6BF940@HK2P15301MB0226.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBeLxK3oZxyGGhW5qVvsCtNdwLAZL3wNyDa7LMVRzq1nkM82fI/647qVwZ2K0joFF6kaOxYGvLWGPlaAJ3Qca+0SP6lu5Anjc9YzVHCPNbgdMh8QLOUbMlu0WXrSEHxe44qjZmOFJcotU9PwsQiURgVUkgpkwLGcOIbZjPgUwREgSsH3A+68qeohsQrorVPd22jJ5zSXB24HVxh7b5cG1JuxG/dSnKaAq+4mDGUelpW+1Cd9IekE3vlpTrO8sk0MtaQ9lH5ugUpIEDeBg5n1TnCUo9Oy51XJvt/iYoX6fYw4c8xTzgmRmpRabtUZSrba4AgXzVav7GMPEuh8W2sDww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(8990500004)(76116006)(66446008)(83380400001)(82950400001)(82960400001)(66476007)(71200400001)(66946007)(66556008)(7696005)(186003)(33656002)(86362001)(6506007)(316002)(110136005)(64756008)(54906003)(478600001)(5660300002)(2906002)(9686003)(107886003)(8676002)(10290500003)(4326008)(52536014)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6eDNq0Y0datH7Vl6Pici0RDU0GEp8hjvRC5RyQoXUJCB7PI5wo3nYnDSlCqS8mm2oRn4WhdmFf+gcMcLs8c4/ZxD8zwLxwqgpPJmARkFcQIdDlN2dd73uw7zt9ucMFDfgIiVb1sKJrF32npEUhQkyOyylQcmXKYm0BhMODt/3HeLyj6uGYnbT80RoDhM7w5fLDi0wjHh63NgExrbH7l7BXlQSP299xinWBiuBLy2YMP+HxvXRa+3LtcM5HzXjJFoL8zR0HK4gTpzDVxeTOfFEoKqu8Q3dXrVMOhNvNnk1Ee0YBFtLmQx/jvvS4mtharZCeUx3TvtyWoK4+n82ut/OcORUG8MXXHxhRW0llM+D0GWDDTWgIVoky4oOhgYeyWRd2+zrNYg+aQkU9sjP9u9Jr9ok8nlOk8ZVKAVg5bfpjwzcBJ+ThfOjC+GKCASjWoW8oD2jUt6IUeN1vqNAIjS/CNzB1zagIdOT2Ilbpn46DgCLdt2zk5qjbxcrHQtC+3IwHVPSxNNje8uSWRFNgs4HY6HTMDoRwo/IEaNfHu43yJSiTNYcPqscO1Gyp4+9/d8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f8fe1-e901-4e40-7b20-08d817c0a173
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 21:58:57.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: my7K4gViMY7HTeJ4BBM88R3FaiZa8yVMSbb+O1mVHZKH/hlrut1rfhUb8aX/daQPhG6YwVS0opNQfe8enkd17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2P15301MB0226
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1oeXBl
cnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgRGVlcGFrIFJhd2F0DQo+IFNl
bnQ6IE1vbmRheSwgSnVuZSAyMiwgMjAyMCAxMTo0OSBQTQ0KPiA+IFsuLi5dDQo+ID4gU29tZSBx
dWljayBjb21tZW50czoNCj4gPiAxLiBoeXBlcnZfdm1idXNfcHJvYmUoKSBhc3N1bWVzIHRoZSBl
eGlzdGVuY2Ugb2YgdGhlIFBDSSBkZXZpY2UsDQo+ID4gd2hpY2gNCj4gPiBpcyBub3QgdHJ1ZSBp
biBhIEh5cGVyLVYgR2VuZXJhdGlvbi0yIFZNLg0KPiANCj4gSSBndWVzcyB0aGF0IG1lYW4gZm9y
IEdlbi0yIFZNIG5lZWQgdG8gcmVseSBvbiB2bWJ1c19hbGxvY2F0ZV9tbWlvIHRvDQo+IGdldCB0
aGUgVlJBTSBtZW1vcnk/IEZyb20gd2hhdCBJIHVuZGVyc3RhbmQgdGhlIHBjaSBpbnRlcmZhY2Ug
YW55d2F5DQo+IG1hcHMgdG8gdm1idXMuDQoNCkluIGEgSHlwZXItViBHZW5lcmF0b24tMiBWTSwg
dGhlcmUgaXMgbm90IHRoZSBsZWdhY3kgSHlwZXItViBQQ0kgZnJhbWVidWZmZXINCmRldmljZSwg
c28gd2UgaGF2ZSB0byBjYWxsIHZtYnVzX2FsbG9jYXRlX21taW8oKSB0byBnZXQgYSBwcm9wZXIg
TU1JTyANCnJhbmdlIGFuZCB1c2UgdGhhdCBhcyB0aGUgVlJBTSBtZW1vcnkuDQoNCkJUVywgd2hh
dCdzIHRoZSBlcXVpdmxlbnQgb2YgRkJfREVGRVJSRURfSU8gaW4gRFJNPyBIYXZlIHRoZSBwYXRj
aA0KaW1wbGVtZW50ZWQgdGhlIHNpbWlsYXIgdGhpbmcgZm9yIERSTSBsaWtlIHRoaXMgZm9yIEZC
IGluIHRoaXMgcGF0Y2g6DQpkMjE5ODdkNzA5ZTggKCJ2aWRlbzogaHlwZXJ2OiBoeXBlcnZfZmI6
IFN1cHBvcnQgZGVmZXJyZWQgSU8gZm9yIEh5cGVyLVYgZnJhbWUgYnVmZmVyIGRyaXZlciIpDQoN
ClRoZXJlIGlzIGFsc28gYW5vdGhlciBpbXBvcnRhbnQgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQg
cGF0Y2g6DQozYTZmYjZjNDI1NWMgKCJ2aWRlbzogaHlwZXJ2OiBoeXBlcnZfZmI6IFVzZSBwaHlz
aWNhbCBtZW1vcnkgZm9yIGZiIG9uIEh5cGVyViBHZW4gMSBWTXMuIikNCklzIHRoZSBzYW1lIGlk
ZWEgYXBwbGljYWJsZSB0byB0aGlzIERSTSBwYXRjaD8NCg0KVGhlIHBjaS1oeXBlcnYgRkIgZHJp
dmVyIGFuZCB0aGlzIERSTSBkcml2ZXIgc2hvdWxkIG5vdCB0cnkgdG8gbG9hZCBhdA0KdGhlIHNh
bWUgdGltZS4gTm90IHN1cmUgd2hhdCBzaG91bGQgYmUgZG9uZSB0byBtYWtlIHN1cmUgdGhhdCB3
b24ndCBoYXBwZW4uDQoNCj4gPiAyLiBJdCBsb29rcyBzb21lIG90aGVyIGZ1bmN0aW9uYWxpdHkg
aW4gdGhlIGh5cGVydl9mYiBkcml2ZXIgaGFzIG5vdA0KPiA+IGJlZW4NCj4gPiBpbXBsZW1lbnRl
ZCBpbiB0aGlzIG5ldyBkcml2ZXIgZWl0aGVyLCBlLmcuIHRoZSBoYW5kbGluZyBvZiB0aGUNCj4g
PiBTWU5USFZJRF9GRUFUVVJFX0NIQU5HRSBtc2cuDQo+IA0KPiBJIGRlbGliZXJhdGVseSBsZWZ0
IHRoaXMgYW5kIHRoaW5ncyBzZWVtcyB0byB3b3JrIHdpdGhvdXQgdGhpcywgbWF5YmUgSQ0KPiBu
ZWVkIHRvIGRvIG1vcmUgdGVzdGluZy4gSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB0aGUgdXNl
LWNhc2UNCj4gb2YgU1lOVEhWSURfRkVBVFVSRV9DSEFOR0UuIEkgb2JzZXJ2ZWQgdGhpcyBtZXNz
YWdlIHdhcyByZWNlaXZlZCBqdXN0DQo+IGFmdGVyIHZtYnVzIGNvbm5lY3QgYW5kIERSTSBpcyBu
b3QgeWV0IGluaXRpYWxpemVkIHNvIG5vIHBvaW50IHVwZGF0aW5nDQo+IHRoZSBzaXR1YXRpb24u
IEV2ZW4gb3RoZXJ3aXNlIHNpdHVhdGlvbiAobW9kZSwgZGFtYWdlLCBldGMuKSBpcw0KPiB0cmln
Z2VyZWQgZnJvbSB1c2VyLXNwYWNlLCBub3Qgc3VyZSB3aGF0IHRvIHVwZGF0ZS4gQnV0IHdpbGwg
ZGVmaW5pdGVseQ0KPiBjbGFyaWZ5IG9uIHRoaXMuDQoNCldoZW4gTGludXggVk0gdXBkYXRlcyB0
aGUgVlJBTSwgTGludXggc2hvdWxkIG5vdGlmeSB0aGUgaG9zdCBvZiB0aGUNCmRpcnR5IHJlY3Rh
bmdsZSwgYW5kIHRoZW4gdGhlIGhvc3QgcmVmcmVzaGVzIHRoZSByZWN0YW5nbGUgaW4gdGhlIFZN
DQpDb25uZWN0aW4gd2luZG93IHNvIHRoZSB1c2VyIHNlZXMgdGhlIHVwZGF0ZWQgcGFydCBvZiB0
aGUgc2NyZWVuLg0KDQpJIHJlbWVtYmVyIHdoZW4gdGhlIHVzZXIgY2xvc2VzIHRoZSBWTSBDb25u
ZWN0aW9uIHdpbmRvdywgdGhlIGhvc3QNCnNlbmRzIHRoZSBWTSBhIG1zZyB3aXRoIG1zZy0+ZmVh
dHVyZV9jaGcuaXNfZGlydF9uZWVkZWQ9MCwgc28gdGhlIFZNDQpkb2Vzbid0IGhhdmUgdG8gbm90
aWZ5IHRoZSBob3N0IG9mIHRoZSBkaXJ0eSByZWN0YW5nbGU7IHdoZW4gdGhlIFZNDQpDb25uZWN0
aW9uIHByb2dyYW0gcnVucyBhZ2FpbiwgdGhlIFZNIHdpbGwgcmVjZWl2ZSBhIG1zZyB3aXRoDQpt
c2ctPmZlYXR1cmVfY2hnLmlzX2RpcnRfbmVlZGVkPTEuDQoNClRoYW5rcywNCi0tIERleHVhbg0K
DQo=
