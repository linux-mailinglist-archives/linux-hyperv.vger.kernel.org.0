Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970922A4088
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Nov 2020 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCJqX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Nov 2020 04:46:23 -0500
Received: from mail-eopbgr760109.outbound.protection.outlook.com ([40.107.76.109]:57572
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgKCJqW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Nov 2020 04:46:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0z06A7LHNjMGNVm8P88Mb8pyRjB1n+qZDaDWwvQcXQ2ftbt7ZXjZkYyd+xFNuCOuZAxbXyRjuH1ZRFW0yraZFdpWB9LhQ6dIRTo48HZxVE1k4cJKapC/LWev8MH9yCJPl8GhDyg92HDgxG2lwYQT/dWMyPIdFiXDezPnlldIdIZmrrntjigBgDoSWsAr0nk7Of0U7zXDHuaAQeeKNFGqMhAPorV7Kbtu4zhySSdRGQOy2L44QrEJIR8lkMfDFzoMRikrrLNZwANDV7wph/sRDQc3nfe5dpRFmbEJufC68D9aIcNdEaWQfNcu0ZQL4JTaluXcUbgNJmGJNjIQsQHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfzsBkwlcLb84gPQlqgg+5WOGApBK5JTn6fp8av3PGE=;
 b=HIFHj9b+rBs1bzN5uYYp0AGt7IpbXfPb1evMa0zlB2sSHokT7hb6xb5e3cSCoocGK4+7BcE6LAjhAgcfU4YKRexQtkA1PXfGpJYLMmAJfjORHBxtIEv6rZMzhi8w6qVwQ7R4DqqFdmpE20tNS6KoARutxd5K+UdxNkKp0vh8uFKapgViFgdD5qAzq/3esI2PtJo4T2hr34IIbSC9X1+sYMQdFAuQMNK1HtMknXvZf3hba2cuXGs/dbvzgOC9DTAT/qlkqIjSnJO3br6y93hnoMZHihbQDayLQF0LLLUhwbzRP8/1l2vDBpAkj4zwp3bcJPIraWg+lEDlU3uHSo1AOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfzsBkwlcLb84gPQlqgg+5WOGApBK5JTn6fp8av3PGE=;
 b=LB9/RndWfwoBrA2+sEeYEzilX3XSA92kO7oY/Nowur2hPKIGe5nS9xeof7gkHvmwKlgpv0RYV9jbVQKrMMSGrL1M75wwqpfFkPcpetP7mjr/IfVQRKKMFfD4hcWOXMUiuufNR9kI9RLXJL3xL3x5kO4biSSkm/EA63AelHfY25s=
Received: from MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21)
 by MW4PR21MB1924.namprd21.prod.outlook.com (2603:10b6:303:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Tue, 3 Nov
 2020 09:46:19 +0000
Received: from MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d]) by MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d%8]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 09:46:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Topic: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Index: AQHWsbeu4+ft06KSG0GlKPe1Plvd8Km2Jm4w
Date:   Tue, 3 Nov 2020 09:46:19 +0000
Message-ID: <MWHPR21MB1546EF053D64DEBA1A586E63BF110@MWHPR21MB1546.namprd21.prod.outlook.com>
References: <20201103011136.59108-1-decui@microsoft.com>
 <6b08181e5520355ac17da8ea376972ab82dca200.camel@infradead.org>
