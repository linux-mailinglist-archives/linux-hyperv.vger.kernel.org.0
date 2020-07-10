Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572C21B2F9
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2020 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJKK4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Jul 2020 06:10:56 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:41025
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbgGJKK4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jul 2020 06:10:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K44dfBtKtorenk/gvu3ZT7a10rbQu7HX5Ot6P1upnWqlhJzSSE4e1suDVFz10G8CvxnpN/P4sCr9TGt22UObdPzKnsrxWJ2Z/fMECNiu/Yhi2r8MtrWOovkHSMeqDTWCWkHQPRQyW4QcNdDikiWO8wMMdH7fsjIksZFrQKFmTpRwofXzWmpN/2Trwz41Azs96RYEFNIEU6cVQz7ylfLZTufrPlTfY9FLa2ivETM/WODGxbdKInsinjDFJ3wn7P3PUBlCQQVSpuI2v3hrpwBvceUBGgfjU0IKtJYU/BVe0LUlOP089DMfMrki+pGbvNSOq/BQ0bXoxRaXljT6XTynuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXoixCKUwMb8YnpESLv4JezVvXGEllYn+T8llM/yFQ=;
 b=oAgJ8lzfTgcJ2/j7TjdY2FE4+rgtQKDsK8gO70By8J4K0dr3QPKaNgfWZKqY7zOppSA9AxukGEWumMFXy760k7mquf5+yHXf02AsXQpqXa5tGjJ6fAQsAFw2FoCq99ksiRL6uUtOvTBTOMAXUB8CVVy0f5HcCeV4azv71hsJfAHn0KpJZ55OMLBknoL/RecbTfML0K4Ro7wOXizFVuRpEflkh8I/OdkX0IbwfESE6NaCf6QqZdREKx3scFZ4tvmQvkaks6GVUKl5xTwg2t5zsD8KNlhJxTgSoVRkyzepGi2SC676PtsZF0Pm3vlDFEbLZjUng7ykFRGf3dSNipzLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXoixCKUwMb8YnpESLv4JezVvXGEllYn+T8llM/yFQ=;
 b=Vz9J0vFl0CKjriTd3uJNHEcet8GUzIwH8KjThWJePbGdbZi639wYzl5U8fbfRuHadxD7alackVF8DRoj/Ekx/cCa6tuvukp1NkuoxtkO2edIXyn3E7gtRJR3lxgxXweF0CkEKqOD/4G9ySphqsw4xIXnXYN6y6YW+E5y2rP16qo=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0890.namprd21.prod.outlook.com (2603:10b6:302:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9; Fri, 10 Jul
 2020 10:10:53 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3195.005; Fri, 10 Jul 2020
 10:10:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>,
        Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Change flag to write log level in panic msg
 to false
Thread-Topic: [PATCH] Drivers: hv: Change flag to write log level in panic msg
 to false
Thread-Index: AQHWS+HzVTYTKiLVr0O7dTomrubg4KkAoBwAgAALHJA=
Date:   Fri, 10 Jul 2020 10:10:52 +0000
Message-ID: <MW2PR2101MB1052E866DA984584B2F8B462D7650@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1593193685-74615-1-git-send-email-joseph.salisbury@microsoft.com>
 <20200710092440.GA16562@aepfle.de>
In-Reply-To: <20200710092440.GA16562@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-10T10:10:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=987f298a-d217-44bf-9349-49ebf21d2b31;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: aepfle.de; dkim=none (message not signed)
 header.d=none;aepfle.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4f39bde-528c-41ce-52ea-08d824b98771
x-ms-traffictypediagnostic: MW2PR2101MB0890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB089088CBD0088B2465EB2EF5D7650@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ngAja1EdxZvZ9iC5sxS0Mgcgv6nE/YXaCrYU2jBEH3Mp2OE26n1dudoPSeGMqbEqGjDBdcCG5lxe1wJVQ+9/ymcnqy7px47oEKomrSYMKp0hntfhFo/wBsv2w9+NdSv2FfZznEEA1fsHvB7Msw39L0lpp/IF49NC78pzd2P0qIrzTOWiSa+jjxCn60JOcCY8C9KmHY+vWIHMNeGjiODg1ynPHoLCSD3EIxnAjkj1ojzqE9t9tVF6z1rGcyISL/lRRZhJ12F9L3f34bB43HrZRiYADqU8QOe+2NDgdMWEXt7zfYRkCMw1Sywe+NZhW5ko0zaBD2gzRxMl8iA6/tmWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(54906003)(4326008)(2906002)(71200400001)(186003)(86362001)(8990500004)(6636002)(9686003)(7696005)(83380400001)(55016002)(316002)(33656002)(26005)(10290500003)(82960400001)(82950400001)(110136005)(8936002)(66946007)(5660300002)(478600001)(76116006)(8676002)(52536014)(66556008)(64756008)(66446008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bFx/U03vyi3cL6a2ttSTqzGELlaMQEbUTWZMNRGrXcpeS+z9+3tzykLY7p9C5JKznKh9SYwcAAiGrTjXC1oVA2F31DKpAPl6chlgNVfwAwY0SNaawAxRkCJr9wGVYlzI81xXGqv7Qo65y0gN59QkS4RwHS43rbuvtQnYMNVKBsQunqKOgIZwYc1JEcfPhH6X2xO3KPWUqlxOFp+xicQ/F/7xDjdmddvGobvnFNR88Gg1ScGtaP6zPNZzPB1n6XxxrONahL0NR/PuuJB7FOHa9K7nysmdP0TYm98QezOdadv/BzhuD647fnSskLaCV8/ZNRIlqJKPu2oy/jIHqwp2mFZlLv04aPKTv6KY97sj5CJUd9FMo3cv4YfTgB913n9IgYOehrh7+rjtloU0jNYPzVe90XIoM/wvy3CE7RBHWGjydpK9cJSkRvJ0PjmkgOLBA++io09K8WTbQjayexEAUQvfFeagsZxwXlx9hcPweVnMH53aXc6ycYfEMF8x1/0U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f39bde-528c-41ce-52ea-08d824b98771
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 10:10:53.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K9ReI8aWG6ANl5neS9CsZuhTgYKbx9vSAG9gdr5kOB1c4W76Z1NMEGC2l1t5HV0KRCl5UUdk6bp5lrnBK9W1Fr1omHkz0Dkxgt8eLf45Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogT2xhZiBIZXJpbmcgPG9sYWZAYWVwZmxlLmRlPiAgU2VudDogRnJpZGF5LCBKdWx5IDEw
LCAyMDIwIDI6MjUgQU0NCj4gDQo+IE9uIEZyaSwgSnVuIDI2LCBKb3NlcGggU2FsaXNidXJ5IHdy
b3RlOg0KPiANCj4gPiBXaGVuIHRoZSBrZXJuZWwgcGFuaWNzLCBvbmUgcGFnZSB3b3J0aCBvZiBr
bXNnIGRhdGEgaXMgd3JpdHRlbiB0byBhbiBhbGxvY2F0ZWQNCj4gPiBwYWdlLiAgVGhlIEh5cGVy
dmlzb3IgaXMgbm90aWZpZWQgb2YgdGhlIHBhZ2UgYWRkcmVzcyB0cm91Z2ggdGhlIE1TUi4gIFRo
aXMNCj4gPiBwYW5pYyBpbmZvcm1hdGlvbiBpcyBjb2xsZWN0ZWQgb24gdGhlIGhvc3QuICBTaW5j
ZSB3ZSBhcmUgb25seSBjb2xsZWN0aW5nIG9uZQ0KPiA+IHBhZ2Ugb2YgZGF0YSwgdGhlIGZ1bGwg
cGFuaWMgbWVzc2FnZSBtYXkgbm90IGJlIGNvbGxlY3RlZC4NCj4gDQo+IEFyZSB0aGUgcGVvcGxl
IHdobyBuZWVkIHRvIHdvcmsgd2l0aCB0aGlzIHRpbnkgYml0IG9mIGluZm9ybWF0aW9uDQo+IHNh
dGlzZmllZCBhbHJlYWR5LCBvciBkaWQgdGhleSBhbHJlYWR5IG1pc3MgaW5mbyBldmVuIHdpdGgg
dGhpcyBwYXRjaD8NCj4gDQo+IEknbSBhc2tpbmcgYmVjYXVzZSBrbXNnX2R1bXBfZ2V0X2J1ZmZl
ciB1bmNvbmRpdGlvbmFsbHkgaW5jbHVkZXMgdGhlDQo+IHRpbWVzdGFtcCAodW5sZXNzIGl0IGlz
IGVuYWJsZWQpLiBJIGRvIHdvbmRlciBpZiB0aGVyZSBzaG91bGQgYmUgYW4gQVBJDQo+IGFkZGl0
aW9uIHRvIG9taXQgdGhlIHRpbWVzdGFtcC4gVGhlbiBldmVuIG1vcmUgZG1lc2cgb3V0cHV0IGNh
biBiZQ0KPiB3cml0dGVuIGludG8gdGhlIDRrIGJ1ZmZlci4NCj4gDQoNCkl0IHdvdWxkIGJlIG5p
Y2UgdG8gZ2V0IGV2ZW4gbW9yZSBkbWVzZyBvdXRwdXQgaW50byB0aGUgNEsgYnVmZmVyIChvcg0K
aGF2ZSBhIGJ1ZmZlciB0aGF0J3MgYmlnZ2VyIHRoYW4gNEspIGJlY2F1c2UgdGhlcmUgYXJlIHN0
aWxsIG9jY3VycmVuY2VzDQp3aGVyZSB3ZSBkb24ndCBnZXQgYWxsIG9mIHRoZSBjYWxsIHN0YWNr
LiAgQnV0IEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gZWxpbWluYXRlDQp0aGUgdGltZXN0YW1wIGJl
Y2F1c2UgaXQgaXMgdXNlZnVsIGZvciBrbm93aW5nIGhvdyBsb25nIHRoZSBWTSBoYXMgYmVlbg0K
cnVubmluZyBhbmQgdG8gdW5kZXJzdGFuZCB3aGF0IGludGVydmFscyBvZiB0aW1lIHRoZXJlIG1p
Z2h0IGJlIGJldHdlZW4NCm1lc3NhZ2VzLiAgSSB0aG91Z2h0IGFib3V0IHdoZXRoZXIgcGFyc2lu
ZyB0aGUgZGF0YSB0byBrZWVwIGp1c3QgdGhlDQpmaXJzdCB0aW1lc3RhbXAgbWlnaHQgYmUgYSB1
c2VmdWwgY29tcHJvbWlzZSwgYnV0IHRoYXQgc2VlbXMgZmFpcmx5DQptZXNzeSBhbmQgSSdtIG5v
dCBzdXJlIGl0J3Mgd29ydGggaXQuICBDb21wcmVzc2luZyB0aGUga21zZyB0ZXh0IGlzDQphbm90
aGVyIGlkZWEsIGJ1dCB0aGUgY29tcHJlc3NlZCB0ZXh0IHdvdWxkIHByb2JhYmx5IGhhdmUgcHJv
YmxlbXMNCmdldHRpbmcgdGhyb3VnaCBvdXIgcmVwb3J0aW5nIHN5c3RlbXMuICBTbyB3ZSd2ZSBz
ZXR0bGVkIGZvciB0aGlzIHNtYWxsDQppbXByb3ZlbWVudCBmb3Igbm93Lg0KDQpNaWNoYWVsDQo=
