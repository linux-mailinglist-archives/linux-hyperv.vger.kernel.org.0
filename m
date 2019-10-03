Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5116CADFF
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfJCSS7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 14:18:59 -0400
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:58944
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731113AbfJCSS6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 14:18:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5LYwP1wkUCJhK41joc5buLVaVApHP9A5w4ftxCD7PeO5u/fs3xEicXf3eRYFXA0yfvoQc4QLgW03mr+6czLOuJJzs1Xw3EQVjdtSXBvNCmW6heKOJklO0hghY7x4HPjQRSOm/kMujUpzxmjVtD//+fB7h6c+XUPVOYqVnvenpa0FibI+bcZ2AwIDEMBy6V60bGjv7JWOSJuga832k769u3xc+GkWj338Zvq03EeG7iKUr0CgVReVu7qKW1WvC4aDP5gFvMgCcptdVS5MY7uaCpR5t89FowLWgEqvlvgaeHqMHysbq/Fe1lygkpYSyPCqrYu76gCpNnPADl8OCRd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZVzpDglIsz6Us7WGaF6KHFvSgYy7koC23diZDQqa6M=;
 b=a74INfAH++hBF98o/BCcIyO7Imu/Z1qF0id9Rrb3fyYDNvKnHN8213pXykHgN4P7iKFTw2raFvyohwJ+DMUdvtiC1fzvRQw8zkWMwbGKLOZ+YI/gDY84/PGGohF5DbT8Uii+Xv2sJaZOoQwtmyeqUpVAxMDoqXeWuo5i+RTEbMJTW6+ZOmQcDRFQNS61m0OnBv2PwCmGR1Qy4r/iOvb8GkhwWqq3+9Ym30sweWr2VqEjkFoMDBBuTHy6rlUWZ75Kn/lpG/EMwYcQ2rtYepWC3qNtiB0ckgKkZcyoRFJAeRzfE1Kw6ISJUBcpXZoqb+VXnmxS98bMpjUEzxvt+6MLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZVzpDglIsz6Us7WGaF6KHFvSgYy7koC23diZDQqa6M=;
 b=ZxEj+hURUKvMuxoJG4jp+6AUjBIkgjglwPH5CUJVvuAEyMT+OlWSAl8affuNb/Y3vH5iJuV+tzoYiN8FrZ4S6IUz02XA5QyqOBeYFrSqEP6rtxpi4DnOF1IEWCpEKNd4psgYu0OgvywdDQTRSsM6K8C4xrhUxKMr+p0h+tQ8AK8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0108.APCP153.PROD.OUTLOOK.COM (10.170.188.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.10; Thu, 3 Oct 2019 18:18:37 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.021; Thu, 3 Oct 2019
 18:18:37 +0000
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
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4VggAqesgCABFerkIAAR5AAgAAEvxCAA52PEIAAuuYAgAAIzDA=
Date:   Thu, 3 Oct 2019 18:18:37 +0000
Message-ID: <PU1P153MB016904AA7BAC9255552A89E1BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20191003174530.GB22365@dtor-ws>
In-Reply-To: <20191003174530.GB22365@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-03T18:18:35.5985548Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=33ad7441-da83-448d-b128-7a96e2c029e8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:e8be:9c25:96c9:9a3c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1826418-1d76-4f6e-29bd-08d7482e1c67
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0108:|PU1P153MB0108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB010888048611AE415CA99A1ABF9F0@PU1P153MB0108.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(5640700003)(229853002)(74316002)(5660300002)(2351001)(305945005)(107886003)(8936002)(14454004)(99286004)(81156014)(8676002)(6246003)(7696005)(6916009)(6436002)(1361003)(6506007)(10290500003)(486006)(476003)(316002)(2501003)(22452003)(76176011)(446003)(186003)(11346002)(55016002)(7736002)(9686003)(54906003)(71200400001)(478600001)(71190400001)(46003)(14444005)(256004)(64756008)(66556008)(33656002)(66476007)(66946007)(76116006)(102836004)(8990500004)(52536014)(66446008)(86362001)(25786009)(10090500001)(2906002)(4326008)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0108;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: op95pzlrpbwfKDGzhroTWub/CrivSmxUvRYbHBOD7GJm3q2ccB1gy/jlILtr2Irear0o2kUU6mGTUG1QWvhOF3aKF6+6sL3K12QYK3DvCEel1e6qKi2RK9075z5u7YMfTnFGtfYYPfWjJlolf0nSHqjiJ7yQyaNNLvmWvf6eJA2ZJq8aGqBdAXwEF85eE1MBWXwc//LIeC9GR+xdm279+eNkX3p3usClUKL8Uje9ciozZ4hX8+X3aH7PDuPEy6C+N2B4DOhqghaMLZL3WhXU6r0gk0+ulpEJmcxLbDThrDbSR9397Apr1eyoMYcSqzbMRIkXb0h143wCxTycQ+60LNpju1f8E1Ezwvn+ur7T2eZIzX7wrxQ1B9iSbbt5pdrECqFRx+VuOp51mE1nmhKdQ+K3ejyJAP0jUqqfDvdwR30=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1826418-1d76-4f6e-29bd-08d7482e1c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 18:18:37.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZbyaLYTWd+346zLLABlxVPtqglh5Zk/SmjOmyPsPxql4YWZZeuctJcCOPpOPQWHGMIEfOsePdj9JnvqgP/LuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0108
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tIDxkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDE5IDEwOjQ2IEFNDQo+ID4NCj4g
PiBJIHRoaW5rIEkgdW5kZXJzdG9vZCBub3c6IGl0IGxvb2tzIHRoZSB2bWJ1cyBkcml2ZXIgc2hv
dWxkIGltcGxlbWVudA0KPiA+IGEgcHJlcGFyZSgpIG9yIGZyZWV6ZSgpLCB3aGljaCBjYWxscyB0
aGUgaHlwZXJ2X2tleWJvYXJkIGRyaXZlcidzDQo+ID4gcHJlcGFyZSgpIG9yIGZyZWV6ZSgpLCB3
aGljaCBjYW4gc2V0IHRoZSBmbGFnIG9yIGRpc2FibGUgdGhlIGtleWJvYXJkDQo+ID4gZXZlbnQg
aGFuZGxpbmcuIFRoaXMgd2F5IHdlIGRvbid0IG5lZWQgdGhlIG5vdGlmaWVyLg0KPiANCj4gUmln
aHQuIEkgdGhpbmsgaW4gcHJhY3RpY2UgdGhlIGN1cnJlbnQgc3VzcGVuZCBpbXBsZW1lbnRhdGlv
biBjYW4gd29yaw0KPiBhcyBmcmVlemUoKSBmb3IgdGhlIEhWIGtleWJvYXJkLCBiZWNhdXNlIGlu
IHN1c3BlbmQgeW91IHNodXQgb2ZmIHZtYnVzDQo+IGNoYW5uZWwsIHNvIHRoZXJlIHNob3VsZCBu
b3QgYmUgd2FrZXVwIHNpZ25hbHMgYW55bW9yZS4gV2hhdCB5b3UgZG8gbm90DQo+IHdhbnQgaXMg
dG8gaGF2ZSB0aGUgY3VycmVudCByZXN1bWUgdG8gYmUgdXNlZCBpbiBwbGFjZSBvZiB0aGF3KCks
IGFzDQo+IHRoZXJlIHlvdSByZS1lbmFibGUgdGhlIHZtYnVzIGNoYW5uZWwgYW5kIHJlc3VtZSBz
ZW5kaW5nIHdha2V1cCByZXF1ZXN0cw0KPiBhcyB5b3UgYXJlIHdyaXRpbmcgb3V0IHRoZSBoaWJl
cm5hdGlvbiBpbWFnZSB0byBzdG9yYWdlLg0KPiANCj4gSSB0aGluayBpZiB2bWJ1cyBhbGxvd2Vk
IEhWIGtleWJvYXJkIGRyaXZlciB0byBzdXBwbHkgZW1wdHkgdGhhdygpIGFuZA0KPiBwb3dlcm9m
ZigpIGltcGxlbWVudGF0aW9ucywgd2hpbGUgdXNpbmcgc3VzcGVuZCgpIGFzIGZyZWV6ZSgpIGFu
ZA0KPiByZXN1bWUoKSBhcyByZXN0b3JlKCksIGl0IHdvdWxkIHNvbHZlIHRoZSBpc3N1ZSBmb3Ig
eW91Lg0KPiANCj4gRG1pdHJ5DQoNCkV4YWN0bHkuIEknbGwgaGF2ZSB0byBmaXggdm1idXMgZmly
c3QsIHRoZW4gcG9zdCBhIHYyIGZvciB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQotLSBEZXh1YW4N
Cg==
