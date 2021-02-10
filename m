Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58739315FCD
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Feb 2021 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhBJHBU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Feb 2021 02:01:20 -0500
Received: from mail-eopbgr750125.outbound.protection.outlook.com ([40.107.75.125]:65243
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231732AbhBJHBR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Feb 2021 02:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd+fXtr35650Mv+1QLVUPZUv0c14aWzDKQmT1F0wig9ARR5FXtIgBpgdvt/nzajH4Y11h8z/IBvefa6UdyLi5uU0jqgmkFjLXr7eAWewYT/LXIvAmtkeIOevTbdFKkS2gJYgstwRENyEc/8unxcVsU5IKcU2bmml9jxtkA56yYHAzlo5U1AylzKrpToZ3Muwc2wUPuIbh/zRA1JQx65/6G1sMa79P/6P/ROWFpTNLrQm1oGxUwCcZbILEY+ZRQG35riEjcifdkUUr9KOPxTxSKAsJavdV+x5JgsXB2QxqPrsa8fysfWSX4XkdHgUW4TGjEfrpGogF7FDNR+KczZ2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1K0bGAMC8tqP5Lb1lR4/JgSHm6czGOulYY0WgpC3fE=;
 b=iajV4ap3SxMeG3g3qplxm1nx/ijXy5M3RmyBoohoEQMhMY5PUqoczDGiKsijtIU+R2siSX2FcCjnCYuwIGxe3moTsOq7qNwd/c8MrcFkUoDslmIpcKrZKc6DSDIZ1q74T9t/Q1L7aZAzcSCADVntDW8ffJhCbCeHAAPNo35P8wgWSMiuVAaPZSvnsT7u7G9mUleJNBkGVtGSXW/3vUAm0DxZa6HO0MNm437+FgIgrhHrorYjC0VM5gvuGfE3Y2dpo0B00dm0jvqtUhYoRBwppHW+5fUEEn5KIRMQRNuTMatFNshqzmZiqnY37UyMKYR/cqzmHYsF37fzMTDr2TQ3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1K0bGAMC8tqP5Lb1lR4/JgSHm6czGOulYY0WgpC3fE=;
 b=Bbv6EvZZymPJglxb6uatXv0FOb5MclO4p+/VvMOh4Xa1+HPYBpILsSSP/h5Lp4f+5eh/BED6FFX3bivH1o4lnIV4MlotZOMnhzlyVPRl58/aySqxkSWPQ5lH3mXbpaeDituHAi2NSlaY+Q/O9wxmDLW/eZ024O2KGlK/yUH8cjM=
Received: from MW2PR2101MB1787.namprd21.prod.outlook.com (2603:10b6:302:8::15)
 by MWHPR21MB0157.namprd21.prod.outlook.com (2603:10b6:300:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Wed, 10 Feb
 2021 07:00:24 +0000
Received: from MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de]) by MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de%7]) with mapi id 15.20.3868.005; Wed, 10 Feb 2021
 07:00:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     James Morse <james.morse@arm.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Leandro Pereira <Leandro.Pereira@microsoft.com>
Subject: RE: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Topic: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Index: AdbQHxbRjXJd8DrBQaCk5mureoGP6groIEYAAA2Kt1AAxnB7gAAZhNXA
Date:   Wed, 10 Feb 2021 07:00:24 +0000
Message-ID: <MW2PR2101MB17871D61A226D106EACA7B8ABF8D9@MW2PR2101MB1787.namprd21.prod.outlook.com>
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
 <CAJZ5v0jRgeAsyZXpm-XdL6GCKWk5=yVh1s4fZ3m0++NJK-gYBg@mail.gmail.com>
 <MW2PR2101MB1787B5253CAA640F8B7D2860BFB29@MW2PR2101MB1787.namprd21.prod.outlook.com>
 <204fa040-115e-552a-5fc1-5520f10bc402@arm.com>
