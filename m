Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8003D11F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhGUO0s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 10:26:48 -0400
Received: from mail-dm3nam07on2137.outbound.protection.outlook.com ([40.107.95.137]:27361
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233044AbhGUO0r (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 10:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViAfJ+omlVMmN5B+mYgd6HXr5q6ePaG9HPA6AMiaNRcWO77/NZ8QQ1MjcDYgMC2qVqvfOUOiV5/3lAL2ilYyfWUoROu7OjkE/NkVZjdnLhtVTShBcfHpdLWlVqs52iqN9Y1AMhkUi23lQ+LxVgs8mVZVYO8/hJFA7rLRM5w04tP31pTvrVQnOsC0Y2fe66CqozBanirueXhJhOV6HAqn1W0em4AB4cFxSL12Sro0P9DEdUksYTRexP92q2CJVgw06AkgQHX6DQWVtUBtU46S6TlPH5udz619OZ/J3ruH5akOz/F14ZSThtEatyDaqegKLTdiKzcFO4kwxZnGgJ+8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmVyXeYYU4AHryoPGllH1xwQm3OQOOMhcD585ecY8dw=;
 b=GUoUlBFwRYu2/qXW+AutIIJo7R0747mPStjU79JP4k4uQ0Lm6UA4qQuOqydwr69+EubzHuJU9PjL1A1SHaLs1atJknuZeeABzzu3NpH5RPTqoVYB8shHC5E8WTExG0joX+jqVibpH295I6AOYHdWNEJRNUJP3zkQncemYMZoaKYfdNEUMRb/Ek7DKSBkp2b3DVh9OFZn4++w8sv+0jK+hw6fBxLg17z8AONMI+6m6jB8F+c5pXIEKIAu3kmeY08CYDyTT8b28mTBtdwqvAczGfhZmJkNh6dJ3Bqkl9j6GiOzSTwY2x21goxFhzpHK+WWrDwpeepUotqwf079BPWSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmVyXeYYU4AHryoPGllH1xwQm3OQOOMhcD585ecY8dw=;
 b=FPLFjfUoSOn/enSjp5GLeSrAnlS33aapPPBUAdW6JKfpaN1FIGNIjGGDK6IKa9ooXMnP/YfDLR6iL6ns4sRuaVyQR2aN3K/1fW92V2TAyMXdXu780uxmg5a6wIY6dW1fm24b6hFjDYxGYkgJlO1SGh8Ilm0R7xA/dDmLknEwuio=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1281.namprd21.prod.outlook.com (2603:10b6:303:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.5; Wed, 21 Jul
 2021 15:07:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Wed, 21 Jul 2021
 15:07:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Index: AQHXfOKuCkOiUQ46GkaTOSxdT1kTAKtLuKKAgAAjIwCAAAKZAIAALFMggAAEVYCAAMG8YIAANRwAgAAxnACAABbogIAAO13A
Date:   Wed, 21 Jul 2021 15:07:22 +0000
Message-ID: <MWHPR21MB1593448243F5DC37B0DC15D0D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
 <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
 <MWHPR21MB159302588AD32CA605192398D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <d8bd9c00-4eb5-187f-e31b-cba2ecec565b@linux.microsoft.com>
 <20210721101026.3tujagjag5umqejh@liuwe-devbox-debian-v2>
 <497414c3-3782-26ad-3b41-105ee12098d4@linux.microsoft.com>
In-Reply-To: <497414c3-3782-26ad-3b41-105ee12098d4@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1b450979-8922-4d5d-a5c8-05c7a699b9ba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-21T15:04:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd755f18-e503-4aa0-7127-08d94c593e2a
x-ms-traffictypediagnostic: CO1PR21MB1281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR21MB1281B32CB40A6FA6DB7D1AFCD7E39@CO1PR21MB1281.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxxwCEccA1Vi+Q6sEVtuNbHbwlwlpm/iQUn6uT6I+Bwxg6NH99niNn5gruo1BxdtsLz84fyAWGjcCABnPtPtai1omFtmKdfgDINSWcBXK1Nwaqx5Xx36geeYLeDmzoRz55i1mPXnORl+Cze7W2Q4kJKSk6NkVAQwTaxt/7bdyC9ZAkXZmZYsCjrg8XuD9SEhpsaRN6bnkiUcWAntFwrTcfxQDZRw9qaIWQm7IdBQXMib2KXp1ljzRyQB/tZGPSuYxzbrxUZVkT77mEGctvVFSqe5AZvZvZTuIDiy7rrUt3VpiAgXC5KkEVZVCr27cwHuYzl1lDKOabb/cciNyqmxdGM+gJe3bSImd4fI2V6R5DLu+jgUG4HABx63TwmMb+/oOww72BJB4GOvwvP4ajNt3Fvptj2DqyLlrPosXeREfPuVIAacR845WYkGnuX4nWJSTBb/CDypREhcN4WWNvvV7GXCMUum8ZIM7zasQPJDVqH1hQuTd+4UGAMeDWaZr+nKUBbnahhJq1KeL9YLLE43V7/NJXeyZpW3Qw+hin/qsBjjmc8Rt0d+6r/8RGjZyQq7crM+oglHZ7TP/+N8oGzZcbI4QTtn7cG1bDTs0cMc6FR07SeQYnOq2Cqd48yj+/cHoCWdIhZB3MA+O/P3SzHkCJsur5+lcjZ8m1QRnR/VFWuoMK3ejcSI56KM7Kk9ZTa9sTEqW3bDJ/yDB6RzKNtz7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(33656002)(82960400001)(82950400001)(83380400001)(52536014)(26005)(86362001)(8676002)(54906003)(55016002)(8936002)(107886003)(71200400001)(10290500003)(186003)(64756008)(76116006)(66476007)(66946007)(66446008)(316002)(122000001)(110136005)(38100700002)(8990500004)(9686003)(4326008)(2906002)(6506007)(7696005)(508600001)(5660300002)(53546011)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHBtLzQxNXBYTHRTMGtOeFBWRG1xdU9XOTQyTTUvNjlPUE93N3J3NHIwVE15?=
 =?utf-8?B?YXpLUllQTmhRUUdKSCtRRWRXeTBBUGM4VjVVeFcxVXkraVNHSmxXKzI0Vi9F?=
 =?utf-8?B?Yyt4WUhKNnB6Sk04Um1FU2dzMEpsTHJQcXlvcGQwekYyRURQU3krUnUxcUNX?=
 =?utf-8?B?T1QwQjExVGxYWkNEQUlXUzRoNXlWQXRYTzJQTEorRzFOUTlzK1JtTGEzaDNk?=
 =?utf-8?B?WFFmNkJyUmw4ajVKNUllb3laUENWejdqL1pzbUJyQlU1QVgvSzg4amVOR0M3?=
 =?utf-8?B?UFNueks4SEMvVStFQzEybVBNSlZKVVJBYzZEWDlDQ0VMOEVxQmtlOEJsdUF1?=
 =?utf-8?B?RUsrVWh5UEpFRGNrOXZLemlsME0zdHZhSERDSy9WZVl2QUhtYWdmTEFsWE9V?=
 =?utf-8?B?WkwyWEtEK3prTERBYW9SZ1czUFQyejhDN1EzSVRFd2QwT2RReC9HaUxWWTVC?=
 =?utf-8?B?Z1A5WmNQbVgyRlQyVktxZy9IaGVJcHdXUHI2Y09LemZOSWpIY3FlYXNMWkJW?=
 =?utf-8?B?SlpPZXp2YXJEdDYySU4rcVdPQTFnTEhVR0kxZFpDSGNvVDNPSURuRlpPSEVU?=
 =?utf-8?B?anAvcW5ELzhvVlBWZkRsUVlXL2o3ckd6dFNLM2NjYndyMytHSWtrKzlINUVj?=
 =?utf-8?B?Z2wrUzF2UllmTUJPSjlPSkNEaExZZ0I3bkdiV2hJbUVJVkdxaXVoTzRrUmRx?=
 =?utf-8?B?QUI5Tk5rR25ZNnhucWpmQVdSSXlxM3JlL015NE0wWHBLMG5iTTd1WGFaTmk0?=
 =?utf-8?B?S3F5QUZlemhWOVZPSFU5VVhTS2JObEZCeVBsMkU3Z24xbVY4UkhoSm1naUdB?=
 =?utf-8?B?QnFGc3Bzbm5SYmdqY2tVMnBQRC9ZQ3F0d2VtRmg0TVFVUXlzSUs0SlcxR0F4?=
 =?utf-8?B?b29ZTVlTQU9neFpKUGdyWlVFN1pYWjVqQkduRDBYSDRwZnpzVENWV3hIcElq?=
 =?utf-8?B?dWF6eFRnNStmM3EwZXJZUit6c1FSTzJyVm90UWRvU0VJNFJISG9QMDFyd0F3?=
 =?utf-8?B?TVA4dE10djQ0NWMxQWxiVG5qZGtacXExdVY0S0lhcGRFQThqRWZ4cVg4bFpF?=
 =?utf-8?B?emQ4UEZFMjJHYnRrZE1tUDFRQjg3OHAzYjJzQUZxM0cya1owRXhlMFdYQkFp?=
 =?utf-8?B?QWM2YTNabXpMRnJobUVRRFVNMTJSTjJ6aTRMN2NFa1pvdUZMMVRlSWVoWmJB?=
 =?utf-8?B?MnpHTzRwczZyWGMra0d2SWdhOHg3WWN3bTU4WUFsVDI5RmxxSHdpVnBhQjY2?=
 =?utf-8?B?WGo2aHFrLzNyMnR4ZlovbDhwOE5jMlcwYW1NNXluYnk5NjJrMjFKT1QxWXhG?=
 =?utf-8?B?MkQwSjBOQTN5bFRYV3BhNzNSekZ1YUpTQ3MwWE9yRm1HMHNTN1A0YU9ZNU41?=
 =?utf-8?B?b0NRL2pYazJOb1ZtSG1KalV4ekl1aFh2cmpWZ0tCUkNZVlZIVWY4NVF4MStm?=
 =?utf-8?B?Q1FDWGI1Sy9VWkpjcXgwNzVMdWw5OEJGcWFreExHNjNBVm04K3d5YmJKYlhH?=
 =?utf-8?B?Rmc1Wmd4TEdhWDJkNVBzZEF3UmwyYlZFd2U1UXN2RkYxaTRIcjdvR0lNb2Jo?=
 =?utf-8?B?STl6akNhWFNhR2RuNTR1c01RQ2orSGRsYWNNMmt5MjA2YW5IUjg2bjdaTDJY?=
 =?utf-8?B?ZnJPWVYrZ1RTOVo5T2RaTWJDRXVYVklTZzVMM0U5TUlHelZXQjJMMDVJajZT?=
 =?utf-8?B?WlFON29CcVU1QjlZQU5TaFZZSHNnUkVqWHdveGRlUFQ4ZGhnVXZFK295dHQ0?=
 =?utf-8?Q?2/ErIyVGiTtm1KZLV3KQqJY0eb4d6mSksE/OVl+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd755f18-e503-4aa0-7127-08d94c593e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 15:07:22.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzJTYcf+muatgy9ZzcW7VC0JMtf64n49PPFUNGZEcoJiAn0a4XzPEjM4s5HJ8zq4gd1c5vaJGTiXL8HPDrPDpsZvh0JcLxFt/2nYRMcBxh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1281
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUHJhdmVlbiBLdW1hciA8a3VtYXJwcmF2ZWVuQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNl
bnQ6IFdlZG5lc2RheSwgSnVseSAyMSwgMjAyMSA0OjMyIEFNDQo+IA0KPiBPbiAyMS0wNy0yMDIx
IDE1OjQwLCBXZWkgTGl1IHdyb3RlOg0KPiA+IE9uIFdlZCwgSnVsIDIxLCAyMDIxIGF0IDEyOjQy
OjUyUE0gKzA1MzAsIFByYXZlZW4gS3VtYXIgd3JvdGU6DQo+ID4+IE9uIDIxLTA3LTIwMjEgMDk6
NDAsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+Pj4gRnJvbTogV2VpIExpdSA8d2VpLmxpdUBr
ZXJuZWwub3JnPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIwLCAyMDIxIDk6MjkgQU0NCj4gPj4+Pg0K
PiA+Pj4+IE9uIFR1ZSwgSnVsIDIwLCAyMDIxIGF0IDA0OjIwOjQ0UE0gKzAwMDAsIE1pY2hhZWwg
S2VsbGV5IHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+
IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjAsIDIwMjEgNjozNSBBTQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IE9uIFR1ZSwgSnVsIDIwLCAyMDIxIGF0IDA2OjU1OjU2UE0gKzA1MzAsIFByYXZlZW4gS3VtYXIg
d3JvdGU6DQo+ID4+Pj4+PiBbLi4uXQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gKwlpZiAoaHZf
cm9vdF9wYXJ0aXRpb24gJiYNCj4gPj4+Pj4+Pj4+ICsJICAgIG1zX2h5cGVydi5mZWF0dXJlcyAm
IEhWX01TUl9BUElDX0FDQ0VTU19BVkFJTEFCTEUpIHsNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4g
SXMgSFZfTVNSX0FQSUNfQUNDRVNTX0FWQUlMQUJMRSBhIHJvb3Qgb25seSBmbGFnPyBTaG91bGRu
J3Qgbm9uLXJvb3QNCj4gPj4+Pj4+Pj4ga2VybmVsIGNoZWNrIHRoaXMgdG9vPw0KPiA+Pj4+Pj4+
DQo+ID4+Pj4+Pj4gWWVzLCB5b3UgYXJlIHJpZ2h0LiBXaWxsIHVwZGF0ZSB0aGlzIGluIHYyLiB0
aGFua3MuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gUGxlYXNlIHNwbGl0IGFkZGluZyB0aGlzIGNoZWNr
IHRvIGl0cyBvd24gcGF0Y2guDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSWRlYWxseSBvbmUgcGF0Y2gg
b25seSBkb2VzIG9uZSB0aGluZy4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBXZWkuDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBJIHdhcyBqdXN0IGxvb2tpbmcgYXJvdW5kIGluIHRoZSBIeXBlci1W
IFRMRlMsIGFuZCBJIGRpZG4ndCBzZWUNCj4gPj4+Pj4gYW55d2hlcmUgdGhhdCB0aGUgYWJpbGl0
eSB0byBzZXQgdXAgYSBWUCBBc3Npc3QgcGFnZSBpcyBkZXBlbmRlbnQNCj4gPj4+Pj4gb24gSFZf
TVNSX0FQSUNfQUNDRVNTX0FWQUlMQUJMRS4gIE9yIGRpZCBJIGp1c3QgbWlzcyBpdD8NCj4gPj4+
Pg0KPiA+Pj4+IFRoZSBmZWF0dXJlIGJpdCBQcmF2ZWVuIHVzZWQgaXMgd3JvbmcgYW5kIHNob3Vs
ZCBiZSBmaXhlZC4NCj4gPj4+Pg0KPiA+Pj4+IFBlciBpbnRlcm5hbCBkaXNjdXNzaW9uIHRoaXMg
aXMgZ2F0ZWQgYnkgdGhlIEFjY2Vzc0ludHJDdHJsUmVncyBiaXQuDQo+ID4+Pj4NCj4gPj4+PiBX
ZWkuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBUaGUgQWNjZXNzSW50ckN0cmxSZWdzIGJpdCAqaXMq
IEhWX01TUl9BUElDX0FDQ0VTU19BVkFJTEFCTEUuDQo+ID4+PiBCb3RoIGFyZSBkZWZpbmVkIGFz
IGJpdCA0IG9mIHRoZSBQYXJ0aXRpb24gUHJpdmlsZWdlIGZsYWdzLiAgOi0pICAgSSBkb24ndA0K
PiA+Pj4ga25vdyB3aHkgdGhlIG5hbWVzIGRvbid0IGxpbmUgdXAuICAgRXZlbiBzbywgaXQncyBu
b3QgY2xlYXIgdG8gbWUgdGhhdA0KPiA+Pj4gQWNjZXNzSW50ckN0cmxSZWdzIGhhcyBhbnkgYmVh
cmluZyBvbiB0aGUgVlAgQXNzaXN0IHBhZ2UuICBJIHNlZSB0aGlzDQo+ID4+PiBkZXNjcmlwdGlv
biBvZiBBY2Nlc3NJbnRyQ3RybFJlZ3M6DQo+ID4+Pg0KPiA+Pg0KPiA+PiBZdXAsIHdoYXQgSSB1
bmRlcnN0b29kIGFzIHdlbGwsIHRoaXMgaXMgdGhlIG9uZSByZXF1aXJlZCBvbmUgZm9yIFBhcnRp
dGlvbiBQcml2aWxlZ2UgRmxhZ3MgKDR0aCBiaXQpLCBob3dldmVyLCBjYW5ub3QNCj4gY29tbWVu
dCBvbiB0aGUgbmFtaW5nIGNvbnZlbnRpb24uDQo+ID4+DQo+ID4+ICAgICAgNSAvKiBWaXJ0dWFs
IEFQSUMgYXNzaXN0IGFuZCBWUCBhc3Npc3QgcGFnZSByZWdpc3RlcnMgYXZhaWxhYmxlICovDQo+
ID4+ICAgICAgNCAjZGVmaW5lIEhWX01TUl9BUElDX0FDQ0VTU19BVkFJTEFCTEUgICAgICAgICAg
ICBCSVQoNCkNCj4gPj4NCj4gPg0KPiA+IFVyZ2gsIG9rYXkuIEl0IGlzIG15IGZhdWx0IGZvciBu
b3QgcmVhZGluZyB0aGUgY29kZSBjbG9zZWx5LiBTb3JyeSBmb3INCj4gPiB0aGUgY29uZnVzaW9u
Lg0KPiA+DQo+ID4+PiBUaGUgcGFydGl0aW9uIGhhcyBhY2Nlc3MgdG8gdGhlIHN5bnRoZXRpYyBN
U1JzIGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gPj4+IEFQSUMgKEhWX1g2NF9NU1JfRU9JLCBIVl9Y
NjRfTVNSX0lDUiBhbmQgSFZfWDY0X01TUl9UUFIpLg0KPiA+Pj4gSWYgdGhpcyBmbGFnIGlzIGNs
ZWFyZWQsIGFjY2Vzc2VzIHRvIHRoZXNlIE1TUnMgcmVzdWx0cyBpbiBhICNHUCBmYXVsdCBpZg0K
PiA+Pj4gdGhlIE1TUiBpbnRlcmNlcHQgaXMgbm90IGluc3RhbGxlZC4NCj4gPj4+DQo+ID4+DQo+
ID4+IEFzIHBlciB3aGF0IEkgYWxzbyB1bmRlcnN0b29kIGZyb20gdGhlIFRMRlMgZG9jLHRoYXQg
d2UgbGV0IHBhcnRpdGlvbg0KPiA+PiBhY2Nlc3MgdGhlIE1TUiBhbmQgZG8gYSBmYXVsdC4gIEhv
d2V2ZXIsIHRoZSBwb2ludCBpcywgZG9lcyBpdCBtYWtlDQo+ID4+IHNlbnNlIHRvIGFsbG9jYXRl
IHBhZ2UgZm9yIHZwIGFzc2lzdCBhbmQgcGVyZm9ybSBhY3Rpb24gd2hpY2ggaXMgbWVhbnQNCj4g
Pj4gdG8gZmFpbCB3aGVuIHRoZSBmbGFnIGlzIGNsZWFyZWQgPw0KPiA+DQo+ID4gTGlrZSBNaWNo
YWVsIHNhaWQsIHRoZXJlIGFyZSBzb21lIG90aGVyIHRoaW5ncyB0aGF0IGFyZSBub3QgdGllZCB0
byB0aGF0DQo+ID4gcGFydGljdWxhciBiaXQuIFdlIHNob3VsZCBnZXQgbW9yZSBjbGFyaXR5IG9u
IHdoYXQgZ2F0ZXMgd2hhdC4gIFBlcmhhcHMNCj4gPiB0aGF0IHByaXZpbGVnZSBiaXQgb25seSBj
b250cm9scyBhY2Nlc3MgdG8gdGhlIEVPSSBhc3Npc3QgYml0IGFuZCB0aGUNCj4gPiBvdGhlciB0
aGluZ3MgaW4gdGhlIFZQIGFzc2lzdCBwYWdlIGFyZSBnYXRlZCBieSBvdGhlciBwcml2aWxlZ2Ug
Yml0cy4NCj4gPiBUaGlzIGJhc2ljYWxseSBtZWFucyB3ZSBzaG91bGQgc2V0dXAgdGhlIHBhZ2Ug
d2hlbiB0aGVyZSBpcyBhdCBsZWFzdCBvbmUNCj4gPiB0aGluZyBpbiB0aGF0IHBhZ2UgY2FuIGJl
IHVzZWQuDQo+ID4NCj4gPiBUaGlzIGlzIG1vc3RseSBhbiBvcnRob2dvbmFsIGlzc3VlIGZyb20g
dGhlIG9uZSB3ZSB3YW50IHRvIGZpeC4gSW4NCj4gPiB0aGUgaW50ZXJlc3Qgb2YgbWFraW5nIHBy
b2dyZXNzIHdlIGNhbiBkcm9wIHRoZSBuZXcgY2hlY2sgZm9yIG5vdyBhbmQNCj4gPiBqdXN0IGFk
ZCBhIHJvb3Qgc3BlY2lmaWMgcGF0aCBmb3Igc2V0dGluZyB1cCBhbmQgdGVhcmluZyBkb3duIHRo
ZSBWUA0KPiA+IGFzc2lzdCBwYWdlcy4NCj4gPg0KPiA+IEhvdyBkb2VzIHRoYXQgc291bmQ/DQo+
ID4NCj4gDQo+IFNvdW5kcyBnb29kIHRvIG1lLiBUaGFua3MgV2VpLg0KPiANCg0KV29yayBmb3Ig
bWUgYXMgd2VsbC4gIFByYXZlZW4gLS0gVGhlIGluY29uc2lzdGVuY3kgaW4gdGhlIG5hbWUgaXMN
Cmhpc3RvcmljYWwsIGFuZCBub3Qgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgY2hhbmdlZCBu
b3cuICBNeQ0KY29tbWVudCB3YXMganVzdCBtdXNpbmcsIG5vdCBzb21ldGhpbmcgYWN0aW9uYWJs
ZS4gOi0pDQoNCk1pY2hhZWwNCg==
