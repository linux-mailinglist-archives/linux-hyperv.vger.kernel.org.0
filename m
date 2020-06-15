Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5961F9EB9
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2020 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgFORmK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Jun 2020 13:42:10 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:5151
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbgFORmJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Jun 2020 13:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWHLLVOfGPt5i0zR3g6Sje08UzGYEisUKMm85fCM7EjAeps/gBy3yJDzLOdzXbl/dy0Gp8xNtdnd8B7dAjVDJRPK14EN1d9PFDbAihIVjdliveRDiVFwNpZtLbl+eIjlY8fpa5Vo2T6p1dcUdRdqSTlkBQ+orROF9ACX5iTVCGgBnF+waqci/pxgu+0JIr4h/U1g2RKFawtbIe3C5LQhYTgiL6br85j8VvFf/WzyUjCursKaloZdHT9Ub22/QOtkVObPE8LOUGL6AUBgo+C2nGhjXwPAOtGZ8Td5ZZ1VVMkQJ5fjXnGjXbuB2Zx1EdSoLmtW2WXu3dE0q2fUm0L4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HKLQCM6M1PsrcOyNFS7D9b+SAj6UooDQ6M+4demsZI=;
 b=IFB4bnjiWn64nobPq5AUF5aMvKEdO8kgJ1o21N4Tlp98WwdSFEdHOaKGwv/CywKIxPll8ErnuEG+V8lzZ26cclEneAJB439ZuNiiSS8lbLo8vWJU5V9w8g91wNAeHSQMqydHXFw0N1ufkL0pFTn31QYgdjMdWcPeQGqVStuiPROsuUEIVZbsz09IbS+KlsFHeaxwAWnc019/v/0zokSGzSsbJShHPMi71xWRTdwiR4ooBM+ANsmOKgFr3uqjyKEoKpdpan2JY7k02KP1RK9dxge9UI0ic/ARchS1nkvPrpuyqRe1hR9VWajtv0LsMCGNe2IdvVRwGFuYKSDlFs8V5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HKLQCM6M1PsrcOyNFS7D9b+SAj6UooDQ6M+4demsZI=;
 b=UcU6MtkkkAX/vYo5j8ds4J01PgTDf49iE73MhZie91LvSniacHpN738W4dz28xXhqYk41Y+KYZaPwRUCwGooP2u8ZtFiD4wwuIGlCA8in3YWrjXq/CFErDAScXWOcQrY//Iknrx7lh9bXNBwWHeAJevT7Ag6fb3o370IHRQbxLQ=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK2P15301MB0019.APCP153.PROD.OUTLOOK.COM (2603:1096:202:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.15; Mon, 15 Jun
 2020 17:41:41 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%8]) with mapi id 15.20.3131.009; Mon, 15 Jun 2020
 17:41:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: hv_hypercall_pg page permissios
Thread-Topic: hv_hypercall_pg page permissios
Thread-Index: AQHWDR+7o7IWH4OD3UKrKLNTyqpwjqjU/2DwgATGLoCAAJaLQA==
Date:   Mon, 15 Jun 2020 17:41:40 +0000
Message-ID: <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200407073830.GA29279@lst.de>
 <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
 <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
