Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A78A1FD9
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH2PvP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Aug 2019 11:51:15 -0400
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:30122
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbfH2PvL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOSpRxr3vO0k5rMOsoXd68aRrXdOZEErTFKtpRZmtwFTDP9J8sd/ioiKqT3ZteYH1XviKEPraRy3nXTgG3Ug7Yaa+o92DQI6w/zw5l5VvgUNip4oRIVQcNrBP2NlBDbHjwjFREbm9lXacOrNRlBXwZWX2DNJemirU/z1nEchp6JgTRdeBk0LHkEp/Ov37qRpDX7iHAglfraBUNOx56fWyAoDYedFHtitqgPw5vZ+iDWLctjeYjIypsBF3rhiBEH5XkA4WOb2Pa7MtxeC+MKVq6lOX4exgK5SYuzhVde9jNuJMmfs+ZUpFkdaTzq9aHwd+BRO6BEC/DkhZ5GJ2gVjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z/UusHvvqFbHm/sbKGIG/GDL3GDSTbf5Eilocl4c70=;
 b=CO9Dg66+0pHHDM6b7JvaE0PMS84qlCOinblQC/RYGLtwHPOBhSdZlQNHFZmwnYHu1K9EUvuDj0qegoB2bSMCF243S3b+859BuG7uisON7Cwoj1Cm+26KPdK58Um6LmX+NO2kzag6P3ZE3TQsBpnVBCF2D1T7Ua3NKTxMAxuN8pbwNYfxLVDyoKM/AtAy4QH5ksN5iM48N+gcfOjdG7SVaIdXhrMCwollElt2qm3DmvMt500eecas7SJl1qa17koqj3deDRppCntKvokkhUamkfu8BN+YM5FsgUpPalH9XFNuI+cduUsb7/tKcOWRGTV/lwKbO+OR4bqFCgh1RPSYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z/UusHvvqFbHm/sbKGIG/GDL3GDSTbf5Eilocl4c70=;
 b=luXRc716fDlVl9a8hnsJnq3e9Po8wC9G6FtlbomCDqFXczShZYHmq32uiozAM7gzywM5R3B50gaHe0tpIoRSrOkGcdEyeN59yh9Lw96Ut03xcT1yd9zAyFwrRE3beGJPvolo1kbOGhqTVfVrdE5+zvMk+e6GbyvlIft+OOYutWk=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1148.namprd21.prod.outlook.com (20.179.50.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.3; Thu, 29 Aug 2019 15:50:47 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b%5]) with mapi id 15.20.2220.000; Thu, 29 Aug 2019
 15:50:47 +0000
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
Subject: RE: [PATCH v3] PCI: hv: Make functions static
Thread-Topic: [PATCH v3] PCI: hv: Make functions static
Thread-Index: AQHVXkqQ0XAm95C7kkufbUVKItTSXacSRh+w
Date:   Thu, 29 Aug 2019 15:50:47 +0000
Message-ID: <DM6PR21MB13372349374A473FF98AD7BCCAA20@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190828221846.6672-1-kw@linux.com>
 <20190829091713.27130-1-kw@linux.com>
