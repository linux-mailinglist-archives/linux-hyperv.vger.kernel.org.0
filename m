Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B650B2915
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Sep 2019 02:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbfINA0J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 20:26:09 -0400
Received: from mail-eopbgr1320095.outbound.protection.outlook.com ([40.107.132.95]:56101
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388921AbfINA0J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 20:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGcqJb6vWcSpCEkubYKqu6VpvMOmxVtCXPaehCTy1pH3yLSdSLnkAunbvtaJSYcvabqmNC4R86bm72RLFcZIiTFNF32VdFRXwqeC792a/5bPs9yUIzsY1EjsawIXuXKcWAo03H12HuveGusQgWGuL64/MNCMNoVdRH4anMarIUy121daMIyyRU9HuCaRv3/VOwpPrfbEgI8cNPUV6qPICWcinlc+FCs20X//9n7zX5nOy1eXMD2NE8bEQW+B5D8YS3VWUeMabdtuU4rk+EgOWREMr0WpTXMw11LepEKj/OmJBggmdq4bYQPsioIJlcgdY0FS7ifkZis1tofzR7qdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR/gvCiv104mOPDFw8+w1B7T+Ia/bGCiNO+mEzPX86c=;
 b=F7FlEzh4zgqNyvFFhLSo4jNwW6L6gKrbX//zFMVlYo0SpngokrCkZt+KALCXTzJ/lvTPosQq/5hUcpyJo491HZuXXgwR7SyMGbJ5cFjnw1oBt6o0F4R4+VDEM9VLdb2m69cWW5zqkny/J/Ff9POm6nngtgfnu9RcsSYbkroEZ9uNbi8N7tc+Rsir1EMAfIKE6QmhHX7i6Opd1RWVK8oYBHwMXLDoLBFzHpxRgcuHSlGqdZHABXlGYa/kOJMsySwAVpv3A0BfRPmVjyDdY/LEHHTHMq0x2fl87H9ZCN/FSurN3Asmocn4pwTLSthZZ5gxBYB9om+VTOFjSFcgkZlJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR/gvCiv104mOPDFw8+w1B7T+Ia/bGCiNO+mEzPX86c=;
 b=UoXNokLvaM3vwDdqLuGvNrvFntEGceDYP+GS/jPSfOWFkHLDbwcnrUKmyvbonWaMv+wJ1BrQvbodE2WyoJ+kwoNVRvfEMsLM9eA3WLrEnMn03GFn+/vpQKm/5Yc3bJc9OhbyAa9KAz97m3bPYeITRzAHDp1j1R+tnODx+yxPY5k=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Sat, 14 Sep 2019 00:26:02 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.009; Sat, 14 Sep 2019
 00:26:02 +0000
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
Thread-Index: AQHVaVISraz6+BtHYEamhMlzHx+g16coS8YAgADwLwCAAMMQUIAAJyMAgAAQlQA=
Date:   Sat, 14 Sep 2019 00:26:01 +0000
Message-ID: <PU1P153MB01699AB87526B16F7AB94045BFB20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
 <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
 <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <ef6f8554-8324-a4d8-4549-759495e482b7@redhat.com>
In-Reply-To: <ef6f8554-8324-a4d8-4549-759495e482b7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-14T00:26:00.3261188Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cc25ee78-8be9-4480-8628-176a5590891e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 274a879a-b4cc-4409-ac59-08d738aa1fbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0154;
x-ms-traffictypediagnostic: PU1P153MB0154:|PU1P153MB0154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0154BA21992E87A14011CCE4BFB20@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(376002)(366004)(39850400004)(346002)(396003)(54534003)(199004)(189003)(74316002)(476003)(2501003)(305945005)(66946007)(486006)(22452003)(2201001)(66556008)(7736002)(5660300002)(86362001)(66476007)(14444005)(10290500003)(256004)(478600001)(14454004)(66446008)(64756008)(26005)(446003)(3846002)(6116002)(52536014)(11346002)(2906002)(33656002)(6246003)(9686003)(6436002)(10090500001)(25786009)(66066001)(7696005)(6636002)(8990500004)(76116006)(6506007)(186003)(229853002)(99286004)(76176011)(71200400001)(53936002)(71190400001)(55016002)(8936002)(316002)(8676002)(102836004)(81156014)(81166006)(1511001)(110136005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BDmH2Nm+8NJHhFPSTAWZgtKR0O8nCIsXiP2b9YNwDdomecqmUyqTgJyKUfWyE9eNuas40v9NcEn+pAjPvHwsxzGPncvSQA9hL5LLe7e56qlyHPBvlg9Jzis6La1nc2ibt1Vd2+Qdf8ZCza5FgjX+JaVoGs+3BmKex3GgkYMb/BK1uV96Wadu3zdCDv78b0SlsUIqpwDxAWxNL7SgduqJsV5OXbVShqd+5DC4gpWsIizZOXWf48OCz/B+NMgIVrv3zEw/b9SefLNFPhcoNJ2Fl7BDpGmMaGZaO+2O7JXmChjQt+bpk+5ZCFj9EV7XoJTc66zmqWaU2kfViSXoIrvBLYBPZriiCFu+kOExp5Kxek0mZF1TgpLAPCtKiqWJZ38kfIMwpWICRDKUpwd1x/TnS4XH0GqTyZrR9CkgTbDdBSA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a879a-b4cc-4409-ac59-08d738aa1fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 00:26:01.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rePjEdsLGzf80UT3JZBBF3zQl/mER1a70ZcPtCDBuN7uKFOo3wP+mbvb8x2wcWlsgldIvECImRxBHPV52CbRfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMTkgMjo0NCBQTQ0KPg0KPiA+IE9uIHJlY2VudCBXaW5kb3dz
IFNlcnZlciAyMDE5KyBob3N0cywgdGhlIHRvb2xzdGFja3Mgb24gdGhlIGhvc3RzDQo+ID4gZ3Vh
cmFudGVlcyB0aGF0IER5bmFtaWMgTWVtb3J5IGFuZCBNZW1vcnkgUmVzaXppbmcgY2FuIG5vdCBi
ZSBlbmFibGVkDQo+ID4gaWYgdGhlIHZpcnR1YWwgQUNQSSBTNCBzdGF0ZSBpcyBlbmFibGVkLCBh
bmQgdmljZSB2ZXJzYS4gUGxlYXNlIHJlZmVyIHRvIHRoZQ0KPiA+IGxvbmcgd3JpdGUtdXAgSSBt
YWRlIGhlcmUuDQo+DQo+IEhhaCwgc28gdGhlIHBhdGNoIGhlcmUgaXMgbm90IGFjdHVhbGx5IHJl
bGV2YW50IGZvciBtb2Rlcm4gSHlwZXItVg0KDQpDb3JyZWN0Lg0KDQo+IGluc3RhbGxhdGlvbnMu
IChJIHdvdWxkIGhhdmUgbG92ZWQgdG8gcmVhZCB0aGF0IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlv
bg0KPiAtIGJ1dCBtYXliZSBJIG1pc3NlZCB0aGF0KQ0KDQpJJ2xsIGFkZCB0aGUgcmVsYXRlZCBk
ZXNjcmlwdGlvbiBpbnRvIHRoZSBjaGFuZ2Vsb2cgb2YgdjIgb2YgdGhpcyBwYXRjaC4NCg0KPiA+
IEFuZCwgdG8gbWFrZSB0aGUgaGliZXJuYXRpb24gZnVuY3Rpb25hbGl0eSBhdXRvbWF0ZWQsIHRo
ZSBob3N0IGlzIGFibGUgdG8NCj4gPiBzZW5kIGEgInBsZWFzZSBoaWJlcm5hdGUiIG1lc3NhZ2Ug
dG8gdGhlIFZNIHZpYSB0aGUgSHlwZXItViBzaHV0ZG93bg0KPiA+IGRldmljZSB1cG9uIHRoZSB1
c2VyJ3MgcmVxdWVzdCAoZS5nLiB2aWEgR1VJIG9yIHNjcmlwdGluZyk6IHNlZSBbLi4uXQ0KPiA+
IFdoZW4gdGhlIGhvc3Qgc2VuZHMgdGhlIG1lc3NhZ2UsDQo+ID4gaXQgY2hlY2tzIGlmIHRoZSB2
aXJ0dWFsIEFDUEkgUzQgc3RhdGUgaXMgZW5hYmxlZCBmb3IgdGhlIFZNOiBpZiBub3QsIHRoZSBo
b3N0DQo+ID4gcmVmdXNlcyB0byBzZW5kIHRoZSBtZXNzYWdlLiBUaGlzIG1lYW5zIHRoYXQgdGhl
IHVzZXIgZG9lcyB3YW50IHRvIG1ha2UNCj4gPiBzdXJlIHRoZSB2aXJ0dWFsIEFDUEkgUzQgc3Rh
dGUgaXMgZW5hYmxlZCBmb3IgdGhlIFZNLCBpZiB0aGUgdXNlciBvZiB0aGUgVk0NCj4gPiB3YW50
cyB0byB1c2UgdGhlIGhpYmVybmF0aW9uIGZlYXR1cmUsIGFuZCB0aGlzIG1lYW5zIER5bmFtaWMg
TWVtb3J5DQo+ID4gYW5kIE1lbW9yeSBSZXNpemluZyBjYW4gbm90IGJlIGFjdGl2ZSBkdWUgdG8g
dGhlIHJlc3RyaWN0aW9ucyBmcm9tIHRoZQ0KPiA+IGhvc3QgdG9vbHN0YWNrLg0KPg0KPiBPa2F5
LCAqYnV0KiB0aGlzIGlzIGEgY3VycmVudCBsaW1pdGF0aW9uLiBKdXN0IHNheWluZy4gSWYgeW91
IGNvdWxkIGF0DQo+IGxlYXN0IHN1cHBvcnQgYmFsbG9vbiBpbmZsYXRlL2RlZmxhdGUsIHRoYXQg
d291bGQgYmUgYSBjbGVhciB3aW4gZm9yDQo+IHVzZXJzLiBBbmQgbGVzcyBjb25maWd1cmF0aW9u
IGtub2JzLg0KDQpGb3IgSHlwZXItViAob24gcmVjZW50bHkgaG9zdHMpLCBEeW5hbWljIE1lbW9y
eSAoYW5kIE1lbW9yeSBSZXNpemluZykNCmFuZCBoaWJlcm5hdGlvbiBhcmUgbXV0dWFsbHkgZXhj
bHVzaXZlIGFuZCBhcyBJIG1lbnRpb25lZCB0aGUgaG9zdCB0b29sc3RhY2sNCmd1YXJhbnRlZXMg
dGhleSBjYW4gbm90IGJlIGJvdGggZW5hYmxlZC4gVGhpcyBpcyBhIGhvc3QgbGltaXRhdGlvbiBh
bmQgdGhlIFZNDQooaS5lLiB3ZSB0aGUgTGludXggdGVhbSkgY2FuIGRvIG5vdGhpbmcgYWJvdXQg
dGhpcy4gTm90ZTogaGVyZSAiZW5hYmxlDQpoaWJlcm5hdGlvbiBmb3IgYSBWTSIgbWVhbnMgImVu
YWJsZSB0aGUgdmlydHVhbCBBQ1BJIFM0IHN0YXRlIGZvciB0aGUgVk0iLg0KDQpCeSBkZWZhdWx0
IGEgVk0gcnVubmluZyBvbiBIeXBlci1WIGRvZXNuJ3QgaGF2ZSB0aGUgUzQgc3RhdGUgZW5hYmxl
ZCwgYW5kDQpiYWxsb29uIGluZmxhdGUvZGVmbGF0ZSBhcmUgaW5kZWVkIHN1cHBvcnRlZC4NCg0K
VGhlIGtub2IgKEkgdGhpbmsgeW91IG1lYW4gdGhlIHZpcnR1YWwgQUNQSSBTNCBzdGF0ZSkgaXMg
aW50cm9kdWNlZCBpbiB0aGUNCmhvc3Qgc2lkZSBkZXNpZ24gb2YgdGhlIFZNIGhpYmVybmF0aW9u
IGZlYXR1cmUsIGFuZCBpcyBlbmZvcmNlZCBpbiB0aGUNCmhvc3QgdG9vbHN0YWNrIChhcyBJIGRl
c2NyaWJlZCBhYm91dCB0aGUgaG9zdC10by1WTSAicGxlYXNlIGhpYmVybmF0ZSINCm1lc3NhZ2Up
LiBObyBrbm9iIG9yIG1vZHVsZSBwYXJhbWV0ZXIgaXMgaW50cm9kdWNlZCBieSB0aGUgVk0gaGVy
ZS4NCg0KPiA+IEFuZCB0aGUgaGliZXJuYXRpb24gZnVuY3Rpb25hbGl0eSB3b24ndCBiZSBvZmZp
Y2lhbGx5IHN1cHBvcnRlZCBvbiBvbGQNCj4gPiBXaW5kb3dzIFNlcnZlciBob3N0cy4NCj4gPg0K
PiA+IFNvLCBJTUhPIHdlIGNhbid0IGJlIGJvdGhlciB0byBpbXBsZW1lbnQgdGhlIGlkZWEgeW91
IGRlc2NyaWJlZCBpbg0KPiA+IGRldGFpbC4gU29ycnkuIDotKQ0KPg0KPiBObyB3b3JyaWVzLCBJ
IG5laXRoZXIgZGV2ZWxvcCBmb3IsIHVzZSBvciB3b3JrIHdpdGggSHlwZXItVi4gSSB3YXMganVz
dA0KPiByZWFkaW5nIGFsb25nIGFuZCB3b25kZXJpbmcgd2h5IHlvdSBiYXNpY2FsbHkgbWFrZSB0
aGUgaHZfYmFsbG9vbg0KPiB1bnVzYWJsZSBpbiB0aGVzZSBlbnZpcm9ubWVudHMuIChpbml0aWFs
bHkgSSB0aG91Z2h0LCAid2h5IGRvbid0IHlvdQ0KPiBqdXN0IGRpc2FsbG93IHByb2JpbmcgdGhl
IGRldmljZSBjb21wbGV0ZWx5IikNCg0KVGhlIEh5cGVyLVYgdGVhbSB0b2xkIG1lIHRoYXQ6IHdo
ZW4gaGliZXJuYXRpb24gaXMgZW5hYmxlZCAmIHVzZWQgZm9yDQphIFZNIHRoZSBvbmx5IHB1cnBv
c2Ugb2YgbG9hZGluZyBodl9iYWxsb29uIGlzIHRoYXQgdGhlIGRyaXZlciBjYW4NCnN0aWxsIHJl
cG9ydCB0aGUgVk0ncyBtZW1vcnkgcHJlc3N1cmUgdG8gdGhlIGhvc3QsIGFuZCBpdCBsb29rcyBk
dWUgdG8NCnNvbWUgKG5vbi10ZWNobmljYWw/KSByZWFzb24gdGhlIEh5cGVyLVYgdGVhbSB0aGlu
a3MgdGhpcyBpbmZvIGNhbiBiZQ0KdXNlZnVsLg0KDQo+IEkgYW0gYXdhcmUgb2YgdGhlIChoeXBl
cnZpc29yKSBpc3N1ZXMgb2YgaGliZXJuYXRpb24vc3VzcGVuZCB3aGVuIGl0DQo+IGNvbWVzIHRv
IGJhbGxvb24gZHJpdmVycyAvIG1lbW9yeSBob3QodW4pcGx1Zy4gKGN1cnJlbnRseSB3b3JraW5n
IG9uDQo+IHZpcnRpby1tZW0gbXlzZWxmIGFuZCBpbml0aWFsbHkgZGVjaWRlZCB0byBibG9jayBh
bnkNCj4gaGliZXJuYXRpb24vc3VzcGVuc2lvbiBhdHRlbXB0cyBpbiBjYXNlIHRoZSBkcml2ZXIg
aXMgbG9hZGVkIGFuZCBtZW1vcnkNCj4gd2FzIHBsdWdnZWQvdW5wbHVnZ2VkKQ0KPg0KPiA+DQo+
ID4gQW5kLCB3aGlsZSBJIGFncmVlIHlvdXIgaWRlYSBpcyBnb29kLCB0ZWNobmljYWxseSBzcGVh
a2luZyBJIHN1c3BlY3QgaXQgbWF5DQo+ID4gbm90IGJlIHJlYWxseSB1c2VmdWwsIGJlY2F1c2Ug
b25jZSBodl9iYWxsb29uIGFsbG93cyBiYWxsb29uLXVwL2Rvd24sDQo+ID4gaHZfYmFsbG9vbiBl
ZmZlY3RpdmVseSBsb3NlcyBjb250cm9sIG9mIG1lbW9yeSBwYWdlczogYWZ0ZXIgdGhlIGhvc3QN
Cj4gPiB0YWtlcyBzb21lIG1lbW9yeSBhd2F5LCB0aGUgVk0gbmV2ZXIga25vd3Mgd2hlbiBleGFj
dGx5IHRoZQ0KPiA+IGhvc3Qgd2lsbCBnaXZlIGl0IGJhY2sgLS0gYWN0dWFsbHkgdGhlIGhvc3Qg
bmV2ZXIgZ3VhcmFudGVlcyBob3cgc29vbg0KPiA+IGl0IHdpbGwgZ2l2ZSB0aGUgbWVtb3J5IGJh
Y2suIENvbnNlcXVlbnRseSwgdGhlIFZNIGFsbW9zdCBpbW1lZGlhdGVseQ0KPiA+IGVuZHMgdXAg
aW4gYW4gdW4taGliZXJuYXRhYmxlIHN0YXRlLi4uDQo+IElmIHlvdSBnbyB2aWEgdGhlIGhvc3Qs
IHlvdSBtaWdodCBiZSBhYmxlIHRvIG1ha2Ugc3VyZSB0byByZXF1ZXN0IHRvDQo+IGRlZmxhdGUg
dGhlIGJhbGxvb24gYmVmb3JlIHlvdSB0cnkgdG8gaGliZXJuYXRlLCBhbmQgaW5mbGF0ZSBhZ2Fp
biB3aGVuDQo+IGJhY2sgdXAuIFlvdSBtaWdodCBldmVuIGFzayB0aGUgdXNlciBmb3IgcGVybWlz
c2lvbnMuIE9mIGNvdXJzZSwgb25jZQ0KPiB5b3UgZGVmbGF0ZWQgdGhlIGJhbGxvb24sIGl0IG1p
Z2h0IG5vdCBiZSBndWFyYW50ZWVkIHRvIGluZmxhdGUgdGhlDQo+IGJhbGxvb24gdG8gdGhlIG9y
aWdpbmFsIHNpemUuIEJ1dCBhZnRlciBhbGwsIGl0J3MgImR5bmFtaWMgbWVtb3J5Iiwgc28NCj4g
aXQgbWlnaHQgZXZlbiBiZSB3aGF0IHRoZSBuYW1lIHN1Z2dlc3RzLiBJdCBjb3VsZCBiZSB2ZXJ5
IHdlbGwNCj4gY29udHJvbGxlZCBmcm9tIHRoZSBob3N0Lg0KPg0KPiBJZiB5b3UgZ28gdmlhIHRo
ZSBndWVzdCwgeW91IHdvdWxkIGZpcnN0IGhhdmUgdG8gdGVsbCB5b3VyIGh5cGVydmlzb3INCj4g
InBsZWFzZSBhbGxvdyBtZSB0byBkZWZsYXRlIHNvIEkgY2FuIGhpYmVybmF0ZSIsIG9yIHNvbWV0
aGluZyBsaWtlIHRoYXQuDQo+IEFmdGVyIGhpYmVybmF0aW9uIChvciBzb21lIHRpbWUgWCksIHRo
ZSBob3N0IG1pZ2h0IHRoZW4gZGVjaWRlIHRvDQo+IGluZmxhdGUgYWdhaW4uDQo+DQo+IEUuZy4s
IHRha2UgYSBsb29rIGF0IHZpcnRpby1iYWxsb29uLiBXaGVuIHN1c3BlbmRpbmcsIGl0IHNpbXBs
eSBkZWZsYXRlcw0KPiAod2l0aG91dCBhc2tpbmcgLi4uKSwgdG8gaW5mbGF0ZSBhZ2FpbiB3aGVu
IHJlc3VtaW5nLiBOb3Qgc2F5aW5nIHRoYXQncw0KPiB0aGUgYmVzdCBhcHByb2FjaCAoaXQncyBu
b3QgOikgKSwgYnV0IG9uZSBhcHByb2FjaCB0byBhdCBsZWFzdCBtYWtlIGl0IHdvcmsuDQoNClll
cywgSSBub3RpY2VkIHRoaXMgYSBmZXcgbW9udGhzIGFnby4gSSB0aGluayBhIG1ham9yIGRpZmZl
cmVuY2UgaW4gSHlwZXItVg0KYmFsbG9vbmluZyBtZWNoYW5pc20gaXMgdGhhdDogYWxsIHRoZSBk
ZWZsYXRlL2luZmxhdGUgcmVxdWVzdHMgYXJlIGZyb20NCnRoZSBob3N0IGFuZCB0aGUgVk0gY2Fu
IG5ldmVyIHByb2FjdGl2ZWx5IGFzayB0aGUgaG9zdCB0byBkZWZsYXRlL2luZmxhdGUNCnRoZSBW
TSdzIG1lbW9yeS4gQWxsIHRoYXQgdGhlIFZNIGNhbiBkbyBpcyByZXBvcnQgaXRzIG1lbW9yeSBw
cmVzc3VyZQ0KdG8gdGhlIGhvc3QgYW5kIGhvcGUgdGhlIGhvc3Qgd2lsbCBzb29uIGdpdmUgYmFj
ayB0aGUgbWVtb3J5IHRoYXQgd2FzDQp0YWtlbiBhd2F5IGJ5IHRoZSBob3N0Lg0KDQpJIHBlcnNv
bmFsbHkgbGlrZSB0aGUgYXBwcm9hY2ggdXNlZCBpbiB2aXJ0aW8tYmFsbG9vbi4gOi0pDQoNCj4g
QW55aG93LCBqdXN0IHNvbWUgY29tbWVudHMgZnJvbSBteSBzaWRlIDopIEkgY2FuIHNlZSBob3cg
V2luZG93cyBTZXJ2ZXINCj4gd29ya2VkIGFyb3VuZCB0aGF0IGlzc3VlIHJpZ2h0IG5vdyBieSBq
dXN0IFhPUidpbmcgYm90aCBmZWF0dXJlcy4NCj4NCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQpUaGFu
a3MgZm9yIHNoYXJpbmcgeW91ciB0aG91Z2h0cyENCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
