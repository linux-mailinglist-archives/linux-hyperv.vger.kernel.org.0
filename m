Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E459DD4376
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Oct 2019 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfJKOxg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Oct 2019 10:53:36 -0400
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:46885
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfJKOxg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Oct 2019 10:53:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQHIUHds0zFZk2xY8mpsg7L/FeZ68Ri1k5AJL8CqngTSamHClVDYPgJDK/Lajb2eWnSnEAQgy/zTBnpJdnxU4KEYEzL/jql3pnEXwzHy13ucWN8DPAyPlk6uNAqbm/p/bw3vGOMuyOIi1QQGr79TaAvU6KoN2HXB0+2EFpegY2zehGlanXus+oDHxOjNlJUISePzYAaaWqszwsdLc2zwjNB/KGrpFY7dfHVSOwNDG80ZukLkuyZUWik3owXMfsCMnMTQIt/eeUBGnOQL7SVcliRVJnmCIG6j48yOKZ2AQHDMvHiSln3yEf/ZHHOLKuw/wtqsE6sy3cHVNNxtcmZxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxoCUgID2niQq37EeuocyoreJT2jYFBUxU2VxdJ5IAM=;
 b=oV/vP3ZbEdg2XlveBnA7dSPsvyq3u5o7s+lyJXW6J/14ITBMjT2mhl9iC6Cf4NqME50OBP0yfv5gg7xKpTOGD9B9wXJWevxNua7wMqh8sDtf6od4TX7PWou3o8LN9gPOv0n0Ei+oWGT38ZnFwWB5OxXcY2yxOzUsCA963OvjSPoPhlFdeYY3PyPmWYNXiS6R40iOayGGHUvfxsXdVZ/WjHoYbG9HB1J2H+LvEzrQo2e4S7OwaepQ2TsaxyXXE90hkLf+wshYocueWB1Fl1VNwfNjtu+57echK1ACGdVnHcfg9PcrY0KNsjQj2Kcdw8nzxKtDX9++7zm3wyLrdhX6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxoCUgID2niQq37EeuocyoreJT2jYFBUxU2VxdJ5IAM=;
 b=EpxsCUHUQ06Kz8w70caYpH3d2QT/qJ8KiyB0F8gqbRlEUcmQ/YCZmfCU7MfE07xz2lc6ZZGuVFhaQCz+3693ZlizxKgrfz45eIif2/GphsLLz6t8FLPUCGunaNmFQ/Qvps6Ajpr4R+mmkITswJOkdUl4Ipgj8+u8UWc0z2eTN0I=
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM (52.132.240.14) by
 KL1P15301MB0247.APCP153.PROD.OUTLOOK.COM (10.255.255.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.2; Fri, 11 Oct 2019 14:53:08 +0000
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318]) by KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318%6]) with mapi id 15.20.2367.004; Fri, 11 Oct 2019
 14:53:07 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "bp@suse.de" <bp@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] mm/resource: Move child to new resource when release mem
 region.
Thread-Topic: [PATCH] mm/resource: Move child to new resource when release mem
 region.
Thread-Index: AQHVfzxrHAkRPyKAWU6JoMkPogDGmKdT788AgAF8bsA=
Date:   Fri, 11 Oct 2019 14:53:06 +0000
Message-ID: <KL1P15301MB0261260E5DD0E3BA4FD80BC092970@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20191010072856.20079-1-Tianyu.Lan@microsoft.com>
 <77e08231-0687-8d8d-0faf-c490a8b510d4@intel.com>
