Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2934253C
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSSsj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 14:48:39 -0400
Received: from mail-bn7nam10on2117.outbound.protection.outlook.com ([40.107.92.117]:34144
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230384AbhCSSsY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 14:48:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM/ep6UOzyLVANK2Si/WnLrh0zXdMPw56Yzqp2/2dNC79+WB/fRVxv3s8jYh4wfTtDT3Dmf670in6LbaoOZf5JflVLIF22VcpbMXmDMS3RiS6gh0W58uD+fA9ud15sQVM/qLPnBYARKoNPfxNDUdE+9LBDaJGGBqLtHKSLXSkVf5fzBJyQyl6nr1w9/oVEv97fA8Pi5c4oHfeiP13JWsCTkxEapy42xApjBNVQabxf1a8B2hulbK6gew/sKbGA7LCX5vnLoP0R9T34qiYo8HGpAU7f0+k03tIB6BZvecLR2zBZeUV+SMAltW0HgA9vcCIX7ZKBNmmPw0UQXhg6OhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nILzfQyd1nyI2DVOHYQaRKlFP+Y/NDo/RbECf1rvEQo=;
 b=dhaSxq/3MvECUostvpGpPY5x3nEEfzmiQkhPRoTA+VPZY5DbbkskRN8hAZSLMVavzdh1Gy3awdFUtt3IAQhx48VoENYNtEcyUKVcfGjtFziIPv0GAKKNftaE+p6rZj7+6msfh0m9OygSzDhqLh0wqfrDJx4wJGrtyxBqyVshcuDz+UjnI0v82IS/HHBPYOHP4wuCGdkIVVxiKE7SqcH+xp9W5D/1cKMo3UfoJQbhl8c1k8ye2wlkV0dmy4dcge/ceHNyqEPIUwCgUpYMB0JnPoIOH2ESKgWIHS2wl87MIzE04Rl9fTUlcsCGA0XAZdBgAuck4eB+c8Mky4g1JNRpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nILzfQyd1nyI2DVOHYQaRKlFP+Y/NDo/RbECf1rvEQo=;
 b=RJK6iqX9WK9v+QFs3vzNwX7YPiov6uVv+EB7dUNs9fkv03K+/LV11ux5fENkMe/d4MM3xFxwzImtHMUWmTlD7Zx8dnjYw27TzmfvnI1lutiMwGbYWB1YUmpcwYaW6wycxDbAY9HsqJYlVMIqoch5Xv2wLSU1xwXSqU/ljmCzMVU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1988.namprd21.prod.outlook.com (2603:10b6:303:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Fri, 19 Mar
 2021 18:48:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3977.016; Fri, 19 Mar 2021
 18:48:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Xu Yihang <xuyihang@huawei.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Thread-Topic: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Thread-Index: AQHXG81biLYe+YQ0KUyfclj07i5wPKqLpwXw
Date:   Fri, 19 Mar 2021 18:48:21 +0000
Message-ID: <MWHPR21MB1593F590A00DCA86C61A5C8CD7689@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210318080348.151022-1-xuyihang@huawei.com>
In-Reply-To: <20210318080348.151022-1-xuyihang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-19T18:48:20Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfac9c68-e632-42c6-beb0-a2f0c0b1a800;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: deb51c3b-9b40-4eb5-e11d-08d8eb0791e7
x-ms-traffictypediagnostic: MW4PR21MB1988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1988C496A4C6ECAA6D791891D7689@MW4PR21MB1988.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptkXm0P71ah5ntxDhW+enTDt/e44r8zcvtEhU6HeweHzCb0+oY6hkCR3W+XnHN7s7x+g0qa1VZUbr2t4ENS9V8+wD6qgqDPYTKq3YQHSMfoIGJ7MgIN2t3E808bP8uhLxtvuH+0GFfAbZMpfSbTeukyKzvlh9uPuFTGIcx1X8ADL8ZFJmTHmZj99D4ym4Np3qYeIXZsvJwYEXGWS0mMOkAUxivBX91mGCDM9oipeYcQnwicz6Zjs7N0N76VlrcMR2MzBqferCWfUexFbmvpzaJUB7T17WktOIklO6i+GZWohUwIxSrCdZpLuOkHVg0NZDh+q0vpFt5C9vVom31taPP2J2T5z9kQADCUlBEcLxfoOS7m03U842kXudEirDYy0UqxVwuhtb6mHTtiqCXbwZSTBYh43AaoCyONMmoiVHn41v5vJ5ZByh0DzGcklruR0Uq6nCADwImPvVD85Af659BVuwJptjhO4Cz04wylrMacR6Fc8QIIeo8MYZveboLBJjuh8L3nyGN8YyL6l9sqQDhBLmNEWDwGolF6dpwlNfhSMB1x5Zi2DylaGnpah9J8ymxmz5dlfnVfEf2k916ozDcNiRyA3BAN2x2t9vB0BR0RrDK243xGaoiNTyJEUuk1HkL6psHPExciBVWvFNkB6dxGT8wCX0SITzc+iEnWv66Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(82950400001)(66946007)(7696005)(66556008)(66446008)(66476007)(6506007)(8676002)(54906003)(316002)(110136005)(8936002)(10290500003)(71200400001)(83380400001)(478600001)(52536014)(33656002)(82960400001)(64756008)(5660300002)(76116006)(86362001)(4326008)(26005)(2906002)(8990500004)(55016002)(9686003)(186003)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzdyeFlEZW9hTVdFdFZXQzd0M0lvT3A3cDRDSmpMRHZITzFENHI5S3B3TDJP?=
 =?utf-8?B?TTJmbDVJeUNoWnFNNDAxVFJjaWhDdS9Xbm1rTnpYM1RNSncyR1R1UUp2RWFM?=
 =?utf-8?B?ZHpGWVo2VlNPRXVSZlZYdGltdWtJd1ArNTFYQk5RQm9aVDVQbHZuRGEybzFx?=
 =?utf-8?B?YWVXaXFxQ3ZJeXdHL2pDNmZXcXFZazhYVDJlUGx6cmV2VllhRkM1anhjUnBz?=
 =?utf-8?B?R1hNT21hTTNIaHQ4K1pSMDZ5WWlWa0FjTTJzRm1namVFdnhuQ2QyUmVEOTdI?=
 =?utf-8?B?MWU5cGZETGhaR3lKb0toakQxR0tFbXc3K2pNUnFZYkdScTk0Uy9lZldNVDE0?=
 =?utf-8?B?ZUNaOFE3UEkxSC8xdVRzZVpUbTRGd3JOWnBIUktDTDJJVjNEa3VuUmJqTHVW?=
 =?utf-8?B?RS9XM1NzMXd1U3V6ZGd2RVBTamt0VXVjWUFCTlQ3ZlJmQUx5S3M0UGhRbE1p?=
 =?utf-8?B?WVMzd1BQVEpLaEVENXpYcWlyRXo4TUlaNzBMK0l2Mlo0NFNHb1NPNS9HcXZT?=
 =?utf-8?B?Uy9NUGtXTkdBUzlGQ2YwZGkyckdaNDV2aVBSWVg5MGJvTFd5Vk5qTEswT0g4?=
 =?utf-8?B?RGJsaG1PVXhrbk9HVVhuK1dyT3FtNzBMcnpnUXQyWEJUaXQ4Y2RUNDVaQzNG?=
 =?utf-8?B?QWY1bUhiYzJiWm5lQTExUjJaYTJaYzh6b3E0elR3YlEzajE3RUgxN29WTGlV?=
 =?utf-8?B?MjdFeVozQTNYQmlzQTFhZUNOWjZ4aWhkRi9QY015dHJRcmdZYTZYY2xjSC8w?=
 =?utf-8?B?TFM4OUUwQUl6eWhZNk1rZ25QR2VDYWp5a3RLYVk1Zk5QU096RDh4Y1lSODcz?=
 =?utf-8?B?NnZZWU8xZDdIL1YyN3gweWl2cysyUGM0OUFVdGFyYlVpaG1pUnJ0cXFmU0do?=
 =?utf-8?B?TUpqMlBrNUlPaTl4cjhzRmdnd0R0dU9QUVYyclJVT2JqdnJnRklZN1kvcTZv?=
 =?utf-8?B?VHVIUnduSGUyZFkxZXIvOS9nQWNvaEpqT3g0RHpCcjlpc2lRZWx3Z0poa0ty?=
 =?utf-8?B?YWpaRHlabzdJdnpOR0hCZTNGeW5MTi9UTFU2SmRDMzF6M2xtQUJrelRoL1pq?=
 =?utf-8?B?YkVFS2FEeGJHWVJFeEthclJudWdHV2NCVThSQmZFZ2Q2WFJab25WNzl6QTd1?=
 =?utf-8?B?U3Q4YXh1WjRTSzBSMTVSRCs5bkFuUWpxaUxmZXdyRkFvWXF3cTIyYVRYRXps?=
 =?utf-8?B?cUw0VHdSS1EwVjNLaEZSNzdiVFFyNERVV0ErV0FjNVdnQyt6SThCSzFyMmJE?=
 =?utf-8?B?MHp1SGJwWi9kT0tDZyswZDNRanJ1S01YOTYvUlhmUnJRaXg1SjVoOWc0ZlZC?=
 =?utf-8?B?SUZPSHFVMnNrakVsQm1NZVNmTkRxYVJvekk3U25Xcnc1eDFUam1zdTIxMDBn?=
 =?utf-8?B?M2FOTlRnZlBHeXJUQ3JHSENFa2lzY3VDSEovT1h5d20wSU1yODE3OU1jaFhu?=
 =?utf-8?B?UG9oWkJDR2pMenphcVlnVlIyalAyWktYaVFzd3hrSTVDSGE3S3pZL2JtS1Nn?=
 =?utf-8?B?eHBNWmhpdDhEUUF5czBieFcvdFdabnZadi8yUFVpbWhqaU1Fdk16K2pZRzEv?=
 =?utf-8?B?VHJITDJPUDQ2ME9rVEhIQ3d0S05qak9Fa2xIM1hES0hKd01US2pacG5aL2N6?=
 =?utf-8?B?TUN2SjV6VFV3WGM0N2dwZi9YUXJHTmtkRUo4WGh3UUFJWGV6bkZ5TFF0RTFO?=
 =?utf-8?B?T1ZaMDlOb1UvN3BJVzZtcjExS050SEZ1NWxjRVFlaWpldjhhcmJwemdQblVJ?=
 =?utf-8?Q?pkpXtnOcP1+BMRB9K5csZsdYm6HDaNlL32Qqb3o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb51c3b-9b40-4eb5-e11d-08d8eb0791e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 18:48:21.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6Scc4Fw3RdRTPXQX3Pm+hCkyKSFqRYl4bsLKmbEi+GEOwEayHHq9BpVmMRFw20PrMezAOgXu8QO4lNmijkz3kuUco2A+yE66qRjdaBmCkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1988
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogWHUgWWloYW5nIDx4dXlpaGFuZ0BodWF3ZWkuY29tPiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMTgsIDIwMjEgMTowNCBBTQ0KPiANCj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVs
IGJ1aWxkIHdhcm5pbmcocyk6DQo+IGFyY2gveDg2L2h5cGVydi9odl9zcGlubG9jay5jOjI4OjE2
OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhtc3JfdmFs4oCZIHNldCBidXQgbm90IHVzZWQgWy0NCj4g
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgIHVuc2lnbmVkIGxvbmcgbXNyX3ZhbDsNCj4g
DQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogWHUgWWloYW5nIDx4dXlpaGFuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGFyY2gv
eDg2L2h5cGVydi9odl9zcGlubG9jay5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaHlw
ZXJ2L2h2X3NwaW5sb2NrLmMgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfc3BpbmxvY2suYw0KPiBpbmRl
eCBmMzI3MGMxZmM0OGMuLjY3YmMxNWM3NzUyYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaHlw
ZXJ2L2h2X3NwaW5sb2NrLmMNCj4gKysrIGIvYXJjaC94ODYvaHlwZXJ2L2h2X3NwaW5sb2NrLmMN
Cj4gQEAgLTI1LDcgKzI1LDcgQEAgc3RhdGljIHZvaWQgaHZfcWxvY2tfa2ljayhpbnQgY3B1KQ0K
PiANCj4gIHN0YXRpYyB2b2lkIGh2X3Fsb2NrX3dhaXQodTggKmJ5dGUsIHU4IHZhbCkNCj4gIHsN
Cj4gLQl1bnNpZ25lZCBsb25nIG1zcl92YWw7DQo+ICsJdW5zaWduZWQgbG9uZyBtc3JfdmFsIF9f
bWF5YmVfdW51c2VkOw0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAgCWlmIChpbl9u
bWkoKSkNCj4gLS0NCj4gMi4xNy4xDQoNClRoaXMgaXMgb25lIG9mIHRob3NlIHNsaWdodGx5IHdl
aXJkIGNhc2VzIHdoZXJlIHRoZSBzaWRlIA0KZWZmZWN0IG9mIHJlYWRpbmcgdGhlIHN5bnRoZXRp
YyBNU1IgcHJvdmlkZWQgYnkgSHlwZXItVg0KaXMgd2hhdCB3ZSB3YW50LiAgVGhlIHJldHVybmVk
IHZhbHVlIGlzIGlycmVsZXZhbnQgYW5kDQpuZXZlciB1c2VkLCBzbyB0aGUgX19tYXliZV91bnVz
ZWQgYW5ub3RhdGlvbiBpcyBjb3JyZWN0Lg0KDQpMZXQgbWUgc3VnZ2VzdCB1cGRhdGluZyB0aGUg
Y29tbWl0IG1lc3NhZ2UsIGFuZCBhZGRpbmcNCmEgYnJpZWYgY29tbWVudCB0byB0aGUgY29kZSB0
byBleHBsYWluIHRoaXMuICBUaGUgc2lkZQ0KZWZmZWN0IGJlaGF2aW9yIGlzIGRlc2NyaWJlZCBp
biB0aGUgSHlwZXItViBUTEZTLCB0aG91Z2gNCnBlcmhhcHMgbm90IGFzIGNsZWFybHkgYXMgaXQg
c2hvdWxkIGJlLg0KDQpNaWNoYWVsDQo=
