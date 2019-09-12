Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DDB14BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 21:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfILTSh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 15:18:37 -0400
Received: from mail-eopbgr1310097.outbound.protection.outlook.com ([40.107.131.97]:10368
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfILTSh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 15:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJCyHgo+NxQ+E83FGtxwU4NdNLM9rMnj/nUB1UNb6gqXbNjU8wXcSFsssR1R3c1bhrvKaP4Tjm14IaAUXEwAmrP76+ymydnslYgWZG8WIpYXdH9+RdK3DEQwYbo7y58wnLhJpAePhh34fUcKsBJ0/cucIZsnekzMZ6VDQPW2jnCU5Xa8JWDHctDetjK2+yUPOP9Ib2WMwoEkF7qN1/myGQsUegPT6kQDCavFEovUNkmz0J452lEPrPHEgVT6EE8o8IJzY5Gb4iAsgtuNutRqOs9m5uGL8D0aT0gUcp7ciJxu2dGcVVX9rODzq/PRAOL64gZRCsyaKSJJpWMqN/Zb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1XgBhog+W3iNqd46TlOklgwrA6qNSCQZIEhkNx9oI4=;
 b=hCCxMBFrzWwO9imRubDKJMkIWfDzOjGjyBfg4Nli/EcZ9x+apuLYBBBwD52YfouGkj54GrgyyiuCVKlu3kSwVpTYuxV0CxEqj33l5pQgCpo/yJDiCNI4LkRqwMSzoP++Inu2W2+q+K+WjnruOQsrkqA8S7UCKplBz9JiQbVucyFogh+J78EC3n4Ya1Pc5sO0JXVJwc8jjRDuvk4aRXRQjRgGl/6g5NGzUkQvrP86KnqZo72+xLDvGoAeyA0cMkZvvBScpFWQK30wWLxoq7gBZpF897mdCiO6ZVgWjboa6N2Q0IyrrgVD4KXcTBNW3kqiWTIXmH1zmGgBmSqoMZRJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1XgBhog+W3iNqd46TlOklgwrA6qNSCQZIEhkNx9oI4=;
 b=Zg+acKx/Eajf/16Iej/hpshEmhne4qG8vkJ7tl98ErLBZsyxudfZ/LQ4i0Zt9/5xJADGn7zQqssx55DsiGjdhhkWPGpg/hy50e44274dLOfsSIQtClXjD9cGjMCguMrai5ip/CQXCGbe/xjMdSL1z3JvQMc+10v2lmG3AMPJk+k=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Thu, 12 Sep 2019 19:18:25 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.007; Thu, 12 Sep 2019
 19:18:25 +0000
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
Thread-Index: AQHVaVISraz6+BtHYEamhMlzHx+g16coS8YA
Date:   Thu, 12 Sep 2019 19:18:25 +0000
Message-ID: <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
In-Reply-To: <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-12T19:18:23.1166005Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b3c2fcd9-db8e-482a-9b82-a7aa08ebc547;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:49e:db48:e427:c2a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6208b7fb-986b-4659-b544-08d737b5fc3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:|PU1P153MB0170:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB017031BE74F8E591E2D49D37BFB00@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(14454004)(6116002)(5660300002)(6636002)(478600001)(10290500003)(55016002)(71200400001)(71190400001)(14444005)(256004)(966005)(76116006)(53936002)(76176011)(6436002)(7696005)(52536014)(99286004)(6246003)(316002)(9686003)(305945005)(6306002)(25786009)(229853002)(110136005)(22452003)(7736002)(64756008)(476003)(6506007)(86362001)(2201001)(446003)(11346002)(186003)(102836004)(8676002)(81166006)(2906002)(8936002)(81156014)(46003)(74316002)(2501003)(66556008)(8990500004)(66476007)(66446008)(10090500001)(33656002)(1511001)(53546011)(66946007)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 36qerhhcxUP9Zu5ARkVABAgjfYoNeIM5Xw//SgBv8m48sLuNB6uNmzqwR1UN4UyRrtG/hgMFxuUoJa7ydYw+BtlavU2y5sdU66aCzQ7I/h2S+MoJhjwIsWi9ZTJaWV78AF23CAET8AFrjEZohXGcpXfqV+8vL0tbzL+AAyaIR9ruw7lJaMxr9GhYzMqlW8zr3PHKMypTD7smKH8HnqvYnzAAnqr/2exJXaxfqAhuET6NfVywVNlfS4t4k8z2NPwwBThfbWQk0ypcNtkSqY9rny//BTRGAC4mPENkpdON8PZZ/K7yZRYJCxp6rU3zCZifDIAsqIfpPGqi+VPnEQOTB6gnOzSkbibvDSKBsl9oPgZl9YO2vtKQ5Uj9cmiYAAUS5Buek1nmODobI/aErWBDWt5SUg98JZwSHQt0aJMnXfU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6208b7fb-986b-4659-b544-08d737b5fc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 19:18:25.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHQd0p/EaouXe5dw3V0XFrmRx98Zav2lgxzdLQmt2Tbp53oH+eOLQoKdzZny8sRDFiXvzSY2y5DjODnF5i1FIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAxMiwgMjAxOSAzOjA5IEFNDQo+IE9uIDEyLjA5LjE5IDAxOjM2LCBE
ZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IFdoZW4gaGliZXJuYXRpb24gaXMgZW5hYmxlZCwgd2UgbXVz
dCBpZ25vcmUgdGhlIGJhbGxvb24gdXAvZG93biBhbmQNCj4gPiBob3QtYWRkIHJlcXVlc3RzIGZy
b20gdGhlIGhvc3QsIGlmIGFueS4NCj4gDQo+IFdoeSBkbyB5b3UgZXZlbiBjYXJlIGFib3V0IHN1
cHBvcnRpbmcgaGliZXJuYXRpb24/IENhbid0IHlvdSBqdXN0IHBhdXNlDQo+IHRoZSBWTSBpbiB0
aGUgaHlwZXJ2aXNvciBhbmQgY29udGludWUgdG8gbGl2ZSBhIGhhcHB5IGxpZmU/IDopDQo+IA0K
PiAodG8gYmUgbW9yZSBwcmVjaXNlLCBtb3N0IFFFTVUvS1ZNIGRpc3RyaWJ1dGlvbnMgSSBhbSBh
d2FyZSBvZiBkb24ndA0KPiBzdXBwb3J0IHN1c3BlbmQvaGliZXJuYXRpb24gb2YgZ3Vlc3RzIGZv
ciBzYWlkIHJlYXNvbiwgc28gSSB3b25kZXIgd2h5DQo+IEh5cGVyLVYgbmVlZHMgaXQpDQoNCklu
IHNvbWUgc2NlbmFyaW9zLCBoaWJlcm5hdGlvbiBjYW4gYmUgYmV0dGVyIHRoYW4gcGF1c2UvdW5w
YXVzZSwNCnNhdmUvcmVzdG9yZSBhbmQgbGl2ZSBtaWdyYXRpb246DQoNCjEuIENvbXBhcmVkIHRv
IHBhdXNlL3VucGF1c2UsIHRoZSBWTSBjYW4gcG93ZXIgb2ZmIGNvbXBsZXRlbHkgd2l0aA0KaGli
ZXJuYXRpb24sIGFuZCBhbGwgdGhlIHN0YXRlcyBhcmUgc2F2ZWQgaW5zaWRlIHRoZSBWTSBpbWFn
ZSwgdGhlbiB0aGUNCmltYWdlIGNhbiBiZSBjb3BpZWQgdG8gYW5vdGhlciBob3N0IHRvIHN0YXJ0
IHRoZSBWTSBhZ2FpbiwgYXMgbG9uZyBhcw0KdGhlIG5ldyBob3N0IHVzZXMgZXhhY3RseSB0aGUg
c2FtZSBjb25maWd1cmF0aW9uIGZvciB0aGUgVk0uDQoNCjIuIENvbXBhcmVkIHRvIHBhdXNlL3Vu
cGF1c2UsIGhpYmVybmF0aW9uIG1heSBiZSBtb3JlIHJlbGlhYmxlLCBzaW5jZSBpdCdzDQpwZXJm
b3JtZWQgYnkgdGhlIFZNIGtlcm5lbCByYXRoZXIgdGhhbiB0aGUgaG9zdCwgc28gdGhlIFZNIGtl
cm5lbCBtYXkNCmJldHRlciB0YWNrbGUgc29tZSBjbG9jay1zb3VyY2UvZXZlbnQtc2Vuc2l0aXZl
IGlzc3Vlcy4NCg0KMy4gSGliZXJuYXRpb24gY2FuIGJlIGVzcGVjaWFsbHkgdXNlZnVsIHdoZW4g
d2UgcGFzcyB0aHJvdWdoIGEgUENJZSBkZXZpY2UsDQplLmcuIGEgTklDLCBhIE5WTWUgY29udHJv
bGxlciBvciBhIEdQVSwgdG8gdGhlIFZNLCBhcyB1c3VhbGx5IHNhdmUvcmVzdG9yZQ0KYW5kIGxp
dmUgbWlncmF0aW9uIGNhbiBub3Qgd29yayB3aXRoIHRoaXMga2luZCBvZiBjb25maWd1cmF0aW9u
LCBiZWNhdXNlDQp1c3VhbGx5IHRoZSBob3N0IGRvZXNuJ3Qga25vdyBob3cgdG8gc2F2ZS9yZXN0
b3JlIHRoZSBzdGF0ZSBvZiB0aGUgUENJZQ0KZGV2aWNlLg0KDQo+ID4gVGhpcyBwYXRjaCBpcyBi
YXNpY2FsbHkgYSBwdXJlIEh5cGVyLVYgc3BlY2lmaWMgY2hhbmdlIGFuZCBpdCBoYXMgYQ0KPiA+
IGJ1aWxkIGRlcGVuZGVuY3kgb24gdGhlIGNvbW1pdCAyNzFiMjIyNGQ0MmYgKCJEcml2ZXJzOiBo
djogdm1idXM6DQo+IEltcGxlbWVudA0KPiA+IHN1c3BlbmQvcmVzdW1lIGZvciBWU0MgZHJpdmVy
cyBmb3IgaGliZXJuYXRpb24iKSwgd2hpY2ggaXMgb24gU2FzaGEgTGV2aW4ncw0KPiA+IEh5cGVy
LVYgdHJlZSdzIGh5cGVydi1uZXh0IGJyYW5jaA0KPiA+IEBAIC0xNjcyLDYgKzE2OTQsMjQgQEAg
c3RhdGljIGludCBiYWxsb29uX3Byb2JlKHN0cnVjdCBodl9kZXZpY2UgKmRldiwNCj4gPiAgew0K
PiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICsjaWYgMA0KPiANCj4gSSBhbSBub3Qgc3VyZSBpZiB0
aGF0J3MgYSBnb29kIGlkZWEuIENhbid0IHlvdSBiYXNlIHRoaXMgc2VyaWVzIG9uDQo+IGh2X2lz
X2hpYmVybmF0aW9uX3N1cHBvcnRlZCgpID8NCg0KVW5sdWNraWx5LCBJIGNhbiBub3QuIDotKA0K
DQpNeSBodl9pc19oaWJlcm5hdGlvbl9zdXBwb3J0ZWQoKSBwYXRjaCBpcyBzdGlsbCBpbiByZXZp
ZXcsIGFuZCBoYXMgbm90IGJlZW4NCmluIGFueSB0cmVlIHlldCAoaXQncyBzdXBwb3NlZCB0byBn
byB0aHJvdWdoIHRoZSB0aXAuZ2l0IHRyZWUncyB0aW1lcnMvY29yZQ0KYnJhbmNoIHNpbmNlIG90
aGVyd2lzZSB0aGUgYnJhbmNoIGNvbnRhaW5zIHNvbWUgcGF0Y2hlcyB0aGF0IHdvdWxkIA0KY2F1
c2UgY29uZmxpY3RzKTogDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS85LzUvMTE1OA0KaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvOS81LzExNjANCiANCj4gPiArCS8qDQo+ID4gKwkgKiBU
aGUgcGF0Y2ggdG8gaW1wbGVtZW50IGh2X2lzX2hpYmVybmF0aW9uX3N1cHBvcnRlZCgpIGlzIGdv
aW5nDQo+ID4gKwkgKiB0aHJvdWdoIHRoZSB0aXAgdHJlZS4gRm9yIG5vdywgbGV0J3MgaGFyZGNv
ZGUgYWxsb3dfaGliZXJuYXRpb24NCj4gPiArCSAqIHRvIGZhbHNlIHRvIGtlZXAgdGhlIGN1cnJl
bnQgYmVoYXZpb3Igb2YgaHZfYmFsbG9vbi4gSWYgcGVvcGxlDQo+ID4gKwkgKiB3YW50IHRvIHRl
c3QgaGliZXJuYXRpb24sIHBsZWFzZSBibGFja2xpc3QgaHZfYmFsbG9vbiBmb3Igbm93DQo+ID4g
KwkgKiBvciBkbyBub3QgZW5hYmxlIER5bmFtaWQgTWVtb3J5IGFuZCBNZW1vcnkgUmVzaXppbmcu
DQo+ID4gKwkgKg0KPiA+ICsJICogV2UnbGwgcmVtb3ZlIHRoZSBjb25kaXRpb25hbCBjb21waWxh
dGlvbiBhcyBzb29uIGFzDQo+ID4gKwkgKiBodl9pc19oaWJlcm5hdGlvbl9zdXBwb3J0ZWQoKSBp
cyBhdmFpbGFibGUgaW4gdGhlIG1haW5saW5lIHRyZWUuDQo+ID4gKwkgKi8NCj4gPiArCWFsbG93
X2hpYmVybmF0aW9uID0gaHZfaXNfaGliZXJuYXRpb25fc3VwcG9ydGVkKCk7DQo+ID4gKyNlbHNl
DQo+ID4gKwlhbGxvd19oaWJlcm5hdGlvbiA9IGZhbHNlOw0KPiA+ICsjZW5kaWYNCg0KVGhhbmtz
LA0KLS0gRGV4dWFuDQo=
