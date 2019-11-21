Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0F104A88
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 07:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUGEq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Nov 2019 01:04:46 -0500
Received: from mail-eopbgr1310124.outbound.protection.outlook.com ([40.107.131.124]:56580
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfKUGEq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Nov 2019 01:04:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd82ysVmAntD6G9fpjNY9fnaj+BNtZLET3/4tVO8ZIWj2RMWzLkx2mZkUhLOPmovUv4A7HbfYby00EvWFcz10UaKy0gxsOWjdz5msCHm6uQKRTA6/aM9kOuyuTlhXo1WWuGn7f0lUR0fKO76lnOFlvZY2W2WVA9kC5tIJMSq8wYUtB+KK+LS16AzVLorotyFzVlLV/meGGHGYdi7kpLpx22i2MhVTx1jYgxNhEhe22qYl54qyFaqg+O+2nDxYPD5UIp4Pa/nmALJweSRQMklm6AoI0GyTm3wZ5bYtEYugnWf9AWGJ2J15xWjM4HSF+8RuTFjcq5tqtbmrnOwPUdcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oxv3ctmYWgT2BZXAttyha0B2WgLb6uXbu5FZ0sQRc4=;
 b=MrDWc0mO9/dxrWxuxfaXQFJUSdvs/CYnXO8QkTQMNJezGd12NGMddgH8gzfcx78wd+PR8XQk8uPfzak/+NGJMM/lb4YlW5b1xBBNmIZQP4OdXI127sY9U2vaIZ37Jf/WMbBDcbfaS6RRwR5GNkm3UklaOxL+ja/yM1PwfB6NUvdHwayrm59N56vezUeafTIOj2gOJ7USaQoCuSKmdiWQFtRxzmTFHzGNWtTp5pprCwwCMcxIDysQOqnVaJhD6vLz13u6HErnF1deAhQrRZRDa/Id1XekLhY9fnxac8euEvbvufw81y4qO/PpeVFkHm8NBuTe6qMR/eZphsmj0B4w5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oxv3ctmYWgT2BZXAttyha0B2WgLb6uXbu5FZ0sQRc4=;
 b=Q8f6YxfoDh+/rCeNiYVzzHNkFbf2p4xpTiRf6hxxzPiOOAVltcaddJKqgQGlXAYMWkz672cB11l/5XK7ecnx4h+lLtXILRRlpcT33BKKPD6+U4zStF0yDWNV1cr9GLhw1fOLVrgMrmajZkG3nBkv3Xn+ALlFV86nm7vtTTUe19A=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.0; Thu, 21 Nov 2019 06:04:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2495.010; Thu, 21 Nov 2019
 06:04:36 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO
 feature
Thread-Topic: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO
 feature
Thread-Index: AQHVn3IaBpxutL9CjUq7Dxtj1Of6aKeU7DrwgAA3eZA=
Date:   Thu, 21 Nov 2019 06:04:35 +0000
Message-ID: <PU1P153MB0169BF13B371A3A5037DA538BB4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574234028-48574-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01699A8B75901F896F1E4503BB4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01699A8B75901F896F1E4503BB4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-21T02:47:14.6204741Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e51bbfc-6a79-4f24-a8ad-0c7f07e32939;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da3c40ac-1617-4278-5034-08d76e48afd1
x-ms-traffictypediagnostic: PU1P153MB0122:|PU1P153MB0122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0122D0374ADA80D821A0B20FBB4E0@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(13464003)(199004)(189003)(478600001)(1511001)(316002)(86362001)(8936002)(6246003)(446003)(11346002)(256004)(2940100002)(25786009)(53546011)(6506007)(74316002)(305945005)(476003)(8676002)(7736002)(2201001)(14444005)(22452003)(102836004)(81156014)(81166006)(5660300002)(26005)(10090500001)(186003)(99286004)(110136005)(52536014)(76176011)(9686003)(6436002)(966005)(14454004)(76116006)(71190400001)(71200400001)(486006)(6306002)(6636002)(66446008)(66556008)(64756008)(66066001)(66476007)(2501003)(229853002)(2906002)(66946007)(8990500004)(10290500003)(55016002)(7696005)(33656002)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43vvaM3VlhxAMc9XltOVZOhIkB1roZ4joj0IjT5QgFKgDV4hA9o61wabE9y7zsxygmF7u0Ws2uZ3ElGsp/KQ7rOEfqHkmysATd3D0qnT4BCwMEpyP9L4cU2+YPAIB29rrrqDsFbz9F/byBMqA3eeViYjHTnL/QsgTmpN7Jl3NhTfI/rIRfcBP8G/BSjMMjXOwjWjTyE2OOF8xhrWFkqR5KASKIPTxst8rxIsrwIHlZvGUXAYW6ncE3sUJkRVAs6FR9SgTWpYk6J17AkuIYyvAOmBTz2VDpSzUqBTfvh7r2r/fw1nAr3QMc0ZAmTXInV4UUxmmoLd3wAx8NEV+ATn6IBsFr+2DW4vN2jSn7FPIACKLG6KgcICbVfqGRpkkioS+h8JwxUeqCShXQ04Amp3JdjmPm6s9FrP5zSGo4HSI1EM1M63PlnXvJE40S4uVH81qBuF/oR081h+iP0t9KRP1Fe+RuJKyEFoDICn8F7AAdg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3c40ac-1617-4278-5034-08d76e48afd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 06:04:35.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS8EpL9W9u3dUK2x90x+XXuUmHiHuT0GrwfLUwyyTysji5LZjA35Kz85vv+oVUPLev9QcrmQ+CRFtRSz1kRMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdlaSBIdQ0KPiBTZW50OiAy
MDE5xOoxMdTCMjHI1SAxMDo0Nw0KPiBUbzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNv
bT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4gSGFpeWFuZyBaaGFuZyA8
aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGhlbW1pbkBt
aWNyb3NvZnQuY29tPjsgc2FzaGFsQGtlcm5lbC5vcmc7IGIuem9sbmllcmtpZUBzYW1zdW5nLmNv
bTsNCj4gbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgbGludXgtDQo+IGZiZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTWljaGFlbCBLZWxsZXkNCj4gPG1pa2VsbGV5QG1pY3Jvc29mdC5j
b20+OyBTYXNoYSBMZXZpbiA8QWxleGFuZGVyLkxldmluQG1pY3Jvc29mdC5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0hdIHZpZGVvOiBoeXBlcnZfZmI6IEZpeCBoaWJlcm5hdGlvbiBmb3IgdGhl
IGRlZmVycmVkIElPDQo+IGZlYXR1cmUNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiBGcm9tOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiA+IFNlbnQ6
IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgMzoxNCBQTQ0KPiA+IFRvOiBLWSBTcmluaXZh
c2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPiA8aGFpeWFuZ3pAbWlj
cm9zb2Z0LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29t
PjsNCj4gPiBzYXNoYWxAa2VybmVsLm9yZzsgYi56b2xuaWVya2llQHNhbXN1bmcuY29tOyBsaW51
eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOw0KPiA+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+OyBT
YXNoYQ0KPiBMZXZpbg0KPiA+IDxBbGV4YW5kZXIuTGV2aW5AbWljcm9zb2Z0LmNvbT4NCj4gPiBD
YzogV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT47IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29m
dC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIXSB2aWRlbzogaHlwZXJ2X2ZiOiBGaXggaGliZXJu
YXRpb24gZm9yIHRoZSBkZWZlcnJlZCBJTyBmZWF0dXJlDQo+ID4NCj4gPiBmYl9kZWZlcnJlZF9p
b193b3JrKCkgY2FuIGFjY2VzcyB0aGUgdm1idXMgcmluZ2J1ZmZlciBieSBjYWxsaW5nDQo+ID4g
ZmJkZWZpby0+ZGVmZXJyZWRfaW8oKSAtPiBzeW50aHZpZF9kZWZlcnJlZF9pbygpIC0+IHN5bnRo
dmlkX3VwZGF0ZSgpLg0KPiA+DQo+ID4gQmVjYXVzZSB0aGUgdm1idXMgcmluZ2J1ZmZlciBpcyBp
bmFjY2Vzc2libGUgYmV0d2VlbiBodmZiX3N1c3BlbmQoKSBhbmQNCj4gPiBodmZiX3Jlc3VtZSgp
LCB3ZSBtdXN0IGNhbmNlbCBpbmZvLT5kZWZlcnJlZF93b3JrIGJlZm9yZSBjYWxsaW5nDQo+ID4g
dm1idXNfY2xvc2UoKSBhbmQgdGhlbiByZXNjaGVkdWxlIGl0IGFmdGVyIHdlIHJlb3BlbiB0aGUg
Y2hhbm5lbCBpbg0KPiA+IGh2ZmJfcmVzdW1lKCkuDQo+ID4NCj4gPiBGaXhlczogYTRkZGIxMWQy
OTdlICgidmlkZW86IGh5cGVydjogaHlwZXJ2X2ZiOiBTdXBwb3J0IGRlZmVycmVkIElPIGZvcg0K
PiA+IEh5cGVyLVYgZnJhbWUgYnVmZmVyIGRyaXZlciIpDQo+ID4gRml4ZXM6IDgyNDk0NmE4YjZm
YiAoInZpZGVvOiBoeXBlcnZfZmI6IEFkZCB0aGUgc3VwcG9ydCBvZiBoaWJlcm5hdGlvbiIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gPiAt
LS0NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIDIgYWZvcmVtZW50aW9uZWQgcGF0Y2hl
cyBvbiBTYXNoYSBMZXZpbidzIEh5cGVyLVYgdHJlZSdzDQo+ID4gaHlwZXJ2LW5leHQgYnJhbmNo
Og0KPiA+DQo+IGh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuDQo+ID4gZWwub3JnJTJGcHViJTJGc2NtJTJGbGlu
dXglMkZrZXJuZWwlMkZnaXQlMkZoeXBlcnYlMkZsaW51eC5naXQlMkZsb2cNCj4gPiAlMkYlM0Zo
JTNEaHlwZXJ2LQ0KPiA+DQo+IG5leHQmYW1wO2RhdGE9MDIlN0MwMSU3Q3dlaCU0MG1pY3Jvc29m
dC5jb20lN0M0NTExNDNmZjc4ZjA0NDAxZDkNCj4gPiA2ZjA4ZDc2ZDg5M2E4NCU3QzcyZjk4OGJm
ODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzcNCj4gPg0KPiAwOTgzMDg0OTMy
MTcxMjEmYW1wO3NkYXRhPVAyZm8lMkYxVEpVTUlqNUZ0SkNPcDJRd0RyZ2hoVmZQU0NFSjRmMQ0K
PiA+IHZrT1h2SSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gVGhlIDIgYWZvcmVtZW50aW9u
ZWQgcGF0Y2hlcyBoYXZlIG5vdCBhcHBlYXJlZCBpbiB0aGUgbWFpbmxpbmUgeWV0LCBzbw0KPiBw
bGVhc2UNCj4gPiBwaWNrIHVwIHRoaXMgcGF0Y2ggb250byBoZSBzYW1lIGh5cGVydi1uZXh0IGJy
YW5jaC4NCj4gPg0KPiA+ICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2h5cGVydl9mYi5jIHwgMiArKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9mYmRldi9oeXBlcnZfZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYv
aHlwZXJ2X2ZiLmMNCj4gPiBpbmRleCA0Y2QyN2U1MTcyYTEuLjA4YmMwZGZiNWNlNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2h5cGVydl9mYi5jDQo+ID4gKysrIGIvZHJp
dmVycy92aWRlby9mYmRldi9oeXBlcnZfZmIuYw0KPiA+IEBAIC0xMTk0LDYgKzExOTQsNyBAQCBz
dGF0aWMgaW50IGh2ZmJfc3VzcGVuZChzdHJ1Y3QgaHZfZGV2aWNlICpoZGV2KQ0KPiA+ICAJZmJf
c2V0X3N1c3BlbmQoaW5mbywgMSk7DQo+ID4NCj4gPiAgCWNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmcGFyLT5kd29yayk7DQo+ID4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmluZm8tPmRl
ZmVycmVkX3dvcmspOw0KPiA+DQo+ID4gIAlwYXItPnVwZGF0ZV9zYXZlZCA9IHBhci0+dXBkYXRl
Ow0KPiA+ICAJcGFyLT51cGRhdGUgPSBmYWxzZTsNCj4gPiBAQCAtMTIyNyw2ICsxMjI4LDcgQEAg
c3RhdGljIGludCBodmZiX3Jlc3VtZShzdHJ1Y3QgaHZfZGV2aWNlICpoZGV2KQ0KPiA+ICAJcGFy
LT5mYl9yZWFkeSA9IHRydWU7DQo+ID4gIAlwYXItPnVwZGF0ZSA9IHBhci0+dXBkYXRlX3NhdmVk
Ow0KPiA+DQo+ID4gKwlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmluZm8tPmRlZmVycmVkX3dvcmss
IGluZm8tPmZiZGVmaW8tPmRlbGF5KTsNCj4gPiAgCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcGFy
LT5kd29yaywgSFZGQl9VUERBVEVfREVMQVkpOw0KPiA+DQo+ID4gIAkvKiAwIG1lYW5zIGRvIHJl
c3VtZSAqLw0KPiA+IC0tDQo+ID4gMi4xOS4xDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgSHUg
PHdlaEBtaWNyb3NvZnQuY29tPg0KDQpTb3JyeSwgcGxlYXNlIGRpc3JlZ2FyZCB0aGUgU2lnbmVk
LW9mZi1ieSBsaW5lIEkgYWRkZWQgYWJvdmUuIEl0IHdhcyBteSBtaXN0YWtlLg0Kc2hvdWxkIGJl
Og0KDQpSZXZpZXdlZC1ieTogV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT4NCg0KDQo=
