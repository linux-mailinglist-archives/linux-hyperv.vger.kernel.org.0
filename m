Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB01B6B7D
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2020 04:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDXCkz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 22:40:55 -0400
Received: from mail-eopbgr1320105.outbound.protection.outlook.com ([40.107.132.105]:9298
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbgDXCkz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 22:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRn4JEN1087idpO81Tgs65elJZU7Vt2aatv1QZkh4iNytyP3LyFH1QR/obLzWGdmGJERAn9WJVokftL7ZDw8mYvyR1DOI3BjQQL8tMTHFAygt/5ChkKenEh3Pee0b766MEqCOxPBWIEDNbita5oOWWr8WKDRsr8BM2hgeWNTd1hvp/3q2JPTeDLvAcPvyS2bYBG72H+Pv4iaKbIcycZLgDPy55n4z3RLeHdzwGm25ZrknJLlgS9xZgY2Ipu0RsxM2gALC46QbL2NUwmK0SLDIkqkDkx++rnI7ohKYNn9S9u1IA0xfuK63ocjr2YrRl3/vXG7HLKajNKLtkct/Xwm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+3plmkVHaOkf4ssGaoDjjP/Ib7NDh9rqe0asqvxehA=;
 b=LeJwYd6IWQGsrslE55HzeISBPoX81WPchedT34egZ0/UbRbSTjWeDfLcl9qdRMYeFYwJbbdi61mdayFpwHYC03aBzgTzQ1+I57+BVHdsHrU0NASd/V3Dqo6/Pp6+BStq3snRtZfTLQoM7kWIfqNcJiY5NJFb+GUecvhR8wwjcONYnNSiu+D+Ae9PppAvuyV7eRt//kG6TNrxMkq+mVJMWNywlBAUFwfXiOJOFo4Sb7G0bfN+4vfFwwJsvNakVisf93rGSL/dIHn7sp9ig6a8kDINpIfbYBK0Igb2c9chW0oN9eXAMjRcJhIwpmWwZ1wglAED46/rW/HeEpVQlDq5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+3plmkVHaOkf4ssGaoDjjP/Ib7NDh9rqe0asqvxehA=;
 b=NbAgEKvq+j3DlGPbO9tS2uP8hMOJXoUk1+chBzOuF5rUQzhOVdi/J9Anod/jn/25S0ENL0LuHiX9Qn4JKk3/bTIBt/uUw1YduLrd4Y9aKIxYlUnhvXFRMOIlHmsvu6smrLvDkWdlFN6Pmv5Imfv5Q4u59fiRxLA9ZTIGgncEXqE=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.2; Fri, 24 Apr 2020 02:40:48 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.010; Fri, 24 Apr 2020
 02:40:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGGMw6DFeJK2tFE2eFTHRpRyDH6iElrSggAD4nwCAAKqbQIAAsEKAgAAFkoCAAGxVgIAAKIpg
Date:   Fri, 24 Apr 2020 02:40:47 +0000
Message-ID: <HK0P153MB0273AA8524DFA8FC5A99A73FBFD00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
 <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
 <HK0P153MB02731F9C5FC61C466715362CBFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <f23cb660-13e4-8466-4c78-163fcc857caa@acm.org>
In-Reply-To: <f23cb660-13e4-8466-4c78-163fcc857caa@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-24T02:40:45.2684681Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b2c7ca1d-0152-4b25-9ef4-a37c4ea752b4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:3421:d362:4eed:46b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b592353-288b-46c2-23c1-08d7e7f8e54b
x-ms-traffictypediagnostic: HK0P153MB0273:|HK0P153MB0273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0273660022AB066B8CD39E8EBFD00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(8676002)(82950400001)(6506007)(52536014)(66946007)(7416002)(5660300002)(55016002)(71200400001)(81156014)(66476007)(53546011)(8936002)(478600001)(4326008)(7696005)(54906003)(110136005)(186003)(107886003)(9686003)(10290500003)(8990500004)(2906002)(76116006)(33656002)(66556008)(86362001)(64756008)(66446008)(316002)(82960400001)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uhpo/ky8z84uR15GGrhoj8mz0+wnXptK9PbrYki1fMMHY5NJ44O4ATRn/9B8ohqP5h65A8jusaHMAzjFxKmGUV1jRMmiYY8rGoyk3e1CaN/Z+S2TJW07Pcyrx68oeOBGXlmZK3nf5ybg8ghTifM1lDSCQZVL1EpGB1uuSRYyTHO82B32dml4TnS3H9ODTb8+vGIiQK+LgC+KSh3SjngKMf+iZRBZuaSwjXixhb6DJsP1/MG4t7XlPDsMIqemwyOx2mvmhrn0iY3h7uNI468uxgB2lR1RaL5qgykVPPiFF18OqQ+cgDyvSPIu5QDUqihPtCXlnh+Gd1e/1L96GarcV4SvqPhuYBkhQxf8x8T1SRLf/Y883+tQvC0CfQkfR2K8mLC6hu1KeV40Ftbb2tiT7X6HjU+UdGmSmjuSAWz5aRqEMLvlyDZ1xDP/0kgE9z3ZjVIGcAvgJ0fWiCom3cCIRGXa+KKCbCju7HTIBB6LXsE=
x-ms-exchange-antispam-messagedata: 9X1CvJQ/beVwaaMH+C0Yny/K+EtMuM7Imp14OYPjotxVwejhmSw+slzwBwYnTFg6YUq6h4JdGGUylPF9vvWdHmawCOsBNET+kfCWz21VREnglRAn81vUOWA4BZ7LLQdsvYNWltvdo/1bDSmAWJBYR4ptMKXTQ4Z8ABu92bgJoW9HOxfSDMR63sVfNaDVkNbLUUCaH2TO5fif2foa0milNKgEpoQi2vakAvGr+D9ycjvihLzJ7oE+OO7UibH1HzPqdsVumrHPzyXGZhodak/6suYRxGz0Z2hJt5sRsf0yz6Z2ueYc1w8lKJ2nwA8VQ/StW6ArBHE22BlC5LGmTi7gZpJAlg3DPuUHGsN7x5xD2SLJSVxe8ZFrgtWkpg4aYlp0cQqwRSM3zpSvKtNREstVuXf0ZI/RhOiD7A+1mTg073RkbP5hVOpRcdElHu5qCrnmGrltCAFyFFqrHyF5wGP6vkBT4/odQ00+4Qy+2iMf9Ryw6X0osSV5fFeME1g6Ox8HE5bXzdWlmbVCeok+qBcpxBu19oq5hd9TMvqStmTr4lds8ms9S86g5MH6fUPBtbniWNCZkwsrK4lwpC1XjmR2UGkUB0uHpM3Gqfx3fiNjSfa6Vwah3FAM1zEP2fQUdO+g3wj2ShHVzaWTFlqiyZMoKoGAFXiHTSnxsFZhA7uF8GFZF+zP0tVnrKwNFHdH2T9gMH7ho1lqMczA12IRX7bFeKWB3Ohyx0OeKOdgvfPhEjuARxMTxvxLl2d51fAwRdlFDlEM/6WAnGPF6ctJs+7hqpGrWc9doKUi5gBOIXIF72wbn48G39/TK3iV6nuk4qIsMqJn5tFXe5bJd0x1qFJycV2eNcrLgj2C/XLlBfyAbRs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b592353-288b-46c2-23c1-08d7e7f8e54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:40:47.6539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4TtzK1FdbAcsQru/vqGJ0IA43NDkF52ZdMP/WwodfJUJZ14kWti/68+inUGeIiGv/Bkgk+feduqUxckCLQv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0273
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDIzLCAyMDIwIDQ6MjUgUE0NCj4gT24gMjAyMC0wNC0yMyAxMToyOSwgRGV4
dWFuIEN1aSB3cm90ZToNCj4gPiBTbyBpdCBsb29rcyB0aGUgYmVsb3cgcGF0Y2ggYWxzbyB3b3Jr
cyBmb3IgbWU6DQo+ID4NCj4gPiAtLS0gYS9rZXJuZWwvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiAr
KysgYi9rZXJuZWwvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiBAQCAtODk4LDYgKzg5OCwxMSBAQCBz
dGF0aWMgaW50IHNvZnR3YXJlX3Jlc3VtZSh2b2lkKQ0KPiA+ICAgICAgICAgZXJyb3IgPSBmcmVl
emVfcHJvY2Vzc2VzKCk7DQo+ID4gICAgICAgICBpZiAoZXJyb3IpDQo+ID4gICAgICAgICAgICAg
ICAgIGdvdG8gQ2xvc2VfRmluaXNoOw0KPiA+ICsNCj4gPiArICAgICAgIGVycm9yID0gZnJlZXpl
X2tlcm5lbF90aHJlYWRzKCk7DQo+ID4gKyAgICAgICBpZiAoZXJyb3IpDQo+ID4gKyAgICAgICAg
ICAgICAgIGdvdG8gQ2xvc2VfRmluaXNoOw0KPiA+ICsNCj4gPiAgICAgICAgIGVycm9yID0gbG9h
ZF9pbWFnZV9hbmRfcmVzdG9yZSgpOw0KPiA+ICAgICAgICAgdGhhd19wcm9jZXNzZXMoKTsNCj4g
PiAgIEZpbmlzaDoNCj4gPg0KPiA+IEp1c3QgdG8gYmUgc3VyZSwgSSdsbCBkbyBtb3JlIHRlc3Rz
LCBidXQgSSBiZWxpZXZlIHRoZSBwYW5pYyBjYW4gYmUgZml4ZWQNCj4gPiBieSB0aGlzIGFjY29y
ZGluZyB0byBteSB0ZXN0cyBJIGhhdmUgZG9uZSBzbyBmYXIuDQo+IA0KPiBJZiBhIGZyZWV6ZV9r
ZXJuZWxfdGhyZWFkcygpIGNhbGwgaXMgYWRkZWQgaW4gc29mdHdhcmVfcmVzdW1lKCksIHNob3Vs
ZA0KPiBhIHRoYXdfa2VybmVsX3RocmVhZHMoKSBjYWxsIGJlIGFkZGVkIHRvbz8NCg0KR29vZCBj
YXRjaCEgDQoNCk5vdGU6IHRoYXdfcHJvY2Vzc2VzKCkgdGhhd3MgZXZlcnkgZnJvemVuIHByb2Nl
c3MsIGluY2x1ZGluZyBib3RoIHVzZXINCnNwYWNlIHByb2Nlc3NlcyBhbmQga2VybmVsIHByb2Nl
c3Nlcy4NCg0KSW4gc29mdHdhcmVfcmVzdW1lKCk6DQoxLiBJZiBmcmVlemVfa2VybmVsX3RocmVh
ZHMoKSBmYWlscywgSSBzaG91bGQgYWRkIGEgInRoYXdfcHJvY2Vzc2VzKCk7ICINCmJlZm9yZSAi
Z290byBDbG9zZV9GaW5pc2g7ICIgc28gdGhhdCBhbGwgdGhlIHVzZXIgc3BhY2UgcHJvY2Vzc2Vz
IGNhbiANCmJlIHRoYXdlZC4NCg0KMi4gSWYgZnJlZXplX2tlcm5lbF90aHJlYWRzKCkgc3VjY2Vl
ZHMsIGJ1dCBsb2FkX2ltYWdlX2FuZF9yZXN0b3JlKCkNCkZhaWxzLCB0aGVyZSBpcyBhbHJlYWR5
IGEgdGhhd19wcm9jZXNzZXMoKS4NCg0KMy4gSWYgbG9hZF9pbWFnZV9hbmRfcmVzdG9yZSgpIHN1
Y2NlZWRzLCBpdCB3b24ndCByZXR1cm4sIGFuZCB0aGUNCmV4ZWN1dGlvbiB3aWxsIHJldHVybiBm
cm9tIHRoZSAnb2xkJyBrZXJuZWwncyBoaWJlcm5hdGUoKSAtPiANCmhpYmVybmF0aW9uX3NuYXBz
aG90KCkgLT4gY3JlYXRlX2ltYWdlKCkgLT4gc3dzdXNwX2FyY2hfc3VzcGVuZCgpLA0KYW5kIGxh
dGVyIGhpYmVybmF0ZSgpIC0+IHRoYXdfcHJvY2Vzc2VzKCkgd2lsbCB0aGF3IGV2ZXJ5IGZyb3pl
bg0KcHJvY2VzcyBvZiB0aGUgJ29sZCcga2VybmVsLg0KIA0KPiBBbnl3YXksIHBsZWFzZSBDYyBt
ZSBpZiBhIHBhdGNoIGZvciBzb2Z0d2FyZV9yZXN1bWUoKSBpcyBzdWJtaXR0ZWQuDQoNClN1cmUu
IFdpbGwgZG8uDQoNCj4gPiBJJ20gc3RpbGwgbm90IHN1cmUgd2hhdCB0aGUgY29tbWVudCBiZWZv
cmUgc2NzaV9kZXZpY2VfcXVpZXNjZSgpIG1lYW5zOg0KPiA+ICAqICAuLi4gU2luY2Ugc3BlY2lh
bCByZXF1ZXN0cyBtYXkgYWxzbyBiZSByZXF1ZXVlZCByZXF1ZXN0cywNCj4gPiAgKiAgICAgIGEg
c3VjY2Vzc2Z1bCByZXR1cm4gZG9lc24ndCBndWFyYW50ZWUgdGhlIGRldmljZSB3aWxsIGJlDQo+
ID4gICogICAgICB0b3RhbGx5IHF1aWVzY2VudC4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBpZiB0
aGVyZSBjYW4gYmUgc29tZSBvdGhlciBJL08gc3VibWl0dGVkIGFmdGVyDQo+ID4gc2NzaV9kZXZp
Y2VfcXVpZXNjZSgpIHJldHVybnMgaW4gdGhlIGNhc2Ugb2YgaGliZXJuYXRpb24sIGFuZCBJIGRv
bid0DQo+ID4ga25vdyBpZiBhYWNfc3VzcGVuZCgpIC0+IHNjc2lfaG9zdF9ibG9jaygpIHNob3Vs
ZCBiZSBmaXhlZC9yZW1vdmVkLA0KPiA+IGJ1dCBhcyBmYXIgYXMgdGhlIHBhbmljIGlzIGNvbmNl
cm5lZCwgSSdtIHZlcnkgZ2xhZCBJIGhhdmUgZm91bmQgYSBiZXR0ZXINCj4gPiBmaXggd2l0aCB5
b3VyIGhlbHAuDQo+IA0KPiBUaGUgZnVuY3Rpb24gYmxrX3NldF9wbV9vbmx5KCkgaW5jcmVtZW50
cyB0aGUgcS0+cG1fb25seSBjb3VudGVyIHdoaWxlDQo+IHRoZSBibGtfY2xlYXJfcG1fb25seSgp
IGZ1bmN0aW9uIGRlY3JlbWVudHMgdGhlIHEtPnBtX29ubHkgY291bnRlci4NCj4gSWYgcS0+cG1f
b25seSA+IDAsIGJsa19xdWV1ZV9lbnRlcigpIG9ubHkgc3VjY2VlZHMgaWYgdGhlIGZsYWcNCj4g
QkxLX01RX1JFUV9QUkVFTVBUIGlzIHNldCBpbiB0aGUgc2Vjb25kIGFyZ3VtZW50IHBhc3NlZCB0
byB0aGF0DQo+IGZ1bmN0aW9uLiBibGtfZ2V0X3JlcXVlc3QoKSBjYWxscyBibGtfcXVldWVfZW50
ZXIoKS4gVGhlIHJlc3VsdCBpcyB0aGF0DQo+IHdoaWxlIHEtPnBtX29ubHkgPiAwIGJsa19nZXRf
cmVxdWVzdCgpIG9ubHkgc3VibWl0cyBhIHJlcXVlc3Qgd2l0aG91dA0KPiB3YWl0aW5nIGlmIHRo
ZSBCTEtfTVFfUkVRX1BSRUVNUFQgZmxhZyBpcyBzZXQgaW4gaXRzIHNlY29uZCBhcmd1bWVudC4N
Cj4gc2NzaV9leGVjdXRlKCkgc2V0cyB0aGUgQkxLX01RX1JFUV9QUkVFTVBUIGZsYWcuIEluIG90
aGVyIHdvcmRzLA0KPiBzY3NpX2RldmljZV9xdWllc2NlKCkgYmxvY2tzIHJlcXVlc3RzIHN1Ym1p
dHRlZCBieSBmaWxlc3lzdGVtcyBidXQgc3RpbGwNCj4gYWxsb3dzIFNDU0kgY29tbWFuZHMgc3Vi
bWl0dGVkIGJ5IHRoZSBTQ1NJIGNvcmUgdG8gYmUgZXhlY3V0ZWQuDQo+ICJzcGVjaWFsIiByZWZl
cnMgdG8gcmVxdWVzdHMgd2l0aCB0aGUgQkxLX01RX1JFUV9QUkVFTVBUIGZsYWcgc2V0Lg0KPiAN
Cj4gQmFydC4NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgY2xhcmlmaWNhdGlvbiEgU28gaXQg
c291bmRzIGxpa2Ugd2UncmUgc2FmZSBoZXJlLA0KYW5kIEkgZ3Vlc3MgdGhlIHNjc2lfaG9zdF9i
bG9jaygpIGluIGFhY19zdXNwZW5kKCkgc2hvdWxkIGJlIHJlbW92ZWQNCnRvIGRpc2NvdXJhZ2Ug
cGVvcGxlIGZyb20gdHJ5aW5nIHRvIHVzZSBzY3NpX2hvc3RfYmxvY2soKSBpbiBhIC5zdXNwZW5k
KCkNCmNhbGxiYWNrLiA6LSkNCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
