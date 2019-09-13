Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62DB26E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 22:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfIMUyi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 16:54:38 -0400
Received: from mail-eopbgr1310115.outbound.protection.outlook.com ([40.107.131.115]:6326
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfIMUyi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 16:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhEKuXM2twHpOYZw6+3wUNVG46iuL5S1Uj7SA+QKFas+0kZsz3Lt6x5NWmx5NF0nvx8WJV+f84mPS+gwD3J6tHsw/XfK4j2MO4ivZtynnMkITzvRlzc6E/MaklPSuDL9izVMNW0gLRPHSgPZBlAU70uQrtEtomb4SGQwBH5yj1AyAEEkYclkM/bZoLyGFcd4qxyUfA41CryXlwSMzKY56dML7q/tOEKNbWeKSVG8rAQc+hbFp70NQGSEkMPxrx936IdScgYocK5YJ4AdugOgnDZVnPXBh3ZzCSkv6sW2QEB4oxecqZMbXqVxnCeUg1dyTdLsjjhGJ9Cv6BCIm6nSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgIoqdT7T1hU2kO89WRdJrrxvzrDd6KNJc3Qqw6O+AE=;
 b=HvXAaPRUSP+6P6govXY+j137dMDTKVE5HOWhi8Q+r6VfpSZxT2pbYZMRnX+uJ1DBs3y0kF088YmWX+gpQL1A2t/d3ec+qc4Vw9R04gKLLFEomLm1Jq3nESoseGPdW/xhWRn5tzOyKZ0KeRjsvNPvlQyrbM/p/yB3+chBZIaeeWpki20oTcW4SA/h/1lPDGnmI58c/PPha1wNi4zLfPggt3I1es6QKH6pX29CSDfBknlfdTNFbbeKuKgtKYq9AXvc9eIKWP0wRT85UWq6vS6DEUUmsvC3gpbcfdQnbr9/DSjBlEoEMGzTV99OC8XXUkAG2so3bjvhd9Jummn6truLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgIoqdT7T1hU2kO89WRdJrrxvzrDd6KNJc3Qqw6O+AE=;
 b=apGWWVAeBkglnC5t+cfW7894jOxlfNIsRppl82CjIGKSBetKGN3+hI8BVdVl3ojyZzereFtv0InXTewWsa9Ig+TBKQ435Wjy3EubqrQICCFIqtuFbElfJUjd46OHXEgLMY+jBDdj05KButsFxjCot0Kr/eJv9J0GrLIBxzCLRtM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0108.APCP153.PROD.OUTLOOK.COM (10.170.188.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.10; Fri, 13 Sep 2019 20:54:27 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.009; Fri, 13 Sep 2019
 20:54:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Add the support of hibernation
Thread-Topic: [PATCH] hv_balloon: Add the support of hibernation
Thread-Index: AQHVaVISraz6+BtHYEamhMlzHx+g16coS8YAgADwLwCAAMMQUA==
Date:   Fri, 13 Sep 2019 20:54:26 +0000
Message-ID: <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
 <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
In-Reply-To: <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-13T20:54:25.2162824Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab38279b-cba9-4b2a-b491-af6eb9f38d3a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 861c4f49-c133-4176-8855-08d7388c90e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0108;
x-ms-traffictypediagnostic: PU1P153MB0108:|PU1P153MB0108:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB01083D60836103757D323916BFB30@PU1P153MB0108.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39840400004)(396003)(376002)(346002)(366004)(189003)(199004)(11346002)(486006)(33656002)(66066001)(446003)(76176011)(81156014)(8676002)(66476007)(2501003)(476003)(26005)(64756008)(66556008)(66946007)(53546011)(10290500003)(66446008)(102836004)(1511001)(305945005)(6506007)(76116006)(74316002)(186003)(229853002)(7736002)(316002)(22452003)(110136005)(6436002)(14454004)(478600001)(966005)(7696005)(25786009)(99286004)(6246003)(53936002)(55016002)(6306002)(81166006)(52536014)(2201001)(3846002)(6116002)(6636002)(9686003)(256004)(14444005)(86362001)(10090500001)(71190400001)(71200400001)(8936002)(2906002)(5660300002)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0108;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ABKUpJkfIrZDpGAqB7UcGOg6nN+J6G+LsJKAOL68zFb6QJcTLN+gG+rPj3HkrvdBjl813b46YfHu31fP6MZz5igR8HMUdleKrp/GoMHl+QeIfFFEXWvf6Y7zb537r+3I43sR72/84XLj0wJNg1owplBoD7QXl76zPOPoF1Sk8RgI0SdZ9SNNNYVhhazq2hq+TKIkj7yC9gfs+hhTM8/E+59J5ETL6RH/DHSI37IXtCGC4tBRpua/zxHJZ8AdVtHD4RgVKcjKnEw6Z30KyzYSMsi/apIwfFdXFu7TKbG/6562DAJ5mlv+oLrVMGIg0oTrXGkIokqnPrPpRVeQ12KPNyI7432zLrtNIDTo18SNDubgXQj7fRI4bvW0S+vEgD78+1S1CRbBRe9O0tZyYnsli3Tq/dHgjk56KGj3CXvjPFI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861c4f49-c133-4176-8855-08d7388c90e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 20:54:26.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+95rglwvB9ZyJKoT7OZ1W1mZXuB91zWGlE2S1UtxA+2OHgptJMjOfoBAqVusk71DB23uG57yZzeXz2J7di7yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0108
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMTkgMTI6NDYgQU0NCj4gDQo+IE9uIDEyLjA5LjE5IDIxOjE4
LCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IDMuIEhpYmVybmF0aW9uIGNhbiBiZSBlc3BlY2lhbGx5
IHVzZWZ1bCB3aGVuIHdlIHBhc3MgdGhyb3VnaCBhIFBDSWUgZGV2aWNlLA0KPiA+IGUuZy4gYSBO
SUMsIGEgTlZNZSBjb250cm9sbGVyIG9yIGEgR1BVLCB0byB0aGUgVk0sIGFzIHVzdWFsbHkgc2F2
ZS9yZXN0b3JlDQo+ID4gYW5kIGxpdmUgbWlncmF0aW9uIGNhbiBub3Qgd29yayB3aXRoIHRoaXMg
a2luZCBvZiBjb25maWd1cmF0aW9uLCBiZWNhdXNlDQo+ID4gdXN1YWxseSB0aGUgaG9zdCBkb2Vz
bid0IGtub3cgaG93IHRvIHNhdmUvcmVzdG9yZSB0aGUgc3RhdGUgb2YgdGhlIFBDSWUNCj4gPiBk
ZXZpY2UuDQo+IA0KPiBJbnRlcmVzdGluZy4gVW5kZXIgUUVNVS9LVk0gKGVzcGVjaWFsbHkgZm9y
IG1pZ3JhdGlvbiksIHRoZSBkaXNjdXNzZWQNCj4gc29sdXRpb25zIEkgYW0gYXdhcmUgb2YgcmF0
aGVyIHdhbnRlZCB0byB0ZW1wb3JhcmlseSB1bnBsdWcgdGhlIFBDSQ0KPiBkZXZpY2VzIG9yIHJl
cGxhY2UgdGhlbSB3aXRoIHNvbWUga2luZCBvZiAic3RhbmRieSIgZGV2aWNlIHRlbXBvcmFyaWx5
Lg0KDQpGb3IgdGhlIGNvbXBsZXggZGV2aWNlcyBsaWtlIGEgbW9kZXJuIEdQVSwgdGhlcmUgbWF5
IG5vdCBiZSBhbiANCmVxdWl2YWxlbnQgInN0YW5kYnkiIHNvZnR3YXJlLWVtdWxhdGVkIGRldmlj
ZSBmb3IgaXQsIGFuZCB1bnBsdWdnaW5nIHRoZQ0KUENJIGRldmljZSB0ZW1wb3JhcmlseSBpcyBu
b3QgZ29vZCwgYXMgaXQgbWF5IG5vdCBiZSB0cmFuc3BhcmVudCB0byB0aGUNCnVzZXJzcGFjZSBh
cHBsaWNhdGlvbnMuIEhpYmVybmF0aW9uIGhlcmUgaXMgZXNwZWNpYWxseSB1c2VmdWwsIGUuZy4g
dG8gVmlydHVhbA0KRGVza3RvcCBJbmZyYXN0cnVjdHVyZSB1c2VycyB3aG9zZSBWTXMgY2FuIG93
biBwaHlzaWNhbCBHUFVzLCBiZWNhdXNlDQphbGwgdGhlIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMg
YXJlIGZyb3plbiB3aGVuIHRoZSBWTSBpcyBoaWJlcm5hdGVkLCBhbmQNCndoZW4gdGhlIFZNIHJl
c3VtZXMgYmFjaywgdGhlIGFwcGxpY2F0aW9ucyBhcmUgYXV0b21hdGljYWxseSByZXN1bWVkIA0K
YW5kIGNvbnRpbnVlIHRvIHJ1biBzZWFtbGVzc2x5LCBhdCBsZWFzdCBpbiB0aGVvcnkuIEEgaGli
ZXJuYXRlZCBWTSBzYXZlcw0KY29tcHV0ZSByZXNvdXJjZXMgYW5kIGNvc3QgZm9yIHRoZSB1c2Vy
cy4NCiANCj4gQW55aG93LCB3b3VsZCBpdCBhbHNvIGJlIGFuIG9wdGlvbiBmb3IgeW91IGluc3Rl
YWQgb2YgbWFraW5nIHRoZSBiYWxsb29uDQo+IGJhc2ljYWxseSB1c2VsZXNzIGluIGNhc2UgdGhl
IHZpcnR1YWwgQUNQSSBTNCBzdGF0ZSBpcyBlbmFibGVkIHRvDQo+IA0KPiBhKSBSZW1lbWJlciBp
ZiB0aGVyZSB3YXMgYSBoYXJtZnVsIHJlcXVlc3RzIHRoYXQgd2FzIHByb2Nlc3NlZCAobWVtb3J5
DQo+IGFkZCwgYmFsbG9vbiB1cCwgYmFsbG9vbiBkb3duKSAtIG9yIGlmIHRoZSBkZXZpY2UgaXMg
KmN1cnJlbnRseSogaW4gYW4NCj4gdW4taGliZXJuYXRhYmxlIHN0YXRlLiBFLmcuLCBpZiBzb21l
Ym9keSBpbmZsYXRlZCB0aGUgYmFsbG9vbiwgeW91IGNhbid0DQo+IGhpYmVybmF0ZS4gQnV0IGlm
IHRoZSBiYWxsb29uIHdhcyBkZWZsYXRlZCBhZ2FpbiwgeW91IGNhbiBhZ2FpbiBoaWJlcm5hdGUu
DQo+IA0KPiBiKSBCbG9jayBoaWJlcm5hdGlvbiBpbiBiYWxsb29uX3N1c3BlbmQoKSBpbiBjYXNl
IHRoZSBkZXZpY2UgaXMgaW4gc3VjaA0KPiBhbiB1bi1oaWJlcm5hdGFibGUgc3RhdGUuDQo+IA0K
PiANCj4gVGhlbiB5b3UgZG9uJ3QgbmVlZCBodl9pc19oaWJlcm5hdGlvbl9zdXBwb3J0ZWQoKS4g
VGhlIFZNIGlzIGFibGUgdG8NCj4gaGliZXJuYXRlIGFzIGxvbmcgYXMgRHluYW1pYyBNZW1vcnkg
YW5kIE1lbW9yeSBSZXNpemluZyB3YXMgbm90IHVzZWQuDQo+IFRoaXMgaXMgc29tZXRoaW5nIHRo
YXQgY2FuIGJlIGRvY3VtZW50ZWQgcGVyZmVjdGx5IHdlbGwuDQo+IA0KPiBEYXZpZCAvIGRoaWxk
ZW5iDQoNCk9uIHJlY2VudCBXaW5kb3dzIFNlcnZlciAyMDE5KyBob3N0cywgdGhlIHRvb2xzdGFj
a3Mgb24gdGhlIGhvc3RzDQpndWFyYW50ZWVzIHRoYXQgRHluYW1pYyBNZW1vcnkgYW5kIE1lbW9y
eSBSZXNpemluZyBjYW4gbm90IGJlIGVuYWJsZWQNCmlmIHRoZSB2aXJ0dWFsIEFDUEkgUzQgc3Rh
dGUgaXMgZW5hYmxlZCwgYW5kIHZpY2UgdmVyc2EuIFBsZWFzZSByZWZlciB0byB0aGUNCmxvbmcg
d3JpdGUtdXAgSSBtYWRlIGhlcmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzkvNS8xMTYw
IC4NCg0KQW5kLCB0byBtYWtlIHRoZSBoaWJlcm5hdGlvbiBmdW5jdGlvbmFsaXR5IGF1dG9tYXRl
ZCwgdGhlIGhvc3QgaXMgYWJsZSB0bw0Kc2VuZCBhICJwbGVhc2UgaGliZXJuYXRlIiBtZXNzYWdl
IHRvIHRoZSBWTSB2aWEgdGhlIEh5cGVyLVYgc2h1dGRvd24NCmRldmljZSB1cG9uIHRoZSB1c2Vy
J3MgcmVxdWVzdCAoZS5nLiB2aWEgR1VJIG9yIHNjcmlwdGluZyk6IHNlZSANCmh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE5LzkvMTMvODExIC4gV2hlbiB0aGUgaG9zdCBzZW5kcyB0aGUgbWVzc2Fn
ZSwNCml0IGNoZWNrcyBpZiB0aGUgdmlydHVhbCBBQ1BJIFM0IHN0YXRlIGlzIGVuYWJsZWQgZm9y
IHRoZSBWTTogaWYgbm90LCB0aGUgaG9zdA0KcmVmdXNlcyB0byBzZW5kIHRoZSBtZXNzYWdlLiBU
aGlzIG1lYW5zIHRoYXQgdGhlIHVzZXIgZG9lcyB3YW50IHRvIG1ha2UNCnN1cmUgdGhlIHZpcnR1
YWwgQUNQSSBTNCBzdGF0ZSBpcyBlbmFibGVkIGZvciB0aGUgVk0sIGlmIHRoZSB1c2VyIG9mIHRo
ZSBWTQ0Kd2FudHMgdG8gdXNlIHRoZSBoaWJlcm5hdGlvbiBmZWF0dXJlLCBhbmQgdGhpcyBtZWFu
cyBEeW5hbWljIE1lbW9yeQ0KYW5kIE1lbW9yeSBSZXNpemluZyBjYW4gbm90IGJlIGFjdGl2ZSBk
dWUgdG8gdGhlIHJlc3RyaWN0aW9ucyBmcm9tIHRoZSANCmhvc3QgdG9vbHN0YWNrLg0KDQpBbmQg
dGhlIGhpYmVybmF0aW9uIGZ1bmN0aW9uYWxpdHkgd29uJ3QgYmUgb2ZmaWNpYWxseSBzdXBwb3J0
ZWQgb24gb2xkDQpXaW5kb3dzIFNlcnZlciBob3N0cy4NCg0KU28sIElNSE8gd2UgY2FuJ3QgYmUg
Ym90aGVyIHRvIGltcGxlbWVudCB0aGUgaWRlYSB5b3UgZGVzY3JpYmVkIGluDQpkZXRhaWwuIFNv
cnJ5LiA6LSkNCg0KQW5kLCB3aGlsZSBJIGFncmVlIHlvdXIgaWRlYSBpcyBnb29kLCB0ZWNobmlj
YWxseSBzcGVha2luZyBJIHN1c3BlY3QgaXQgbWF5DQpub3QgYmUgcmVhbGx5IHVzZWZ1bCwgYmVj
YXVzZSBvbmNlIGh2X2JhbGxvb24gYWxsb3dzIGJhbGxvb24tdXAvZG93biwNCmh2X2JhbGxvb24g
ZWZmZWN0aXZlbHkgbG9zZXMgY29udHJvbCBvZiBtZW1vcnkgcGFnZXM6IGFmdGVyIHRoZSBob3N0
DQp0YWtlcyBzb21lIG1lbW9yeSBhd2F5LCB0aGUgVk0gbmV2ZXIga25vd3Mgd2hlbiBleGFjdGx5
IHRoZQ0KaG9zdCB3aWxsIGdpdmUgaXQgYmFjayAtLSBhY3R1YWxseSB0aGUgaG9zdCBuZXZlciBn
dWFyYW50ZWVzIGhvdyBzb29uDQppdCB3aWxsIGdpdmUgdGhlIG1lbW9yeSBiYWNrLiBDb25zZXF1
ZW50bHksIHRoZSBWTSBhbG1vc3QgaW1tZWRpYXRlbHkNCmVuZHMgdXAgaW4gYW4gdW4taGliZXJu
YXRhYmxlIHN0YXRlLi4uDQoNClRoYW5rcywNCi0tIERleHVhbg0K