In-Reply-To: <6b08181e5520355ac17da8ea376972ab82dca200.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d807f655-eca4-442d-897a-90b3f68693b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-03T09:37:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:881e:8402:7b3a:208e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daaa300a-6dc5-436b-8f88-08d87fdd5117
x-ms-traffictypediagnostic: MW4PR21MB1924:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1924598A89D84D7562D06B67BF110@MW4PR21MB1924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PeltjaDENTrpehX34YL4+wruG2qPXi52Welmbm7JV+A/zyPfC2Csa/ZySXtoTLSmfzb8CTDeWF9l2OISeEDEdPWevWFqxykZ3PgstXrOVaNDF+6bzk40Nm4Il8LBQ3zsmtVpOZnDrqyQ/8gm4nYc+aXgC+v4Av+IX/rOgbCTiisvOIG1tthDtOMvr0ZjXPpO7UZKI+g8M4RldCRq6kuoZvO3DwH0CY8Jg6B68JyehVBnw/BwgCxzl3K2hAIVlX7B6UIUy1L8Mb3eN/h7BaqSc3VjQj1Pv9/0LKDLzo8IS97Vpr+9MLbq6AYNC46Yh/3cB2vyZuj9WU5CY1eL+it/glVRu39F7+qot3OlCCHGfFlyvlSRUnIXir1fU2eqWJ6Gw4dMwblbng5dLhmClIkBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1546.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(2906002)(5660300002)(71200400001)(9686003)(8936002)(186003)(52536014)(82950400001)(82960400001)(54906003)(316002)(6506007)(110136005)(55016002)(4326008)(66476007)(66446008)(64756008)(33656002)(10290500003)(7416002)(66556008)(8990500004)(7696005)(66946007)(86362001)(478600001)(966005)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RFe3BWWZpDZkPOexbEegP8Z8SuhiKD/uuHjSXKf9tR8Isp4pLus3el4fRhTMyz9dv05HE/yGuaP9adksk2075AIXkMT55DHgGd5d9sgWGASZSqeoP1NU4lXMMOPPpQQ9yKxAvryzn/UtTiyZpVhE1e1TpjPvgJyklxQhuqrq8hEUHlNobMETb+/+7t04+ssvyV1SGyrBXrro+30BiLYgP+97nnMzbOTGK3yEGJIpqOpN0bA/omPw+TRMjgp87FVkvhELsUqAky/EpCcB6hu68ttiCy9IYw5utKvLITfp27Fg9QhWywfQYiNX85q/sEs0rOopG9abu+M0FSJurO6OFmmahl5WIh4TU7vCw9WNHUhRub/SHN2vdHto4k/t2n1MCUHzNkOls4rM/3lctMhdamt18t81/U0lW4wqAkhnYVvy0qzso9YIXa3wlWveIcJWoKPLiXgBCcFwAPMaaSXKX25eFHKHkaLatL/2PdzYJLSBgEFNNSDo+MW0W5aPc8ADZIh0opnISjOU/a9X8+SYNNfjie6OyRtRo3RwqDX0GZxCi6SjJTUrTbjmaiLHN3/r340SarLgxRgE4LlxGYTnoDD4EVGeNxGmw/uhFMo5CKIV64An1+Oh7s6HQquxoMr3xZpM4IYUHc+IdStRFbEsoJ+XfsOmwpew+2CT15w9ECIff03UmSV1KehiPQBGCbK6PNIM0oOMiBuoRjjPjTMpzQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1546.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaa300a-6dc5-436b-8f88-08d87fdd5117
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 09:46:19.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pM0lo8IlGHjKoAG55mdDVp0UPKWMiEZA4UxnQCRKTUKJ2dfLt5Z+W5s18saPnVDlrbhxz3ATjDQA4zwkKgqlMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1924
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFR1
ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjAgMTI6MDMgQU0NCj4gPiArLyoNCj4gPiArICogSWYgbXNf
aHlwZXJ2X21zaV9leHRfZGVzdF9pZCgpIHJldHVybnMgdHJ1ZSwNCj4gPiBoeXBlcnZfcHJlcGFy
ZV9pcnFfcmVtYXBwaW5nKCkNCj4gPiArICogcmV0dXJucyAtRU5PREVWIGFuZCB0aGUgSHlwZXIt
ViBJT01NVSBkcml2ZXIgaXMgbm90IHVzZWQ7IGluc3RlYWQsIHRoZQ0KPiA+ICsgKiBnZW5lcmlj
IHN1cHBvcnQgb2YgdGhlIDE1LWJpdCBBUElDIElEIGlzIHVzZWQ6IHNlZQ0KPiA+IF9faXJxX21z
aV9jb21wb3NlX21zZygpLg0KPiA+ICsgKg0KPiA+ICsgKiBOb3RlOiBGb3IgYSBWTSBvbiBIeXBl
ci1WLCBubyBlbXVsYXRlZCBsZWdhY3kgZGV2aWNlIHN1cHBvcnRzIFBDSQ0KPiBNU0kvTVNJLVgs
DQo+ID4gKyAqIGFuZCBQQ0kgTVNJL01TSS1YIG9ubHkgY29tZSBmcm9tIHRoZSBhc3NpZ25lZCBw
aHlzaWNhbCBQQ0llIGRldmljZSwgYW5kDQo+IHRoZQ0KPiA+ICsgKiBQQ0kgTVNJL01TSS1YIGlu
dGVycnVwdHMgYXJlIGhhbmRsZWQgYnkgdGhlIHBjaS1oeXBlcnYgZHJpdmVyLiBIZXJlDQo+IGRl
c3BpdGUNCj4gPiArICogdGhlIHdvcmQgIm1zaSIgaW4gdGhlIG5hbWUgIm1zaV9leHRfZGVzdF9p
ZCIsIGFjdHVhbGx5IHRoZSBjYWxsYmFjayBvbmx5DQo+ID4gKyAqIGFmZmVjdHMgaG93IElPQVBJ
QyBpbnRlcnJ1cHRzIGFyZSByb3V0ZWQuDQo+ID4gKyAqLw0KPiANCj4gSSBuYW1lZCBpdCBsaWtl
IHRoYXQgb24gcHVycG9zZSB0byBtYWtlIHRoZSBwb2ludCB0aGF0IHRoZSBJL09BUElDIGlzDQo+
IGp1c3QgYSBkZXZpY2UgZm9yIHR1cm5pbmcgbGluZSBpbnRlcnJ1cHRzIGludG8gTVNJcy4gU29t
ZSBWTU1zLCBqdXN0DQo+IGxpa2UgcmVhbCBoYXJkd2FyZSwgcmVhbGx5IGRvIGltcGxlbWVudCB0
aGVpciBJL09BUElDIGVtdWxhdGlvbiB0aGF0DQo+IHdheS4gSXQgbWFrZXMgYSBsb3Qgb2Ygc2Vu
c2UgdG8gZG8gc28gaWYgeW91IHN1cHBvcnQgaW50ZXJydXB0DQo+IHJlbWFwcGluZy4NCg0KSSB0
b3RhbGx5IGFncmVlLg0KIA0KPiBGV0lXIEkgbWlnaHQgaGF2ZSBwaHJhc2VkIHlvdXIgbGFzdCBw
YXJhZ3JhcGggaW4gdGhhdCBjb21tZW50IGFzDQo+IA0KPiAgIE5vdGU6IGZvciBhIFZNIG9uIEh5
cGVyLVYsIHRoZSBJL09BUElDIGlzIHRoZSBvbmx5IGRldmljZSB3aGljaA0KPiAgIChsb2dpY2Fs
bHkpIGdlbmVyYXRlcyBNU0lzIGRpcmVjdGx5IHRvIHRoZSBzeXN0ZW0gQVBJQyBpcnEgZG9tYWlu
Lg0KPiAgIFRoZXJlIGlzIG5vIEhQRVQsIGFuZCBQQ0kgTVNJL01TSS1YIGludGVycnVwdHMgYXJl
IHJlbWFwcGVkIGJ5IHRoZQ0KPiAgIHBjaS1oeXBlcnYgaG9zdCBicmlkZ2UuDQoNCkkgYWdyZWUu
IFRoaXMgdmVyc2lvbiBpcyBtdWNoIGJldHRlci4NCiANCj4gQnV0IGRvbid0IGJvdGhlciB0byBj
aGFuZ2UgaXQ7IEkgdGhpbmsgSSd2ZSBtYWRlIG15IHBvaW50IHF1aXRlIHdlbGwNCj4gZW5vdWdo
IHdpdGggaHR0cHM6Ly9naXQua2VybmVsLm9yZy90aXAvdGlwL2MvNWQ1YTk3MTMzIDopDQo+IA0K
PiAtLQ0KPiBkd213Mg0KDQpIaSBEYXZpZCwNClRoaXMgcGF0Y2ggaGFzIGJlZW4gaW4gdGhlIHg4
Ni9hcGljIGJyYW5jaCAod2l0aCBhIGxpbmUgbWlzc2luZyBpbiB0aGUgY29tbWl0DQpsb2cpLiBJ
ZiBwb3NzaWJsZSwgSSBob3BlIHRnbHggY2FuIGhlbHAgbWFrZSB0aGlzIGNoYW5nZSB5b3Ugc3Vn
Z2VzdGVkLCBhbmQgYWRkDQp0aGUgbWlzc2luZyBsaW5lIGluIHRoZSBjb21taXQgbG9nLiA6LSkN
Cg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
