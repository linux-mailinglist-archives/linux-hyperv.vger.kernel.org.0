Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDDBA0D95
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfH1WcP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 18:32:15 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:61944
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfH1WcP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 18:32:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkFuEtcdt3v2R1PZIDUxY5yc/C7Zw2zcuE6b2Mc+jUUdWQhgEMXTqQjxMRqJCRuhIHyXOggIlNt7Syx4ZNIPiaYOTuAWX58lfmLSPQ0EhD0/Sr1B+mYGxkiy6zXetRkz3JONl8j8A3YBAtd10P+cC5svCe90HeuourCh98KPOYbihVmafK80IA0A3sNmg2KiMpnjCZljL3LHzVsQ/pVtDKTfrFqeGF9rI6QCFe9oCQkt90kdu328ozhGsmESAwHhumfnJ1/6/2KXKUmuUHd+t64w9Iya8eZxWk4P0af2qq/n2dQ8O6uQUu0V4ZXrFaRyMu7wn5g068SpblyDJt3+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFSkZM6cEP8XoenE1QzpfJQ3LUVaHA8UJozByd475eU=;
 b=iIPXgF4M3htkwlSgYqnICmnzhyum9sn7GRx5liyDqVVotDSLyi0kORaN6uma40U3iGvx/K5u8AF9GwEZW/ytD3nrdqGb9oTXbF6lkeJ73ZE6rFekXuoocBEM+//SYcFZzcD1f0026rEwc9UbuafA0WSO5q41J/uCmn/pgXnPjyUw9etHTSsy7uG5LZF96LmND+vhSAm5oC/HuRAX0QrTYElRjkaOjEXvLyu+B+oPGcRBuwIiH27ZZPcQnHEwlZi1i3q6SH1HG/HLa5JHO6qUt4uiJHP9laemb5JELEO+AzIHMJ5UU1Mhy7cFVlz9LZUy3aP/z64aJpBlu+CKU25fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFSkZM6cEP8XoenE1QzpfJQ3LUVaHA8UJozByd475eU=;
 b=WdNDNj/Ge5f2SUz6wkzEHpCDIsAd42T6Yzhz87A3bc6+nkwDWAulO4c7Lmuvyc9hKXFeTDHwxs50dRi8YXsLOfbGM309IgmPYnaY4sp//QE/VioUnP6s1O0Rv09JDX0NLqkvTcyHquhpezlgwvh9IYls//OEenB9XEruXQW+eqU=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1273.namprd21.prod.outlook.com (20.179.51.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.5; Wed, 28 Aug 2019 22:32:12 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b%5]) with mapi id 15.20.2220.000; Wed, 28 Aug 2019
 22:32:11 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Make functions only used locally static in
 pci-hyperv.c
Thread-Topic: [PATCH v2] PCI: hv: Make functions only used locally static in
 pci-hyperv.c
Thread-Index: AQHVXe6TS8LsYHPB50mHaE/2a8/d+qcRJEug
Date:   Wed, 28 Aug 2019 22:32:11 +0000
Message-ID: <DM6PR21MB133796BB3D4A41278C513332CAA30@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190826154159.9005-1-kw@linux.com>
 <20190828221846.6672-1-kw@linux.com>
