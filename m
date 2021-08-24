Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2693F671F
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHXRbE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 13:31:04 -0400
Received: from mail-centralus02namln2014.outbound.protection.outlook.com ([40.93.8.14]:3413
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240886AbhHXR2z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 13:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoA08Zmx8Z+Oh2c/YabCbZrcHkA20mSl3kSfcIHR99rwxSWRE3kf6wTwU0DU00qCXoNp1YrK+ZogMJiTkZRrcql4/eR0GsDHzP0DAecSvRQBIsCSEn0KEC+lNRFQtHMe9QKMnqp9HuNsAZlpstnUeAshe/S7UNlZx1yC8LxANOa0DoglcyXW4+LDXCX+tv5xWm+aI4Tf+yvhp+T6CtMoiJR00gsSdOy4/RhmQK9sqMKYHi71xuLsp/1Z8/PMH2cEeBHLfSv67U31BHx8+/JTyeIZ1YpucAsL3N36ky88KGM2nvgF1zLnFfWbkkvtqE4zLrI1WxvWQ9fCmMZn0kTLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH68eenytSC4P3pggSwBCgCbmE3Q4uwM9iG/rCwfDjs=;
 b=bPH3LfD/dLx9BTdSrqdCHXA3Z66Bb4F+4xEdeijHrtao4T3SB7G5fwruaTjg1vlEU8i286uXToFq7kL6Lv8TQwj/cBi5TWHY5yh1hg70T7fdq4qbj9G2CEIlYN7bt4eX9bxMrUAxpa14+XNGki867qJaGKsIR8Jc88lASA6Z73CXkWAGY71xVkGvNG+Mi8OmIUbHktHbkbFx1GsdkWOkRcDk4UcqDXQikLzui9r3au6fw+mxwMc9ww7esiWCkVN55sVUu0U6HK6sf4vxNvZr3TXX8vdv4CJmhBe3CYzAmw/zU1YYenHk3b2TD2eD+XEYKoS7qqoCZK/bUQD9UbY/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH68eenytSC4P3pggSwBCgCbmE3Q4uwM9iG/rCwfDjs=;
 b=Pck/XxdstJLwbFWWw96ttr4ir3ScZ9XWN7Ny3M8Z9lMISvxhIqKq2FDmczKp1m6DKCkJUcwA4F3/WByVsCw4lc1Js80H+HDqSN6U4DFMr5tRzFcM935Ng5AnjpSEdkaEAywDCtt6QU9LJw7jF1fnlD/R+dmg38+0VLr2kSTUu9A=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1160.namprd21.prod.outlook.com (2603:10b6:a03:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9; Tue, 24 Aug
 2021 17:28:07 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4436.016; Tue, 24 Aug 2021
 17:28:07 +0000
From:   Long Li <longli@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiDgHJZXiucJEOu37Y9ArQK+auCfYUAgABrnzA=
Date:   Tue, 24 Aug 2021 17:28:07 +0000
Message-ID: <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
In-Reply-To: <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8eb6a14f-f3c0-4df9-987b-c38e40597571;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T17:27:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9550b0d3-6dc4-4b95-1e13-08d967248975
x-ms-traffictypediagnostic: BYAPR21MB1160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1160230CE57D55C7E14D359FCEC59@BYAPR21MB1160.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpcrsb47ocqr7XpOC7mTkvHCvt4tQPYYlWRmEzr3jztYSm12KXWoreFiytT6Wcd22He40UiaqCAluTWUYeYmgmi+S24tcUjoYMPOr2PQ5mjqbqtem0aUsW/xz/fVYxV6UkbDYXHq98EJtq21sBe6Wbp49wr6r64iFcEpQmx/ph6Y+VfVRPCFUGaarjMcZDDDnT4Ft9mGYntZIyAopZIFWGdoKlmQ0RCS5okXEZDW1r8FNyLCdCQMzhBrPJCjKlhgYt6bvNivngyQp6y2hnXATJIe7hC3DtqWS/SBgDSMasCq4Orz0Iel0H+yH2ODMRDNgDdbKtKSf5r7Oqn8SCUmnrgSH+cx8xDp8rP3tYL2AyultMkKKlkd8f13kKm1+sRPIAQ+k7JSwWoAdejxRRxB7aGD3DKxkTCrauz68Ew9lsfuAIPxi1Z/26XC++qy2HzQXA8eKg7CFGvxFhh7Lff9zojEh16grSKy91jcP0GwOBgrgDNVS3Qcn5DCtijw50mRQcH9VFGJflDaR+u+fAG1bDxKG4v4hciEM7YhEdSr3LQFuX1EdaTgdDUO4ZgxT38y6qEm853l4hARlethmKyXltHj8aDtKWckP8Xp9ENNndO3YsnTXZ0i//HYTcXYPGcHT58RLKZXD5MbVyVDGles6LCSsMfB70MqvfdWLhtg5z2ds9Ky5HVgcpGAxGPgH674I7R4DC2OPPqwUhC31M/zQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(316002)(7416002)(82950400001)(82960400001)(26005)(83380400001)(66476007)(8936002)(8676002)(8990500004)(66446008)(64756008)(66556008)(66946007)(66574015)(9686003)(186003)(6506007)(7696005)(110136005)(508600001)(76116006)(5660300002)(38070700005)(55016002)(4326008)(10290500003)(122000001)(38100700002)(52536014)(54906003)(33656002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzhtczNiZ1dwS1Z0cGZPdDY2aFEzNmNmdklDNENQL2RYRzZjNld3alRYMytn?=
 =?utf-8?B?b3F3U2F6a0ZMMFdwZVhsZjNEeXdPOThkalZEZSsxeHNodEhmcEVLT2d4RVRL?=
 =?utf-8?B?ZkpHREc4Ym1melVYeDJrT29JRmRoV3Vyd0pzN0JEUFlLSDBvaE9hbWJHU3Yw?=
 =?utf-8?B?NHZLRXZOcWlmR2M2NlkwaTJEUVBDVmo1cmFzemEwVXhnbTFSVVhQc0ZTVUhR?=
 =?utf-8?B?bFg3aHdma3JBTW9RQ3cxWk56UGs1aEsxT0ZUVnpaVXlBU1dHTVpoQXdpdndN?=
 =?utf-8?B?b1NqS1JrTFpJeURkMHdtU1I3MzkxaEFtM2IvdjlHZkRBSUVhMWw2NkR6Vyt0?=
 =?utf-8?B?c3VuRXM3RERXK08rakJvZ1UxcmZXRW1VQ0NRN1gyeklSODcvd3ZYMHMvWS82?=
 =?utf-8?B?NVF1Y1hWZXFiUmFZTytlRWhRTm96U0l1K09rSFhMblpQc1JXaUlrT3RZa2Fy?=
 =?utf-8?B?OXlDNmZvcHg5b3FsQXF4eVV1S1VURFVBRkgvZXJkSjBmMnBTdURjVVVxL1o5?=
 =?utf-8?B?TlhueE16ckJWd05sK3RYSnhRaXhhQVpVaGV5SVNZYUNTdDEwNmE2T1JEeGtJ?=
 =?utf-8?B?KzBSdmJmZDJhVDF6Zk56WHB5dDVuVERjQThSUXl6NFZvSFpidCtzbzlXK0o3?=
 =?utf-8?B?dXV2SjZTWmFSa3Qwa1RqRTZ4dGNXdGs2OERISWdYSE1STjZXNm8xZlpQc3I5?=
 =?utf-8?B?M1hlZzZXVUtiL0htdnM0Ni85Q1JlR2c2UHU0VTZ2V1dkbmsvZStjS1ZWUkEw?=
 =?utf-8?B?RURNOHZ3RmwrNE5Yd0tnbm1SSk1Ia1RXdGVIQWNPTTFkZDBrc1lKZU1VNVNy?=
 =?utf-8?B?Z3Ixd2IzYjh3b3RHU3Q5MEkxVnovbFI4TVhseklZYkY5MHpUZlFrQzRMZW9S?=
 =?utf-8?B?YmZKcXlFdkFhbHBHS3c0d1cxUGFXcDZkb3FJbFFSUDVjSUE3c2tVdmxIWFNJ?=
 =?utf-8?B?UzZnT1o2ZlM0YUxUcHRBbktValg5Q1BZOE9Yb0NZTGJzaFVwKzlqak05c1ZS?=
 =?utf-8?B?UmFXV3k0SUloYUJBaVYvUFFhdnNuYWk1ZEZCbU5nOEFLODcvVGV0Smt0MGRR?=
 =?utf-8?B?cmZEMkhqQ1B0bXM1L0crUE4vY0x1RFR0ay8wcTJucHJRTnBvWE5Kb085R0tZ?=
 =?utf-8?B?WU0zeU5LRTlrQ2o1V0g0WFJ3SzRzaGJ4NTRwMm5sc09sSDRhbTdSY3RnaWZh?=
 =?utf-8?B?empQZkRQYzFWR0llNzk0VWwyZTZEMm9wVVEwWENwNUQrSzB1ZGN3T00randr?=
 =?utf-8?B?ckpuMFJCSVJuYjE4SmV5Y1luUmt6K244YW5sM2dCdWo3MlpSbXVoOTRoSjdD?=
 =?utf-8?B?TkVENnpuM2NiTTc0RzVCbnY3cW5SKzN6UklFVUhQbjdOdUZZSEtjb2ViNVlK?=
 =?utf-8?B?ZkwvMGtJaEQzQXNNOXk2TE93RDJxMHBacnk4M1pMdzZrMnBKVlYxb3Q0ckho?=
 =?utf-8?B?VlY2UW5kd3NYTVNaSnliN2duekZxdTF1Z28xTTFMVVh5Qkx5cGZoRXBxUkdE?=
 =?utf-8?B?LzdiZVNMVVFBWVJZTVRjRXBYZE9KM1ZaNzdPcXplWXRONkVzS3JPN1lsOFow?=
 =?utf-8?B?Vytvb24zaGRMSWo5TG1EUVBQdjMzb3FCQ2gxNzNnc3ZiVkpQT0FmcG9nTVFD?=
 =?utf-8?B?RGh5Q1Y3azV3YU9nMDFOMEp5bFBDZnNNQjhXdkZ2QWFPS2x1Zlk0VjF1SHh2?=
 =?utf-8?B?RnFPVEphMlVVMUVJdVUxa2tIOG0rTDcybGM2UkJIS1VxWkhLMGNnalFFbi9M?=
 =?utf-8?Q?yjGsH0WrTbKWUpsmRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9550b0d3-6dc4-4b95-1e13-08d967248975
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 17:28:07.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJ8d6gabdK3NV3qKMk4386bC38KeBPvTeoqqnmSeiv7+5vRSyJ2qnXKF17NxP5IZFXDAQ5w36C1DWf6hp/taKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1160
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGh2OiBGaXggYSBidWcgb24gcmVtb3ZpbmcgY2hp
bGQgZGV2aWNlcyBvbiB0aGUgYnVzDQo+IA0KPiBPbiBUdWUsIEF1ZyAyNCwgMjAyMSBhdCAxMjoy
MDoyMEFNIC0wNzAwLCBsb25nbGlAbGludXhvbmh5cGVydi5jb20gd3JvdGU6DQo+ID4gRnJvbTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBJbiBodl9wY2lfYnVzX2V4
aXQsIHRoZSBjb2RlIGlzIGhvbGRpbmcgYSBzcGlubG9jayB3aGlsZSBjYWxsaW5nDQo+ID4gcGNp
X2Rlc3Ryb3lfc2xvdCgpLCB3aGljaCB0YWtlcyBhIG11dGV4Lg0KPiA+DQo+ID4gVGhpcyBpcyBu
b3Qgc2FmZSBmb3Igc3BpbmxvY2suIEZpeCB0aGlzIGJ5IG1vdmluZyB0aGUgY2hpbGRyZW4gdG8g
YmUNCj4gPiBkZWxldGVkIHRvIGEgbGlzdCBvbiB0aGUgc3RhY2ssIGFuZCByZW1vdmluZyB0aGVt
IGFmdGVyIHNwaW5sb2NrIGlzDQo+ID4gcmVsZWFzZWQuDQo+ID4NCj4gPiBGaXhlczogOTRkMjI3
NjMyMDdhICgiUENJOiBodjogRml4IGEgcmFjZSBjb25kaXRpb24gd2hlbiByZW1vdmluZyB0aGUN
Cj4gPiBkZXZpY2UiKQ0KPiA+DQo+ID4gQ2M6ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jv
c29mdC5jb20+DQo+ID4gQ2M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+
DQo+ID4gQ2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPg0KPiA+
IENjOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IERleHVhbiBDdWkgPGRl
Y3VpQG1pY3Jvc29mdC5jb20+DQo+ID4gQ2M6IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tPg0KPiA+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiA+IENjOiAiS3J6eXN6dG9mIFdpbGN6ecWEc2tpIiA8a3dAbGludXguY29tPg0KPiA+IENjOiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+IENjOiBNaWNoYWVsIEtlbGxl
eSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gPiBDYzogRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBvcmFjbGUuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQG9yYWNsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS1oeXBlcnYuYw0KPiA+IGluZGV4IGE1M2JkODcyOGQwZC4uZDRmM2NjZTE4OTU3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gPiBAQCAtMzIyMCw2
ICszMjIwLDcgQEAgc3RhdGljIGludCBodl9wY2lfYnVzX2V4aXQoc3RydWN0IGh2X2RldmljZSAq
aGRldiwNCj4gYm9vbCBrZWVwX2RldnMpDQo+ID4gIAlzdHJ1Y3QgaHZfcGNpX2RldiAqaHBkZXYs
ICp0bXA7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAJaW50IHJldDsNCj4gPiAr
CXN0cnVjdCBsaXN0X2hlYWQgcmVtb3ZlZDsNCj4gDQo+IFRoaXMgY2FuIGJlIG1vdmVkIHRvIHdo
ZXJlIGl0IGlzIG5lZWRlZCAtLSB0aGUgaWYoIWtlZXBfZGV2KSBicmFuY2ggLS0gdG8gbGltaXQg
aXRzDQo+IHNjb3BlLg0KPiANCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAqIEFmdGVyIHRoZSBob3N0
IHNlbmRzIHRoZSBSRVNDSU5EX0NIQU5ORUwgbWVzc2FnZSwgaXQgZG9lc24ndCBAQA0KPiA+IC0z
MjI5LDkgKzMyMzAsMTggQEAgc3RhdGljIGludCBodl9wY2lfYnVzX2V4aXQoc3RydWN0IGh2X2Rl
dmljZSAqaGRldiwgYm9vbA0KPiBrZWVwX2RldnMpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4g
PiAgCWlmICgha2VlcF9kZXZzKSB7DQo+ID4gLQkJLyogRGVsZXRlIGFueSBjaGlsZHJlbiB3aGlj
aCBtaWdodCBzdGlsbCBleGlzdC4gKi8NCj4gPiArCQlJTklUX0xJU1RfSEVBRCgmcmVtb3ZlZCk7
DQo+ID4gKw0KPiA+ICsJCS8qIE1vdmUgYWxsIHByZXNlbnQgY2hpbGRyZW4gdG8gdGhlIGxpc3Qg
b24gc3RhY2sgKi8NCj4gPiAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmaGJ1cy0+ZGV2aWNlX2xpc3Rf
bG9jaywgZmxhZ3MpOw0KPiA+IC0JCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShocGRldiwgdG1w
LCAmaGJ1cy0+Y2hpbGRyZW4sDQo+IGxpc3RfZW50cnkpIHsNCj4gPiArCQlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUoaHBkZXYsIHRtcCwgJmhidXMtPmNoaWxkcmVuLA0KPiBsaXN0X2VudHJ5KQ0K
PiA+ICsJCQlsaXN0X21vdmVfdGFpbCgmaHBkZXYtPmxpc3RfZW50cnksICZyZW1vdmVkKTsNCj4g
PiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoYnVzLT5kZXZpY2VfbGlzdF9sb2NrLCBmbGFn
cyk7DQo+ID4gKw0KPiA+ICsJCS8qIFJlbW92ZSBhbGwgY2hpbGRyZW4gaW4gdGhlIGxpc3QgKi8N
Cj4gPiArCQl3aGlsZSAoIWxpc3RfZW1wdHkoJnJlbW92ZWQpKSB7DQo+ID4gKwkJCWhwZGV2ID0g
bGlzdF9maXJzdF9lbnRyeSgmcmVtb3ZlZCwgc3RydWN0IGh2X3BjaV9kZXYsDQo+ID4gKwkJCQkJ
CSBsaXN0X2VudHJ5KTsNCj4gDQo+IGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSBjYW4gYWxzbyBi
ZSB1c2VkIGhlcmUsIHJpZ2h0Pw0KPiANCj4gV2VpLg0KDQpJIHdpbGwgYWRkcmVzcyB5b3VyIGNv
bW1lbnRzLg0KDQpMb25nDQoNCj4gDQo+ID4gIAkJCWxpc3RfZGVsKCZocGRldi0+bGlzdF9lbnRy
eSk7DQo+ID4gIAkJCWlmIChocGRldi0+cGNpX3Nsb3QpDQo+ID4gIAkJCQlwY2lfZGVzdHJveV9z
bG90KGhwZGV2LT5wY2lfc2xvdCk7DQo+ID4gQEAgLTMyMzksNyArMzI0OSw2IEBAIHN0YXRpYyBp
bnQgaHZfcGNpX2J1c19leGl0KHN0cnVjdCBodl9kZXZpY2UgKmhkZXYsDQo+IGJvb2wga2VlcF9k
ZXZzKQ0KPiA+ICAJCQlwdXRfcGNpY2hpbGQoaHBkZXYpOw0KPiA+ICAJCQlwdXRfcGNpY2hpbGQo
aHBkZXYpOw0KPiA+ICAJCX0NCj4gPiAtCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoYnVzLT5k
ZXZpY2VfbGlzdF9sb2NrLCBmbGFncyk7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCXJldCA9IGh2X3Nl
bmRfcmVzb3VyY2VzX3JlbGVhc2VkKGhkZXYpOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
