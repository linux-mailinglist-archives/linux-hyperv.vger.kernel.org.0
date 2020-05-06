Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB781C7362
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2020 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgEFOzV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 May 2020 10:55:21 -0400
Received: from mail-mw2nam12on2134.outbound.protection.outlook.com ([40.107.244.134]:8417
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729078AbgEFOzV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 10:55:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXHqqxaH6ZfxRADm83kAwBvTeWP1vYRrtEwru3LgdiS77TLANUlOcQ3WoFwEXJ9Rz4HVbZo8JRivlVNRM3czR0TASb2IQk6n0SBJUTuVDbvVzjp3XAvGLdhLQiqDv+afkTLzRk1t9OA8tysMU5Y+wIKq/LUEEX1tVAyzrpP0vpZ7d4mQX4XqbmrWH0d81tA7xPcfT6m0Vg0BN5uFwxUOKdGIBcr1NzYdbf6sJTN09sfCV/QYmLT2CKcYPGSfKWpN7qozeD3/Rwul8v1aWPXC08H3IVSGfN6mbY+Ld/PjoKsGrT1O0xdgLXz5bA6KTkw8ykEcDp6IjIZWM4GMmrN1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqwQ8BbzQwgPpbD/Ya5zBnjkVn6zMrsBhBGAo3r1qMk=;
 b=YuRGmEgTufT/W0yNocant5TLFwyzLQW/u5Qz2wtHkGG2hcCweKroVWbxn8NbDdrfjn+KturVp1xTxKREONxuEAIi828mF0ibqaCHy7/IbMm3t3Cme9asvOs0500mjdVHgYCdJyg1yhYwhIaDoURo0TtVqT7NHsslau2t+C6iKiotjlRd+wNPOB0N9huXdtOYMBium3uYqYz5wUZVEofeOWHhACdlNdYF/u44jGPrEriUQaspDqmJ+oQGj/5+G/BDD4mGNXIaEc3DsR8Oir/m7BzeY81D1HqiALfuHC1HBsFnqmtZ5TLcY8UTKJHuCsKEXhn3PoREOL1rtg2TRiyhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqwQ8BbzQwgPpbD/Ya5zBnjkVn6zMrsBhBGAo3r1qMk=;
 b=BJ7OS9iRY/SIGQa1fNQRvvo9VcrBUOYuZ68VdTY7vV4McoVh9unhxW9GSf/iOlecfvqzsjip6YIFNvsjpyE7gX91Qv8qn3Hcm49V2TKcSwnjx0hSm9c5QbA8UwBWJwEY/QixDPTqx0/zXiongVzPDpDQ5mYLb38Ifj8GRn/3Y6M=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0889.namprd21.prod.outlook.com (2603:10b6:302:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Wed, 6 May
 2020 14:55:17 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Wed, 6 May 2020
 14:55:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Topic: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Index: AQHWH3qC9OKP6NPAT0GaOvO53wpTCqiZnaWAgAD0DwCAAF0CgIAAJNkAgAAXKMA=
Date:   Wed, 6 May 2020 14:55:17 +0000
Message-ID: <MW2PR2101MB1052F033623F91A0FF991DE4D7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200501053617.24689-1-weh@microsoft.com>
 <20200505150315.GA16228@e121166-lin.cambridge.arm.com>
 <SG2P153MB02136EA9764D340F3D81DF2DBBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
 <20200506110930.GA31068@e121166-lin.cambridge.arm.com>
 <SG2P153MB0213216D3C150AA4758FCBB8BBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0213216D3C150AA4758FCBB8BBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-06T13:21:31.0626998Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d44992dc-f522-438b-bf8e-b8ba39ee1998;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaa35743-703f-40fb-2590-08d7f1cd7de2
x-ms-traffictypediagnostic: MW2PR2101MB0889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0889AF9829C86A8F29090AD8D7A40@MW2PR2101MB0889.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkKRsd0UwJnr/IZ1t4HVmflMaPcbKmmFPaoMImkqZJ7f3Dthepo8cs+nHIqzQ/NQRC7taBgLg1axnxGMU2bnjdZ2jCQnP70cW7ReV3RCYBKsJ0f21PADn/ATM/47RVSYb8rUU21bbuuYtDmgeKzKxKjnf6wCNozQzcwHHCGeayQrSOCmb9SOIZuiKiKdqaaoDXMAIGfsNnFI+dMUVz5pdbtd23w5i2iyOJJI+QHu5ft1d1w7QPq2mdXbQnUXyOzsmZtM5aTYTAj3Bxt57QDCR7L0ov7PVt+druPSaPY21yoQuDMmtLZe6IuidvCXvAik3eKUXg0pLSM8uRdqeEVr9bLEpS7WvpDP+2t1kfjnQ1ZptvdCsV8BWnBCMJnh+9TR2oLJOXRvw5FriaPrsvbW+7n0vbIdPJ7RreAIf5s9H1di3MImKLHvRCh055WrrNGZfaiNR33c1i2PLkI6IQHGYQgHe66/EwX7V9gSGucYSnbcSkJZ9zx6fOv2ZQ1se/ZjbvHWtxHTSkDAVN3gEEk9dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(33430700001)(5660300002)(2906002)(186003)(52536014)(7696005)(82950400001)(82960400001)(66946007)(110136005)(9686003)(54906003)(64756008)(66476007)(76116006)(71200400001)(8936002)(66446008)(8676002)(66556008)(86362001)(316002)(33656002)(55016002)(10290500003)(478600001)(8990500004)(107886003)(4326008)(53546011)(6506007)(33440700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sw212kwtl5+HR5+3Y/L5k7Myjb/sOrS2Qrt8OCMSzZvVZd8qJ830SuWCv9uvTOSNUeXMIYbSLddCDdzX9R5AlLKliqoTGkgmLM4aPkwqm8piQOtzfcNucVnvTQCyJg5QznN57D3KXUiXXJsrp3fWbikb8FHJuUEypyPmpXjdRVWzCuxB3z5IQStQOdHkEKmnkTv2jnuCBkEye/HaGyekpHpUOcWMf1BJQ9hWfQ1b1WoYy5nnN0p6V3NiJZ+E2HhOEza3iV+0k2ZnqLtHhYDuF/beJyyzIlycCfJncoYvbu63aPG7OegQtpKUiw0gYKQbFyxvcfUf+UD8tWcjHXep4PjvSgnxzEAU3ZlDBDIyLUJhZ96VfuOMPFmEdmiBWdLiu9JeSR6Mjv6HEHJ74P2O9Q8E0Z2627j9EFvAy2nNzqZONQg5z6sNTwqbADVk3Sndyxvnjc/X5Qsde3TzrPyE9SJAiISG/c/ubJgyWDNisDnpbJaLSQzPEKYFqRrizB/0aWZXP132GtP6jQ114UByhvcp68JoPpbX4QnYvsF+JwIvKttTvruApuLNLkkgKGOAJDaI8eNwZrLoBBp+/hqzhls0QP4InbtEGIgCs9y4xPi6hL6swK+HOezTrt8UASOc67yAK99wEHqxRMwZC5ZrPbFGA/9wAoR8ISWlptxDJSQRxGSlGJ6jmgbXfvEEwah0bTv/SqxnUUFdEUdl8KSSFXqVQDVXzzs1cxZR08fNPqCzQy4Xm2hvqbBX8N3dQCH+u2A5PPZcB2x63wVHyhCr3QTJ/GYzruHPO1+KT7llU+I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa35743-703f-40fb-2590-08d7f1cd7de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 14:55:17.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aukWFOhV02K6p/EUm3Ir0RHt73LaBkf77l8XwcW5RPd2uXgNWQkEASw+EESB9woG7WOwiGp1CW/jXT+lYXFgaIH0DpgWCOP0A+egcvdhzLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0889
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT4gIFNlbnQ6IFdlZG5lc2RheSwgTWF5IDYs
IDIwMjAgNjoyMiBBTQ0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
TG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+DQo+ID4gU2VudDog
V2VkbmVzZGF5LCBNYXkgNiwgMjAyMCA3OjEwIFBNDQo+ID4gVG86IFdlaSBIdSA8d2VoQG1pY3Jv
c29mdC5jb20+DQo+ID4gQ2M6IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFp
eWFuZyBaaGFuZw0KPiA+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgU3RlcGhlbiBIZW1taW5n
ZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+Ow0KPiA+IHdlaS5saXVAa2VybmVsLm9yZzsgcm9i
aEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC0NCj4gPiBoeXBlcnZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgTWlj
aGFlbCBLZWxsZXkNCj4gPiA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEvMl0gUENJOiBodjogRml4IHRoZSBQQ0kgSHlwZXJWIHByb2JlIGZhaWx1
cmUgcGF0aCB0bw0KPiA+IHJlbGVhc2UgcmVzb3VyY2UgcHJvcGVybHkNCj4gPg0KPiA+IE9uIFdl
ZCwgTWF5IDA2LCAyMDIwIGF0IDA1OjM2OjQ2QU0gKzAwMDAsIFdlaSBIdSB3cm90ZToNCj4gPiA+
IEhpIExvcmVuem8sDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4gUGxlYXNl
IHNlZSBteSBjb21tZW50cyBpbmxpbmUuDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbT4NCj4gPiA+ID4gU2VudDogVHVlc2RheSwgTWF5IDUsIDIwMjAgMTE6MDMg
UE0NCj4gPiA+ID4gVG86IFdlaSBIdSA8d2VoQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IENjOiBL
WSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcNCj4gPiA+ID4g
PGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA+ID4gPiA8c3Ro
ZW1taW5AbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiA+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC0gaHlwZXJ2QHZnZXIua2VybmVs
Lm9yZzsNCj4gPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtIGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IERleHVhbiBDdWkNCj4gPiA+ID4gPGRlY3VpQG1pY3Jvc29mdC5jb20+
OyBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAxLzJdIFBDSTogaHY6IEZpeCB0aGUgUENJIEh5cGVyViBwcm9iZQ0K
PiA+ID4gPiBmYWlsdXJlIHBhdGggdG8gcmVsZWFzZSByZXNvdXJjZSBwcm9wZXJseQ0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBGcmksIE1heSAwMSwgMjAyMCBhdCAwMTozNjoxN1BNICswODAwLCBXZWkg
SHUgd3JvdGU6DQo+ID4gPiA+ID4gU29tZSBlcnJvciBjYXNlcyBpbiBodl9wY2lfcHJvYmUoKSB3
ZXJlIG5vdCBoYW5kbGVkLiBGaXggdGhlc2UNCj4gPiA+ID4gPiBlcnJvciBwYXRocyB0byByZWxl
YXNlIHRoZSByZXNvdXJzZXMgYW5kIGNsZWFuIHVwIHRoZSBzdGF0ZSBwcm9wZXJseS4NCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBkb2VzIG1vcmUgdGhhbiB0aGF0LiBJdCBhZGRzIGEgdmFy
aWFibGUgdG8gc3RvcmUgdGhlDQo+ID4gPiA+IG51bWJlciBvZiBzbG90cyBhY3R1YWxseSBhbGxv
Y2F0ZWQgLSBJIHByZXN1bWUgdG8gZnJlZSBvbmx5IGFsbG9jYXRlZCBvbiBzbG90cw0KPiA+IG9u
IHRoZSBleGl0IHBhdGguDQo+ID4gPiA+DQo+ID4gPiA+IFR3byBwYXRjaGVzIHJlcXVpcmVkIEkg
YW0gYWZyYWlkLg0KPiA+ID4NCj4gPiA+IFdlbGwsIGFkZGluZyB0aGlzIHZhcmlhYmxlIGlzIG5l
ZWRlZCB0byBtYWtlIHRoZSBjYWxsIG9mICIodm9pZCkNCj4gPiBodl9wY2lfYnVzX2V4aXQoaGRl
diwgdHJ1ZSkiDQo+ID4NCj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IC0gaXQgaXMgbm90IGNs
ZWFyIGZyb20gdGhlIGNvbW1pdCBsb2cgYW5kIHRoZSBjb2RlLA0KPiA+IHBsZWFzZSBleHBsYWlu
IGl0IHNpbmNlIGl0IGlzIG5vdCBvYnZpb3VzLg0KPiA+DQo+IEh2X3BjaV9idXNfZXhpdCgpIGNh
bGxzIGh2X3NlbmRfcmVzb3VyY2VzX3JlbGVhc2VkKCkgdG8gcmVsZWFzZSBhbGwgY2hpbGQgcmVz
b3VyY2VzLg0KPiBUaGVzZSBjaGlsZCByZXNvdXJjZXMgd2VyZSBhbGxvY2F0ZWQgaW4gaHZfc2Vu
ZF9yZXNvdXJjZXNfYWxsb2NhdGVkKCkuDQo+IEh2X3NlbmRfcmVzb3VyY2VzX2FsbG9jYXRlZCgp
IGNvdWxkIGZhaWwgaW4gdGhlIG1pZGRsZSwgbGVhdmluZyBzb21lIGNoaWxkIHJlc291cmNlcw0K
PiBhbGxvY2F0ZWQgYW5kIHJlc3Qgbm90LiBXaXRob3V0IGFkZGluZyB0aGlzIHZhcmlhYmxlIHRv
IHJlY29yZCB0aGUgaGlnaGVzdCBzbG90IG51bWJlciB0aGF0DQo+IHJlc291cmNlIGhhcyBiZWVu
IHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQsIGNhbGxpbmcgaHZfc2VuZF9yZXNvdXJjZXNfcmVsZWFz
ZWQoKSBjb3VsZA0KPiBjYXVzZSBzcHVyaW91cyByZXNvdXJjZSByZWxlYXNlIHJlcXVlc3RzIGJl
aW5nIHNlbnQgdG8gaHlwZXJ2aXNvci4NCj4gDQo+IFRoaXMgaGFkIGJlZW4gZmluZSBzaW5jZSBo
dl9wY2lfYnVzX2V4aXQoKSB3YXMgbmV2ZXIgY2FsbGVkIGluIGVycm9yIHBhdGggYmVmb3JlIHRo
aXMgcGF0Y2gNCj4gd2FzDQo+IGludHJvZHVjZWQuIFRvIGFkZCB0aGlzIGNhbGwgdG8gY2xlYW4g
dGhlIHBjaSBzdGF0ZSBpbiB0aGUgZXJyb3IgcGF0aCwgd2UgbmVlZCB0byBrbm93IHRoZQ0KPiBz
dGFydGluZw0KPiBwb2ludCBpbiBjaGlsZCBkZXZpY2UgdGhhdCByZXNvdXJjZSBoYXMgbm90IGJl
ZW4gYWxsb2NhdGVkLiBIZW5jZSB0aGlzIHZhcmlhYmxlDQo+IGlzIHVzZWQgaW4gaHZfc2VuZF9y
ZXNvdXJjZXNfYWxsb2NhdGVkKCkgdG8gcmVjb3JkIHRoaXMgcG9pbnQgYW5kIGluDQo+IGh2X3Nl
bmRfcmVzb3VyY2VfcmVsZWFzZWQoKSB0byBzdGFydCBkZWFsbG9jYXRpbmcgY2hpbGQgcmVzb3Vy
Y2VzLg0KPiANCj4gSSBjYW4gYWRkIHRvIHRoZSBjb21taXQgbG9nIGlmIHlvdSBhcmUgZmluZSB3
aXRoIHRoaXMgZXhwbGFuYXRpb24uDQo+IA0KDQpGV0lXLCBJIHRoaW5rIG9mIHRoaXMgcGF0Y2gg
YXMgZm9sbG93czoNCg0KSW4gc29tZSBlcnJvciBjYXNlcyBpbiBodl9wY2lfcHJvYmUoKSwgYWxs
b2NhdGVkIHJlc291cmNlcyBhcmUgbm90DQpmcmVlZC4gIEZpeCB0aGlzIGJ5IGFkZGluZyBhIGZp
ZWxkIHRvIGtlZXAgdHJhY2sgb2YgdGhlIGhpZ2ggd2F0ZXIgbWFyaw0KZm9yIHNsb3RzIHRoYXQg
aGF2ZSByZXNvdXJjZXMgYWxsb2NhdGVkIHRvIHRoZW0uICBJbiBjYXNlIG9mIGFuIGVycm9yLCB0
aGlzDQpoaWdoIHdhdGVyIG1hcmsgaXMgdXNlZCB0byBrbm93IHdoaWNoIHNsb3RzIGhhdmUgcmVz
b3VyY2VzIHRoYXQNCm11c3QgYmUgcmVsZWFzZWQuICBTaW5jZSBzbG90cyBhcmUgbnVtYmVyZWQg
c3RhcnRpbmcgd2l0aCB6ZXJvLCBhDQp2YWx1ZSBvZiAtMSBpbmRpY2F0ZXMgbm8gc2xvdHMgaGF2
ZSBiZWVuIGFsbG9jYXRlZCByZXNvdXJjZXMuICBUaGVyZQ0KbWF5IGJlIHVudXNlZCBzbG90cyBp
biB0aGUgcmFuZ2UgYmV0d2VlbiBzbG90IDAgYW5kIHRoZSBoaWdoDQp3YXRlciBtYXJrIHNsb3Qs
IGJ1dCB0aGVzZSBzbG90cyBhcmUgYWxyZWFkeSBpZ25vcmVkIGJ5IHRoZSBleGlzdGluZyBjb2Rl
DQppbiB0aGUgYWxsb2NhdGUgYW5kIHJlbGVhc2UgbG9vcHMgd2l0aCB0aGUgY2FsbCB0byBnZXRf
cGNpY2hpbGRfd3Nsb3QoKS4NCg0KTWljaGFlbA0K
