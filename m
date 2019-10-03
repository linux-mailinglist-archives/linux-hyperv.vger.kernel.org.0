Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92633C9867
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJCGoy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 02:44:54 -0400
Received: from mail-eopbgr1300117.outbound.protection.outlook.com ([40.107.130.117]:59744
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfJCGoy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 02:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UallpPXBEEqVcDOOhxMxkaLov4yuIaDLuizWfNpxwm/4XfcINUQdqAmtCjldcNyPWkAFsJTkWBOMWIBLbEBy+JhSX3Bj6tknyHKvcje+b3n2ywKep21304pD/Dpggo/e8aFhtteBRjXONUlzzMXbtyXAbOyhx0+ZKB9W0Pz2bGWYdvRtcr+VZ3lnG17cgJzzHwZlkOVXFWq1RH+UGGp4unKXt42CYevt1LVxO72j40BaSNKtupcBsT0Gmv1KCGYfC8NfajiiCjOQS0g3DDOfTHeffvjnsFg9po+3XU3sDuVyoljWrojelODsAjCfWs2pb2+wLOxh86iQwo4/6sHb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzTi/bd79kdo4uu5/8krTJiB7nb/MdXsYmOR5LLVuZc=;
 b=b50ZM90GrWg/FqfEgpJ7DsGYUONmKu+IKZ0YvCaQrDlWOLklPPgRX1UFxznM80mUPE0UeowOjj7iCOpfpfk4XNV6dwIpjf1GxxuRtvF6x8B4KGttc+ovnXEj3f5tmCcLDTVn+MYAqnoZ+a2aXAvQYTIGNPXcwCcqcDIv6SwiVup24rBAcXn/LmdTkPwnewiKO4nHqxs21cLGcQATL+aoJRfKZ3IXcbHMIQnuvvpx7Ln8QjC07K2nER+1LtgxX4CAgdcXBN4rwhq80b6pN6CNCSwCqE4To4IaX2woFyw8mqgR8SPKV35MpCRptreqBDNI9vS397TRTI3zzBvxGZ1liQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzTi/bd79kdo4uu5/8krTJiB7nb/MdXsYmOR5LLVuZc=;
 b=hxlT2Gi+dj1690Hk6JM6AZF/fext1NsKYsXB8D4EmPk+7F+a9i14ua0SMupYXjcyuS9SltN/W4JgjqdeP6VNatYb+hYSTJso59XlwatCLtTwtHGtS40pVGtdVJwVBpAMXPRq7zUSplIXwRkg3stWogzE7Z9X9SPLUmwkxU/1G4c=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0187.APCP153.PROD.OUTLOOK.COM (10.170.188.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Thu, 3 Oct 2019 06:44:05 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.021; Thu, 3 Oct 2019
 06:44:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Topic: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4VggAqesgCABFerkIAAR5AAgAAEvxCAA52PEA==
Date:   Thu, 3 Oct 2019 06:44:04 +0000
Message-ID: <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-03T05:35:12.9166695Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8fbbc20-ec57-44eb-b763-8c5867f66517;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:24b0:cdff:a7c5:c70f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e54bb8f-0ace-4921-9d5b-08d747cd15b5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0187:|PU1P153MB0187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01875BDB1344A08938A40952BF9F0@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(74316002)(2940100002)(229853002)(52536014)(66946007)(64756008)(66446008)(66476007)(66556008)(14454004)(102836004)(2906002)(6116002)(5660300002)(76116006)(8990500004)(99286004)(316002)(76176011)(6916009)(6506007)(22452003)(71200400001)(186003)(7696005)(71190400001)(54906003)(305945005)(446003)(8936002)(11346002)(2351001)(81166006)(33656002)(86362001)(486006)(10090500001)(8676002)(81156014)(2501003)(25786009)(478600001)(6436002)(55016002)(5640700003)(256004)(14444005)(107886003)(4326008)(6246003)(9686003)(476003)(46003)(10290500003)(1361003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0187;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FY2sOINe7ZVumXp3E7adJUjFpwDN9N55EiJpblczxJax9vUaZbHSXC1vI0+J4RjT4W1XCoFkgNvO1n1pVmqAgTih2IRMYBGrvjr2F+27IXvQ3d3VkRz/InieoNk/RaOnVywfVpaAxt4cYIRF1ncRWeb+piDRGFiKpr799MrlsIp3NZm4AmYIpxxGZBlupSMwuN/7N2XfadpI/zCqz2P3ALNMel6lmMGNktaOUvCupZxgwATfhix36EkMDpBYPAi4/YLEE+PYqLTYSllmbfzdxV2VVlmwyg7s/zgpivr7V5rXT6FRAivQyDRqqngFMELzR/nzcS1R3rfVZBdJ5dNsoqC4DVFns3LH+jP6zaK1WZNmoz8hMM8wdOhpd87PsjXyPhA22N26wdETK2jvoKzUHokxfQr+NtarNTs9JtGRl4Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e54bb8f-0ace-4921-9d5b-08d747cd15b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 06:44:04.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmwmdAPkB+pFQuMQ8du4BoZT+YXDzxUqfIm4DPr0ZcVJ7LuZQw080L/haVh8fxE1gCsJz1yv+9ITQBfdml8cIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0187
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEZXh1YW4gQ3VpDQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyLCAyMDE5IDEw
OjM1IFBNDQo+ID4gLi4uIA0KPiA+DQo+ID4gwq9cXyjjg4QpXy/CryBJZiB5b3UgZG8gbm90IHdh
bnQgdG8gaW1wbGVtZW50IGhpYmVybmF0aW9uIHByb3Blcmx5IGluIHZtYnVzDQo+ID4gY29kZSB0
aGF0IGlzIHRvdGFsbHkgdXAgdG8geW91IChoYXZlIHlvdSByZWFkIGluIHBtLmggaG93IGZyZWV6
ZSgpIGlzDQo+ID4gZGlmZmVyZW50IGZyb20gc3VzcGVuZCgpPykuDQo+ID4gRG1pdHJ5DQo+IA0K
PiBJIHVuZGVyc3RhbmQgZnJlZXplKCkgaXMgZGlmZmVyZW50IGZyb20gc3VzcGVuZCgpLiBIZXJl
IEkgdHJlYXQgc3VzcGVuZCgpIGFzIGENCj4gaGVhdnl3ZWlnaHQgZnJlZXplKCkgZm9yIHNpbXBs
aWNpdHkgYW5kIElNSE8gdGhlIGV4dHJhIGNvc3Qgb2YgdGltZSBpcw0KPiBuZWdsZWN0YWJsZSBj
b25zaWRlcmluZyB0aGUgbG9uZyBoaWJlcm5hdGlvbiBwcm9jZXNzLCB3aGljaCBjYW4gdGFrZQ0K
PiA1fjEwKyBzZWNvbmRzLg0KPiANCj4gRXZlbiBpZiBJIGltcGxlbWVudCBhbGwgdGhlIHBtIG9w
cywgSU1PIHRoZSBpc3N1ZSB3ZSdyZSB0YWxraW5nIGFib3V0DQo+IChpLmUuIHRoZSBoaWJlcm5h
dGlvbiBwcm9jZXNzIGNhbiBiZSBhYm9ydGVkIGJ5IHVzZXIncyBrZXlib2FyZC9tb3VzZQ0KPiBh
Y3Rpdml0aWVzKSBzdGlsbCBleGlzdHMuIEFjdHVhbGx5IEkgdGhpbmsgYSBwaHlzaWNhbCBMaW51
eCBtYWNoaW5lIHNob3VsZCBoYXZlDQo+IHRoZSBzYW1lIGlzc3VlLg0KPiANCj4gSW4gcHJhY3Rp
Y2UsIElNTyB0aGUgaXNzdWUgaXMgbm90IGEgYmlnIGNvbmNlcm4sIGFzIHRoZSBWTSB1c3VhbGx5
IHJ1bnMgaW4NCj4gYSByZW1vdGUgZGF0YSBjZW50ZXIsIGFuZCB0aGUgdXNlciBoYXMgbm8gYWNj
ZXNzIHRvIHRoZSBWTSdzDQo+IGtleWJvYXJkL21vdXNlLiA6LSkNCj4gDQo+IEkgaG9wZSBJIHVu
ZGVyc3Rvb2QgeW91ciBjb21tZW50cy4gSSdsbCBwb3N0IGEgdjIgd2l0aG91dCB0aGUgbm90aWZp
ZXIuDQo+IFBsZWFzZSBBY2sgdGhlIHYyIGlmIGl0IGxvb2tzIGdvb2QgdG8geW91Lg0KPiANCj4g
LS0gRGV4dWFuDQoNCkkgdGhpbmsgSSB1bmRlcnN0b29kIG5vdzogaXQgbG9va3MgdGhlIHZtYnVz
IGRyaXZlciBzaG91bGQgaW1wbGVtZW50DQphIHByZXBhcmUoKSBvciBmcmVlemUoKSwgd2hpY2gg
Y2FsbHMgdGhlIGh5cGVydl9rZXlib2FyZCBkcml2ZXIncw0KcHJlcGFyZSgpIG9yIGZyZWV6ZSgp
LCB3aGljaCBjYW4gc2V0IHRoZSBmbGFnIG9yIGRpc2FibGUgdGhlIGtleWJvYXJkDQpldmVudCBo
YW5kbGluZy4gVGhpcyB3YXkgd2UgZG9uJ3QgbmVlZCB0aGUgbm90aWZpZXIuDQoNClBsZWFzZSBs
ZXQgbWUga25vdyBpZiBJIHN0aWxsIGRvbid0IGdldCBpdCByaWdodC4NCg0KVGhhbmtzLA0KLS0g
RGV4dWFuDQo=