In-Reply-To: <204fa040-115e-552a-5fc1-5520f10bc402@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9af99347-80ae-493a-ac37-f14abe1da8f4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-10T06:25:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d30b542-ecc7-48d8-0889-08d8cd918a54
x-ms-traffictypediagnostic: MWHPR21MB0157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB015747FFC4A94895CABC3403BF8D9@MWHPR21MB0157.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: up3MMx/DHWXKdnbFH5yaetZkh8RoQ6ehlbTmxdivxko45osYgbkC3jvIsJBKY86SSMWVJWoB92cbH2+IU07OcId4bmM/WlKJF5p1Qe/oSf/uIWhIAblTZ/r3WyFNXst7Up6OmU4VSUA5a5PkxuCrucjLaYQIeMBDoIs40fld5pzUvbHdEIfo41dfqVTZRX6FTq38N+NJhpgQdrnpE1FkglLG8necFh/8T8XpM7qMHdJN3oarMNUdeqMt39pt8JsHhyPvYdMVqnb3b/Bgfm/NKk4fgNj/juusJaCvcYqWzHYyJlGqfxPRQNDrDI6fPnrSDrd1A+F50B8wZ5aOF1thfAmlK7jvM7VzLPrEA1fPpEE0KWyPdSRxkYoe9dBAC972yyzN/9KpQqFI5HaVnAWBBFxdESZtikDQt5rFLIEFkdgD7PXzGXKGnBk1//OLL/zN+ozOzG20yiAW0nqshljynmhEBMOx67cndhUaINkdd5qibcDmrX9iVL7GPqZRthwpdI8ntLIfk+ATZyys3wDRRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1787.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(55016002)(7696005)(6506007)(15650500001)(86362001)(53546011)(82960400001)(478600001)(5660300002)(52536014)(9686003)(6916009)(82950400001)(66446008)(4326008)(66476007)(66556008)(26005)(2906002)(8936002)(64756008)(316002)(76116006)(8676002)(107886003)(10290500003)(66946007)(8990500004)(186003)(54906003)(83380400001)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzZSRXlDWWRVd0ZPdWpwWU5JMzJJU0oxTllFbjQxMnkzbGNVRHhRaGZGRlBZ?=
 =?utf-8?B?M21nNnhLTHBvNWhtbDVJUTMzMlZiVDdKdXBWR2JXUGpMWkZsek9nNDlKUmhx?=
 =?utf-8?B?aEFwdGlkN2hPWC9sakZ0Y0trMlhEd3ZoWWF3Nnl1SGtyT0JER0hDMC9MeGd3?=
 =?utf-8?B?ZVhUS0xpa2NWMDN1SHJyVVhXakRnWHFWaFUzNXY1M1dtaGZuc0UwUHlHV3dI?=
 =?utf-8?B?aWUwNWlMYk1JSTRuU3dZODJRSkZwa3VITkZUeXlhRS9rckpoSFk3aWZ2MVJR?=
 =?utf-8?B?V1lGK2NmSFRlT0N3cGhWeFU0eGpyV29iZHI5bXVKTjdhbUtiMmphUEdBTmNR?=
 =?utf-8?B?R0tMdXlEbUdPMFd4c2pRNDJVRWxZTU53YSswR1M0QlB2bWwybmhNQnhyNDZt?=
 =?utf-8?B?Um9PRFpmVzlWcDFvbVJDVjg1VmdHbmw5emFUOEFVWW5WVVlwcFI3VDJkbGx4?=
 =?utf-8?B?VXBCS3g1ZHRCTWpUNFl4SW0vcTJqdGpHbWRDWXlpdEp3eFNONG8rT3RKMWs0?=
 =?utf-8?B?MjFjT2F1azlLNU9JWGFuS1VLQmxtVitaOFd6RFNnL01Ic2hiZTJhbTYzZEhC?=
 =?utf-8?B?bEUvcncwZG02b0lUQVVTSVdnVS9rNm9HczNTM2lac21DaVBlTmRPclgwVzdq?=
 =?utf-8?B?cFdXZUFPYWpXQWxKN1RIRXNJd1RWdHZEdm5oU0FwMHJOWlpXT0dNejI5dHpK?=
 =?utf-8?B?MUN1RkR3NlJNdit2bWN4MkJtT0djMDljMkUweDRvNVh6RDZ0NWREQXVzSG1o?=
 =?utf-8?B?MXk5eFAwYmtHRU1Qam5FV093STJud3RjaVJKYThDK2RzN0FaSmRoa050cGlY?=
 =?utf-8?B?aW5vb3d0T2QxQVQ0YlREY1BDOUtCSzFvaXpDRE5aSmZlbE9iajJBUWkxRUxj?=
 =?utf-8?B?a2xTSFhZc1htVUVxbWtJRWUrTWkrZThCTHFBU0NSQjhleGFwZ3Rna2JMbG54?=
 =?utf-8?B?SWJ5aHVlUGllWWc0dXZ3L0QyWFZOdXZRRFBDeHlEaU1udlBFUjlsK0c1ektt?=
 =?utf-8?B?L1BpNlI3ZnBIMzFreHpzTm1NL2V0dytRTytlUWdPYTFjbC9rTko3WnJsR3JQ?=
 =?utf-8?B?RmZNVlUwWVhXOTg3U1pSNmVPQkRLMk1ud3RPdFQ2SWEvQS94RnZYRTZ5MFg5?=
 =?utf-8?B?TTRqQ3VSTzJLQmhZM1JYMnJwemVITldrTTB5b0lHVVV1dHFlYTB2QUVIWmp5?=
 =?utf-8?B?NGI5UFFvMHJoK2ZMeC8yWXdOWUVKaFFWZ24rbXllc05aeXRSQzAzRXBFWXVy?=
 =?utf-8?B?eW5waWt4Ymh0dnY4aUsyRmxYY2NmMU11eWZBQkdwZW1FNHhsYmRRcWo3SExT?=
 =?utf-8?B?ZUJaUjRCbWI5VUhMak4xc3lXNk1SazUvQU84ZVRvSGtZZVBvdnpibWY4Tkk0?=
 =?utf-8?B?WnRpNUU5SkcvS3dIRlRnK24xcmZlcVZFZXFxOFZnY2NwV3lGV3dzaXFzWUx2?=
 =?utf-8?B?SGNneThYdGRuWVg4L1U3czJDdmRvYnJ2YjZkSzBQVHMxOTBPV1h3Ry9rQmd2?=
 =?utf-8?B?aGhCd2VQQXg4S0xxbjVMR1hra0Q5Tnc2K0Fla25lUExoVVR2OWJhUG9GKzA2?=
 =?utf-8?B?Znh3NHRaVldMZ1NXU0p4MG9DVG9WeUkrUkxLWW0zSEpZUnhFL1Q5UGNKZ3Jy?=
 =?utf-8?B?UlE5ay9lQkVldGtuMlVtMFJ3VjgvNmJLT1FvbmI4bGVEdTh3ZHo1bWZXSUdS?=
 =?utf-8?B?ai9qbDZTbmVLQitJSFErbUZramlrNmx6TVVCNWlQN0FicmpZbEtxcHdwOUlK?=
 =?utf-8?Q?nSDAbFM8xxVesbTO0mXRiRjWAByeGMkXUsLl8Qh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1787.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d30b542-ecc7-48d8-0889-08d8cd918a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 07:00:24.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5jwIi3CxPpaU6dRm+SbPMfdnV3AliyyASL+W+GFVZJI2ea6Qe2TK4KxE5R+AwHjTIkNx05dHXYX+AETcDdW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0157
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgRmVicnVhcnkgOSwgMjAyMSAxMDoxNSBBTQ0KPiBUbzogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47
IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBNaWNoYWVsIEtlbGxleQ0KPiA8bWlr
ZWxsZXlAbWljcm9zb2Z0LmNvbT47IExlYW5kcm8gUGVyZWlyYSA8TGVhbmRyby5QZXJlaXJhQG1p
Y3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBIb3cgY2FuIGEgdXNlcnNwYWNlIHByb2dyYW0g
dGVsbCBpZiB0aGUgc3lzdGVtIHN1cHBvcnRzIHRoZSBBQ1BJDQo+IFM0IHN0YXRlIChTdXNwZW5k
LXRvLURpc2spPw0KPiANCj4gSGkgRGV4dWFuLA0KPiANCj4gT24gMDUvMDIvMjAyMSAxOTozNiwg
RGV4dWFuIEN1aSB3cm90ZToNCj4gPj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBr
ZXJuZWwub3JnPg0KPiA+PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDUsIDIwMjEgNTowNiBBTQ0K
PiA+PiBUbzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gPj4gQ2M6IGxpbnV4
LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
PiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlA
bWljcm9zb2Z0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IEhvdyBjYW4gYSB1c2Vyc3BhY2UgcHJv
Z3JhbSB0ZWxsIGlmIHRoZSBzeXN0ZW0gc3VwcG9ydHMgdGhlDQo+IEFDUEkNCj4gPj4gUzQgc3Rh
dGUgKFN1c3BlbmQtdG8tRGlzayk/DQo+ID4+DQo+ID4+IE9uIFNhdCwgRGVjIDEyLCAyMDIwIGF0
IDI6MjIgQU0gRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4+Pg0K
PiA+Pj4gSGkgYWxsLA0KPiA+Pj4gSXQgbG9va3MgbGlrZSBMaW51eCBjYW4gaGliZXJuYXRlIGV2
ZW4gaWYgdGhlIHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IHRoZQ0KPiBBQ1BJDQo+ID4+PiBTNCBz
dGF0ZSwgYXMgbG9uZyBhcyB0aGUgc3lzdGVtIGNhbiBzaHV0IGRvd24sIHNvICJjYXQgL3N5cy9w
b3dlci9zdGF0ZSINCj4gPj4+IGFsd2F5cyBjb250YWlucyAiZGlzayIsIHVubGVzcyB3ZSBzcGVj
aWZ5IHRoZSBrZXJuZWwgcGFyYW1ldGVyDQo+ICJub2hpYmVybmF0ZSINCj4gPj4+IG9yIHdlIHVz
ZSBMT0NLRE9XTl9ISUJFUk5BVElPTi4NCj4gDQo+ID4+PiBJbiBzb21lIHNjZW5hcmlvcyBJTU8g
aXQgY2FuIHN0aWxsIGJlIHVzZWZ1bCBpZiB0aGUgdXNlcnNwYWNlIGlzIGFibGUgdG8NCj4gPj4+
IGRldGVjdCBpZiB0aGUgQUNQSSBTNCBzdGF0ZSBpcyBzdXBwb3J0ZWQgb3Igbm90LCBlLmcuIHdo
ZW4gYSBMaW51eCBndWVzdA0KPiA+Pj4gcnVucyBvbiBIeXBlci1WLCBIeXBlci1WIHVzZXMgdGhl
IHZpcnR1YWwgQUNQSSBTNCBzdGF0ZSBhcyBhbiBpbmRpY2F0b3INCj4gPj4+IG9mIHRoZSBwcm9w
ZXIgc3VwcG9ydCBvZiB0aGUgdG9vbCBzdGFjayBvbiB0aGUgaG9zdCwgaS5lLiB0aGUgZ3Vlc3Qg
aXMNCj4gPj4+IGRpc2NvdXJhZ2VkIGZyb20gdHJ5aW5nIGhpYmVybmF0aW9uIGlmIHRoZSBzdGF0
ZSBpcyBub3Qgc3VwcG9ydGVkLg0KPiANCj4gV2hhdCBnb2VzIHdyb25nPyBUaGlzIHNvdW5kcyBs
aWtlIGEgZnVubnkgd2F5IG9mIHNpZ25hbGxpbmcgaHlwZXJ2aXNvciBwb2xpY3kuDQoNCkhpIEph
bWVzLA0KU29ycnkgaWYgSSBoYXZlIGNhdXNlZCBhbnkgY29uZnVzaW9uLiBNeSBhYm92ZSBkZXNj
cmlwdGlvbiBvbmx5IGFwcGxpZXMgdG8NCng4NiBMaW51eCBWTSBvbiBIeXBlci1WLg0KDQpGb3Ig
QVJNNjQgSHlwZXItViwgSSBzdXNwZWN0IHRoZSBtYWlubGluZSBMaW51eCBrZXJuZWwgc3RpbGwg
Y2FuJ3Qgd29yayBpbiBhDQpMaW51eCBWTSBydW5uaW5nIG9uIEFSTTY0IEh5cGVyLVYsIHNvIEFG
QUlLIHRoZSBWTSBoaWJlcm5hdGlvbiBoYXNuJ3QNCmJlZW4gdGVzdGVkOiBpdCBtYXkgd29yayBv
ciBtYXkgbm90IHdvcmsuIFRoaXMgaXMgaW4gb3VyIFRvLURvIGxpc3QuDQoNCkxpbnV4IFZNIG9u
IEh5cGVyLVYgbmVlZHMgdG8ga25vdyBpZiBoaWJlcm5hdGlvbiBpcyBzdXBwb3J0ZWQvZW5hYmxl
ZA0KZm9yIHRoZSBWTSwgbWFpbmx5IGR1ZSB0byAyIHJlYXNvbnM6DQoNCjEuIEluIHRoZSBWTSwg
dGhlIGh2X2JhbGxvb24gZHJpdmVyIHNob3VsZCBkaXNhYmxlIHRoZSBiYWxsb29uIHVwL2Rvd24N
Cm9wZXJhdGlvbnMgaWYgaGliZXJuYXRpb24gaXMgZW5hYmxlZCBmb3IgdGhlIFZNLCBvdGhlcndp
c2UgYmFkIHRoaW5ncyBjYW4NCmhhcHBlbiwgZS5nLiB0aGUgaHZfYmFsbG9vbiBkcml2ZXIgYWxs
b2NhdGVzIHNvbWUgcGFnZXMgYW5kIGdpdmVzIHRoZQ0KcGFnZXMgdG8gdGhlIGh5cGVycHZpc29y
OyBub3cgaWYgdGhlIFZNIGlzIGFsbG93ZWQgdG8gaGliZXJuYXRlLCBsYXRlcg0Kd2hlbiB0aGUg
Vk0gcmVzdW1lcyBiYWNrLCB0aGUgVk0gbG9zZXMgdGhlIHBhZ2VzIGZvciBldmVyLCBiZWNhdXNl
DQpIeXBlci1WIGRvZXNuJ3Qgc2F2ZSB0aGUgaW5mbyBvZiB0aGUgcGFnZXMgdGhhdCB3ZXJlIGZy
b20gdGhlIFZNLCBzbw0KSHlwZXItViB0aGlua3Mgbm8gcGFnZXMgbmVlZCB0byBiZSByZXR1cm5l
ZCB0byB0aGUgVk0uDQoNCjIuIElmIGhpYmVybmF0aW9uIGlzIGVuYWJsZWQgZm9yIGEgVk0sIHRo
ZSBWTSBoYXMgYSBMaW51eCBhZ2VudCBwcm9ncmFtDQp0aGF0IGF1dG9tYXRpY2FsbHkgY3JlYXRl
cyBhbmQgc2V0cyB1cCB0aGUgc3dhcCBmaWxlIGZvciBoaWJlcm5hdGlvbi4gSWYNCmhpYmVybmF0
aW9uIGlzIG5vdCBlbmFibGVkIGZvciB0aGUgVk0sIHRoZSBhZ2VudCBzaG91bGQgbm90IHRyeSB0
byBjcmVhdGUNCmFuZCBzZXQgdXAgdGhlIHN3YXAgZmlsZSBmb3IgaGliZXJuYXRpb24uDQogDQo+
ID4+PiBJIGtub3cgd2UgY2FuIGNoZWNrIHRoZSBTNCBzdGF0ZSBieSAnZG1lc2cnOg0KPiA+Pj4N
Cj4gPj4+ICMgZG1lc2cgfGdyZXAgQUNQSTogfCBncmVwIHN1cHBvcnQNCj4gPj4+IFsgICAgMy4w
MzQxMzRdIEFDUEk6IChzdXBwb3J0cyBTMCBTNCBTNSkNCj4gPj4+DQo+ID4+PiBCdXQgdGhpcyBt
ZXRob2QgaXMgdW5yZWxpYWJsZSBiZWNhdXNlIHRoZSBrZXJuZWwgbXNnIGJ1ZmZlciBjYW4gYmUg
ZmlsbGVkDQo+ID4+PiBhbmQgb3ZlcndyaXR0ZW4uIElzIHRoZXJlIGFueSBiZXR0ZXIgbWV0aG9k
PyBJZiBub3QsIGRvIHlvdSB0aGluayBpZiB0aGUNCj4gPj4+IGJlbG93IHBhdGNoIGlzIGFwcHJv
cHJpYXRlPyBUaGFua3MhDQo+ID4+DQo+ID4+IFNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+ID4+DQo+
ID4+IElmIEFDUEkgUzQgaXMgc3VwcG9ydGVkLCAvc3lzL3Bvd2VyL2Rpc2sgd2lsbCBsaXN0ICJw
bGF0Zm9ybSIgYXMgb25lDQo+ID4+IG9mIHRoZSBvcHRpb25zIChhbmQgaXQgd2lsbCBiZSB0aGUg
ZGVmYXVsdCBvbmUgdGhlbikuICBPdGhlcndpc2UsDQo+ID4+ICJwbGF0Zm9ybSIgaXMgbm90IHBy
ZXNlbnQgaW4gL3N5cy9wb3dlci9kaXNrLCBiZWNhdXNlIEFDUEkgaXMgdGhlIG9ubHkNCj4gPj4g
dXNlciBvZiBoaWJlcm5hdGlvbl9vcHMuDQo+IA0KPiA+IFRoaXMgd29ya3Mgb24geDg2LiBUaGFu
a3MgYSBsb3QhDQo+ID4NCj4gPiBCVFcsIGRvZXMgdGhpcyBhbHNvIHdvcmsgb24gQVJNNjQ/DQo+
IA0KPiBOb3QgdG9kYXkuIFRoZSBTNC9TNSBzdHVmZiBpcyBwYXJ0IG9mICdBQ1BJX1NZU1RFTV9Q
T1dFUl9TVEFURVNfU1VQUE9SVCcsDQo+IHdoaWNoIGFybTY0DQo+IGRvZXNuJ3QgZW5hYmxlIGFz
IGl0IGhhcyBhIGZpcm13YXJlIG1lY2hhbmlzbSB0aGF0IGNvdmVycyB0aGlzIG9uIGJvdGggRFQg
YW5kDQo+IEFDUEkNCj4gc3lzdGVtcy4gVGhhdCBjb2RlIGlzIHdoYXQgY2FsbHMgaGliZXJuYXRp
b25fc2V0X29wcygpIHRvIGVuYWJsZSBBQ1BJJ3MNCj4gcGxhdGZvcm0gbW9kZS4NCg0KVGhhbmtz
IGZvciB0aGUgZXhwbGFuYXRpb24hDQoNCj4gUmVnYXJkbGVzczogaGliZXJuYXRlIHdvcmtzIGZp
bmUuIFdoYXQgZG9lcyB5b3VyIGh5cGVydmlzb3IgZG8gdGhhdCBjYXVzZXMNCj4gcHJvYmxlbXM/
DQo+IChJIHRoaW5rIGFsbCB3ZSBleHBlY3QgZnJvbSBmaXJtd2FyZSBpcyBpdCBkb2Vzbid0IHJh
bmRvbWlzZSB0aGUgcGxhY2VtZW50IG9mDQo+IHRoZSBBQ1BJDQo+IHRhYmxlcyBhcyB0aGV5IGFy
ZW4ndCBuZWNlc3NhcmlseSBwYXJ0IG9mIHRoZSBoaWJlcm5hdGUgaW1hZ2UpDQo+IA0KPiBUaGFu
a3MsIA0KPiBKYW1lcw0KDQpJIGhhdmUgZXhwbGFpbmVkIHRoZSBwcm9ibGVtcyBhYm92ZSBmb3Ig
TGludXggVk0gb24gQVJNNjQgSHlwZXItVi4NCg0KSSBzdXBwb3NlIHlvdSBtZWFuIGhpYmVybmF0
aW9uIHdvcmtzIGZpbmUgZm9yIEFSTTY0IGJhcmUgbWV0YWwuIA0KRm9yIExpbnV4IFZNIG9uIEFS
TTY0IEh5cGVyLVYsIEkgc3VzcGVjdCBzb21lIEh5cGVyLVYgc3BlY2lmaWMgc3RhdGVzIG1heQ0K
aGF2ZSB0byBiZSBzYXZlZCBhbmQgcmVzdG9yZWQgZm9yIGhpYmVybmF0aW9uLiBUaGlzIGlzIGlu
IG91ciBUby1EbyBsc2l0Lg0KDQpUaGFua3MsDQpEZXh1YW4NCg0K
