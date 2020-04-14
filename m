Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768E1A8717
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407325AbgDNRKK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 13:10:10 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:20271
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732059AbgDNRKH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 13:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnPDae1Gy0mTJz3JBWs1OmxoDhP+agaZD8ojqLo3fyo5T2phjTlhctnDn9YSRPbQ927eY7x3BRNtY/KcRwS+eJs00ajUS3qvsqIdjqcSEuER/t/rE8/koPV/4dWHuFyD3PVTciWPr8gG65Ys6YEB/FKRHKX5NmRngcq5JkeWR1/TR1tpbdQFPoJmq/G4oe5WdcAtpg/CU8UQpdkV31pmzcugR00ISkJ/F37xKtfVAac5Oa2mdpUyU+6gG4PgQi0QvHJmaqx54TECE6JqFj4fpHOc/JNgKLm7vlL4PU1POYclqzQwWuVWccxpbSrjXM49E7Kkl0oiV1pNb3HmLbFB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZuklEyEEJvDLqQtSDAr/xWGlHr0GOiPNeM5Yaz9wUY=;
 b=AiXV7d6M4EADRGwGbIEZGRIwT8AKBdLfTNizp5C/LiBJluXKQ9R2djMQbMxkjLlyjipY9SVP5IVZDFYrCx+Kh0TM0MI8Bk8iLV7DtXRFR7NNeOPk5WvlCjE5QyRI1mAOGRzqCYujjo5sHbhyzo/UqI0TkKPsKvYD05jhgBe/aDBHaZ/cd+VTld1wrfcJR4BMWPifwdjV+0A/1YxhmezMH7JHjixyZ9jxXcVxHXt+Xyd9pxLxtA0Y0srZb62zL1uQ4udwF0uAKxigdTRIDjDuRnSPxrII40WsOhwtzTkVJmfLCzYEBk2Jdj3n6Ap+0zU3nnQaxi/6zguo4VnOmBTfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZuklEyEEJvDLqQtSDAr/xWGlHr0GOiPNeM5Yaz9wUY=;
 b=PNqGr6nUC27VlySWnB8UiqFlNNk/Q0DAjAj+2o824cvvcqFAZVD+JAvz3v8lDdH+j2XlY9VZmoRS63OmrF1ejgMY2PiUk0xt0w1bWlIMS38ZBn0NF0Gn4o+pwoIqZt+d2+FXPgygxhuc/J0ZgeNh5Tx91tKMqdYio0YI++SDWnQ=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0116.APCP153.PROD.OUTLOOK.COM (52.133.156.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.0; Tue, 14 Apr 2020 17:09:55 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2937.000; Tue, 14 Apr 2020
 17:09:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Topic: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Index: AdYO+lVJkAFfrToQQYmccjddvm2wiwAEVA6AAC5hOXAAE0msgAACwDPgAJfieJA=
Date:   Tue, 14 Apr 2020 17:09:55 +0000
Message-ID: <HK0P153MB027385877F1C918BC85BEFFFBFDA0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
 <HK0P153MB027320771C7A000B85BF3B97BFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <55ba8004-55fa-4bd6-59e9-c21f9c0e75bc@acm.org>
 <HK0P153MB0273B8F511D973C2428174EBBFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0273B8F511D973C2428174EBBFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-11T17:20:07.7914188Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=655d1367-f268-49d2-b97b-a0a42308529b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:6e:a884:7deb:b553]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39df7b87-534d-4ef5-02ff-08d7e096a7a4
