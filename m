Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F559337F39
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Mar 2021 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCKUpu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Mar 2021 15:45:50 -0500
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:41025
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229490AbhCKUpc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Mar 2021 15:45:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7VKG6iN8TcW6oDFY5wo/tIysv7Q1Y1mIYullOAFDR6nK6rrpn3nQW0qDl0VLNT2TYkZq85uqpgPaKoaPSUjujDTIUAL+j990Hi+EVzKwbr9pO5XzAb/BMC+B1iaPO1PsTcM9eDfrL1sOYdlRV/5h0wSP2yGzoHOQMVipAvb8DhsJs876wl7KZrRKU9P5PA+Po5ihiNVu1i1tTZ5iSDmJusRxuQa7+qdSpmMNno/ku1TIJtGIO6CXkDh8F4VhCWHvE1F2nnSZ23i82WETx3+7f2ko5+keJt1g9GMjIdfck0/IsIfuRt5C3L0R3C1wqUqKPBTqSE8cKR55I8xXDf6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq0db7WPUwYxkbr0L7U39OlwmgKR95IETNFSEJX/Eto=;
 b=odBu9eslc3hZek05nrtMyegdYW+PNSktzMnEVzkYfM1VtDC1nIk3BJqxMLp/F3FbfHhTnNAmJKa0N+2BsFbdDjR8ydkggh6LNr7xv0eIezFpkhWQ1VUC/CIII5C7h2gTj0Zp9t8xSk6TXJrrXdIPInRHiXPzUGW9G2VSGGWfX0R7RlZFUUFJ6h5kVfGTeBGNEeOVbx0LDs0unaVZaElDRxpRwYUQwYqBMM4r5ogkIhrE2mI58ngoPdkT7bqNXaYeS8lmTkuEgRXh/aduBK3oh7ztx21Wpi1OloaYffsh2Dut0xYCBZl40jyM8aHqqpDmcxcgjWl6MNv0oFOsvRhjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq0db7WPUwYxkbr0L7U39OlwmgKR95IETNFSEJX/Eto=;
 b=fQpJsggheGRHQfOiUV/4yObF5m7hGb9yek9Lfx0Sjei+wR6p8mHjSWAv3xzJ+AyySOQ5mL9SgvmJH7QxAuitvfpCSPVIFZBI0VpXSHJwXTGd1dwi8RLgcvqZurJ2vTjrNUzzqGK8mnYVEpjam8Lcfr8C3QP0dusJBKzLRHf+E3E=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0286.namprd21.prod.outlook.com (2603:10b6:300:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.11; Thu, 11 Mar
 2021 20:45:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.008; Thu, 11 Mar 2021
 20:45:30 +0000
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
Subject: RE: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Topic: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Index: AQHWv52Sf16Ua5UbGEyERkZGDy8rgqpN98MAgDHk+QCAABFkcA==
Date:   Thu, 11 Mar 2021 20:45:30 +0000
Message-ID: <MWHPR21MB1593DACDA296E8DAC5D8BC78D7909@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-12-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593EC8F1ACA57299AB5016AD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <9e06a119-880f-5199-903b-056675331d6f@linux.microsoft.com>
In-Reply-To: <9e06a119-880f-5199-903b-056675331d6f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-11T20:45:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c330553d-a3fa-4b52-bafb-5d76f7bbe704;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f91ef307-066e-476a-1309-08d8e4ce9bec
x-ms-traffictypediagnostic: MWHPR21MB0286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB028670766298858E5523159AD7909@MWHPR21MB0286.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ta3GsT1cp7Z0bEDIauYIfWD7yaN/K6bRX2kyKDaPRW4g6UuffTgikJnsW2nM8OpFA7YnPkD9ya5puOO8zpzZ5xY8di7ggcF40SHQHprnDBy6kenC6YnrD1cyYvaVZRFPuEX2HUTT9fzX1icWzVR7IEN+Oe4XinrkyXZagqYNMlWqoSh1OXhdn6R7WR7rfeV772rKGdArpUMKTQDEeVDneDvoJkeWoV8Z4lmggOyap7NCsD1Dsbmedn1t/6t7I7cMzoROtFEVWpyA0LMQ/bkzkkDyQaR4QJvpihH+R7JkNQIcPw01ylZ90SqK2J9kMp76m8UypAm0XU0aZfVAc/NII0glg4L7mtVcAYKd8a95ZxyAOq+RAFQ0PxA6h1w1q0BRzSkMfj6+2a/7qpT/RVv4ZUnqvyRIxrN8VA8fWB7GSicr4IYSMMN14rX1XD+7EcjOvTrjIR0bj6rEVPslzPl4b4cTYYUXzE2xN/JGeLB7cNbpfLejkc2sbx5X2rfcfsaIg4FOOjo4L67lTl8TNgfhDShT7xA00hS6k89L3fsdrVw/NvVbVQ5Bos9ZL1uFBVmk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(107886003)(9686003)(53546011)(82950400001)(66476007)(33656002)(6506007)(76116006)(71200400001)(66446008)(7696005)(478600001)(82960400001)(64756008)(316002)(8990500004)(66556008)(10290500003)(66946007)(2906002)(86362001)(52536014)(4326008)(8676002)(8936002)(15650500001)(54906003)(5660300002)(110136005)(26005)(83380400001)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R3FFdUtpRVF2MktqWC9lWGlwTzExVWxwdXRWYndDQnpSUUZnaUZlVEVQNUJF?=
 =?utf-8?B?YW5VTjZDYW54aW1BQ2NIZm1WaWFNRjE0ejdxblpYeXp4aHNzR1lBOUZoNWRC?=
 =?utf-8?B?MFkyS2dzUXpzU25OdVZmUkFmcStsbUl1dkR0eFI0d1QxRFhXYjgyemFPcDNZ?=
 =?utf-8?B?SHJjR1QxUkkyTG5NV05BQ2RtWWZRUVp6MkMzSGxRS05xbG1oTmJlZkRoRGJP?=
 =?utf-8?B?VHhYSXUxelUyMlpPeTFrbXQ2S3VTOVhmaXBZaUhYMTUxMk40dXg3blltVktX?=
 =?utf-8?B?MCsvcHdCZGh4eDd2SFBBd0xtWTdBaS9pcXZQYTY0OVY1RFZIaHVWczJlWUhi?=
 =?utf-8?B?eTVYRTU5VjA5dzBINmpxdXUrMVhjTVIvc0p4L2pwbTFJSmZhWUo0SHRLVGMv?=
 =?utf-8?B?Sm81diswT05oQ3Nld1NWRUhESWJuQ3RNWEg0Q3dUamdWb2svREs1b3dtU1Ra?=
 =?utf-8?B?QUZoUTVFSlhlcTVhTjgvYzJ0NDlvWUJXeHN0Yld3TVp1OVFjUG5lREN5R3Zq?=
 =?utf-8?B?NDZaTXVmRUlneDdWbThGeHBSWHlLcTVSWDI5dWVFU1d5KzkrcFFnWEhQTVBu?=
 =?utf-8?B?QlpOdStKaTMwWWkycFdib2VneUNNUTFmU3N2bHBzZWtoVEtoektFSTlHYkx5?=
 =?utf-8?B?eEU2K29hWnN4aHJteHBBRHFrdUFLNEpkUUVwaFB6Y2lBZ0k1L2FpYkEyT1Mx?=
 =?utf-8?B?eHFSa3B2d0NZTVBvdld3OUZpUjZWbStxR1JoUjcyYzZqRi9hZXFoNlprZXBI?=
 =?utf-8?B?VlZwT1I5dU9sY1dkUE5TRVEwbkVyS1NheW45ck0wMlRoVmhQNDdsbVhnY25J?=
 =?utf-8?B?Z1RwTE5sQXgwcFZhN1daWERtTEJ0d1lOdkxGZm80SVlDQTRrUzZONm02Rm02?=
 =?utf-8?B?VSt4L0lLZ3lrdnJIVlFlbDB3K0tQbFZqWU0zR3dlenFxejFBckVDUWRnQWl6?=
 =?utf-8?B?eGc0cHRudWszaFhLR0VpaUQ4a0lNbUtzS3VwN1o3VHZMSFpMdjZCd3N2RmxL?=
 =?utf-8?B?SUwxVGl5UkRTM00yendtNHB3b3ozT0NwZmpwa1ZrR0pVays2T3g2T1lDNko2?=
 =?utf-8?B?NEg1K2x6SUhoZmZZdFFIR3Y2UUFwMER3MURwMzByQ0FKR0x5Z25PZEMxdUVH?=
 =?utf-8?B?NktZQ0pkYTdMbXpvL2RseWNaOXhoVzRHdG1JeVAyNUIvTkJJL3hBZTJ2VERR?=
 =?utf-8?B?QUF4d29UZFlQaFJUMmF4dU1rbFFiRS9pQ1l0dGl3MStDMzNweFZZZlJVdWRv?=
 =?utf-8?B?Vm9rVGl6T251VVdSbjU2bVhyL0RhblpsaGlIUkl4SVJEdW93Q253b0RaVDBT?=
 =?utf-8?B?a0htRFR0b0pXQVJheVA1aW1PR3FqeEVIUm52TFJUN1ZnSlNSN2FoTnRZMmQ2?=
 =?utf-8?B?RWw1cjQ4MFNhY0o4Zk95TEMzam5Oc3FNMkRlZEgzWStrUytzMXkxQkUyVDlC?=
 =?utf-8?B?RVg4OWwyWERFWEpTOHBpbE9NdzJpU0k2bGRJcE5ENnZFMXFYUlhpZC9ON2E3?=
 =?utf-8?B?SWVGZkptbGJyTWkrYlBoUEgrZERzZDFpM2J6Z091V2YzVEFSQldEYjgvSGFD?=
 =?utf-8?B?T2NrQmUzTzVBTjY4OVNYY0ZzeEVqby9PRkxGMXR3NXpGNlloWkY2aHZ3aDdq?=
 =?utf-8?B?Mk1JZmVEWTFka2xOZnViTWlkSytmbGNWeUpkeWltUGFnajlaUWFkOTFYcHNl?=
 =?utf-8?B?SERMRmk3R3pXRU1kd2UrZVk1SS9aRUQwdElaaW1uOVdTTnRlaEtLRWlhSFRo?=
 =?utf-8?Q?P61Um/rl4ehbbt+0Vk9Kj33ye2XmzubxSzDEek0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ef307-066e-476a-1309-08d8e4ce9bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 20:45:30.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctiuR1ivK1HF0fa9sV3JD7t5/l1n/6ac5MYYCT7PFhcXMtTjMmZWcy0lSdjKT8bn7bKm2juyMbgoJk897yP+EjXUGsBAr7e4lcpuK76gFBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMTEsIDIwMjEgMTE6MzggQU0NCj4gDQo+IE9uIDIvOC8yMDIx
IDExOjQ3IEFNLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOdW5vIERhcyBOZXZl
cyA8bnVub2Rhc25ldmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IEZyaWRheSwgTm92ZW1i
ZXINCj4gMjAsIDIwMjAgNDozMSBQTQ0KPiA+Pg0KPiA+PiBTYW1lIGlkZWEgYXMgc3luaWMgc2V0
dXAgaW4gZHJpdmVycy9odi9odi5jOmh2X3N5bmljX2VuYWJsZV9yZWdzKCkNCj4gPj4gYW5kIGh2
X3N5bmljX2Rpc2FibGVfcmVncygpLg0KPiA+PiBTZXR0aW5nIHVwIHN5bmljIHJlZ2lzdGVycyBp
biBib3RoIHZtYnVzIGRyaXZlciBhbmQgbXNodiB3b3VsZCBjbG9iYmVyDQo+ID4+IHRoZW0sIGJ1
dCB0aGUgdm1idXMgZHJpdmVyIHdpbGwgbm90IHJ1biBpbiB0aGUgcm9vdCBwYXJ0aXRpb24sIHNv
IHRoaXMNCj4gPj4gaXMgc2FmZS4NCj4gPj4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5OiBMaWxsaWFu
IEdyYXNzaW4tRHJha2UgPGxpZ3Jhc3NpQG1pY3Jvc29mdC5jb20+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IExpbGxpYW4gR3Jhc3Npbi1EcmFrZSA8bGlncmFzc2lAbWljcm9zb2Z0LmNvbT4NCj4gPj4g
U2lnbmVkLW9mZi1ieTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3Nv
ZnQuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZz
LmggICAgICB8ICAyOSAtLS0NCj4gPj4gIGFyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vaHlwZXJ2
LXRsZnMuaCB8IDI2NCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gIGluY2x1ZGUvYXNt
LWdlbmVyaWMvaHlwZXJ2LXRsZnMuaCAgICAgICB8ICA0NiArLS0tLQ0KPiA+PiAgaW5jbHVkZS9s
aW51eC9tc2h2LmggICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPj4gIGluY2x1ZGUvdWFw
aS9hc20tZ2VuZXJpYy9oeXBlcnYtdGxmcy5oICB8ICA0MyArKysrDQo+ID4+ICB2aXJ0L21zaHYv
bXNodl9tYWluLmMgICAgICAgICAgICAgICAgICAgfCAgOTggKysrKysrKystDQo+ID4+ICA2IGZp
bGVzIGNoYW5nZWQsIDQwNCBpbnNlcnRpb25zKCspLCA3NyBkZWxldGlvbnMoLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oDQo+ID4+IGluZGV4IDRjZDQ0YWU5YmZmYi4u
YzM0YTZiYjRmNDU3IDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBl
cnYtdGxmcy5oDQo+ID4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgN
Cj4gPj4gQEAgLTI2NywzNSArMjY3LDYgQEAgc3RydWN0IGh2X3RzY19lbXVsYXRpb25fc3RhdHVz
IHsNCj4gPj4gICNkZWZpbmUgSFZfWDY0X01TUl9UU0NfUkVGRVJFTkNFX0VOQUJMRQkJMHgwMDAw
MDAwMQ0KPiA+PiAgI2RlZmluZSBIVl9YNjRfTVNSX1RTQ19SRUZFUkVOQ0VfQUREUkVTU19TSElG
VAkxMg0KPiA+Pg0KPiA+PiAtDQo+ID4+IC0vKiBEZWZpbmUgaHlwZXJ2aXNvciBtZXNzYWdlIHR5
cGVzLiAqLw0KPiA+PiAtZW51bSBodl9tZXNzYWdlX3R5cGUgew0KPiA+PiAtCUhWTVNHX05PTkUJ
CQk9IDB4MDAwMDAwMDAsDQo+ID4+IC0NCj4gPj4gLQkvKiBNZW1vcnkgYWNjZXNzIG1lc3NhZ2Vz
LiAqLw0KPiA+PiAtCUhWTVNHX1VOTUFQUEVEX0dQQQkJPSAweDgwMDAwMDAwLA0KPiA+PiAtCUhW
TVNHX0dQQV9JTlRFUkNFUFQJCT0gMHg4MDAwMDAwMSwNCj4gPj4gLQ0KPiA+PiAtCS8qIFRpbWVy
IG5vdGlmaWNhdGlvbiBtZXNzYWdlcy4gKi8NCj4gPj4gLQlIVk1TR19USU1FUl9FWFBJUkVECQk9
IDB4ODAwMDAwMTAsDQo+ID4+IC0NCj4gPj4gLQkvKiBFcnJvciBtZXNzYWdlcy4gKi8NCj4gPj4g
LQlIVk1TR19JTlZBTElEX1ZQX1JFR0lTVEVSX1ZBTFVFCT0gMHg4MDAwMDAyMCwNCj4gPj4gLQlI
Vk1TR19VTlJFQ09WRVJBQkxFX0VYQ0VQVElPTgk9IDB4ODAwMDAwMjEsDQo+ID4+IC0JSFZNU0df
VU5TVVBQT1JURURfRkVBVFVSRQk9IDB4ODAwMDAwMjIsDQo+ID4+IC0NCj4gPj4gLQkvKiBUcmFj
ZSBidWZmZXIgY29tcGxldGUgbWVzc2FnZXMuICovDQo+ID4+IC0JSFZNU0dfRVZFTlRMT0dfQlVG
RkVSQ09NUExFVEUJPSAweDgwMDAwMDQwLA0KPiA+PiAtDQo+ID4+IC0JLyogUGxhdGZvcm0tc3Bl
Y2lmaWMgcHJvY2Vzc29yIGludGVyY2VwdCBtZXNzYWdlcy4gKi8NCj4gPj4gLQlIVk1TR19YNjRf
SU9QT1JUX0lOVEVSQ0VQVAk9IDB4ODAwMTAwMDAsDQo+ID4+IC0JSFZNU0dfWDY0X01TUl9JTlRF
UkNFUFQJCT0gMHg4MDAxMDAwMSwNCj4gPj4gLQlIVk1TR19YNjRfQ1BVSURfSU5URVJDRVBUCT0g
MHg4MDAxMDAwMiwNCj4gPj4gLQlIVk1TR19YNjRfRVhDRVBUSU9OX0lOVEVSQ0VQVAk9IDB4ODAw
MTAwMDMsDQo+ID4+IC0JSFZNU0dfWDY0X0FQSUNfRU9JCQk9IDB4ODAwMTAwMDQsDQo+ID4+IC0J
SFZNU0dfWDY0X0xFR0FDWV9GUF9FUlJPUgk9IDB4ODAwMTAwMDUNCj4gPj4gLX07DQo+ID4+IC0N
Cj4gPj4gIHN0cnVjdCBodl9uZXN0ZWRfZW5saWdodGVubWVudHNfY29udHJvbCB7DQo+ID4+ICAJ
c3RydWN0IHsNCj4gPj4gIAkJX191MzIgZGlyZWN0aHlwZXJjYWxsOjE7DQo+ID4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL2h5cGVydi10bGZzLmgNCj4gYi9hcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL2h5cGVydi0NCj4gPj4gdGxmcy5oDQo+ID4+IGluZGV4IDJmZjY1
NTk2MjczOC4uYzZhMjcwNTNmNzkxIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L3VhcGkvYXNtL2h5cGVydi10bGZzLmgNCj4gPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS91YXBp
L2FzbS9oeXBlcnYtdGxmcy5oDQo+ID4+IEBAIC03MjIsNCArNzIyLDI2OCBAQCB1bmlvbiBodl9y
ZWdpc3Rlcl92YWx1ZSB7DQo+ID4+ICAJCXBlbmRpbmdfdmlydHVhbGl6YXRpb25fZmF1bHRfZXZl
bnQ7DQo+ID4+ICB9Ow0KPiA+Pg0KPiA+PiArLyogRGVmaW5lIGh5cGVydmlzb3IgbWVzc2FnZSB0
eXBlcy4gKi8NCj4gPj4gK2VudW0gaHZfbWVzc2FnZV90eXBlIHsNCj4gPj4gKwlIVk1TR19OT05F
CQkJCT0gMHgwMDAwMDAwMCwNCj4gPj4gKw0KPiA+PiArCS8qIE1lbW9yeSBhY2Nlc3MgbWVzc2Fn
ZXMuICovDQo+ID4+ICsJSFZNU0dfVU5NQVBQRURfR1BBCQkJPSAweDgwMDAwMDAwLA0KPiA+PiAr
CUhWTVNHX0dQQV9JTlRFUkNFUFQJCQk9IDB4ODAwMDAwMDEsDQo+ID4+ICsNCj4gPj4gKwkvKiBU
aW1lciBub3RpZmljYXRpb24gbWVzc2FnZXMuICovDQo+ID4+ICsJSFZNU0dfVElNRVJfRVhQSVJF
RAkJCT0gMHg4MDAwMDAxMCwNCj4gPj4gKw0KPiA+PiArCS8qIEVycm9yIG1lc3NhZ2VzLiAqLw0K
PiA+PiArCUhWTVNHX0lOVkFMSURfVlBfUkVHSVNURVJfVkFMVUUJCT0gMHg4MDAwMDAyMCwNCj4g
Pj4gKwlIVk1TR19VTlJFQ09WRVJBQkxFX0VYQ0VQVElPTgkJPSAweDgwMDAwMDIxLA0KPiA+PiAr
CUhWTVNHX1VOU1VQUE9SVEVEX0ZFQVRVUkUJCT0gMHg4MDAwMDAyMiwNCj4gPj4gKw0KPiA+PiAr
CS8qIFRyYWNlIGJ1ZmZlciBjb21wbGV0ZSBtZXNzYWdlcy4gKi8NCj4gPj4gKwlIVk1TR19FVkVO
VExPR19CVUZGRVJDT01QTEVURQkJPSAweDgwMDAwMDQwLA0KPiA+PiArDQo+ID4+ICsJLyogUGxh
dGZvcm0tc3BlY2lmaWMgcHJvY2Vzc29yIGludGVyY2VwdCBtZXNzYWdlcy4gKi8NCj4gPj4gKwlI
Vk1TR19YNjRfSU9fUE9SVF9JTlRFUkNFUFQJCT0gMHg4MDAxMDAwMCwNCj4gPj4gKwlIVk1TR19Y
NjRfTVNSX0lOVEVSQ0VQVAkJCT0gMHg4MDAxMDAwMSwNCj4gPj4gKwlIVk1TR19YNjRfQ1BVSURf
SU5URVJDRVBUCQk9IDB4ODAwMTAwMDIsDQo+ID4+ICsJSFZNU0dfWDY0X0VYQ0VQVElPTl9JTlRF
UkNFUFQJCT0gMHg4MDAxMDAwMywNCj4gPj4gKwlIVk1TR19YNjRfQVBJQ19FT0kJCQk9IDB4ODAw
MTAwMDQsDQo+ID4+ICsJSFZNU0dfWDY0X0xFR0FDWV9GUF9FUlJPUgkJPSAweDgwMDEwMDA1LA0K
PiA+PiArCUhWTVNHX1g2NF9JT01NVV9QUlEJCQk9IDB4ODAwMTAwMDYsDQo+ID4+ICsJSFZNU0df
WDY0X0hBTFQJCQkJPSAweDgwMDEwMDA3LA0KPiA+PiArCUhWTVNHX1g2NF9JTlRFUlJVUFRJT05f
REVMSVZFUkFCTEUJPSAweDgwMDEwMDA4LA0KPiA+PiArCUhWTVNHX1g2NF9TSVBJX0lOVEVSQ0VQ
VAkJPSAweDgwMDEwMDA5LA0KPiA+PiArfTsNCj4gPg0KPiA+IEkgaGF2ZSBhIHNlcGFyYXRlIHBh
dGNoIHNlcmllcyB0aGF0IG1vdmVzIHRoaXMgZW51bSB0byB0aGUNCj4gPiBhc20tZ2VuZXJpYyBw
b3J0aW9uIG9mIGh5cGVydi10bGZzLmggYmVjYXVzZSB0aGVyZSdzIG5vdCBhIGdvb2Qgd2F5DQo+
ID4gdG8gc2VwYXJhdGUgdGhlIGFyY2ggbmV1dHJhbCBmcm9tIGFyY2ggZGVwZW5kZW50IHZhbHVl
cy4NCj4gPg0KPiANCj4gT2ssIGJ1dCBpdCBzaG91bGQgYWxzbyBiZSBjaGFuZ2VkIHRvICNkZWZp
bmUgaW5zdGVhZCBvZiBhbiBlbnVtLCByaWdodD8NCj4gSSB3aWxsIGRvIHRoYXQgaW4gdGhpcyBw
YXRjaC4NCj4gVGhpcyByZXF1aXJlcyBhIGNvdXBsZSBvZiBjaGFuZ2VzIGluIG90aGVyIGZpbGVz
IGluIGRyaXZlcnMvaHYNCj4gd2hlcmUgdGhpcyBlbnVtIGlzIHVzZWQuDQoNCkJlY2F1c2Ugb2Yg
dGhlIG90aGVyIHVzZXMgb2YgdGhlIGVudW0gaW4gcGxhY2VzIHRoYXQgZG9uJ3QgZGVwZW5kDQpv
biBleGFjdCBzdHJ1Y3R1cmUgbGF5b3V0cywgSSBsZWZ0IGl0IGFzIGFuIGVudW0gd2hlbiBJIG1v
dmVkIGl0Lg0KV2hlbiBvbmUgb2YgdGhlIGVudW0gdmFsdWVzIGlzIHBhc3NlZCB0byBIeXBlci1W
LCB0aGUgZW51bQ0KaXMgYXNzaWduZWQgdG8gYSB1MzIgZmllbGQsIHdoaWNoIEkgdGhpbmsgaXMg
YWNjZXB0YWJsZS4gIFlvdSBjb3VsZA0KZG8gdGhlIHNhbWUgd2l0aCB0aGUgb3RoZXIgZW51bXMg
eW91ciBhbHJlYWR5IGhhdmUgLS0ga2VlcCB0aGUNCmNvbnN0YW50IGRlZmluaXRpb25zIGFzIG1l
bWJlcnMgb2YgYW4gZW51bSwgYnV0IGFzc2lnbiB0byBhIHUzMg0KZmllbGQgaW4gdGhlIHN0cnVj
dHVyZXMgdGhhdCBnZXQgcGFzc2VkIHRvIEh5cGVyLVYuICBUaGVyZSBtYXkNCmFjdHVhbGx5IGJl
IHNvbWUgYmVuZWZpdCBpbiB0aGF0IGFwcHJvYWNoLCBwYXJ0aWN1bGFybHkgaWYgdGhlIGVudW0N
CmlzIHBhc3NlZCBhcyBhbiBpbmRpdmlkdWFsIGFyZ3VtZW50IGludG8gc29tZSBmdW5jdGlvbihz
KS4gDQoNCk90aGVycyBtYXkgaGF2ZSBhbiBvcGluaW9uIG9uIHRoaXMgYXBwcm9hY2ggLi4uLi4N
Cg0KTWljaGFlbA0K
