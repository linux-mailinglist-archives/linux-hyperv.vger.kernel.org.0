Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5546CAA
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNXIu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 19:08:50 -0400
Received: from mail-eopbgr1310123.outbound.protection.outlook.com ([40.107.131.123]:8811
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfFNXIt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 19:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=XP+j5GVgIH+zJhyFAoP1pdYT9x6lAJlcl12CiXdzoaJqeWU2FKl/hJDYgF7SEpJy5GCvQIdG07L9RmUuZMca354x/BUArIb/2figIp2KBntghO3b2SMOS0/CiNx1/D5JxiUXulRDb+Y9XhuSO5nPLAEuN5Ydi4AP3uT8q0KTtYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91wbSZpcH4jJO/PNEpkaEwEBqSaSTl1O6E4KDK41f6o=;
 b=k3JgwAheQPzMNgGTr3suWE/WBbQDhpYrYUcdtEb2QQg50tiWbiGdbc8c/4IsqEU5y0IkxvyfyyIUv4JAzv1cDvGq3xxI+r1AocjpDTXP7vpSsey+I3n6AHGlsJ28tcaUDa0wsmObXfotH4kBdCxSRdwqlRxLl/YuX995s/viqD0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91wbSZpcH4jJO/PNEpkaEwEBqSaSTl1O6E4KDK41f6o=;
 b=RGPCGstrK2W8pfK6H+awLzH8CxxSj/2ER7841WsyfiXin1jQpBw6eMlejPQHh0+gOOy2EHSg5HpPs+ubaEPh7uG0MLQNWeNVNypJ3oLfbR9j3XCOtTwwXLtrm1hVvOCYsvy8RwEFssOvoeQn+EHd2OCksfbkkXKQjuh3OyIv2Vg=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0137.APCP153.PROD.OUTLOOK.COM (10.170.188.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.0; Fri, 14 Jun 2019 23:08:40 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%4]) with mapi id 15.20.2008.007; Fri, 14 Jun 2019
 23:08:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH 2/2] hv_balloon: Reorganize the probe function
Thread-Topic: [PATCH 2/2] hv_balloon: Reorganize the probe function
Thread-Index: AQHVIuDsvIeorl+TakinvZrlEfDGAKabr1KwgAAKBOA=
Date:   Fri, 14 Jun 2019 23:08:39 +0000
Message-ID: <PU1P153MB01699145D8BDE54ABAFF7EF5BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1560537692-37400-1-git-send-email-decui@microsoft.com>
 <1560537692-37400-2-git-send-email-decui@microsoft.com>
 <BL0PR2101MB13487B8D2A157AA7FCFD159DD7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB13487B8D2A157AA7FCFD159DD7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-14T21:56:21.9387171Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb391304-eed6-45c4-a296-25ce2c9f2395;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:a444:4515:ca58:8eeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c41acfa3-7831-4ea5-ebdd-08d6f11d3d41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0137;
