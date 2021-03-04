Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22A532DE23
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 00:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCDX7A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Mar 2021 18:59:00 -0500
Received: from mail-co1nam11on2093.outbound.protection.outlook.com ([40.107.220.93]:19789
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhCDX7A (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Mar 2021 18:59:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neaT7Eb1Mr1F7MOPBZ3CoGxLcRfezG3Ugmf4CjV5osSYUOPtO5L2CD+kMsywJpzOliGobzc3F4JHL/xzPgS7CkNVBBbdnlRdLzK2IfQ4zSOY3IDO2MiDiFflXVNki3FUw5QOS4aZNjBKT/EvnkMm9hRmsgPi3NZGuHcZ33VsIYsBj15jlobCrW+ZqyC29oWFrQVu86BDK2H+zhePpTG53ZJtyt33rJVLXWocfLMsTy2AkKATGCS3r7qjw6AxlNSKiuLsrIwYRvIF36f8OSZug9NuJTiYfxfKnc8h8ObvCVLRoDFBdOSGEF+aCDLjYV5RAMw1RO6ef0Ggogc6ydDrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQvfzouemzlKH6fPAw4oJSaukSZ17aPqAwlO0Pz7VE=;
 b=Mrc/E1Ahbb7yj8VMDwpGwOdaUAUyWqa9r7Hq8H9RoONIsbW2fZsbQ0xwjwpLtQDCZU91qtv25y0bJ+w55PpJs62LF3wBNlRvmKdwgQY/MHgeZ+FV6V4EgJ0f04/oe/4gsxkHaXyePQpA9ADPmUiVQwkoynfzUjNe/Px2s3cxH/revZNRo90xRcgX8pNlF1JLQNOPSbkVlltP35xS4hGls0+CUnv9RVE61fKXMZgnzKBa+TC+s9gMTLLfX10LFSg/JA47/a0rFF9Q5VLTTwWKDGJFIGgjMqe9HZXMNjegz3Em6sWJd71RwhMvUFYK1N4DG0c5rJHkdQ7GjtkD0cmpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQvfzouemzlKH6fPAw4oJSaukSZ17aPqAwlO0Pz7VE=;
 b=fHI0VQ6tDYtxRbo57LlNm6zwpwYHVeXQDNKCBn988WhL8AE6STcgQxJiFLBoR4oVV8sD+W4biQHxWzjLhPJlllQg/uXhG3CIM7O6tcc9wN/CPmYG8O3LAdecCAm3p2PZPwew6whmaof9J5MQKMkMZnvfpKEkI136KQZ59GsNfDI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0908.namprd21.prod.outlook.com (2603:10b6:302:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.17; Thu, 4 Mar
 2021 23:58:58 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.024; Thu, 4 Mar 2021
 23:58:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize, delete
 partition hypercalls
Thread-Topic: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize,
 delete partition hypercalls
Thread-Index: AQHWv52RO39n9Z5WhEuKJPNiXbM1XKpL8TdwgCkxh4CAAAEL4A==
Date:   Thu, 4 Mar 2021 23:58:58 +0000
Message-ID: <MWHPR21MB1593060CD27B9AAA10862833D7979@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-7-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593518130E3E0532894C516D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <e6cc796d-f9ee-5203-95a9-05906f95d3f8@linux.microsoft.com>
In-Reply-To: <e6cc796d-f9ee-5203-95a9-05906f95d3f8@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-04T23:58:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f5c14bb-864e-4434-a8eb-256a611d347a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 249ef088-a906-47bd-bbc4-08d8df697a23
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09085D227A7740754A65E550D7979@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIC4EUMhROCGbHmjF8PPh5bG/vVZfszWprF6w4sTRj7l2Ainxs63FYH5JnKVhDFlxm7ZsF0CQ3QNJT+FUcj6xbWujShrQv25Zzc7e7IY/fNXxGDAde4ixB4bOupMqwBAoeYjMMjdFa7MKz/a7WKO7/oK9GsXmD4vnTs1d8X+sCL9ahYiGgYtv7tPE8NLkdzcl3Mlrf1t7wcIc9asVD6Hud6kUfo9sd7kF9Dt7Gz6DpSxLqIo9Mpe5uHj8UJUSla+cnN5MDnMQpD+66lRZmw/JPwEQ7k+9KjUyNLrmpJ0dbWMrIw+Z+0mGPKeMp4s3eNhzoF1KaAz2rboCXWRIx1GjSZ3FQaxLmfe2iPyObYgPxGC4WDdfn4PyvqGy5xCrmXeEUuSV3TQjvkQHLR3WUOjQmRx+43TXHjhQED97QJS73gIxTZXfDdhKIpwsqQwGRpj6Unoxua9YG2bYwzAaYK7cposBCEFHh0D6uUN40ZblUZoUxEbC2VU/n6Kr+yD6AbZeBhm6Nogcru1rZptLX7dfBzgqB9VvhVDxlwEikpIy/j3eWyqL55dq1MMX8lmOOms
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(66556008)(76116006)(66446008)(66946007)(71200400001)(8990500004)(10290500003)(54906003)(478600001)(33656002)(2906002)(64756008)(7696005)(66476007)(4326008)(110136005)(83380400001)(55016002)(186003)(9686003)(82950400001)(82960400001)(53546011)(8936002)(5660300002)(86362001)(107886003)(6506007)(8676002)(52536014)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkpwSTFwbGVoYURvWGJHT1Rka20yQXBXSjE5dVVsR3ZQb0FBeFZ6N2Q3bnFz?=
 =?utf-8?B?ZHZVRjFldEJjV0QvL1JzK2Ntb25SalBLd2RPc3NVSDllbFNHM05wdEpvVWhK?=
 =?utf-8?B?ZDhuUkE3Yi9GSUlvcTMyUzZnSVdub2ljZzZ3WWhIbzRsWDRYWm4rZ0k0UG9h?=
 =?utf-8?B?NnM5cCtUOFpuV0hGZUcvY0swKzhrVFRpYll5aFM4endNaG0vTzFONFFFR0xE?=
 =?utf-8?B?aDlqMzM4Qko0NklNbXFpdnYwd0JoelFJbUt1VFpGeUY2T0dqRXV4WlI3c1BL?=
 =?utf-8?B?NG05djVPZHhvS3hwNDdMVVQycWttUzRySlpCaTdBWCtvSWpPZFIrMlR5T29B?=
 =?utf-8?B?SHl5OVM0NjRxdjVGeVphVGlJVVNsTHpHOFdYUE91MStlVVNyVmE5T3ZnYmF2?=
 =?utf-8?B?VXdsblArcC9vTmJ4eDl3M0hBZ3dNV0JlQjQ5WEJ6ZjBUUkNvWGdqWms5SmNx?=
 =?utf-8?B?THE4K0VVOUUvQ1dKQ2RQY1pCM3d6SndWcjMvSnhmYnNzaHdLalBJMGNaWkYv?=
 =?utf-8?B?a2V5SVpLYlBhK0xCV1hhdERUK0w5Y0VKQmZCNWczbW5BSmFMSGxkc3dUTVJy?=
 =?utf-8?B?U2M4aXNYVFhFZ21IRk8zZWdTMU91K1llZENxTFN0UFdsSzZuTFFEZlJ6dTVv?=
 =?utf-8?B?WUxYWWIvSFByT2pxTkt6SCt2MGx5bDFwdmUvSG9nSmhWUHVsYVR0RUI0L3lZ?=
 =?utf-8?B?MDdvUVBYeC9GdDNhMU1POFcwcHFrKzBNbVJ5dEthMlBXQnZpYTVNYlMrLzdT?=
 =?utf-8?B?Y1NTenJ2MFJ0b0o5YzJlbEdIVmd2SWM2aGoyeUZIUUtyTDNiOFhzWWlxZUp5?=
 =?utf-8?B?R0FJVXBNYTdIY3VYdlBxczhHUkxaNk5DODA3MXpPcSt3eXNacEtoK0hsSlhi?=
 =?utf-8?B?V1pyY3JEYmJSc1dmODhVMDd2OGNUc2RxR1pwMHN5dnJWcGRjVHMyZXI2a1B2?=
 =?utf-8?B?QVJiODk0MC9vNnc2OGpXeE1OdEVITG80OU9BWThtRGhzZGt1Z1BxZEc0K1ZM?=
 =?utf-8?B?SHNwWjhBVjNmUUxxTDNzaHQyU3JOeVkrL2k3cHpaMzZUN1M0dFBIUWxRY29u?=
 =?utf-8?B?RVlEWDE0SXQ3L3lYR09GN2Vwczl2U09lc2Y4c0ZodXJwbnArYWlNU2l6QVZS?=
 =?utf-8?B?NCtlUExZNkZrUjJueXdBRXhBc1VVMnozQnBLb0tqajdsbEpNdWQvNlV1OUc4?=
 =?utf-8?B?NFRHcGkwdTFzTFNyNFZtRGhHT2pEc2o2ZGNpakkyTm5ZYTl1R0dmOFUxSTR0?=
 =?utf-8?B?UzJjRUU3NWczYmxYUExWZHRSNmU5QlVEUU5xazBUalpPYi9JbWU1MU8zeXAv?=
 =?utf-8?B?bEtHRitCcHdZWFY0aHQydUNrSjhuemc3ZUhkVXZERm1pTGEzSXpxS2pGS3Nw?=
 =?utf-8?B?MldjTzNwQ0FMR0Y0R2JNbTludW5pQnlnbGxrd2pzamx3U3F0VVVjMnJPSVZ2?=
 =?utf-8?B?b3pCUmpzSFA1S09nZDk4K1Vra0N2TjVzRDhXV29uVm5FellLMXprSGtpOTk5?=
 =?utf-8?B?RWVnNVV3WjZVNThJcFhmSDNib2V2U3JwSUNzd1lBOFpJQ3FHcE9RWmVhOEtU?=
 =?utf-8?B?K0ZkWjMzdUdkWlRPQVl2azV6V0NSeU1Rb2FXcjFhTHdOTExsQ1F2b3BBKzhX?=
 =?utf-8?B?MmIzMzBrTFJ5anlYcnJFYWJLTDBPYjZrTE1FU0tjV2p3MWpBT3VFNHBCUzFH?=
 =?utf-8?B?YytoR01YSGI5UGFITTc5cFJjS2lpcENjdW41anErY3phQjFGQytIbnRrVm1K?=
 =?utf-8?Q?Iu+hRNSqIAC3Cie043hO8vizstErBII6TRvX8Hp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ef088-a906-47bd-bbc4-08d8df697a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 23:58:58.5897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNZobscYgBW+ukzDiFK9S3dAcDan+0UKH2oELaGAJmxD7/ocffATnpObQJPqbN3zYQjKEArn1xdZl2IodBjVTeWK4qkHvWBeTfQ4AyENQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggNCwgMjAyMSAzOjQ5IFBNDQo+IA0KPiBPbiAyLzgvMjAyMSAx
MTo0MiBBTSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTnVubyBEYXMgTmV2ZXMg
PG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlkYXksIE5vdmVtYmVy
DQo+IDIwLCAyMDIwIDQ6MzAgUE0NCj4gPj4NCg0KW3NuaXBdDQoNCj4gPj4gKw0KPiA+PiArc3Rh
dGljIGludA0KPiA+PiAraHZfY2FsbF9jcmVhdGVfcGFydGl0aW9uKA0KPiA+PiArCQl1NjQgZmxh
Z3MsDQo+ID4+ICsJCXN0cnVjdCBodl9wYXJ0aXRpb25fY3JlYXRpb25fcHJvcGVydGllcyBjcmVh
dGlvbl9wcm9wZXJ0aWVzLA0KPiA+PiArCQl1NjQgKnBhcnRpdGlvbl9pZCkNCj4gPj4gK3sNCj4g
Pj4gKwlzdHJ1Y3QgaHZfY3JlYXRlX3BhcnRpdGlvbl9pbiAqaW5wdXQ7DQo+ID4+ICsJc3RydWN0
IGh2X2NyZWF0ZV9wYXJ0aXRpb25fb3V0ICpvdXRwdXQ7DQo+ID4+ICsJaW50IHN0YXR1czsNCj4g
Pj4gKwlpbnQgcmV0Ow0KPiA+PiArCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzOw0KPiA+PiArCWlu
dCBpOw0KPiA+PiArDQo+ID4+ICsJZG8gew0KPiA+PiArCQlsb2NhbF9pcnFfc2F2ZShpcnFfZmxh
Z3MpOw0KPiA+PiArCQlpbnB1dCA9IChzdHJ1Y3QgaHZfY3JlYXRlX3BhcnRpdGlvbl9pbiAqKSgq
dGhpc19jcHVfcHRyKA0KPiA+PiArCQkJaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKSk7DQo+ID4+ICsJ
CW91dHB1dCA9IChzdHJ1Y3QgaHZfY3JlYXRlX3BhcnRpdGlvbl9vdXQgKikoKnRoaXNfY3B1X3B0
cigNCj4gPj4gKwkJCWh5cGVydl9wY3B1X291dHB1dF9hcmcpKTsNCj4gPj4gKw0KPiA+PiArCQlp
bnB1dC0+ZmxhZ3MgPSBmbGFnczsNCj4gPj4gKwkJaW5wdXQtPnByb3hpbWl0eV9kb21haW5faW5m
by5hc191aW50NjQgPSAwOw0KPiA+PiArCQlpbnB1dC0+Y29tcGF0aWJpbGl0eV92ZXJzaW9uID0g
SFZfQ09NUEFUSUJJTElUWV9NQU5HQU5FU0U7DQo+ID4+ICsJCWZvciAoaSA9IDA7IGkgPCBIVl9Q
QVJUSVRJT05fUFJPQ0VTU09SX0ZFQVRVUkVfQkFOS1M7ICsraSkNCj4gPj4gKwkJCWlucHV0LT5w
YXJ0aXRpb25fY3JlYXRpb25fcHJvcGVydGllcw0KPiA+PiArCQkJCS5kaXNhYmxlZF9wcm9jZXNz
b3JfZmVhdHVyZXMuYXNfdWludDY0W2ldID0gMDsNCj4gPj4gKwkJaW5wdXQtPnBhcnRpdGlvbl9j
cmVhdGlvbl9wcm9wZXJ0aWVzDQo+ID4+ICsJCQkuZGlzYWJsZWRfcHJvY2Vzc29yX3hzYXZlX2Zl
YXR1cmVzLmFzX3VpbnQ2NCA9IDA7DQo+ID4+ICsJCWlucHV0LT5pc29sYXRpb25fcHJvcGVydGll
cy5hc191aW50NjQgPSAwOw0KPiA+PiArDQo+ID4+ICsJCXN0YXR1cyA9IGh2X2RvX2h5cGVyY2Fs
bChIVkNBTExfQ1JFQVRFX1BBUlRJVElPTiwNCj4gPj4gKwkJCQkJIGlucHV0LCBvdXRwdXQpOw0K
PiA+DQo+ID4gaHZfZG9faHlwZXJjYWxsIHJldHVybnMgYSB1NjQsIHdoaWNoIHNob3VsZCB0aGVu
IGJlIG1hc2tlZCB3aXRoDQo+ID4gSFZfSFlQRVJDQUxMX1JFU1VMVF9NQVNLIGJlZm9yZSBjaGVj
a2luZyB0aGUgcmVzdWx0Lg0KPiA+DQo+IA0KPiBZZXMsIEknbGwgZml4IHRoaXMgZXZlcnl3aGVy
ZS4NCj4gDQo+ID4+ICsJCWlmIChzdGF0dXMgIT0gSFZfU1RBVFVTX0lOU1VGRklDSUVOVF9NRU1P
UlkpIHsNCj4gPj4gKwkJCWlmIChzdGF0dXMgPT0gSFZfU1RBVFVTX1NVQ0NFU1MpDQo+ID4+ICsJ
CQkJKnBhcnRpdGlvbl9pZCA9IG91dHB1dC0+cGFydGl0aW9uX2lkOw0KPiA+PiArCQkJZWxzZQ0K
PiA+PiArCQkJCXByX2VycigiJXM6ICVzXG4iLA0KPiA+PiArCQkJCSAgICAgICBfX2Z1bmNfXywg
aHZfc3RhdHVzX3RvX3N0cmluZyhzdGF0dXMpKTsNCj4gPj4gKwkJCWxvY2FsX2lycV9yZXN0b3Jl
KGlycV9mbGFncyk7DQo+ID4+ICsJCQlyZXQgPSAtaHZfc3RhdHVzX3RvX2Vycm5vKHN0YXR1cyk7
DQo+ID4+ICsJCQlicmVhazsNCj4gPj4gKwkJfQ0KPiA+PiArCQlsb2NhbF9pcnFfcmVzdG9yZShp
cnFfZmxhZ3MpOw0KPiA+PiArCQlyZXQgPSBodl9jYWxsX2RlcG9zaXRfcGFnZXMoTlVNQV9OT19O
T0RFLA0KPiA+PiArCQkJCQkgICAgaHZfY3VycmVudF9wYXJ0aXRpb25faWQsIDEpOw0KPiA+PiAr
CX0gd2hpbGUgKCFyZXQpOw0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIHJldDsNCj4gPj4gK30NCj4g
Pj4gKw0KDQpJIGhhZCBhIHNlcGFyYXRlIHRocmVhZCBvbiB0aGUgbGludXgtaHlwZXJ2IG1haWxp
bmcgbGlzdCBhYm91dCB0aGUNCmluY29uc2lzdGVuY3kgaW4gaG93IHdlIGNoZWNrIGh5cGVyY2Fs
bCBzdGF0dXMgaW4gY3VycmVudCB1cHN0cmVhbQ0KY29kZSwgYW5kIHByb3Bvc2VkIHNvbWUgaGVs
cGVyIGZ1bmN0aW9ucyB0byBtYWtlIGl0IGVhc2llciBhbmQNCm1vcmUgY29uc2lzdGVudC4gIEpv
ZSBTYWxpc2J1cnkgaGFzIHN0YXJ0ZWQgd29yayBvbiBhIHBhdGNoIHRvDQpwcm92aWRlIHRob3Nl
IGhlbHBlciBmdW5jdGlvbnMgYW5kIHRvIHN0YXJ0IHVzaW5nIHRoZW0gaW4gY3VycmVudA0KdXBz
dHJlYW0gY29kZS4gIFlvdSBjb3VsZCBjb29yZGluYXRlIHdpdGggSm9lIHRvIGdldCB0aGUgaGVs
cGVyDQpmdW5jdGlvbnMgYXMgd2VsbCBhbmQgdXNlIHRoZW0gYXMgZGlzY3Vzc2VkIGluIHRoYXQg
dGhyZWFkLiAgVGhlbg0KbGF0ZXIgb24gd2Ugd29uJ3QgaGF2ZSB0byBjb21lIGJhY2sgYW5kIGZp
eCB1cCB0aGUgdXNlcyBpbiB0aGlzDQpwYXRjaCBzZXJpZXMuDQoNCk1pY2hhZWwNCg==
