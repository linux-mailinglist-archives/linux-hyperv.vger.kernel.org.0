Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03323B98BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2019 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfITVC0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Sep 2019 17:02:26 -0400
Received: from mail-eopbgr1320091.outbound.protection.outlook.com ([40.107.132.91]:10560
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387479AbfITVC0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Sep 2019 17:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNI2jozsbdfZ1q/mlTn/zqL3fRo5f9Ivlhrf8vCQxGTXLVTANCk3PcjeAqYFwdZ7x5+2qzISxk2DmkJEuzpdjxFNxCBNoD9Nv+o5hOCc1cuwQZFZzlRMgPSt5skgIVNx8r5cKTLq0lBKin+jD+MWiE3Qr5PMibeTJ3UzylJP1Pm3cDAFKlXcHrwrlyqmoFyctg0jL8pFstRIGQLy1y4xzJ5nwXOpQADSVYEGWIDryEFNfMW806HdsMO0b/q4V/epm13aBBC9PUG3t+PP9JFfhITntcb97XgJ3p+vNbidUQS+M2p2pcye6Xnr9qNnYhr0d5xX8nlqiKmPsKv+RNdC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCGtCUd2rUU151G4hjuMQ9tsMmftcL4pHsopUd2hHA=;
 b=I9YANJfm5HJlWiG8IskjLDX4CabpAwyhaPSakbLdJcw7aisdWk6/DbXyNNbIx40Fd6gx+ZlMgUPY/7iAENYaL2bx0qc1hve7hI6m+M2l547iDd+ZqcDfBNVuWGVX9FZ8n1AERsW46RyARjwIWqoxNaNXxmfmBDEKiVHox8jnrrQw58ldeh+dPzn0LoXjgy7WF4cvlrCvTPl2Tt39ijeXW9go5HMdqQ1FsOpe7duBwqWZ2eNPD30GaJ0zvomFL80W3GNsBC+0U2Z8zWM0s1wF6ozWRfbF43iHayFf3otyN3DZE5ECt7x+2V9sTclngcrJM+Vw8JdV9CUDDDXgFMtUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCGtCUd2rUU151G4hjuMQ9tsMmftcL4pHsopUd2hHA=;
 b=P7hCctUdH3/B5HrycI2qmMTUZQHNimQE263/Zk2NjqOTCX+rTlhQyc1NfYPrlwtJ5oyzb7uqNPLTF2ga71NDHQ1XzkFV81n0EuYla/r1EnH1j6VDTsjIqL2hsy3ULloieSYVkW6FSD8x3dikr8U0GtelJdxUcnSOsj5bWT5OO8s=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0138.APCP153.PROD.OUTLOOK.COM (10.170.188.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.2; Fri, 20 Sep 2019 21:02:17 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.011; Fri, 20 Sep 2019
 21:02:16 +0000
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
Thread-Index: AQHVbuNVCpMi5NoRqE2LyfAnlphBbaczhVyQgACoLoCAAIj/AA==
Date:   Fri, 20 Sep 2019 21:02:16 +0000
Message-ID: <PU1P153MB016961C78DA0656E479C5F15BF880@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568870297-108679-1-git-send-email-decui@microsoft.com>
 <CAK8P3a0oi2MQwt-P8taBt+VS+RTaoeNBgjoYNE7_L2VoQUSaEA@mail.gmail.com>
 <PU1P153MB016971CD922FC453F3E31E04BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAK8P3a0EvdR0SZdPhRV2o3PrxHo4BpJdWzAjExmKHhwrOsL54Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0EvdR0SZdPhRV2o3PrxHo4BpJdWzAjExmKHhwrOsL54Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-20T21:02:14.6237119Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8cecff4-31a7-4330-b920-8b22f4dbcd20;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:54b9:c9c3:20f2:72c9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec215871-5d47-49a3-8270-08d73e0dd1ad
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0138:|PU1P153MB0138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01382B00973E448C8624E51BBF880@PU1P153MB0138.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(186003)(46003)(6916009)(476003)(446003)(11346002)(486006)(86362001)(25786009)(55016002)(9686003)(14444005)(256004)(107886003)(4326008)(6246003)(71190400001)(71200400001)(2906002)(229853002)(7696005)(81166006)(81156014)(99286004)(8936002)(76176011)(6506007)(53546011)(102836004)(6116002)(8676002)(66476007)(66556008)(64756008)(66446008)(33656002)(76116006)(66946007)(8990500004)(10090500001)(6436002)(5660300002)(316002)(54906003)(7736002)(305945005)(74316002)(22452003)(52536014)(14454004)(10290500003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0138;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDANZKOjMTbeMdqy2yla2fRCS+ZIioH3lod3xs791lcXDEgF/YrZZ7viUtpSenriedy+IrZ9EZ+zopEIViWzpIb+TYS0ALYw6Hh/GQgS5e1Duc2NDXQz8+iygmVvha8P7dwp1XyZo+rZ8ZmXZ9+os9LyJRJadsm4zayUIyq0cMixy6MsRUsHgzdZT2TyY5F6DKXRFZK06TbUHFr9DZ1AK1DVf9q6UANiFK3aXb2HxsxkcOgRm8OWcgB7cJVn8QbQu8BASaCMTUwMFHyjdFeqxhLOKL6XkrDY/1ADdirZRURT2KtWUwzbeCrZuN1Hj19zY9ufHP/vHuazmx+Ybf/Ok2UwPoMCwC9RNBatfLBTMGfUqCwoBiDdxIwpmE7GcSEFbX+YmKY33WOOKcZRMfFiJyP4vfRxF+o0J1sSZUqENts=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec215871-5d47-49a3-8270-08d73e0dd1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 21:02:16.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRYawhtzNcE5lUuIN2CStGMteDAOrQVXWIKBqvPp2MBTFXI4vtPdCXH1Q7oOaBuSVRiMyNWsgPV3YfTl6qVjig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0138
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBTZW50OiBGcmlkYXksIFNl
cHRlbWJlciAyMCwgMjAxOSAxMjozMyBBTQ0KPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCAxMToz
OCBQTSBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTksIDIwMTkgNToxMSBBTQ0KPiA+ID4gT24gVGh1LCBTZXAg
MTksIDIwMTkgYXQgNzoxOSBBTSBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiB3
cm90ZToNCj4gDQo+ID4gPiBJIHRoaW5rIHRoaXMgd2lsbCBzdGlsbCBwcm9kdWNlIGEgd2Fybmlu
ZyBpZiBDT05GSUdfUE0gaXMgc2V0IGJ1dA0KPiA+ID4gQ09ORklHX1BNX1NMRUVQIGlzIG5vdCwg
cG9zc2libHkgaW4gb3RoZXIgY29uZmlndXJhdGlvbnMgYXMNCj4gPiA+IHdlbGwuDQo+ID4NCj4g
PiBZb3UncmUgY29ycmVjdC4gVGhhbmtzIQ0KPiA+DQo+ID4gSSdsbCB1c2UgIiAjaWZkZWYgQ09O
RklHX1BNX1NMRUVQIC4uLiAjZW5kaWYiIGluc3RlYWQuDQo+ID4NCj4gPiBUaGUgbWVudGlvbmVk
IGZ1bmN0aW9ucyBhcmUgb25seSB1c2VkIGluIHRoZSBtaWNyb3MNCj4gPiBTRVRfTk9JUlFfU1lT
VEVNX1NMRUVQX1BNX09QUywgd2hpY2ggaXMgZW1wdHkgaWYgQ09ORklHX1BNX1NMRUVQDQo+ID4g
aXMgbm90IGRlZmluZWQuIFNvIGl0IGxvb2tzIHRvIG1lIHVzaW5nICIjaWZkZWYgQ09ORklHX1BN
X1NMRUVQIC4uLiIgc2hvdWxkDQo+ID4gcmVzb2x2ZSB0aGUgaXNzdWUuDQo+IA0KPiBQcm9iYWJs
eSwgeWVzLiBUaGVyZSBhcmUgc29tZXRpbWVzIHN1cnByaXNpbmcgZWZmZWN0cywgc3VjaCBhcyB3
aGVuIG9uZSBvZiB0aGUNCj4gZnVuY3Rpb25zIGluc2lkZSBvZiB0aGUgI2lmZGVmIGNhbGwgYW5v
dGhlciBmdW5jdGlvbiB0aGF0IGlzIG90aGVyd2lzZSB1bnVzZWQuDQoNCkkgcmV2aWV3ZWQgdGhl
IHJlbGF0ZWQgZnVuY3Rpb25zIGFnYWluIGFuZCBJIGJlbGlldmUgd2l0aCB0aGUgdjIgd2UgZG9u
J3QgaGF2ZQ0Kc3VjaCBhbiBpc3N1ZSBhcyB5b3UgZGVzY3JpYmVkIGhlcmUuDQogDQo+IEkgd291
bGQgbm9ybWFsbHkgdHJ5IHRvIGJ1aWxkIGEgZmV3IGh1bmRyZWQgcmFuZGNvbmZpZyBidWlsZHMg
dG8gYmUgZmFpcmx5IHN1cmUNCj4gb2YgYSBjaGFuZ2UgbGlrZSB0aGlzLCBvciB1c2UgX19tYXli
ZV91bnVzZWQgbGlrZSBtb3N0IG90aGVyIGRyaXZlcnMgZG8gaGVyZS4NCj4gDQo+ICAgICAgICBB
cm5kDQoNCkkgZG8gc2VlIGEgbG90IG9mIGRyaXZlcnMgdXNpbmcgX19tYXliZV91bnVzZWQsIGJ1
dCBJTU8gY29uZGl0aW9uYWwNCmNvbXBpbGF0aW9uIGlzIHNsaWdodGx5IGJldHRlci4gSW4gY2Fz
ZSBjb25kaXRpb25hbCBjb21waWxhdGlvbiBzdGlsbCBoYXMgc29tZQ0KdW5leHBlY3RlZCBpc3N1
ZSwgd2UgY2FuIGFsd2F5cyBtYWtlIGEgZnVydGhlciBmaXguIDotKQ0KDQpUaGFua3MsDQotLSBE
ZXh1YW4NCg==
