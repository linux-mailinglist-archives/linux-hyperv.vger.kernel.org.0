Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C762BF7C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfIZRmg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 13:42:36 -0400
Received: from mail-eopbgr1320105.outbound.protection.outlook.com ([40.107.132.105]:64128
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbfIZRmg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 13:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2F89yxOU4JTTpnL7NI0xgsM7ZNXJrRaUXvEI41z4imzZJRLvPtpkboZPLiE9lNYYTwoy9KQK90v0yidevEPT/7ldLX3zIMrZQE6B5fn8gNO4pQLd+Xli4271FR8iqirysPP3Zx1SQVTR+jtllCfFViuOPiV3g19OgolZCrmEhLdzomxoW3h/aNtRBcc10wEVVKGh3Zl/yzSPpE8f1JCOdwUJIPJM+tajrELxDOgTh7dThImzoYJqjCZ0SRX18N08R5m5t09tRs9UIpW+TzgVPlBZHS/QuS5IwTQ2ZaFkYnbnKQn7W4bCgYL+6xlwB12cHK6MqZIMzM87faL52208A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siRzhU2SHBunF+HSzvU+tpVSfHSHm+C9dznz4LWX9H4=;
 b=gvYjMgdqGMRA0ZYrnBT0ie4M5Q8TpEJYh8ySnaH5HzjbKf82gwKAeF6dcyJC0Q8usAjNEtiFG+7NgAy8bJGH0vA+tWKcSHmw8pw5L9fp4WzdggxFBb80lditb2wNN9e7MKA1ACjV9QFh4XIndTZ1Orokg3pgGZUxF28Ofl3qdgr4y+svoYnqgYAlQuDQZ8J6dbPj6/ukWxvTGQ2mrVSDXORO2WKYjGRQ0RJB4p7JLbUMKaBbYYoKt3YxO6ZNuLi5aLZjzhPZ9YZS+lflY8Qb6n7DBFCYg17QpCZ5LY9TK4SoxPxeElCG8bMioF9TjEvYhsQmoO2E+vJ1kevBXa/BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siRzhU2SHBunF+HSzvU+tpVSfHSHm+C9dznz4LWX9H4=;
 b=bM88qrnCFhMashLaKDV8GNZWfsz1z/x9Q5HvS1H5VP8s+mqFgArt+WyH8dIN92fYzergk229Nsu2WGYIToCds7g6xywbVbwEcNmev62O9QGH51IyuXsz2n78MAXN+i2VcJA7JOTjwc8UE0Opg95tqOrlQz0yCBzwI2TucydtEs0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.4; Thu, 26 Sep 2019 17:42:30 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Thu, 26 Sep 2019
 17:42:30 +0000
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
Thread-Index: AQHVaVISraz6+BtHYEamhMlzHx+g16coS8YAgADwLwCAAMMQUIAAJyMAgAAQlQCAEq5eQIAAvdCAgAADroA=
Date:   Thu, 26 Sep 2019 17:42:29 +0000
Message-ID: <PU1P153MB016917228A692F581CEA8C10BF860@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
 <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
 <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <ef6f8554-8324-a4d8-4549-759495e482b7@redhat.com>
 <PU1P153MB01699AB87526B16F7AB94045BFB20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169B05143A68A56740669AFBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <2134429f-dc6d-06e0-9e4b-9028f62f6666@redhat.com>
In-Reply-To: <2134429f-dc6d-06e0-9e4b-9028f62f6666@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-26T17:42:27.9468217Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b87b614-024c-4dc3-b0da-286b93399247;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:566:9f1e:2738:2c0a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95a9ed7-4fd8-4cae-b743-08d742a8e770
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0203:|PU1P153MB0203:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB02035787031A00A4F4655BE2BF860@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(199004)(189003)(1511001)(6246003)(86362001)(6436002)(110136005)(316002)(186003)(6116002)(6636002)(7736002)(55016002)(76116006)(6306002)(66946007)(66476007)(66556008)(64756008)(66446008)(22452003)(9686003)(71190400001)(71200400001)(2501003)(229853002)(2201001)(99286004)(10090500001)(486006)(11346002)(8676002)(446003)(966005)(8936002)(10290500003)(14454004)(25786009)(7696005)(46003)(76176011)(52536014)(6506007)(102836004)(2906002)(256004)(8990500004)(53546011)(74316002)(5660300002)(81156014)(476003)(478600001)(81166006)(33656002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4z0tiV5uBnMOWkLMJVOnk0m/Tlk36Zk/OhRmmy4E56vsGV76qoWPD1C0sC2J1OGHyV7wXSfIeMkPq3Yq5PrAYN6WMhXjabPwBZnsnBLGiGEHVJMFo6/eCq6Nyk27cNYr3IISr0cnrZwv7XJ8a8cu0M7stXHSThnoK0hoXEAz7+lw+eirM7jBtrx2agbXnyyM3X9UAw7H6cKNyffYYy4vIn/8gkrx9PjjQ0zAFj2R53J7woUVZapYWDtRBKgILl53ws0Ogpez+wnvhOcaDLMfkbpnlzgzmv4Vz6w4vYu+WiZB9x69PWA/ZJeCClNXnx6FVH8x3k5y2AQ1n7NUnPcm285VpSmSwCUv1GgXeK3oB6kdyC7L+f47Cl67DRXxA0un5YJmH0KDLdaGRhiwFC3BRtDcEsusBHXl8RTcd5H0/1jMtXxIXzeA6PejggGMqMGPQ+4Ogcy68LaTlKfCZ8QXug==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95a9ed7-4fd8-4cae-b743-08d742a8e770
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 17:42:29.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pfIn2omMkzTv40UojkiIe7A7jOBUoAw293fIr/ODhoBelHzLw5If9mhMtzSrdHt1ol8Sa4ZJpDT5buLxO9k3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyNiwgMjAxOSAxMjoyMCBBTQ0KPiBUbzogRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4g
SGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2Vy
DQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgc2FzaGFsQGtlcm5lbC5vcmc7DQo+IGxpbnV4
LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1p
Y2hhZWwgS2VsbGV5DQo+IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBodl9iYWxsb29uOiBBZGQgdGhlIHN1cHBvcnQgb2YgaGliZXJuYXRpb24NCj4gDQo+
IE9uIDI1LjA5LjE5IDIyOjAzLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+PiBGcm9tOiBsaW51eC1o
eXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+ID4+ICBbLi4uIHNuaXBwZWQgLi4uXQ0KPiA+
Pj4gQW55aG93LCBqdXN0IHNvbWUgY29tbWVudHMgZnJvbSBteSBzaWRlIDopIEkgY2FuIHNlZSBo
b3cgV2luZG93cw0KPiBTZXJ2ZXINCj4gPj4+IHdvcmtlZCBhcm91bmQgdGhhdCBpc3N1ZSByaWdo
dCBub3cgYnkganVzdCBYT1InaW5nIGJvdGggZmVhdHVyZXMuDQo+ID4+Pg0KPiA+Pj4gRGF2aWQg
LyBkaGlsZGVuYg0KPiA+Pg0KPiA+PiBUaGFua3MgZm9yIHNoYXJpbmcgeW91ciB0aG91Z2h0cyEN
Cj4gPj4NCj4gPj4gLS0gRGV4dWFuDQo+ID4NCj4gPiBIaSBEYXZpZCwNCj4gPiBJZiBteSBleHBs
YW5hdGlvbiBzb3VuZHMgZ29vZCB0byB5b3UsIGNhbiBJIGhhdmUgYW4gQWNrZWQtYnkgZnJvbSB5
b3U/DQo+ID4NCj4gDQo+IEkgZG8gQUNLIHRoZSBhcHByb2FjaCBidXQgbm90IHRoZSBwYXRjaCBp
biBpdCdzIGN1cnJlbnQgc3RhdGUuIEkgZG9uJ3QNCj4gbGlrZSB0aGUgaWZkZWZzIC0gb25jZSB5
b3UgY2FuIGdldCByaWQgb2YgdGhlIGlmZGVmZXJ5IC0gZS5nLiwgYWZ0ZXIgdGhlDQo+IHByZXJl
cXVpc2l0ZSBpcyB1cHN0cmVhbSAtIHlvdSBjYW4gYWRkIG15DQo+IA0KPiBBY2tlZC1ieTogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5i
DQoNCk1ha2VzIHNlbnNlLiBJJ2xsIHdhaXQgZm9yIHRoZSBwcmVyZXF1aXNpdGUgcGF0Y2ggKGku
ZS4gdGhlIHBhdGNoIHRoYXQgaW1wbGVtZW50cw0KaHZfaXNfaGliZXJuYXRpb25fc3VwcG9ydGVk
KCksIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzkvNS8xMTYwICkgdG8gYmUgDQppbiB1cHN0
cmVhbSBmaXJzdCwgdGhlbiBJJ2xsIGJlIGFibGUgdG8gZ2V0IHJpZCBvZiB0aGUgYmVsb3cgImlm
IDAiIGFuZCBwb3N0IGEgdjINCndpdGggeW91ciBBY2tlZC1ieS4gVGhhbmtzLCBEYXZpZCENCg0K
KyNpZiAwDQorCS8qDQorCSAqIFRoZSBwYXRjaCB0byBpbXBsZW1lbnQgaHZfaXNfaGliZXJuYXRp
b25fc3VwcG9ydGVkKCkgaXMgZ29pbmcNCisJICogdGhyb3VnaCB0aGUgdGlwIHRyZWUuIEZvciBu
b3csIGxldCdzIGhhcmRjb2RlIGFsbG93X2hpYmVybmF0aW9uDQorCSAqIHRvIGZhbHNlIHRvIGtl
ZXAgdGhlIGN1cnJlbnQgYmVoYXZpb3Igb2YgaHZfYmFsbG9vbi4gSWYgcGVvcGxlDQorCSAqIHdh
bnQgdG8gdGVzdCBoaWJlcm5hdGlvbiwgcGxlYXNlIGJsYWNrbGlzdCBodl9iYWxsb29uIGZvdyBu
b3cNCisJICogb3IgZG8gbm90IGVuYWJsZSBEeW5hbWlkIE1lbW9yeSBhbmQgTWVtb3J5IFJlc2l6
aW5nLg0KKwkgKg0KKwkgKiBXZSdsbCByZW1vdmUgdGhlIGNvbmRpdGlvbmFsIGNvbXBpbGF0aW9u
IGFzIHNvb24gYXMNCisJICogaHZfaXNfaGliZXJuYXRpb25fc3VwcG9ydGVkKCkgaXMgYXZhaWxh
YmxlIGluIHRoZSBtYWlubGluZSB0cmVlLg0KKwkgKi8NCisJYWxsb3dfaGliZXJuYXRpb24gPSBo
dl9pc19oaWJlcm5hdGlvbl9zdXBwb3J0ZWQoKTsNCisjZWxzZQ0KKwlhbGxvd19oaWJlcm5hdGlv
biA9IGZhbHNlOw0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