x-ms-traffictypediagnostic: PU1P153MB0137:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01370D5D8161BAE1F346D579BFEE0@PU1P153MB0137.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(99286004)(11346002)(2201001)(102836004)(76176011)(110136005)(6506007)(256004)(7696005)(7736002)(54906003)(1511001)(6116002)(14444005)(2906002)(33656002)(486006)(476003)(446003)(8676002)(186003)(316002)(5660300002)(81156014)(81166006)(74316002)(71200400001)(86362001)(71190400001)(305945005)(22452003)(8936002)(6636002)(46003)(6436002)(4326008)(478600001)(8990500004)(68736007)(64756008)(52536014)(66556008)(10290500003)(229853002)(55016002)(14454004)(73956011)(66946007)(2501003)(6246003)(53936002)(76116006)(10090500001)(66446008)(9686003)(66476007)(25786009)(266184004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0137;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RN7amEHCUz8TeK7su7SZ3yebrd48I9J+If1XkRDqsVwQkiNbgOvUrKlETC+TvfzyQvq9ba40Fwu/b5tQ63ojMv/IPJm9J0y17vlMSYjF1TT1OYAjxil+g+01wsbG6ev1+3OtHz5fp0WWRBmEr8lYeTGp85MUElklxH87bxn8eDIgoWBHfLLOtl/ZXbWFVkw9D06M3sZpwp0fbFRZMz1dYirVNyVxcJUgGXY78Or0mDxNj/yFiqAQPZT+kVPTp7s/IgaIh1+j2kdgRbElgS961JLk7gLZqdIqLvjeuaqcSW6BpjWCaodzME5ZxFWb14+9gaapJ0K2I/+pvW9IT4+hypFJzo/Pzm3FxbA6v753AxQAMVpT1A20OPkzbeQ+eh2q8BUIDtzSYG1q1vsXA8q1eMSO0Qr8RnQU14kQNiX8WUE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41acfa3-7831-4ea5-ebdd-08d6f11d3d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 23:08:39.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0137
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDog
RnJpZGF5LCBKdW5lIDE0LCAyMDE5IDI6NTYgUE0NCj4gPiAuLi4NCj4gPiArCXJldCA9IGJhbGxv
b25fY29ubmVjdF92c3AoZGV2KTsNCj4gPiArCWlmIChyZXQgIT0gMCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsNCj4gPiAgCWRtX2RldmljZS5zdGF0ZSA9IERNX0lOSVRJQUxJWkVEOw0KPiA+
IC0JbGFzdF9wb3N0X3RpbWUgPSBqaWZmaWVzOw0KPiANCj4gSSB3YXMgY3VyaW91cyBhYm91dCB0
aGUgYWJvdmUgZGVsZXRpb24uICBCdXQgSSBndWVzcyB0aGUgbGluZQ0KPiBpcyBub3QgbmVlZGVk
IGFzIHRoZSB0aW1lX2FmdGVyKCkgY2hlY2sgaW4gcG9zdF9zdGF0dXMoKSBzaG91bGQNCj4gaGFu
ZGxlIGFuIGluaXRpYWwgdmFsdWUgb2YgMCBmb3IgbGFzdF9wb3N0X3RpbWUganVzdCBmaW5lLg0K
DQpJbiBhIDMyLWJpdCBrZXJuZWwsIHNpemVvZih1bnNpZ25lZCBsb25nKSBpcyA0LCBhbmQgdGhl
IGdsb2JhbCAzMi1iaXQNCnZhcmlsYWJsZSAiamlmZmllcyIgY2FuIG92ZXJmbG93IGluIDQ5Ljcg
ZGF5cyBpZiBIWiBpcyBkZWZpbmVkIGFzIDEwMDA7DQpzbyBpbiB0aGVvcnkgdGhlcmUgaXMgYSB0
aW55IGNoYW5jZSB0aW1lX2FmdGVyKCkgY2FuIG5vdCB3b3JrIGFzDQpleHBlY3RlZCBoZXJlIChp
LmUuIHdlJ3JlIGxvYWRpbmcgaHZfYmFsbG9vbiBkcml2ZXIgd2hlbiB0aGUNCiJqaWZmaWVzIiBp
cyBqdXN0IGFib3V0IHRvIG92ZXJmbG93LCB3aGljaCBpcyBoaWdobHkgdW5saWtlbHkgaW4gcHJh
Y3RpY2UpOw0KZXZlbiBpZiB0aGF0IGhhcHBlbnMsIHdlIGRvIG5vdCBjYXJlLCBzaW5jZSB0aGUg
Y29uc2VxdWVuY2UgaXMNCmp1c3QgdGhhdCB0aGUgbWVtb3J5IHByZXNzdXJlIHJlcG9ydGluZyBp
cyBkZWxheWVkIGJ5IDEgc2Vjb25kLiA6LSkNCg0KPiA+ICsNCj4gPiArCWRtX2RldmljZS50aHJl
YWQgPQ0KPiA+ICsJCSBrdGhyZWFkX3J1bihkbV90aHJlYWRfZnVuYywgJmRtX2RldmljZSwgImh2
X2JhbGxvb24iKTsNCj4gPiArCWlmIChJU19FUlIoZG1fZGV2aWNlLnRocmVhZCkpIHsNCj4gPiAr
CQlyZXQgPSBQVFJfRVJSKGRtX2RldmljZS50aHJlYWQpOw0KPiA+ICsJCWdvdG8gcHJvYmVfZXJy
b3I7DQo+ID4gKwl9DQo+IA0KPiBKdXN0IGFuIG9ic2VydmF0aW9uOiAgdGhpcyB0aHJlYWQgY3Jl
YXRpb24gbm93IGhhcHBlbnMgYXQgdGhlIGVuZCBvZiB0aGUNCj4gcHJvYmluZyBwcm9jZXNzLiAg
QnV0IHRoYXQncyBnb29kLCBiZWNhdXNlIGluIHRoZSBvbGQgY29kZSwgdGhlIHRocmVhZA0KPiB3
YXMgc3RhcnRlZCBhbmQgY291bGQgcnVuIGJlZm9yZSB0aGUgcHJvdG9jb2wgdmVyc2lvbiBoYWQg
YmVlbg0KPiBuZWdvdGlhdGVkLiAgU28gSSdsbCBhc3N1bWUgeW91ciBjaGFuZ2UgaGVyZSBpcyBp
bnRlbnRpb25hbC4NCg0KWWVzLCB0aGlzIGlzIGludGVudGlvbmFsLg0KIA0KPiA+DQo+ID4gIAly
ZXR1cm4gMDsNCj4gPg0KPiA+IC1wcm9iZV9lcnJvcjI6DQo+ID4gK3Byb2JlX2Vycm9yOg0KPiA+
ICsJdm1idXNfY2xvc2UoZGV2LT5jaGFubmVsKTsNCj4gPiAgI2lmZGVmIENPTkZJR19NRU1PUllf
SE9UUExVRw0KPiA+ICsJdW5yZWdpc3Rlcl9tZW1vcnlfbm90aWZpZXIoJmh2X21lbW9yeV9uYik7
DQo+IA0KPiBIbW1tLiBFdmlkZW50bHkgdGhlIGFib3ZlIGNsZWFudXAgd2FzIG1pc3NpbmcgaW4g
dGhlDQo+IG9sZCBjb2RlLg0KDQpZZXMuDQogDQo+ID4gIAlyZXN0b3JlX29ubGluZV9wYWdlX2Nh
bGxiYWNrKCZodl9vbmxpbmVfcGFnZSk7DQo+ID4gICNlbmRpZg0KPiA+IC0Ja3RocmVhZF9zdG9w
KGRtX2RldmljZS50aHJlYWQpOw0KPiA+IC0NCj4gPiAtcHJvYmVfZXJyb3IxOg0KPiA+IC0Jdm1i
dXNfY2xvc2UoZGV2LT5jaGFubmVsKTsNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0K
PiA+IEBAIC0xNzM0LDExICsxNzQyLDExIEBAIHN0YXRpYyBpbnQgYmFsbG9vbl9yZW1vdmUoc3Ry
dWN0IGh2X2RldmljZQ0KPiAqZGV2KQ0KPiA+ICAJY2FuY2VsX3dvcmtfc3luYygmZG0tPmJhbGxv
b25fd3JrLndyayk7DQo+ID4gIAljYW5jZWxfd29ya19zeW5jKCZkbS0+aGFfd3JrLndyayk7DQo+
ID4NCj4gPiAtCXZtYnVzX2Nsb3NlKGRldi0+Y2hhbm5lbCk7DQo+ID4gIAlrdGhyZWFkX3N0b3Ao
ZG0tPnRocmVhZCk7DQo+ID4gKwl2bWJ1c19jbG9zZShkZXYtPmNoYW5uZWwpOw0KPiANCj4gUHJl
c3VtYWJseSB0aGlzIGlzIGFuIGludGVudGlvbmFsIG9yZGVyaW5nIGNoYW5nZSBhcyB3ZWxsLg0K
PiBUaGUga3RocmVhZCBzaG91bGQgYmUgc3RvcHBlZCBiZWZvcmUgY2xvc2luZyB0aGUgY2hhbm5l
bC4NCg0KWWVzLiBUaGUgb2xkIGNvZGUgaXMgYnVnZ3k6IGFmdGVyIHRoZSB2bWJ1c19jbG9zZSgp
LCB0aGVyZSBpcw0KYSBzbWFsbCB3aW5kb3cgaW4gd2hpY2ggdGhlIG9sZCBjb2RlIGNhbiBzdGls
bCB0cnkgdG8gc2VuZA0KbWVzc2FnZXMgdG8gdGhlIGhvc3QgdmlhIGEgZnJlZWQgcmluZ2J1ZmZl
ciwgY2F1c2luZyBwYW5pYy4NCiANCj4gPiAgI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRw0K
PiA+IC0JcmVzdG9yZV9vbmxpbmVfcGFnZV9jYWxsYmFjaygmaHZfb25saW5lX3BhZ2UpOw0KPiA+
ICAJdW5yZWdpc3Rlcl9tZW1vcnlfbm90aWZpZXIoJmh2X21lbW9yeV9uYik7DQo+ID4gKwlyZXN0
b3JlX29ubGluZV9wYWdlX2NhbGxiYWNrKCZodl9vbmxpbmVfcGFnZSk7DQo+IA0KPiBBbmQgeW91
J3ZlIGNoYW5nZWQgdGhlIG9yZGVyaW5nIG9mIHRoZXNlIHN0ZXBzIHNvIHRoZXkgYXJlDQo+IHRo
ZSBpbnZlcnNlIG9mIHdoZW4gdGhleSBhcmUgc2V0IHVwLiAgQWxzbyBhIGdvb2QgY2xlYW51cCAu
Li4uDQoNClllcy4gVGhlIGNoYW5nZSBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeSwgYnV0IGxldCdz
IGp1c3QgZG8gaXQNCmluIGEgYmV0dGVyIG1hbm5lci4NCiANCj4gDQo+IFJldmlld2VkLWJ5OiBN
aWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCg0KVGhha3MgZm9yIHRoZSBk
ZXRhaWxlZCBjb21tZW50cyENCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
