Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524731EED7B
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2020 23:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFDVtk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Jun 2020 17:49:40 -0400
Received: from mail-eopbgr1320122.outbound.protection.outlook.com ([40.107.132.122]:8249
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgFDVtk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Jun 2020 17:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R//VyhcFFRd1ELifyD8Q7rDzfEAOl7JAjUaC07rJHzuh46tjAAdRLWouE/BKUKaT9uiatwcNcNrOwX9+LJA4x8x337sGr9gmY2VOKxNnPqfsRuINHVOw4QZwGrj4YbUlKeeeCAZLQppBkL0XqlTaUeO1C4DQGvK/+w5egcqa9mEk/l32rGZZy9DGrIDuvfBOAJX4emDyAkvXAXRbjFRLgHJdKYYL0RmYjE5y3mjoLdj9CJC9Gs3b5ihkxPc8Mg4T9q+WDL53L7x3jhO2yL27Lt44dapp9SgM6jOgOqIO/JkJWvZvKRbt/M29DBCZgLozzFt8nN7uAkZvsynO02tiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQu0y/eedBIMGwq+dIwMvSZGC83/S6X/U2Ns1PJiOug=;
 b=mf1QVu5mW/RTFlbrgV9/8C7Hgdo6EHQtZFESuOMr6nv11EjZ/UY0QDOfQZvQZwgUHpd7p+7ZfXvnVSpQqCS6/KA6X5pDKHMbAJvoekU0FvW5rOyEAygDnTYvk/lXwLlStXxcbaYlYbmYZi2X4yLxcYHMN28tRf86EMxYFp3eVuz1g6I510qr3PT0tW8pmwJU6LS5hGi3cLEJG4hthlBcvWv2ZU/gYyWWgstq2dwDmXbf63kyZwFepcEhInpkJfxHibQ72CoIILrkdJA4EtFykAqkasAs4pS1rFutk/3lFEwLcZNzfQLdu64I3vndjKA09E/KfJ8jPea08lksPwyhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQu0y/eedBIMGwq+dIwMvSZGC83/S6X/U2Ns1PJiOug=;
 b=IWBW759Kne5IuFoz45jGbB38E0JtREWHuunXkwd9GIwJQVPcQuOrKitr2yVkWjo6M95T+EPaMeMTh2oxXSgAQMCZX9QjsKMSX7fWqU8CZfS+DxyCZAwBA6a8BqgmVaWaX6FaYK1+GDs5DO+1lXrvHgqfXRoGLMsqH9akgnytLbM=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK0P153MB0339.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3; Thu, 4 Jun
 2020 21:49:31 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%7]) with mapi id 15.20.3088.011; Thu, 4 Jun 2020
 21:49:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "efremov@linux.com" <efremov@linux.com>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
Thread-Topic: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
Thread-Index: AQHWOrkjuNlCF70aE0iSK1Gft60RkajI/fMQ
Date:   Thu, 4 Jun 2020 21:49:31 +0000
Message-ID: <HK0P153MB03228498F6E0AD292909CC7BBF890@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200604130406.108940-1-efremov@linux.com>
 <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
 <696a6af8-744d-01b5-4a37-5320887e9108@linux.com>
