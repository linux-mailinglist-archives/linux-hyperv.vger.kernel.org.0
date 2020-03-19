Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E618AA1B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 01:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCSA6L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 20:58:11 -0400
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:36705
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSA6L (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 20:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/qduBfy6pu4Tx41lTy5BQTCMnrikWG6SJIkTVY6uHldDCDdZpLHGBZUsFxakfB616W8Ohf1KCrkOj44oV2rznwrdqjU16Xt3FH6G073gNZTZ4S6f4QnUuZ6SzPy8Dq6URgn1TmW+xqhGppQBanm6pF9UcaRxyYprQ1T+wQRfS238wID35jwF5uWJfDNdvPPkCa3aH50C19XJvtTYCkQXdR5nSZLsNiNiezstDKQSawLWVR7nWLBvVbdOnUgtiZiJHqznUobcTTPmqHFALo972676YmoJJaZbLWWgSdZPKljxWYojrPO9ABAFalj3DQAQ3m3Y0nPuo/pKhzBy8SclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSfZ9/ubjKYYcfZNtPBxkAM0Gz5fkyjW6Nv+UWap9Hg=;
 b=SOggntUHu61voCdALx718u2THdVN0cQxFq7XsKp0cUG0Tp/0VY8Eo0oEnc0xpEYXX07KhlwVNrsl7YpUmfheOtgZYXjukmOu1pKaUiedVKifHuQBPV5l095ruK3ijtpcxTif82f4Z8e5FrbpqY6ovFnRR+jUZdsq42+imMZ8U6kitdD4VXOmnzlDB+7F/n6qoc+V6BCldcIme0UTfo65k0lJyBv+xVRVOHTENShIIrYvh0ctaKmwtddyCDUwIjobc7uNBbJHkb7C61dGFr4PK7QrUu6f9mHMEqs++MvnoqH+/xPuqvC+UQNn0HOYjIhUDnRXhQ/co2RMjupBex2VqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSfZ9/ubjKYYcfZNtPBxkAM0Gz5fkyjW6Nv+UWap9Hg=;
 b=HdlnGv4FtUl2mSiQxO60w8Oc+ErTQqfSdDcNEbnQJsrPxod/+R6FSCQY/1jDpprK6XcJyWisKcgvNxzOYrdAhG4YVfVPtHgh3vZlF/FVs4qYJmobzlpa9HP226RS7uC5CUKiSbPqA8AJIXXavJqAS8UN89TPV9d+mgI9oqnTLL4=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0924.namprd21.prod.outlook.com (2603:10b6:302:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.3; Thu, 19 Mar
 2020 00:57:27 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Thu, 19 Mar 2020
 00:57:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
Thread-Topic: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
Thread-Index: AQHV/F+JseEF95+YQU+g3MTcEXvX1qhPGEGQ
Date:   Thu, 19 Mar 2020 00:57:26 +0000
Message-ID: <MW2PR2101MB1052F185AF4134EB2BB9ECBFD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T00:57:24.2640761Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60fca1c1-b539-46ad-b401-1b419f8cbbf4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9c1fe86-25f8-4dee-07b9-08d7cba07ebe
x-ms-traffictypediagnostic: MW2PR2101MB0924:|MW2PR2101MB0924:|MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0924714CC10AE4930D382D3CD7F40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(7696005)(26005)(8676002)(316002)(478600001)(6506007)(71200400001)(66446008)(66556008)(186003)(66476007)(54906003)(8990500004)(55016002)(64756008)(76116006)(110136005)(66946007)(52536014)(9686003)(86362001)(81166006)(81156014)(8936002)(33656002)(10290500003)(5660300002)(2906002)(4326008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NA5I5HtnwfJDTEYK7M3XORAeHsVzw9YhiZrAEevE/SPftkJP68JlKRkTB22Cd6FJf8T4xUgATX5EhLD9IQblvVNxNI9p4Fzyc4o9r+DuNSCAFXZvYiZxuu+rAzkHRohQCS9lXv87ksNngTd8xFSjMJ2a3N7opeIYUD6HXmP70S1RZwopNJV3sj0cGkjfgVGehqwsNRIKyZUm8tiuhXVsthfQ4i1GItCZEsJt7d4s/1uRcVFvymOUFEyyXCY8gzSgwjuUQ7wn88SZB+L8/Qt2bQrXx98W1sMqbh5+moWbXwKjzC4Qt4p07glFK4Matqw8hVSE3ki0B1xDwB0zP2cAbx+kt6p9wGn0J9DRJo60VW1ZucVU9XBhhvnH/5XdeeXGu0USQUC8kAPN8sguUwdt46klE1np8dWct8n4mMIyZ8hMgJM1waQOf6eMddvx0RoxRb4VL2fx88/UuyBz0Qykh9i33Eg+CpJ8Awe42AIBTYkekt6coajaWduAJZ4ng8Zl
x-ms-exchange-antispam-messagedata: eV1oNIWn4VwzmvDdsU8bW8ZWrdj6ZVnOz8N65sb9OTFzh7aVruBYsoQTW9ThzbjlJ5bovMAalyoym7/Bv+K92Xfs+JjTVZEsprHg4hL1bEXUm97X//7gLHnj9xFnRwqVPl6nQBT0B+Zah+9vuk3xjA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c1fe86-25f8-4dee-07b9-08d7cba07ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:57:27.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LO9eH1Nks3qDtQQHcpn1lcI1Jynx9gnGxGXmDwWsq1NDgMjOlRYbwQrotlBiDJkWaJZCAHK/SiUKBBI2I26AfuIFrerx95iNzJDup5Rvdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogbHR5a2VybmVsQGdtYWlsLmNvbSA8bHR5a2VybmVsQGdtYWlsLmNvbT4gU2VudDogVHVl
c2RheSwgTWFyY2ggMTcsIDIwMjAgNjoyNSBBTQ0KPiANCj4gVGhpcyBwYXRjaHNldCBmaXhlcyBz
b21lIGlzc3VlcyBpbiB0aGUgSHlwZXItViBwYW5pYyBjb2RlIHBhdGguDQo+IFBhdGNoIDEgcmVz
b2x2ZXMgaXNzdWUgdGhhdCBwYW5pYyBzeXN0ZW0gc3RpbGwgcmVzcG9uc2VzIG5ldHdvcmsNCj4g
cGFja2V0cy4NCj4gUGF0Y2ggMi0zIHJlc29sdmVzIGNyYXNoIGVubGlnaHRlbm1lbnQgaXNzdWVz
Lg0KPiBQYXRjaCA0IGlzIHRvIHNldCBjcmFzaF9rZXhlY19wb3N0X25vdGlmaWVycyB0byB0cnVl
IGZvciBIeXBlci1WDQo+IFZNIGluIG9yZGVyIHRvIHJlcG9ydCBjcmFzaCBkYXRhIG9yIGttc2cg
dG8gaG9zdCBiZWZvcmUgcnVubmluZw0KPiBrZHVtcCBrZXJuZWwuDQoNCkkgc3RpbGwgc2VlIGFu
IGlzc3VlIHRoYXQgaXNuJ3QgYWRkcmVzc2VkIGJ5IHRoZXNlIHBhdGNoZXMuICBUaGUgVk1idXMN
CmRyaXZlciByZWdpc3RlcnMgYSAiZGllIG5vdGlmaWVyIiBhbmQgYSAicGFuaWMgbm90aWZpZXIi
LiAgIEJ1dCBkaWUoKSB3aWxsDQpldmVudHVhbGx5IGNhbGwgcGFuaWMoKSBpZiBwYW5pY19vbl9v
b3BzIGlzIHNldCAod2hpY2ggSSB0aGluayBpdCB0eXBpY2FsbHkNCmlzKS4gIElmIHRoZSBDUkFT
SF9OT1RJRllfTVNHIG9wdGlvbiBpcyAqbm90KiBlbmFibGVkLCB0aGVuDQpoeXBlcnZfcmVwb3J0
X3BhbmljKCkgY291bGQgZ2V0IGNhbGxlZCBieSB0aGUgZGllIG5vdGlmaWVyLCBhbmQgdGhlbg0K
YWdhaW4gYnkgdGhlIHBhbmljIG5vdGlmaWVyLg0KDQpEbyB3ZSBldmVuIG5lZWQgdGhlICJkaWUg
bm90aWZpZXIiPyAgSWYgaXQgd2FzIHJlbW92ZWQsIHRoZXJlIHdvdWxkDQpub3QgYmUgYW55IG5v
dGlmaWNhdGlvbiB0byBIeXBlci1WIHZpYSB0aGUgZGllKCkgcGF0aCB1bmxlc3MgcGFuaWNfb25f
b29wcw0KaXMgc2V0LCB3aGljaCBJIHRoaW5rIGlzIGFjdHVhbGx5IHRoZSBjb3JyZWN0IGJlaGF2
aW9yLiAgSSdtIG5vdA0KY29tcGxldGVseSBjbGVhciBvbiB3aGF0IGlzIHN1cHBvc2VkIHRvIGhh
cHBlbiBpbiBnZW5lcmFsIHRvIHRoZQ0KTGludXgga2VybmVsIGlmIHBhbmljX29uX29vcHMgaXMg
bm90IHNldC4gRG9lcyBpdCB0cnkgdG8gY29udGludWUgdG8gcnVuPw0KSWYgc28sIHRoZW4gd2Ug
c2hvdWxkIG5vdCBiZSBub3RpZnlpbmcgSHlwZXItViBpZiBwYW5pY19vbl9vb3BzIGlzIG5vdA0K
c2V0LCBhbmQgcmVtb3ZpbmcgdGhlIGRpZSBub3RpZmllciBpcyB0aGUgcmlnaHQgdGhpbmcgdG8g
ZG8uDQoNCk1pY2hhZWwNCg0KPiANCj4gVGlhbnl1IExhbiAoNCk6DQo+ICAgeDg2L0h5cGVyLVY6
IFVubG9hZCB2bWJ1cyBjaGFubmVsIGluIGh2IHBhbmljIGNhbGxiYWNrDQo+ICAgeDg2L0h5cGVy
LVY6IEZyZWUgaHZfcGFuaWNfcGFnZSB3aGVuIGZhaWwgdG8gcmVnaXN0ZXIga21zZyBkdW1wDQo+
ICAgeDg2L0h5cGVyLVY6IFRyaWdnZXIgY3Jhc2ggZW5saWdodGVubWVudCBvbmx5IG9uY2UgZHVy
aW5nICBzeXN0ZW0NCj4gICAgIGNyYXNoLg0KPiAgIHg4Ni9IeXBlci1WOiBSZXBvcnQgY3Jhc2gg
cmVnaXN0ZXIgZGF0YSBvciBrc21nIGJlZm9yZSBydW5uaW5nIGNyYXNoDQo+ICAgICBrZXJuZWwN
Cj4gDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMgfCAxMCArKysrKysrKysrDQo+
ICBkcml2ZXJzL2h2L2NoYW5uZWxfbWdtdC5jICAgICAgfCAgNSArKysrKw0KPiAgZHJpdmVycy9o
di92bWJ1c19kcnYuYyAgICAgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pDQo+IA0KPiAtLQ0KPiAyLjE0LjUNCg0K