In-Reply-To: <77e08231-0687-8d8d-0faf-c490a8b510d4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-11T14:53:03.2347409Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c3a9baf7-ec20-4bf2-a413-1bf350ecfb32;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccfd0276-322d-44f9-06cb-08d74e5aba32
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: KL1P15301MB0247:|KL1P15301MB0247:|KL1P15301MB0247:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KL1P15301MB0247192506E1963B0802D2BD92970@KL1P15301MB0247.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(189003)(199004)(10290500003)(6246003)(2201001)(10090500001)(76176011)(478600001)(9686003)(2501003)(25786009)(6506007)(55016002)(8990500004)(53546011)(102836004)(26005)(99286004)(4326008)(7696005)(1511001)(186003)(86362001)(229853002)(66066001)(486006)(7416002)(2906002)(476003)(7736002)(256004)(71200400001)(6116002)(6436002)(8936002)(54906003)(8676002)(11346002)(64756008)(66446008)(110136005)(316002)(81166006)(22452003)(81156014)(71190400001)(76116006)(3846002)(74316002)(446003)(5660300002)(14454004)(33656002)(66476007)(66556008)(52536014)(66946007)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0247;H:KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OxoW7naVAepwoAte1vZtXYGeo6CSFv689W86CABuIfdFk4C8u448OfKu6KE4eRdaIu1dsbyqKNBa6MgNmMMa91aPemqmp7Dzq28HE4EgR0H2ll3PUBslWUXCB5hxUpJQIb+9t+LEdx4jYufwVaQv/uOzUqGJ1UpWoKfAOXV9Uf9ZpMKrU7P5I+fMVhqn97E7Z8hWLM3v2BjTFPSe4qbiAP8O5WwtxosNaLES6te+0/VerZLry5S9FgnDl2LFVaEjpCbHJTRh7TIJJdCVRg9JtqTRMQs2AkG6f8m1hdOdCVI3HtDIZ/DXf8SHhpH1ZmL7Mrz9O8B6F4PZ0TsrDaDoWdQPBw9IC3CCZJhvwT7voLeC/IUkVG71m09B6ufQmIvNp1jsD6VN6oMboITllfNi9u0Q6IS8ECCl7JF5aStNyE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfd0276-322d-44f9-06cb-08d74e5aba32
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 14:53:06.8121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOaWu7j0dzMuX0g27j+oaqTMKY6ZPlZWQfJ8QJYO37YPAAVuzNamrCbleX43Fsm0qbOxEf4/d+GAF5HJy2ubBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0247
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gMTAvMTAvMjAxOSAxMDoyOSBQTSwgRGF2ZSBIYW5zZW4gd3JvdGU6PiBPbiAxMC8xMC8xOSAx
MjoyOCBBTSwgbGFudGlhbnl1MTk4NkBnbWFpbC5jb20gd3JvdGU6DQo+PiBXaGVuIHJlbGVhc2Ug
bWVtIHJlZ2lvbiwgb2xkIG1lbSByZWdpb24gbWF5IGJlIHNwbGl0ZWQgdG8NCj4+IHR3byByZWdp
b25zLiBDdXJyZW50IGFsbG9jYXRlIG5ldyBzdHJ1Y3QgcmVzb3VyY2UgZm9yIGhpZ2gNCj4+IGVu
ZCBtZW0gcmVnaW9uIGJ1dCBub3QgbW92ZSBjaGlsZCByZXNvdXJjZXMgd2hvc2UgcmFuZ2VzIGFy
ZQ0KPj4gaW4gdGhlIGhpZ2ggZW5kIHJhbmdlIHRvIG5ldyByZXNvdXJjZS4gV2hlbiBhZGp1c3Qg
b2xkIG1lbQ0KPj4gcmVnaW9uJ3MgcmFuZ2UsIGFkanVzdF9yZXNvdXJjZSgpIGRldGVjdHMgY2hp
bGQgcmVnaW9uJ3MgcmFuZ2UNCj4+IGlzIG91dCBvZiBuZXcgcmFuZ2UgYW5kIHJldHVybiBlcnJv
ci4gTW92ZSBjaGlsZCByZXNvdXJjZXMgdG8NCj4+IGhpZ2ggZW5kIHJlc291cmNlIGJlZm9yZSBh
ZGp1c3Rpbmcgb2xkIG1lbSByYW5nZS4NCj4gDQo+ICBGcm9tIHRoZSBjb21tZW50LCBpdCBhcHBl
YXJzIHRoZSBvbGQgY29kZSBpbnRlbmRlZCB0byBoYXZlIHRoZSBiZWhhdmlvcg0KPiB0aGF0IHlv
dSBhcmUgY2hhbmdpbmcuICBDb3VsZCB5b3UgZXhwbGFpbiBfd2h5XyB0aGlzIGhhcyBiZWNvbWUg
YQ0KPiBwcm9ibGVtIGZvciB5b3U/DQpIaSBEYXZlOg0KICAgIFRoYW5rcyBmb3IgeW91ciByZXZp
ZXcuIGN1cnJlbnQgY29kZSBhc3N1bWVzIHRoYXQgYWxsIGNoaWxkcmVuIHJlbWFpbiBpbg0KIHRo
ZSBsb3dlciBhZGRyZXNzIGVudHJ5IGZvciBzaW1wbGljaXR5LiBGb3IgbWVtb3J5IGhvdC1yZW1v
dmUsIHNlbGVjdGluZw0KcmVtb3ZlIHJlZ2lvbiB2aWEgc2Nhbm5pbmcgc3lzdGVtIG1lbW9yeSBt
YXkgaGl0IGNhc2Ugb2YgY2hpbGQgaW4gdGhlDQpoaWdoZXIgYWRkcmVzcyBlbnRyeS4NCg0KRm9y
IGV4YW1wbGUsIHRoZSBmb2xsb3dpbmcgb3V0cHV0IGZyb20gL3Byb2MvaW9tZW0gc2hvd3Mga2Vy
bmVsIGNvZGUsDQpkYXRhIGFuZCBic3MgbG9jYXRlIGZyb20gM2EwMDAwMDAgdG8gM2I1ZmZmZmYg
YW5kIHRoZXNlIHJlc291cmNlcyBhcmUgdGhlDQpzeXN0ZW0gcmFtIHJlc291cmNlJ3MgY2hpbGRy
ZW4uIElmIHRoZSAzOTgwMDAwMC0zOWZmZmZmZiB3YXMgc2VsZWN0ZWQgYXMNCnJlbW92ZSByYW5n
ZSwgdGhlIHJlc291cmNlIHdpbGwgYmUgc3BsaXQgaW50byB0d28gcmFuZ2VzIDAwMTAwMDAwLTM5
N2ZmZmZmDQphbmQgMzk4MDAwMDAtYjg3ZjFmZmYuIEN1cnJlbnQgY29kZSBtb3ZlIGtlcm5lbCBp
bWFnZSByZWxhdGVkIHJlc291cmNlcw0KdW5kZXIgMDAxMDAwMDAtMzk3ZmZmZmYgcmVzb3VyY2Uu
IFRoaXMgd2lsbCBjYXVzZSBhZGp1c3RfcmVzb3VyY2UoKSByZXR1cm4NCmVycm9yIGJlY2F1c2Ug
Y2hpbGRyZW4gYXJlIG5vdCBpbiB0aGUgcGFyZW50J3MgcmFuZ2UuDQoNCjAwMTAwMDAwLWI4N2Yx
ZmZmIDogU3lzdGVtIFJBTQ0KICAzYTAwMDAwMC0zYWMwMGU4MCA6IEtlcm5lbCBjb2RlDQogIDNh
YzAwZTgxLTNiMzM4ODNmIDogS2VybmVsIGRhdGENCiAgM2I0ZDMwMDAtM2I1ZmZmZmYgOiBLZXJu
ZWwgYnNzDQoNCg0KDQo=
