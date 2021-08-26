Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA33F8C7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Aug 2021 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhHZQvg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Aug 2021 12:51:36 -0400
Received: from mail-oln040093003014.outbound.protection.outlook.com ([40.93.3.14]:38737
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243119AbhHZQvV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Aug 2021 12:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE4LTFtA6swMCBB0CdHx0YvjBj2EEMYjLnaIFSoVRm6ciDz7ijVRdv43keWjHUIkhLyRsI+kjt0hW4qHsglXzskG3yxAunJcMo3QtKGwXpKOb8x6vtsCPib/15nqMRdI39oqCDUSrfx80sK/0bhQJAb8AXo8kgZJG589zeKwOmDP76l3T/d8jZqGhKvTk6fuiCIB2fFE9TxeGkPlzRwj/+RxvpIRazM9AYPPwt0TbtUYb+7EIDbE/QnC65UH/KZdFWIIMrhmBjoEHQ1fMV+kVM6H6BMzqyABqXffps4GsXivnezv+M1exS+Q1g/LUWe/I4TGOoqj5QQkDGSR9HIZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5t5Ahcge3p2EKRmm6Iw8tAFkLV2reT5+0eBwDMMG5sc=;
 b=iVMzo84m8sXHHBFgqDNALLrGMxQbxPRUa0Q1vK1s+a4LbeNNtrpQboDw4D6T7bWiigR3m41ahnxge+jPiyoEjGVl+dLEopWTqrXi/QKp91cOa3ShwofitrfjtxP6nl48jvqWJTUrDWoUN7qFQvWrMptpxuw7JmiNrDoaenHc4+Exzd9y+UmB4A6ibNZ/UIippa2X6e2sqg7xQf38lCv0YR3JoJG1jfSC9YL+cBSSDrldIslKT9mhFiQ3ktoGW6mlH3zFbiRQzLtHRyBH6fTjn/JnT9BK8PJKpdscygGuK5HhT6xjB+Parx8EgmH9GqQKP62krQZCB5RQelEaki60VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t5Ahcge3p2EKRmm6Iw8tAFkLV2reT5+0eBwDMMG5sc=;
 b=VZ+cDJWDmPgirifk3MAUWUTy2Zbpp6pebgKtAUTYRSDl5OJkHk504o6VHt0lCKLpE58w5kAVY5ehHetwnd87nvhiQl230tjEagIHx6/cHzhiH0SHlVG1mWnhNTz6ZzHgFDquwEj4CSMagoX4Px1eOwbbVZ6V3mtERG7fdWHkec4=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0905.namprd21.prod.outlook.com (2603:10b6:302:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.1; Thu, 26 Aug
 2021 16:50:28 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.004; Thu, 26 Aug 2021
 16:50:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
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
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiESLmzOYeb6EiXQYn0jJPYeauCfYUAgABr14CAAa0jQIAAFqAAgAFUfQA=
Date:   Thu, 26 Aug 2021 16:50:28 +0000
Message-ID: <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8eb6a14f-f3c0-4df9-987b-c38e40597571;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T17:27:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7e54b87-46b1-4776-c5f0-08d968b19bfa
x-ms-traffictypediagnostic: MW2PR2101MB0905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09051DCEF3F963BD54888BB5D7C79@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FO8vS6xSGSsJBiECjyUpt0PqFVcU4qcfDIiLafs0qtSwCJeD40FVff9MGTYOk8eLPuxwEl9b+MA0410R9Whvys2RC5NMRKl8OB676y1uacNib9SsUpkq6kVinxTQ+AdsqTgOR5VBwwty+NmH5z6ffKOLpGAlopw8xQoYum2zzdzFQkwXuWlKGwHzGC0Sp3rp5EQekq6BMgyGsExmaLNq/Cpt3zbXCdQzPP+XAFLi4AWXGOQhZYRqnGsEUtfMrpZwwI2GD9czUUpeknSM/e9F9XGqUVqQDXnhLRSAPLwH5n7bBNL+uPcSFyGG0TjfwK1mh65TBmOpnR42hvDRr1vPdVMuoQ3mkdoRRt0JlhTp10sWC2wBzYJkrxKXtHzroghBAIkMKZtAvZzQz5cMMq+R3S1T3oZoP48JWpb5Ef/bCerU6sKVhhD4b7J1a1bb3/6tykByt1rdg04SzpHIBQSJaamY/SjRJky3CILwAxK5ZkqRgbQV8djYSjHMcnqe1PGFtJqUx5ogq6wbrn9jIHevV0nAzQJvQ7IMdkXCS5qM1JmKxtbHHhgcs6Hm9DKnbEDuTDuls9t3cByvgM9piBia9lfj5JymhJ20b4z4GtPVruy2URv50Bi7GyFPJDJT6TLjbkqCiVG7JCPlyIjE/M8Ous3qXRQ4iMm6NEihcjAz6qo+I4wVciBHJDM0/35FlaV6Pc9FctA0s5us80cx/9N51w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(76116006)(64756008)(52536014)(66476007)(66946007)(110136005)(66556008)(6506007)(8990500004)(55016002)(186003)(66446008)(38070700005)(26005)(10290500003)(5660300002)(54906003)(83380400001)(33656002)(8676002)(4326008)(9686003)(122000001)(7416002)(2906002)(86362001)(71200400001)(82960400001)(38100700002)(7696005)(508600001)(82950400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S09tTkxqbUdsUTB0UGN0SEtCZ2FVZEl3aXVFdG10Y2w5MWJUVkZMYzN1bUNE?=
 =?utf-8?B?UGs4aUJhM0VqZ2x1cHZXc0VlTDQvRm90UVdpWUd2TTM1TEpEOGxWdnNRdllt?=
 =?utf-8?B?NHVFdHByY0Z0QUJxclRIdnQyVDlWQlRRUllDMTQxL050M1Bsc3QvYXhkLzdR?=
 =?utf-8?B?U3dzNXVEeWF6Qi9WSFhKSkpwL3FIUGkrU1B0eG41WkFjaWFWMHVNRXIzSUJ3?=
 =?utf-8?B?QUk4NTJKV0w1azIwRzBRTEtYYkNhSFhCbTJZYzBSTE9UblRibFlzUkU1MDF6?=
 =?utf-8?B?LzBUVWF1Z1F2SmNiazI2MHozSW5qQy9LNFpZdUlSWFNxc2pLZXFETFVMMHA3?=
 =?utf-8?B?UlVoYXpNNndCdUZJTzRYRUNoNUhhZ2pYYit2YStvZE84dTJSRVJYT2JteVNj?=
 =?utf-8?B?OUxKRTJVdktBM29OdkdYYkFXUk9PNUJwNjVqaTRvLzF3SFZHNGJWSU12cjRy?=
 =?utf-8?B?NHR6elZVTzBob2ZVUDNjb29SLzBSNFJHMzN3eUU4K3BOd0x2R3pVUVlUNTVW?=
 =?utf-8?B?NE8yQnpnUDZ0cm4yb3MvQ1Z2KzN4MVEyZjdIaitwNm1yaDVSOEhhcmFPNlFl?=
 =?utf-8?B?RWhNbkVCaWlra01aTFNXK0ZGK04wNVlyTmNxZ2VLVzNHWVpvS0Ura2NNaTVN?=
 =?utf-8?B?MlB5K05SbUJXcVBpVnNNVCtieWlENitXYk9GZ3VZdTFwN29RTjdyWmpRa2F1?=
 =?utf-8?B?MGJXRkN5dDFzaitLdzZEblJLZHhuQjArT2dzQVpxblEwbng2blh2ZTJ5eGZu?=
 =?utf-8?B?bm9iSXRxTThObitBd3RnSkNheURYSUZlTnJLS1J4bzJxWkZUWDV0QUFNeURk?=
 =?utf-8?B?eWVaOU1CM0FpbVlTbW9ES0h2Z0F5OFlScXNwTjZoZjJFSEFRVzNIakhFaWtR?=
 =?utf-8?B?OENFM0NyRnRvV1orZk5qczBtTXhRV3FHczlKaGp3dFhmQ2ZxcXY4aXV2N3hS?=
 =?utf-8?B?OXZnckVkaUdvUUk0R1lPZFlsZ2lHY0Yxb09wKzhFRkFGNjRrNERmdTh1U0pv?=
 =?utf-8?B?T0VzM3FFcmp2MEFWK3FpdWxKcEJubkxrRlR6d1Q0S05oSWRZVWhsZDJmeUFk?=
 =?utf-8?B?QVpRdjZGaWU5Q2VoS253RFViV3d6TU1yYXJIZkZWUHBaRmh3M1htY1VsL1Bv?=
 =?utf-8?B?dFQ2L0R4MVJ4dVhJcGdrTVd0L2wxVUkrOW1TbWxKZk0rektzOXM2TUgvWUZm?=
 =?utf-8?B?WXc1L2dub2ZZR3BrVDlVN2ZWY08yb2Evd1Mra3d5MVBWMERMRWlob3VLUjdH?=
 =?utf-8?B?RFRFbE9iYUZ4RjdMRWJoV1kyNmROZmdhVmRlR3JKdm9JWlppL0k1S1JEcVJn?=
 =?utf-8?B?SHU2b29GRHB1MVo1elNydm9CdnVHMjdibFRrTkRBRFZIMkNnaUp4eHdNOUw1?=
 =?utf-8?B?QjM5Y2Rlc0Zlc01IbkN4ZDRvOG9ZRWNIbStXZFJkeFlVeWtlNTdxTmozUjkx?=
 =?utf-8?B?WDNKNjNZbEo1MkVRdUlLWnV2Y3BaR3FPcklIemNEbno5eFZ4NHFQZDdNVlhy?=
 =?utf-8?B?MXRmWUlTV1BOd1k0OWFIWFhtT1N5WHJrb3hNcVBLRE5GMHA3M0orMnNFenNa?=
 =?utf-8?B?QWxoMWowemlEMEtOd3oyb2ZUd3ZqYnh6ZEhvTTNSVTBYcEJVeDZqS1FCdDBx?=
 =?utf-8?B?TTZFalFJSi9FSXJKYm8ycFNGU2k2eHE4SEtWSENuVmp5OHNvVWhqS0p4cEw4?=
 =?utf-8?B?NlAvc2pYNURNQWlsSldoc3F1M1Q0ejgrT3NVaHpwdmpCcjhJUWd1c2d3UHY5?=
 =?utf-8?Q?j/1sl23N8WCFKQJzkYOkL9L6P/+rO42PZ3e5OVQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e54b87-46b1-4776-c5f0-08d968b19bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 16:50:28.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5RQsZ7/BtJP0fpPR19LXycYcc3lLSiH4NbZwDM9RyqfAbSvjQcMlXW4lzk92RnVmy29wRArJj2hZhStBBsyD5YSdhB4QPxDXc5l2w0SixE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI1LCAyMDIxIDE6MjUgUE0NCg0KPiA+DQo+ID4gSSB0aG91Z2h0IGxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZSgpIGlzIGZvciB1c2Ugd2hlbiBsaXN0IG1hbmlwdWxhdGlvbiBpcyAqbm90Kg0K
PiA+IHByb3RlY3RlZCBieSBhIGxvY2sgYW5kIHlvdSB3YW50IHRvIHNhZmVseSB3YWxrIHRoZSBs
aXN0IGV2ZW4gaWYgYW4gZW50cnkgZ2V0cw0KPiA+IHJlbW92ZWQuICBJZiB0aGUgbGlzdCBpcyBw
cm90ZWN0ZWQgYnkgYSBsb2NrIG9yIG5vdCBzdWJqZWN0IHRvIGNvbnRlbnRpb24gKGFzIGlzIHRo
ZQ0KPiA+IGNhc2UgaGVyZSksIHRoZW4NCj4gPiBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkgaXMgdGhl
IHNpbXBsZXIgaW1wbGVtZW50YXRpb24uICBUaGUgb3JpZ2luYWwNCj4gPiBpbXBsZW1lbnRhdGlv
biBkaWRuJ3QgbmVlZCB0byB1c2UgdGhlIF9zYWZlIHZlcnNpb24gYmVjYXVzZSBvZiB0aGUgc3Bp
biBsb2NrLg0KPiA+DQo+ID4gT3IgZG8gSSBoYXZlIGl0IGJhY2t3YXJkcz8NCj4gPg0KPiA+IE1p
Y2hhZWwNCj4gDQo+IEkgdGhpbmsgd2UgbmVlZCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoKSBi
ZWNhdXNlIHdlIGRlbGV0ZSB0aGUgbGlzdCBlbGVtZW50cyB3aGlsZSBnb2luZyB0aHJvdWdoIHRo
ZW06DQo+IA0KPiBIZXJlIGlzIHRoZSBjb21tZW50IG9uIGxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZSgpOg0KPiAvKioNCj4gICogTG9vcCB0aHJvdWdoIHRoZSBsaXN0LCBrZWVwaW5nIGEgYmFja3Vw
IHBvaW50ZXIgdG8gdGhlIGVsZW1lbnQuIFRoaXMNCj4gICogbWFjcm8gYWxsb3dzIGZvciB0aGUg
ZGVsZXRpb24gb2YgYSBsaXN0IGVsZW1lbnQgd2hpbGUgbG9vcGluZyB0aHJvdWdoIHRoZQ0KPiAg
KiBsaXN0Lg0KPiAgKg0KPiAgKiBTZWUgbGlzdF9mb3JfZWFjaF9lbnRyeSBmb3IgbW9yZSBkZXRh
aWxzLg0KPiAgKi8NCj4gDQoNCkdvdCBpdC4gIFRoYW5rcyAoYW5kIHRvIFJvYiBIZXJyaW5nKS4g
ICBJIHJlYWQgdGhhdCBjb21tZW50IGJ1dA0Kd2l0aCB0aGUgd3JvbmcgYXNzdW1wdGlvbnMgYW5k
IGRpZG4ndCB1bmRlcnN0YW5kIGl0IGNvcnJlY3RseS4NCg0KSW50ZXJlc3RpbmdseSwgcGNpLWh5
cGVydi5jIGhhcyBhbm90aGVyIGNhc2Ugb2YgbG9vcGluZyB0aHJvdWdoDQp0aGlzIGxpc3QgYW5k
IHJlbW92aW5nIGl0ZW1zIHdoZXJlIHRoZSBfc2FmZSB2ZXJzaW9uIGlzIG5vdCB1c2VkLg0KU2Vl
IHBjaV9kZXZpY2VzX3ByZXNlbnRfd29yaygpIHdoZXJlIHRoZSBtaXNzaW5nIGNoaWxkcmVuIGFy
ZQ0KbW92ZWQgdG8gYSBsaXN0IG9uIHRoZSBzdGFjay4NCg0KTWljaGFlbA0K