x-ms-traffictypediagnostic: HK0P153MB0116:|HK0P153MB0116:|HK0P153MB0116:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01166E2BAC7846C3FF5B0CDFBFDA0@HK0P153MB0116.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(81156014)(8676002)(966005)(8936002)(66946007)(2906002)(316002)(82950400001)(55016002)(6506007)(4326008)(54906003)(53546011)(110136005)(64756008)(66476007)(66556008)(9686003)(86362001)(82960400001)(33656002)(71200400001)(8990500004)(7696005)(66446008)(186003)(76116006)(52536014)(478600001)(10290500003)(5660300002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OR2goILjPg8IKj1rO61hE5G/ldGCX7ZglOn5bf3e7uExNmH77TUwERe7KXxM6yrfj92NlaUFqTnvjaFHLZgubbGsnnXLFcRXE4C9kkyMns7Iu8S2qovJ7anv5JZ+quciTUvC/41QjZDWUAclbEABgleTEiniBzriTcAhoqs2beu7PCmpzeFByBxaEUSBNLTBtSUVHPqqV4zhzdknkoc4oI8yBJ2a21RfRIRoYhHUl0Unuqj1CKiLYiH44/47/FadTyHqIrHsSlHp66Df/cP+Z2gI8tL5Xsatd5s6ZhJZU5jCJx9zdKLwGXH8SkrELNZMeHS3NlHO6RY7doYBJIlIj+F8w8mnmnY7TPnRj8LqsebrhV9XFbcaMTUbl0kRrS+L9OMRCd3IDfS8uM4sshdwrV2gIbkEBDHonJNmHjOl17RXY5ZnZLYBJA27L0cUrh8Z4AMypiJbuEpQXo9d/A+VmruGKk+TvmuglMy1/cw2BM8bdhQnO9/RI24DdYybxR0CYOPZD3y8HXQC/I8gGon3w==
x-ms-exchange-antispam-messagedata: r5uhte6r5whCFCfzW1c4oRPKFv4Z7QXx49cxOnoMAWVnV3mZGMRMKCdkDLwukn0/gikDg+kNsj85tvJQlxl0tUiOZEi6yuZVTkZLWqISl+wbtrtwzrqL3Fw89IYIPMp3U1Cnec/+cpfEcRdk97Hwjk7C7X4ZEnZoErRDPjDUqn00IBZH54VGthP0AcxIzjIFszsabL4Yxipa0LWPaNADuA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39df7b87-534d-4ef5-02ff-08d7e096a7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 17:09:55.4586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QisjQS7QlYlwg82uN9WmpHOPqcIosjGlT5e/GCeVYdl6UyCNRUiNxyPY92v4Aa51ZxHv33VU1y39YN94uCyK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0116
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1oeXBl
cnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgRGV4dWFuIEN1aQ0KPiBTZW50
OiBTYXR1cmRheSwgQXByaWwgMTEsIDIwMjAgMTA6MjAgQU0NCj4gVG86IEJhcnQgVmFuIEFzc2No
ZSA8YnZhbmFzc2NoZUBhY20ub3JnPjsgTWluZyBMZWkNCj4gPHRvbS5sZWltaW5nQGdtYWlsLmNv
bT47IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+DQo+IENj
OiBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+Ow0KPiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBMb25nIExpIDxsb25nbGlAbWlj
cm9zb2Z0LmNvbT47IHZrdXpuZXRzDQo+IDx2a3V6bmV0c0ByZWRoYXQuY29tPjsgTWljaGFlbCBL
ZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+OyBLWQ0KPiBTcmluaXZhc2FuIDxreXNAbWlj
cm9zb2Z0LmNvbT47IE9sYWYgSGVyaW5nIDxvbGFmQGFlcGZsZS5kZT47IFN0ZXBoZW4NCj4gSGVt
bWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSRTogU0NTSSBsb3cgbGV2ZWwgZHJpdmVyOiBob3cgdG8gcHJldmVu
dCBJL08gdXBvbiBoaWJlcm5hdGlvbj8NCj4gDQo+ID4gRnJvbTogQmFydCBWYW4gQXNzY2hlIDxi
dmFuYXNzY2hlQGFjbS5vcmc+DQo+ID4gU2VudDogU2F0dXJkYXksIEFwcmlsIDExLCAyMDIwIDg6
MDMgQU0NCj4gPg0KPiA+IE9uIDIwMjAtMDQtMTAgMjM6MDEsIERleHVhbiBDdWkgd3JvdGU6DQo+
ID4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlIGNoYW5nZSB0byBzY3NpX2RldmljZV9zZXRf
c3RhdGUoKSBpcyBPSy4NCj4gPg0KPiA+IEhhZG4ndCBNaW5nIExlaSBhbHJlYWR5IHJvb3QtY2F1
c2VkIHRoaXMgaXNzdWUgZm9yIHlvdT8gRnJvbSBoaXMgZS1tYWlsOg0KPiA+ICJTbyB5b3UgY2Fu
J3QgZnJlZSByZWxhdGVkIHZtYnVzIHJpbmdidWZmZXIgY2F1c2UgQkxLX01RX1JFUV9QUkVFTVBU
DQo+ID4gcmVxdWVzdCBpcyBzdGlsbCB0byBiZSBoYW5kbGVkLiINCj4gPg0KPiA+IFBsZWFzZSBm
b2xsb3cgdGhhdCBhZHZpY2UuDQo+ID4NCj4gPiBCYXJ0Lg0KPiANCj4gSGkgQmFydCwgTWluZywN
Cj4gSSBhZ3JlZSBNaW5nIGhhcyByb290LWNhdXNlZCB0aGUgaXNzdWUsIGJ1dCBpdCBsb29rcyB0
aGUgYWR2aWNlIGNhbiBub3QNCj4gYXBwbHkgdG8gdGhlIGhpYmVybmF0aW9uIHNjZW5hcmlvLiA6
LSkNCj4gDQo+IFNvcnJ5IGZvciBteSBsYWNrIG9mIGtub3dsZWRnZSBvZiB0aGUgY29tcGxleCBT
Q1NJIHN1YnN5c3RlbXMgLS0gY291bGQNCj4geW91IHBsZWFzZSBlbGFib3JhdGUgb24gd2hhdCBh
IGxvdyBsZXZlbCBTQ1NJIGRldmljZSBkcml2ZXIgKGxpa2UgaHZfc3RvcnZzYykNCj4gc2hvdWxk
IGRvIHRvIHNhZmVseSBzYXZlL3Jlc3RvcmUgdGhlIGRldmljZSBzdGF0ZSB1cG9uIGhpYmVybmF0
aW9uPw0KPiANCj4gVGhlIG5hdHVyZSBvZiAiZnJlZSByZWxhdGVkIHZtYnVzIHJpbmdidWZmZXIi
IGluIGh2X3N0b3J2c2MgaXMgdGhhdDogdGhlDQo+IGRyaXZlciBjYW4gbm90IGhhbmRsZSBhbnkg
SS9PIGFmdGVyIHRoZSBkZXZpY2UgaXMgcXVpZXNjZWQgaW4NCj4gc29mdHdhcmVfcmVzdW1lKCkg
LT4gbG9hZF9pbWFnZV9hbmRfcmVzdG9yZSgpIC0+IGhpYmVybmF0aW9uX3Jlc3RvcmUoKQ0KPiAt
PiBkcG1fc3VzcGVuZF9zdGFydCgpIC0+IC4uLiAtPiBzdG9ydnNjX3N1c3BlbmQoKS4gQlRXLCBh
ZnRlciB0aGUgU0NTSQ0KPiBkZXZpY2UgaXMgcXVpZXNjZWQsIHRoZSBoaWJlcm5hdGlvbidzIHJl
c3VtZSBwYXRoIGFsc28gcXVpZXNjZXMgb3RoZXINCj4gZGV2aWNlcywgZGlzYWJsZXMgbm9uLWJv
b3QgQ1BVcywgYW5kIGZpbmFsbHkganVtcHMgdG8gdGhlIG9sZCBrZXJuZWwncw0KPiBlbnRyeSBw
b2ludCB3aGVyZSB0aGUgb2xkIGtlcm5lbCB3YXMgc3VzcGVuZGVkLCBhbmQgdGhlIG9sZCBrZXJu
ZWwgd2lsbA0KPiByZXN1bWUgYmFjay4NCj4gDQo+IE15IGludHVpdGlvbiBpcyB0aGF0IHRoZSB1
cHBlciBsZXZlbCBTQ1NJIGxheWVyIHNob3VsZCBwcm92aWRlIGFuIEFQSSB0bw0KPiBmbHVzaCBh
bnkgcGVuZGluZyBJL08gYW5kIGJsb2NrIGFueSBuZXcgSS9PIGFmdGVyIGEgU0NTSSBkZXZpY2Ug
aXMNCj4gInF1aWVzY2VkIj8gLS0gaXQgbG9va3Mgc2NzaV9ob3N0X2Jsb2NrKCkvc2NzaV9ob3N0
X3VuYmxvY2soKSBhcmUgc3VjaA0KPiBBUElzLCB3aGljaCBhcmUgYWxyZWFkeSB1c2VkIGJ5DQo+
IGRyaXZlcnMvc2NzaS9hYWNyYWlkL2xpbml0LmM6IGFhY19zdXNwZW5kKCkvYWFjX3Jlc3VtZSgp
Lg0KPiANCj4gVGhhdCdzIHdoeSBJIHByb3Bvc2VkIHRoZSBwYXRjaCBvZiB0aGUgc2FtZSB0aGlu
ZyBmb3IgaHZfc3RvcnZzYywgYW5kDQo+IGl0IGxvb2tzIHRoZSBwYXRjaCB3b3JrcyBmb3IgbWU6
IHdpdGhvdXQgdGhlIHBhdGNoIEkgY2FuIGVhc2lseSBoaXQgdGhlDQo+IHBhbmljIEkgcmVwb3J0
ZWQgaW4gdGhlIGZpcnN0IGVtYWlsOyB3aXRoIHRoZSBwYXRjaCwgSSBoYXZlIHN1Y2Nlc3NmdWxs
eQ0KPiBkb25lIG1vcmUgdGhhbiAzMCByb3VuZHMgb2YgaGliZXJuYXRpb24gd2l0aG91dCB0aGUg
cGFuaWMuDQo+IA0KPiBIb3dldmVyLCBpdCBsb29rcyB5b3UgaW1wbGllZCBteSBpbnR1aXRpb24g
aXMgd3JvbmcgYW5kIGl0J3MgKmV4cGVjdGVkKg0KPiB0aGF0IHRoZSB1cHBlciBsZXZlbCBTQ1NJ
IGxheWVyIGNhbiBzdGlsbCBzdWJtaXQgSS9PIHJlcXVlc3RzIHdpdGggdGhlDQo+IEJMS19NUV9S
RVFfUFJFRU1QVCBmbGFnIGFmdGVyIHRoZSBTQ1NJIGRldmljZSBpcyAicXVpZXNjZWQiPw0KPiAN
Cj4gSWYgdGhpcyBpcyB0aGUgY2FzZSwgdGhlbiBob3cgaXMgaHZfc3RvcnZzYyBzdXBwb3NlZCB0
byBoYW5kbGUgdGhlIEkvTw0KPiBhZnRlciB0aGUgU0NTSSBkZXZpY2UgaXMgcXVpZXNjZWQ/IEkg
Y2FuIGtlZXAgdGhlIHJlbGF0ZWQgdm1idXMgcmluZ2J1ZmZlciwNCj4gYnV0IHRoZSByZWFsIGlz
c3VlIGlzOiB0aGUgZHJpdmVyIGlzIHVuYWJsZSB0byBoYW5kbGUgYW55IEkvTyBhdCBhbGwgc2lu
Y2UgdGhlDQo+IHZtYnVzIGNvbm5lY3Rpb24gdG8gdGhlIEh5cGVyLVYgaG9zdCBpcyBkaXNjb25u
ZWN0ZWQgc29vbiwgYWZ0ZXINCj4gdGhlIFNDU0kgZGV2aWNlIGlzIHF1aWVzY2VkLiBTaG91bGQg
aHZfc3RvcnZzYyByZXR1cm4gYW4gZXJyb3IgZm9yIHN1Y2ggSS9PLA0KPiBvciBibG9jayBzdWNo
IEkvTyB1bnRpbCB0aGUgU0NTSSBkZXZpY2UgaXMgcmVzdW1lZD8gLS0gVGhlc2UgZG9uJ3QgbG9v
aw0KPiBnb29kIHRvIG1lLCBhbmQgSSByZWFsbHkgdGhpbmsgdGhlIHVwcGVyIGxldmVsIFNDU0kg
bGF5ZXIgc2hvdWxkIHByb3ZpZGUNCj4gYW4gQVBJIHRvIGJsb2NrIGFueSBuZXcgSS9PIGFmdGVy
IGEgU0NTSSBkZXZpY2UgaXMgInF1aWVzY2VkIiAtLSBhZ2FpbiwgY2FuDQo+IHlvdSBwbGVhc2Ug
Y2xhcmlmeSBpZiBzY3NpX2hvc3RfYmxvY2soKS9zY3NpX2hvc3RfdW5ibG9jaygpIGFyZSBzdWNo
IEFQSXM/DQo+IA0KPiBMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBsaWVzIQ0KPiANCj4gVGhh
bmtzLA0KPiAtLSBEZXh1YW4NCg0KSXQgbG9va3Mgc2NzaV9ob3N0X2Jsb2NrKCkgYW5kIHNjc2lf
aG9zdF91bmJsb2NrKCkgYXJlIGp1c3QgdGhlIEFQSXMNCkkgbmVlZC4gSSBoYXZlIHJ1biBteSBo
aWJlcm5hdGlvbiB0ZXN0IHdpdGggdGhlIEFQSXMgbW9yZSB0aGFuIDEwMDAgcm91bmRzDQphbmQg
dGhlIFZNIGlzIHN0aWxsIHJ1bm5pbmcgZmluZSB3aXRob3V0IHRoZSBwYW5pYyBJIHJlcG9ydGVk
IHByZXZpb3VzbHkgd2hlbg0KSSBkaWRuJ3QgdXNlIHRoZSBBUElzLg0KDQpGWUk6IHRoZSBhYWNy
YWlkIGRyaXZlciBpcyB0aGUgZmlyc3QgdXNlciBvZiB0aGUgQVBJczoNCg0KY29tbWl0IDNkM2Nh
NTNiMTYzOTE0YzEzOTcyODlkMGMyZWU2ZDJmNTIzNjJkY2MNCkF1dGhvcjogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+DQpEYXRlOiAgIEZyaSBGZWIgMjggMDg6NTM6MTQgMjAyMCArMDEw
MA0KDQogICAgc2NzaTogYWFjcmFpZDogdXNlIHNjc2lfaG9zdF8oYmxvY2ssdW5ibG9jaykgdG8g
YmxvY2sgSS9PDQoNCiAgICBVc2Ugc2NzaV9ob3N0X2Jsb2NrKCkgYW5kIHNjc2lfaG9zdF91bmJs
b2NrKCkgaW5zdGVhZCBvZg0KICAgIHNjc2lfYmxvY2tfcmVxdWVzdHMoKS9zY3NpX3VuYmxvY2tf
cmVxdWVzdHMoKSB0byBibG9jayBhbmQgdW5ibG9jayBJL08uDQogICAgVGhpcyBoYXMgdGhlIGFk
dmFudGFnZSB0aGF0IHRoZSBibG9jayBsYXllciB3aWxsIHN0b3Agc2VuZGluZyBJL08gdG8gdGhl
DQogICAgYWRhcHRlciBpbnN0ZWFkIG9mIGhhdmluZyB0aGUgU0NTSSBtaWRsYXllciByZXF1ZXVl
aW5nIEkvTyBpbnRlcm5hbGx5Lg0KDQogICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIwMDIyODA3NTMxOC45MTI1NS0xMC1oYXJlQHN1c2UuZGUNCiAgICBSZXZpZXdlZC1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQogICAgQWNrZWQtYnk6IEJhbHN1bmRhciBQ
IDwgQmFsc3VuZGFyLlBAbWljcm9jaGlwLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gSy4gUGV0
ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KDQpCVFcsIEkgc3VzcGVjdCBhYWNf
c3VzcGVuZCgpIC0+IHNjc2lfaG9zdF9ibG9jaygpIGlzIG5vdCByZWxseSB3b3JraW5nDQpiZWNh
dXNlIHNjc2lfaG9zdF9ibG9jaygpIGRvZXNuJ3QgYWxsb3cgYSBzdGF0ZSB0cmFuc2l0aW9uIGZy
b20gDQpTREVWX1FVSUVTQ0UgdG8gU0RFVl9CTE9DSyBhbmQgcmV0dXJucyAtRUlOVkFMIGZvciB0
aGF0LiBhYWNfc3VzcGVuZCgpDQpzaG91bGQgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiBzY3Np
X2hvc3RfYmxvY2soKSwgYW5kIG15IGNoYW5nZSB0bw0Kc2NzaV9kZXZpY2Vfc2V0X3N0YXRlKCkg
c2hvdWxkIGJlIG5lZWRlZCB0byBhdm9pZCB0aGUgLUVJTlZBTCBlcnJvci4NCg0KSWYgdGhlcmUg
aXMgbm8gb2JqZWN0aW9uLCBJIHBsYW4gdG8gc2VuZCBzb21lIHBhdGNoZXMgbGF0ZXIuDQoNClRo
YW5rcywNCi0tIERleHVhbg0K
