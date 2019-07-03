Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834085DD86
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2019 06:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfGCElE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 00:41:04 -0400
Received: from mail-eopbgr1320103.outbound.protection.outlook.com ([40.107.132.103]:30509
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfGCElE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 00:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4PKPSu1WPWTXhO9vNUYxnPV1KH9qJdP5SFxbohwxcm6cII9lrO84kk0xzmoZumdcypn926stSfdHN9gFj4a6o4gXjz4FfauId26tgQBVPmZdcZ6wxJ5JBSKS5fovZVXU2v59L4Txm0XiWeDjZRT0hGXtWSfdPlyw4YpjUK+OPV8WMYMhhOQLNOdygjft7HZZzQeuc+ybbdUMACAx5n1DaIqHHqt8jq9HWhC8yALT3SqltM5WFfPSs0eZ1TTbWxbjv/oHui75llbybsm2sgwGpz50jiY2mnTs8X6Rg1GR4Gqeio8jtb9R9wCkL9W36EC0qvDRAYl/2vxuWDYrOm/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2WKJJfKSHPJFQvBgNKUeZBkzs1/bCX93P1xBsmL9x8=;
 b=fn8lJjg64OkyMW1aITR7aODuq5IbjB99pLm3dLHoSW3YB5sZPMSqtUi7jowIIZOIc4qMO8EXMgzCj3MQQ9mMWaquVbRXtSOGN66xzXk5SXvaRk3c4xIjeHibFXvfufh+m5+EFLfhu28t6AyvNsxn04XKWuVUMjm21mHW15CYUQekb82HEH4IEbx0OODETA5DJagndHseywl3vNACxOYHDP486fu7GVLZzQ1seEgxeWwAU+v7YB4LYS6v1BvoajWkW0a/fpFxahDKUwOUirLuYhV+3cx9q5rrlLsaCLbyLlkAEMnfelcGJS+15yiXOskX9QYYhU3jXTPxEDhSFqLPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2WKJJfKSHPJFQvBgNKUeZBkzs1/bCX93P1xBsmL9x8=;
 b=lS558bHylDJ1XUsT+7wOQr7ztHznA2M07dVbsEY6q+radpgpRYw1qc7njZ5nCeFjl1XZKvYPiWp3b7Fwk3Q1BIF8CDsDnJ6ycF7J1mUwecOHuuJK0vPJY99pHg17tM6ycW6YOtwNauzoFdndGJcbY2BaAWHihLK57wi2D9YYzsI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Wed, 3 Jul 2019 04:40:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.001; Wed, 3 Jul 2019
 04:40:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yuehaibing <yuehaibing@huawei.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Thread-Topic: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Thread-Index: AQHVMVloxn4hFFa0E0C7KQrPGKhKRQ==
Date:   Wed, 3 Jul 2019 04:40:16 +0000
Message-ID: <PU1P153MB0169D4B9CBA09977186DA706BFFB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
 <20190703001541.GG1729@bombadil.infradead.org>
 <139b6a64-1980-412b-5870-88706084b288@infradead.org>
In-Reply-To: <139b6a64-1980-412b-5870-88706084b288@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-03T04:40:14.5914706Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3862d5da-ee58-4f56-ac83-48b39e67d798;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:78d7:890f:ef80:9f4a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0573585a-458b-4787-48be-08d6ff708bc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0201;
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <PU1P153MB020146A6DCCA1ADD49B762D4BFFB0@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(54094003)(189003)(199004)(25786009)(446003)(256004)(52536014)(8990500004)(54906003)(6246003)(316002)(22452003)(10090500001)(305945005)(6436002)(46003)(486006)(55016002)(186003)(229853002)(7696005)(76176011)(6506007)(53546011)(4326008)(476003)(11346002)(102836004)(2906002)(10290500003)(74316002)(9686003)(8676002)(6306002)(81166006)(81156014)(64756008)(99286004)(33656002)(53936002)(8936002)(6116002)(86362001)(478600001)(966005)(14454004)(5660300002)(71190400001)(71200400001)(76116006)(73956011)(66446008)(66556008)(66476007)(7736002)(66946007)(110136005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VDqlKapRSdkWHQkTk3r5ru79Oj3r4nuzQlzrH814a7Eg5nqNLqdbYisF+oqvkaIqT5jc0t0kWnNET1YlgpkjkSVXyHNgSfXAWfHahaMdFHZNURtu4yToD4pgKRsd/LjvRKBACl6B2A0NvUeHLQhg6YTgNrSncoY7AwWP9JibGNf7OFBeJ7x4yinmn+qmQcMBKIF+FkELVcrcKuvafXuT/YhWRnpX2btmpig64FSnuItofVZJo5x/FoI6jTotttLQcRbr8moPrrHBO/Jo14PpHoo5L2vnEi6VF6zGY3lSs6hBLgDFYpuSrABhpIgPEqUTw1VKrBFsNg48/j/L/x2GXOVpA2TLQ4YkAy/lkJuxWusAfVeR9aK6oi0O+fDyLwKgMGK0HbjxhHdT/gGCGU3as5kEshvWb7NUaNN/jYFgius=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0573585a-458b-4787-48be-08d6ff708bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 04:40:16.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1oeXBl
cnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgUmFuZHkgRHVubGFwDQo+IFNl
bnQ6IFR1ZXNkYXksIEp1bHkgMiwgMjAxOSA4OjI1IFBNDQo+IFRvOiBNYXR0aGV3IFdpbGNveCA8
d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBKYWtlDQo+IE9zaGlucyA8amFr
ZW9AbWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFp
eWFuZw0KPiBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2Vy
DQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwu
b3JnPjsgbGludXgtcGNpDQo+IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBo
djogZml4IHBjaS1oeXBlcnYgYnVpbGQsIGRlcGVuZHMgb24gU1lTRlMNCj4gDQo+IE9uIDcvMi8x
OSA1OjE1IFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiBPbiBUdWUsIEp1bCAwMiwgMjAx
OSBhdCAwNDoyNDozMFBNIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4+IEZyb206IFJh
bmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+Pg0KPiA+PiBGaXggYnVpbGQg
ZXJyb3JzIHdoZW4gYnVpbGRpbmcgYWxtb3N0LWFsbG1vZGNvbmZpZyBidXQgd2l0aCBTWVNGUw0K
PiA+PiBub3Qgc2V0IChub3QgZW5hYmxlZCkuICBGaXhlcyB0aGVzZSBidWlsZCBlcnJvcnM6DQo+
ID4+DQo+ID4+IEVSUk9SOiAicGNpX2Rlc3Ryb3lfc2xvdCIgW2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLWh5cGVydi5rb10gdW5kZWZpbmVkIQ0KPiA+PiBFUlJPUjogInBjaV9jcmVhdGVfc2xv
dCIgW2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5rb10gdW5kZWZpbmVkIQ0KPiA+
Pg0KPiA+PiBkcml2ZXJzL3BjaS9zbG90Lm8gaXMgb25seSBidWlsdCB3aGVuIFNZU0ZTIGlzIGVu
YWJsZWQsIHNvDQo+ID4+IHBjaS1oeXBlcnYubyBoYXMgYW4gaW1wbGljaXQgZGVwZW5kZW5jeSBv
biBTWVNGUy4NCj4gPj4gTWFrZSB0aGF0IGV4cGxpY2l0Lg0KPiA+DQo+ID4gSSB3b25kZXIgaWYg
d2Ugc2hvdWxkbid0IHJhdGhlciBwcm92aWRlIG5vLW9wIHZlcnNpb25zIG9mDQo+ID4gcGNpX2Ny
ZWF0ZXxkZXN0cm95X3Nsb3QgZm9yIHdoZW4gU1lTRlMgaXMgbm90IHNldD8NCj4gPg0KPiANCj4g
TWFrZXMgc2Vuc2UuICBJJ20gdGVzdC1idWlsZGluZyB0aGF0IG5vdy4NCj4gDQo+IC0tDQo+IH5S
YW5keQ0KDQorIFl1ZWhhaWJpbmcsIHdobyBzdWJtaXR0ZWQgYSBzaW1pbGFyIHBhdGNoLCB3aGlj
aCBJIGd1ZXNzIGlzIG5lZ2xlY3RlZA0KYXQgdGhlIGVuZCBvZiB0aGUgZGlzY3Vzc2lvbiBsYXN0
IG1vbnRoOg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS81LzMxLzU1OQ0KaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMTkvNi8xNC83ODQNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzYv
MTUvMjQNCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