In-Reply-To: <87y2ooiv5k.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-15T17:41:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d684f98c-067c-4200-9ca7-0624449fed1d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:b8fb:6bb:502d:341f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 825cd6e0-507e-489b-052d-08d811535cec
x-ms-traffictypediagnostic: HK2P15301MB0019:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK2P15301MB0019301B700A55ACB2DBEF16BF9C0@HK2P15301MB0019.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjlQARfMawEP4L+dVFGPt0yz5glLtMPP9SdkKfZn+c4UOPylz1s9DXlUTXWyhqOf1ZlFA8jfvm7q0oOCEFbfKGYRxI7CauuMrhqUnZFP/Y6bWzLx6VV54BfuNwCl1MVW9GWHKbV2DJ2o90i96dKrxCP2d8EzjZRaYrkP7Q+o4c9OO+Sy24HGaS3FfViPiLXMuYdHe3fHFpFWNfzeq7gCPrlPqF664SAHbkuYZ4lxWgrUV5crZ3IDwC7DXn1J4bbljzcMgl9Q0E3jVrOhn9crRW1NehW4cypw4PcuQm4ge5/9+obZYn0RFuqGmt9EUDK676BBzFcRQmknB3tvHl7hfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(478600001)(86362001)(9686003)(8936002)(8676002)(186003)(6506007)(55016002)(8990500004)(82950400001)(82960400001)(66556008)(7116003)(71200400001)(53546011)(76116006)(66446008)(64756008)(7696005)(66476007)(66946007)(83380400001)(2906002)(52536014)(110136005)(10290500003)(54906003)(33656002)(4326008)(5660300002)(316002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1PAN2IelGau9wmehE0uVwPh2ZmSxc8Tqf7QTkwoR/QFSfFMbfIkp/vTgODLyb9ybA0krcKcPA3lVGu8SwDBCUzi8rtv9+ZULSMCGA2dGpQW+BY/KAkbXzGyC9bfpvxmKe7P3ghboeqZk35UR57ZtJpcm0L1R3CD+OvPxKVn4TLBDruzoeujearipaFfGOXH66qUeOoR5RDV42sg4ghqUHNpbskz2pTNEUwTerKQuv9NNYi5JPfop+fIn0vKYqsAhcdAYLVjH5Rfy0tPqi9KCcbtxFJxI+YTAoAsO15ewnAU9+xQqIvk89g5c3uH8AVN8axgXmkBicK20visLsazRtyhSfs/oEBe/GoMDvacqkQg3XP025Jiv9qcDxory+/f88P2/l35RiWFIgY4Kisq5xCIGRDhUSPR5x1lVqxLbsZ8PNHyYOJus8EgRODeXzn5+1qEQlTggjqz7/ifYd/z6JiVw+IYtGLV9st23rn6BS1o8dekCgAfQkR4fJxkMHIrdR2oO6Q1mz8FZ/hAb1dchc/EsAIY79l08+LXh1v1c3rU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825cd6e0-507e-489b-052d-08d811535cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 17:41:40.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHPkVpUf1CZMlC9l3dx+0fXz88JOhksWvfZA7Wpj30Gzme6eE6SJanfFsi5dT35+fkqVQlmEq8eIr6D+CtaUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2P15301MB0019
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMTUsIDIwMjAgMTozNSBBTQ0KPiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3Nv
ZnQuY29tPiB3cml0ZXM6DQo+IA0KPiA+PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5r
ZXJuZWwub3JnDQo+ID4+IDxsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgQW5keSBMdXRvbWlyc2tpDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIw
MjAgMjowMSBQTQ0KPiA+PiA+IE9uIEFwciA3LCAyMDIwLCBhdCAxMjozOCBBTSwgQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+IHdyb3RlOg0KPiA+PiA+DQo+ID4+ID4g77u/T24gVHVlLCBB
cHIgMDcsIDIwMjAgYXQgMDk6Mjg6MDFBTSArMDIwMCwgVml0YWx5IEt1em5ldHNvdiB3cm90ZToN
Cj4gPj4gPj4gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IHdyaXRlczoNCj4gPj4gPj4N
Cj4gPj4gPj4+IEhpIGFsbCwNCj4gPj4gPj4+DQo+ID4+ID4+PiBUaGUgeDg2IEh5cGVyLVYgaHlw
ZXJjYWxsIHBhZ2UgKGh2X2h5cGVyY2FsbF9wZykgaXMgdGhlIG9ubHkgYWxsb2NhdGlvbg0KPiA+
PiA+Pj4gaW4gdGhlIGtlcm5lbCB1c2luZyBfX3ZtYWxsb2Mgd2l0aCBleGVjdHV0YWJsZSBwZXJz
bWlzc2lvbnMsIGFuZCB0aGUNCj4gPj4gPj4+IG9ubHkgdXNlciBvZiBQQUdFX0tFUk5FTF9SWC4g
IElzIHRoZXJlIGFueSBnb29kIHJlYXNvbiBpdCBuZWVkcyB0bw0KPiA+PiA+Pj4gYmUgcmVhZGFi
bGU/ICBPdGhlcndpc2Ugd2UgY291bGQgdXNlIHZtYWxsb2NfZXhlYyBhbmQga2lsbCBvZmYNCj4g
Pj4gPj4+IFBBR0VfS0VSTkVMX1JYLiAgTm90ZSB0aGF0IGJlZm9yZSAzNzJiMWU5MTM0M2U2ICgi
ZHJpdmVyczogaHY6DQo+IFR1cm4NCj4gPj4gb2ZmDQo+ID4+ID4+PiB3cml0ZSBwZXJtaXNzaW9u
IG9uIHRoZSBoeXBlcmNhbGwgcGFnZSIpIGl0IHdhcyBldmVuIG1hcHBlZCB3cml0YWJsZS4uDQo+
ID4+ID4+DQo+ID4+ID4+IFtUaGVyZSBpcyBub3RoaW5nIHNlY3JldCBpbiB0aGUgaHlwZXJjYWxs
IHBhZ2UsIGJ5IHJlYWRpbmcgaXQgeW91IGNhbg0KPiA+PiA+PiBmaWd1cmUgb3V0IGlmIHlvdSdy
ZSBydW5uaW5nIG9uIEludGVsIG9yIEFNRCAoVk1DQUxML1ZNTUNBTEwpIGJ1dCBpdCdzDQo+ID4+
ID4+IGxpa2VseSBub3QgdGhlIG9ubHkgcG9zc2libGUgd2F5IDotKV0NCj4gPj4gPj4NCj4gPj4g
Pj4gSSBzZWUgbm8gcmVhc29uIGZvciBodl9oeXBlcmNhbGxfcGcgdG8gcmVtYWluIHJlYWRhYmxl
LiBJIGp1c3QNCj4gPj4gPj4gc21va2UtdGVzdGVkDQo+ID4+ID4NCj4gPj4gPiBUaGFua3MsIEkg
aGF2ZSB0aGUgc2FtZSBpbiBteSBXSVAgdHJlZSwgYnV0IGp1c3Qgd2FudGVkIHRvIGNvbmZpcm0g
dGhpcw0KPiA+PiA+IG1ha2VzIHNlbnNlLg0KPiA+Pg0KPiA+PiBKdXN0IHRvIG1ha2Ugc3VyZSB3
ZeKAmXJlIGFsbCBvbiB0aGUgc2FtZSBwYWdlOiB4ODYgZG9lc27igJl0IG5vcm1hbGx5IGhhdmUN
Cj4gYW4NCj4gPj4gZXhlY3V0ZS1vbmx5IG1vZGUuIEV4ZWN1dGFibGUgbWVtb3J5IGluIHRoZSBr
ZXJuZWwgaXMgcmVhZGFibGUgdW5sZXNzIHlvdQ0KPiA+PiBhcmUgdXNpbmcgZmFuY3kgaHlwZXJ2
aXNvci1iYXNlZCBYTyBzdXBwb3J0Lg0KPiA+DQo+ID4gSGkgaGNoLA0KPiA+IFRoZSBwYXRjaCBp
cyBtZXJnZWQgaW50byB0aGUgbWFpbmluZSByZWNlbnRseSwgYnV0IHVubHVja2lseSB3ZSBub3Rp
Y2VkDQo+ID4gYSB3YXJuaW5nIHdpdGggQ09ORklHX0RFQlVHX1dYPXkgKGl0IGxvb2tzIHR5cGlj
YWxseSB0aGlzIGNvbmZpZyBpcyBkZWZpbmVkDQo+ID4gYnkgZGVmYXVsdCBpbiBMaW51eCBkaXN0
cm9zLCBhdCBsZWFzdCBpbiBVYnVudHUgMTguMDQncw0KPiA+IC9ib290L2NvbmZpZy00LjE4LjAt
MTEtZ2VuZXJpYykuDQo+ID4NCj4gPiBTaG91bGQgd2UgcmV2ZXJ0IHRoaXMgcGF0Y2gsIG9yIGZp
Z3VyZSBvdXQgYSB3YXkgdG8gYXNrIHRoZSBERUJVR19XWCBjb2RlDQo+IHRvDQo+ID4gaWdub3Jl
IHRoaXMgcGFnZT8NCj4gPg0KPiANCj4gQXJlIHlvdSBzdXJlIGl0IGlzIGh2X2h5cGVyY2FsbF9w
Zz8gDQpZZXMsIDEwMCUgc3VyZS4gSSBwcmludGVkIHRoZSB2YWx1ZSBvZiBodl9oeXBlcmNhbGxf
cGcgYW5kIGFuZCBpdCBtYXRjaGVkIHRoZQ0KYWRkcmVzcyBpbiB0aGUgd2FybmluZyBsaW5lICIg
eDg2L21tOiBGb3VuZCBpbnNlY3VyZSBXK1ggbWFwcGluZyBhdCBhZGRyZXNzIi4NCg0KPiBBRkFJ
VSBpdCBzaG91bGRuJ3QgYmUgVytYIGFzIHdlDQo+IGFyZSBhbGxvY2F0aW5nIGl0IHdpdGggdm1h
bGxvY19leGVjKCkuIEluIG90aGVyIHdvcmRzLCBpZiB5b3UgcmV2ZXJ0DQo+IDc4YmIxN2Y3NmVk
YywgZG9lcyB0aGUgaXNzdWUgZ28gYXdheT8NCj4gDQo+IFZpdGFseQ0KDQpZZXMsIHRoZSB3YXJu
aW5nIGdvZXMgYXdheSBpZiBJIHJldmVydA0KNzhiYjE3Zjc2ZWRjICgieDg2L2h5cGVydjogdXNl
IHZtYWxsb2NfZXhlYyBmb3IgdGhlIGh5cGVyY2FsbCBwYWdlIikNCjg4ZGNhNGNhNWE5MyAoIm1t
OiByZW1vdmUgdGhlIHBncHJvdCBhcmd1bWVudCB0byBfX3ZtYWxsb2MiKSANCihJIGhhdmUgdG8g
cmV2ZXJ0IHRoZSBzZWNvbmQgYXMgd2VsbCB3aXRoIHNvbWUgbWFudWFsIGFkanVzdG1lbnRzLCBz
aW5jZQ0KX192bWFsbG9jKCkgaGFzIDIgcGFyYW1ldGVycyBub3cuKQ0KDQpUaGFua3MsDQpEZXh1
YW4NCg==