In-Reply-To: <696a6af8-744d-01b5-4a37-5320887e9108@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-04T21:49:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3cfe004-f624-4e11-8802-ac1e1393a663;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e404:4689:ed94:8298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a9dca31-7efc-4860-f1f3-08d808d129eb
x-ms-traffictypediagnostic: HK0P153MB0339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0339DB6E82E5604B79A2FE37BF890@HK0P153MB0339.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSHoNXY14aOxrjiag9B6zy1DERFKbQNKu4cuDoJ2EMwiD0UX8epfD3yJEjxCrDgObXnsO4tIPT3G+K3hfLd4a51TIn6IQsZOMwRn9c/Dy2VZI2ubFhN81lxuT7LbHbhwDDF4U6LrBQEqQG6Gs/AtBIgNIzF0T+esNei9XQgNrSKmUNbFuxh3EVoZDrIATRT80SJdulJ69Xab7A9bcdv8rSZm12ElMnv3FMuugkF8B/+5zDeHrjaPnPjufT6i2zQe1scP/7R6NvTWQefc/bIK28piBZO/aJUXc6FRiOUBvAG3wqf8x7tRDup4cEZlYvMZwj2oUThJ3k9E/mFHCMEFOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(8936002)(5660300002)(4744005)(186003)(8676002)(7696005)(83380400001)(66946007)(76116006)(478600001)(2906002)(71200400001)(10290500003)(82950400001)(82960400001)(6636002)(4326008)(33656002)(54906003)(52536014)(6506007)(316002)(66476007)(86362001)(9686003)(55016002)(110136005)(8990500004)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lieWSi4q/ix3XjrjPRz15st05UXQrIZyarsQFJyBkKeP76kkMWd2oDFpZwmyY5rrZMTtNGxTeEX0c8loqHWgfntTGhruhfeCdTF5m3dkgRelZmdqN/Gf+R+qnTiRshnSVWWOFMqglMJsEFV+1TV9gyH4mLIX4TVOZr2r2sYxnZ91ePyL8nUbUvrKIWTe6WJ3BVlqv28GJHsmhgcm0DRp9HvfDS/Dic49iBRpqM+BhDaflNCTk0NBJXnOZUKXlvqNrh5LcGTb68YzTZMa6qykNTUE3TeFfVcqvvuuMirY3avAo0iu+FR52waCzgd05GvF9qfODKtJnYsaSQI5VCJhT3nhZqmJg+SGB99gxmX/m4kbGBr/jzFuzVYEusFn8WfUF+mLlgpHd/FLTipS/SL2GCni4s3cm5rNutdnuTxmXAgGd08Y6MU8zOD2PsWTpIo04tPoEXldh7sfvr0a/OJRG4SodxcRHqofMKn9jHVvCUia/y1djEJXzXuA/MQ19+Ja6gnVa0zaSWtipdNq9Cp8dZo4TRxa4nRk6hkY9dAq9boC3Mh+wCaBBG5sTtHhf5Qn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9dca31-7efc-4860-f1f3-08d808d129eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 21:49:31.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqTJXO+N3UhSlSuKqB3obR3PVCEFnxiuK4DXcDX7+0Y8NCgB4KuFI4zWe0IIhSQd1QyUbBUFaP/+KshlJP5PHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0339
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEZW5pcyBFZnJlbW92IDxlZnJlbW92QGxpbnV4LmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEp1bmUgNCwgMjAyMCAyOjQzIFBNDQo+ID4NCj4gPiBIaSBEZW5pcywNCj4gPiBXaGVuIEkg
YWRkZWQgdGhlIGZ1bmN0aW9uIHN0b3J2c2Nfc3VzcGVuZCgpIHNldmVyYWwgbW9udGhzIGFnbywg
c29tZWhvdw0KPiA+IEkgZm9yZ290IHRvIHJlbW92ZSB0aGUgdW5uZWNlc3NhcnkgbWVtc2V0KCku
IFNvcnJ5IQ0KPiA+DQo+ID4gVGhlIGJ1ZmZlciBpcyByZWNyZWF0ZWQgaW4gc3RvcnZzY19yZXN1
bWUoKSAtPiBzdG9ydnNjX2Nvbm5lY3RfdG9fdnNwKCkgLT4NCj4gPiBzdG9ydnNjX2NoYW5uZWxf
aW5pdCgpIC0+IHN0b3JfZGV2aWNlLT5zdG9yX2NobnMgPSBrY2FsbG9jKC4uLiksIHNvIEkgYmVs
aWV2ZQ0KPiA+IHRoZSBtZW1zZXQoKSBjYW4gYmUgc2FmZWx5IHJlbW92ZWQuDQo+IA0KPiBJJ20g
bm90IHN1cmUgdGhhdCBJIHVuZGVyc3RhbmQgeW91ciBkZXNjcmlwdGlvbi4gQXMgZm9yIG1lLCBt
ZW1zZXQgd2l0aCAwDQo+IGJlZm9yZQ0KPiBtZW1vcnkgZnJlZWluZyBpcyByZXF1aXJlZCBvbmx5
IGZvciBzZW5zaXRpdmUgaW5mb3JtYXRpb24gYW5kIGl0J3MgY29tcGxldGVseQ0KPiB1bnJlbGF0
ZWQgdG8gbWVtb3J5IHplcm9pbmcgZHVyaW5nIGFsbG9jYXRpb24gd2l0aCBremFsbG9jL2tjYWxs
b2MuDQo+IElmIGl0J3Mgbm90IGEgc2Vuc2l0aXZlIGluZm9ybWF0aW9uIHRoZW4gbWVtc2V0IGNv
dWxkIGJlIHNhZmVseSByZW1vdmVkLg0KDQpUaGVyZSBpcyBubyBzZW5zaXRpdmUgaW5mbyBpbiB0
aGUgYnVmZmVyIGhlcmUuDQoNCj4gPiBDYW4geW91IHBsZWFzZSBtYWtlIGEgdjIgcGF0Y2ggZm9y
IGl0IGFuZCBDYyBteSBjb3Jwb3JhdGUgZW1haWwgImRlY3VpIiAoaW4NCj4gVG8pPw0KPiANCj4g
WWVzLCBvZiBjb3Vyc2UuIENvdWxkIEkgYWRkICJTdWdnZXN0ZWQtYnkiPw0KPiANCj4gVGhhbmtz
LA0KPiBEZW5pcw0KDQpTdXJlLiANCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQoNCg==