In-Reply-To: <20190829091713.27130-1-kw@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-29T15:50:45.9921578Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=39b782ed-4752-40bd-9310-0105ca1563ca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:9132:cdd:d641:5942]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4172b37e-7e2a-4d97-b835-08d72c98a8e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1148;
x-ms-traffictypediagnostic: DM6PR21MB1148:|DM6PR21MB1148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1148F14BE4B439D8B9D6CCB9CAA20@DM6PR21MB1148.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(13464003)(102836004)(8676002)(6506007)(25786009)(66446008)(86362001)(99286004)(53546011)(186003)(305945005)(446003)(7696005)(10090500001)(6436002)(6246003)(55016002)(478600001)(54906003)(22452003)(476003)(2906002)(74316002)(11346002)(110136005)(33656002)(52536014)(5660300002)(71190400001)(486006)(8936002)(14454004)(9686003)(64756008)(66476007)(53936002)(66946007)(316002)(76116006)(76176011)(7736002)(46003)(6116002)(256004)(71200400001)(14444005)(10290500003)(229853002)(81156014)(8990500004)(4326008)(81166006)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1148;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNwhKAcoVII7ul2uHZfb3knzNLlrSBjyrgKiBpEp87GcxsEvnDdUQuJKMQxoz+RUFtt8DeOpEDS7vSL855vyeE+HST4kB5TCdlev23psAbQO4U0OUo1YVP0wrepE8nWofde/NupTTPZJtXHBWZlmVfjfjKaz+tKAxs8tASKlj9qrjWZZvKVcfBpfYiYgnYVddqXj33cMBsgUb2vQUUn8Mwg07yBaIOeZ3ipLUAAiEHNd6RPMOnChre9JWdBn6Mx1lzv37RPhgFhIqz+b3C+A8bOjLTF5pYI/zdXUZtSEN2RoFGgGdEaQ0XxV4qm5UxgYtXgs3VQ9OhpDkS7AETRebqnuV8CKbP6MR/xl3QeJxUzfOSXOQWvz1sJfqdNNpo4QHcWQCaEd4P2WaJXFA8lBVqxHeJBPXFZbTW+15qqHDLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172b37e-7e2a-4d97-b835-08d72c98a8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:50:47.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2AB9MKlMmevbB/ar9SCNfXOoizrmCIyulx+Gw4669NzuSTxJ3VA+ENrw4VO/AXdWV+QovuHh5syHWywJUx2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1148
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIFdpbGN6
eW5za2kgPGtzd2lsY3p5bnNraUBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBLcnp5c3p0b2YNCj4g
V2lsY3p5bnNraQ0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDE5IDI6MTcgQU0NCj4g
VG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IEtZIFNyaW5pdmFz
YW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFuZ3pAbWljcm9z
b2Z0LmNvbT47IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsg
U2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPjsgTG9yZW56bw0KPiBQaWVyYWxpc2kgPGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIFBDSTogaHY6IE1ha2UgZnVuY3Rpb25zIHN0YXRpYw0K
PiANCj4gRnVuY3Rpb25zIGh2X3JlYWRfY29uZmlnX2Jsb2NrKCksIGh2X3dyaXRlX2NvbmZpZ19i
bG9jaygpIGFuZA0KPiBodl9yZWdpc3Rlcl9ibG9ja19pbnZhbGlkYXRlKCkgYXJlIG5vdCB1c2Vk
IGFueXdoZXJlIGVsc2UgYW5kIGFyZSBsb2NhbCB0bw0KPiBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaS1oeXBlcnYuYywNCj4gYW5kIGRvIG5vdCBuZWVkIHRvIGJlIGluIGdsb2JhbCBzY29wZSwg
c28gbWFrZSB0aGVzZSBzdGF0aWMuDQo+IA0KPiBSZXNvbHZlIGZvbGxvd2luZyBjb21waWxlciB3
YXJuaW5nIHRoYXQgY2FuIGJlIHNlZW4gd2hlbiBidWlsZGluZyB3aXRoDQo+IHdhcm5pbmdzIGVu
YWJsZWQgKFc9MSk6DQo+IA0KPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYzo5
MzM6NTogd2FybmluZzoNCj4gIG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYaHZfcmVhZF9j
b25maWdfYmxvY2vigJkNCj4gICBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+IA0KPiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYzoxMDEzOjU6IHdhcm5pbmc6DQo+ICBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmGh2X3dyaXRlX2NvbmZpZ19ibG9ja+KAmQ0KPiAgIFstV21p
c3NpbmctcHJvdG90eXBlc10NCj4gDQo+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVy
di5jOjEwODI6NTogd2FybmluZzoNCj4gIG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYaHZf
cmVnaXN0ZXJfYmxvY2tfaW52YWxpZGF0ZeKAmQ0KPiAgIFstV21pc3NpbmctcHJvdG90eXBlc10N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBXaWxjenluc2tpIDxrd0BsaW51eC5jb20+
DQoNClJldmlld2VkLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0K
DQpUaGFua3MhDQo=