In-Reply-To: <20190828221846.6672-1-kw@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-28T22:32:10.6393175Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c93428da-745d-45eb-822e-1faebec1ec71;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:3261:3ef3:246a:9ec3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42b0fd7f-5a76-4c8f-3b61-08d72c0791e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1273;
x-ms-traffictypediagnostic: DM6PR21MB1273:|DM6PR21MB1273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1273B9D7CF3527E1D88E7663CAA30@DM6PR21MB1273.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:63;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(13464003)(199004)(189003)(6436002)(22452003)(10090500001)(66946007)(52536014)(64756008)(46003)(7736002)(486006)(25786009)(2906002)(229853002)(33656002)(54906003)(110136005)(4326008)(186003)(6116002)(66556008)(71200400001)(316002)(5660300002)(66476007)(8676002)(81166006)(66446008)(71190400001)(81156014)(76116006)(102836004)(8990500004)(478600001)(7696005)(10290500003)(86362001)(6246003)(9686003)(53546011)(6506007)(8936002)(55016002)(53936002)(14454004)(74316002)(305945005)(446003)(11346002)(476003)(76176011)(14444005)(256004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1273;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C4WPBxiyN4OEjnR2yJQJzXsszTi8eQrsH1bwkgnqRRMpPT69DaH2QK6FNXzziinuMFqEnX8MM+Lv1u+1JCuraF1IpW/KgrYP6C0ugNivEwuEYpUQZZFCdgnGd0RXh2uKfi7O1NY1eKGfo9n84kwsA1aRHUjRngAd+sDSZMDnOuSyga3blz2MmrucgeovnChkd8Hp8Bv+cH1mIyBCg4KeyP/I051y3xU4AFIFhEx6T1dbFNsfb0rgp2gIGSn3JeXo9cWEXJAUOU7+g5szrqvWAsUiH5C3JgTUCJTB5A7jw6qDb3dvXCipv4ouYTiv6dFm/Erp276tHzRIJDNcPf+EXVxizWxNlfL1n/iQVevjtJ2runQIuwkKB9h0XJQVgc3tbDiNV7R+d3JW072nYjyqWhWAqvo46yQFTVm6YP2rJ5s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b0fd7f-5a76-4c8f-3b61-08d72c0791e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 22:32:11.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jEq9CqjfIz2apBfq49ezzy+M5KoYDyJTwGG8Oj37kzGHuoXW/W3PwuVVStH0kuhx5joI73TE+EZOn49Pg94Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1273
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIFdpbGN6
eW5za2kgPGtzd2lsY3p5bnNraUBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBLcnp5c3p0b2YNCj4g
V2lsY3p5bnNraQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOCwgMjAxOSAzOjE5IFBNDQo+
IFRvOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+IENjOiBLWSBTcmluaXZh
c2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6QG1pY3Jv
c29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47
IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz47IExvcmVuem8NCj4gUGllcmFsaXNpIDxs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIIHYyXSBQQ0k6IGh2OiBNYWtlIGZ1bmN0aW9ucyBvbmx5IHVz
ZWQgbG9jYWxseSBzdGF0aWMgaW4gcGNpLQ0KPiBoeXBlcnYuYw0KPiANCj4gRnVuY3Rpb25zIGh2
X3JlYWRfY29uZmlnX2Jsb2NrKCksIGh2X3dyaXRlX2NvbmZpZ19ibG9jaygpDQo+IGFuZCBodl9y
ZWdpc3Rlcl9ibG9ja19pbnZhbGlkYXRlKCkgYXJlIG5vdCB1c2VkIGFueXdoZXJlDQo+IGVsc2Ug
YW5kIGFyZSBsb2NhbCB0byBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYywNCj4g
YW5kIGRvIG5vdCBuZWVkIHRvIGJlIGluIGdsb2JhbCBzY29wZSwgc28gbWFrZSB0aGVzZSBzdGF0
aWMuDQo+IA0KPiBSZXNvbHZlIGZvbGxvd2luZyBjb21waWxlciB3YXJuaW5nIHRoYXQgY2FuIGJl
IHNlZW4gd2hlbg0KPiBidWlsZGluZyB3aXRoIHdhcm5pbmdzIGVuYWJsZWQgKFc9MSk6DQo+IA0K
PiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYzo5MzM6NTogd2FybmluZzogbm8g
cHJldmlvdXMgcHJvdG90eXBlIGZvcg0KPiDigJhodl9yZWFkX2NvbmZpZ19ibG9ja+KAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdDQo+ICBpbnQgaHZfcmVhZF9jb25maWdfYmxvY2soc3RydWN0IHBj
aV9kZXYgKnBkZXYsIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbiwNCj4gICAgICBeDQo+IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jOjEwMTM6NTogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlDQo+IGZvciDigJhodl93cml0ZV9jb25maWdfYmxvY2vigJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQ0KPiAgaW50IGh2X3dyaXRlX2NvbmZpZ19ibG9jayhzdHJ1Y3QgcGNp
X2RldiAqcGRldiwgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuLA0KPiAgICAgIF4NCj4gZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmM6MTA4Mjo1OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUNCj4gZm9yIOKAmGh2X3JlZ2lzdGVyX2Jsb2NrX2ludmFsaWRhdGXigJkg
Wy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KPiAgaW50IGh2X3JlZ2lzdGVyX2Jsb2NrX2ludmFsaWRh
dGUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHZvaWQgKmNvbnRleHQsDQo+ICAgICAgXg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgV2lsY3p5bnNraSA8a3dAbGludXguY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gICBVcGRhdGUgY29tbWl0IG1lc3NhZ2UgdG8gaW5jbHVkZSBjb21w
aWxlciB3YXJuaW5nLg0KPiANCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5j
IHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlw
ZXJ2LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS0NCj4gaHlwZXJ2LmMNCj4gaW5kZXgg
ZjFmMzAwMjE4ZmFiLi5jOTY0MmU0MjljMmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jDQo+IEBAIC05MzAsNyArOTMwLDcgQEAgc3RhdGljIHZvaWQgaHZfcGNpX3JlYWRf
Y29uZmlnX2NvbXBsKHZvaWQgKmNvbnRleHQsDQo+IHN0cnVjdCBwY2lfcmVzcG9uc2UgKnJlc3As
DQo+ICAgKg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvbiBmYWlsdXJlDQo+
ICAgKi8NCj4gLWludCBodl9yZWFkX2NvbmZpZ19ibG9jayhzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
dm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuLA0KPiArc3RhdGljIGludCBodl9yZWFkX2NvbmZp
Z19ibG9jayhzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVu
LA0KPiAgCQkJIHVuc2lnbmVkIGludCBibG9ja19pZCwgdW5zaWduZWQgaW50ICpieXRlc19yZXR1
cm5lZCkNCg0KVGhlIHNlY29uZCBsaW5lIHNob3VsZCBiZSBhbGlnbmVkIG5leHQgdG8gdGhlICIo
IiBvbiB0aGUgZmlyc3QgbGluZS4NCkFsc28gdGhlIGZpcnN0IGxpbmUgaXMgbm93IG92ZXIgODAg
Y2hhcnMuDQoNClRoYW5rcywNCi0gSGFpeWFuZw0KDQo=
