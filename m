Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A8B8386
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfISVj3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 17:39:29 -0400
Received: from mail-eopbgr1320139.outbound.protection.outlook.com ([40.107.132.139]:62432
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390087AbfISVj2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 17:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl+6Zg4iNfDfMaLJnRRxQRewjhDXhjBrQk6UA7sX6h8NLMseL12dEuTCkObFrmhaxrIoF8KJppCucjdZ1XtIbCrNvd4gtway+uUGZmvKEqvMQrufy+DP0YXzkqeHqqVLO7lkCq5Ro/nv+tdkPPn0PhoD1ytfl798dr0CsS3ElmMHe/o/xfqGRfLI8V9BDiZel6sY2HQJORa4vK24UUJTIk8OVLIw9kEkXLMflEM0xFQhGq8JPNod+uhJwq96/3oRdBFrRQOJYg67ktYhBd6IrvMyi+Cf74Tw3wsw/eTFA5HLQUtHDPqU3uFQbgl1O9RulhJTit4q7QEBX23n6IPvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/GYmMZdV538hmEfRiHZxye30Ly2wtVoI26OwnYTh7o=;
 b=mRId6/HUhdSvjQ9bl/ih51d2UTwbBZeIli+F30YDLvGChl5IeIXUSSZ3J/JGWDgnOJBrFP6nosCB6CrhBSB/POPgZwQJYr+sMNdm39vjN5fH7VnM2ZQ0QwYGV+wxsxhdShRtKyXLg9A4K1fAQoQhJBReqqRlSz6IgLKrVuIj0HLpPT2bFVv0J8yF4PM1y2SA+99k9mFRO53kVEjpZNP+wNNQd0iFt/7/ptRH2XgScEGFUK0l8QMzBU76CZ9VR3l8BMfYEN1PFWhCJOpMIISmOYy6Gkf3+/dsbauQbyh/ppcfT7Y4SyYN/0POtp22yvq9RVQEaW98QIebXcJloGiz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/GYmMZdV538hmEfRiHZxye30Ly2wtVoI26OwnYTh7o=;
 b=Olq/jhVdcATB9fbPgAxQvpzujFyvhuzMd0BQGqB7rJGCfvqn0DuKsQBCwMtJML9EqlrgmMxAvyUjXfWUJL606FzJ2TPpPykOknKYBECgAuoLEchysa9rF9IrvMN3pD4ttJS/himvw+pgXwz9D4P5WYiJdWit89dftxxDDQ3SGho=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Thu, 19 Sep 2019 21:38:41 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.000; Thu, 19 Sep 2019
 21:38:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM
Thread-Index: AQHVbuNVCpMi5NoRqE2LyfAnlphBbaczhVyQ
Date:   Thu, 19 Sep 2019 21:38:41 +0000
Message-ID: <PU1P153MB016971CD922FC453F3E31E04BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568870297-108679-1-git-send-email-decui@microsoft.com>
 <CAK8P3a0oi2MQwt-P8taBt+VS+RTaoeNBgjoYNE7_L2VoQUSaEA@mail.gmail.com>
In-Reply-To: <CAK8P3a0oi2MQwt-P8taBt+VS+RTaoeNBgjoYNE7_L2VoQUSaEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-19T21:38:39.6926031Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cd706fc0-d6f8-43c9-bcd5-202658fceced;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:c9f2:179e:3d7c:c55e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6276f572-7bfd-4f61-6d95-08d73d49bd99
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0124:|PU1P153MB0124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB012438A26B008EFBF9A1E012BF890@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:186;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(99286004)(74316002)(86362001)(71200400001)(5660300002)(10090500001)(229853002)(46003)(446003)(102836004)(11346002)(25786009)(6506007)(476003)(8990500004)(71190400001)(53546011)(22452003)(6116002)(7736002)(9686003)(305945005)(107886003)(66476007)(66946007)(76116006)(66556008)(6246003)(64756008)(66446008)(52536014)(6436002)(55016002)(6916009)(2906002)(256004)(14444005)(81156014)(4326008)(33656002)(8936002)(486006)(81166006)(186003)(14454004)(7696005)(316002)(8676002)(10290500003)(76176011)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1P2Lf8pMpUaVrYM8NPkHuQoADsW8xKeHn3wVaZohsdEJ1CXp6Ni0LZlLSuHrCxpic5JSM822x2+mMWmmkO2XIkQFSWWnRTCEkOts/i4cr9xvRVbpqBOlTdeDzG/OwcQtqoyJRZEKQs4amVcFus/eDRJ4xcGw9Oid5+oSDpVeTofkYVq4mfQsJ994WUOpANKa1LB2j3eYb7kzjU6MM8OYy5xLZ3phpNm1HMlYm38GjMQ8eDt4W+3SQB2wUHsbIBTDscO6/El8pFvgyX6llfWJ08AiKc3BJa3F1UrcWTGnUaybSvDfBSzhqP+zOYvsGSvCR+rD9SpU28E583bAmVtoRe+8TSKNBq//MZIBFSz2foSMEoXPjK16Ta1cmT/8KnDXjFcQVvPVPyBl4Hp5XsnVz+RH75WOO4yPk1ydmb2pIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6276f572-7bfd-4f61-6d95-08d73d49bd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 21:38:41.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyMxUYsgpqqokrJ62yT5qYRFQwf7oLEdCAIt/7hKu3HN5Tee0U3+vxli8AnxkU4yWLawMcPcP8P5hZjLX7PsUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE5LCAyMDE5IDU6MTEgQU0NCj4gT24gVGh1LCBT
ZXAgMTksIDIwMTkgYXQgNzoxOSBBTSBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IElmIENPTkZJR19QTSBpcyBub3Qgc2V0LCB3ZSBjYW4gY29tbWVudCBv
dXQgdGhlc2UgZnVuY3Rpb25zIHRvIGF2b2lkIHRoZQ0KPiA+IGJlbG93IHdhcm5pbmdzOg0KPiA+
DQo+ID4gZHJpdmVycy9odi92bWJ1c19kcnYuYzoyMjA4OjEyOiB3YXJuaW5nOiDigJh2bWJ1c19i
dXNfcmVzdW1l4oCZIGRlZmluZWQNCj4gYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0N
Cj4gPiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjIxMjg6MTI6IHdhcm5pbmc6IOKAmHZtYnVzX2J1
c19zdXNwZW5k4oCZIGRlZmluZWQNCj4gYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0N
Cj4gPiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjkzNzoxMjogd2FybmluZzog4oCYdm1idXNfcmVz
dW1l4oCZIGRlZmluZWQgYnV0IG5vdA0KPiB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCj4gPiBk
cml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjkxODoxMjogd2FybmluZzog4oCYdm1idXNfc3VzcGVuZOKA
mSBkZWZpbmVkIGJ1dCBub3QNCj4gdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+ID4NCj4gPiBG
aXhlczogMjcxYjIyMjRkNDJmICgiRHJpdmVyczogaHY6IHZtYnVzOiBJbXBsZW1lbnQgc3VzcGVu
ZC9yZXN1bWUgZm9yDQo+IFZTQyBkcml2ZXJzIGZvciBoaWJlcm5hdGlvbiIpDQo+ID4gRml4ZXM6
IGY1MzMzNWUzMjg5ZiAoIkRyaXZlcnM6IGh2OiB2bWJ1czogU3VzcGVuZC9yZXN1bWUgdGhlIHZt
YnVzIGl0c2VsZg0KPiBmb3IgaGliZXJuYXRpb24iKQ0KPiA+IFJlcG9ydGVkLWJ5OiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERleHVhbiBDdWkgPGRl
Y3VpQG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJIHRoaW5rIHRoaXMgd2lsbCBzdGlsbCBwcm9kdWNl
IGEgd2FybmluZyBpZiBDT05GSUdfUE0gaXMgc2V0IGJ1dA0KPiBDT05GSUdfUE1fU0xFRVAgaXMg
bm90LCBwb3NzaWJseSBpbiBvdGhlciBjb25maWd1cmF0aW9ucyBhcw0KPiB3ZWxsLg0KPiANCj4g
IEFybmQNCg0KWW91J3JlIGNvcnJlY3QuIFRoYW5rcyEgDQoNCkknbGwgdXNlICIgI2lmZGVmIENP
TkZJR19QTV9TTEVFUCAuLi4gI2VuZGlmIiBpbnN0ZWFkLg0KDQpUaGUgbWVudGlvbmVkIGZ1bmN0
aW9ucyBhcmUgb25seSB1c2VkIGluIHRoZSBtaWNyb3MNClNFVF9OT0lSUV9TWVNURU1fU0xFRVBf
UE1fT1BTLCB3aGljaCBpcyBlbXB0eSBpZiBDT05GSUdfUE1fU0xFRVANCmlzIG5vdCBkZWZpbmVk
LiBTbyBpdCBsb29rcyB0byBtZSB1c2luZyAiI2lmZGVmIENPTkZJR19QTV9TTEVFUCAuLi4iIHNo
b3VsZA0KcmVzb2x2ZSB0aGUgaXNzdWUuDQoNCkJUVywgQ09ORklHX1BNX1NMRUVQIGRlcGVuZHMg
b24gQ09ORklHX1BNLCBzbyBpZiBDT05GSUdfUE0gaXMgbm90DQpkZWZpbmVkLCBDT05GSUdfUE1f
U0xFRVAgaXMgbm90IGRlZmluZWQgZWl0aGVyLg0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
