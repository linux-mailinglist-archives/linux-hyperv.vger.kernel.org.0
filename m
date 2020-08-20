Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3524C530
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Aug 2020 20:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHTSVP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 14:21:15 -0400
Received: from mail-mw2nam10on2101.outbound.protection.outlook.com ([40.107.94.101]:6606
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgHTSVM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 14:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chogcpk9+5tGkcw8esbl9vzwc0o6plhRqyW9nJtZ+SqmINbGmJwsd4KhzEZ3dtAOgpxuGLefD0ogAV5utxcH/FpccjtE9nA++cHAZi+pHYgjczB0++rdH/hK/ZmT6LmqL96R4qH7NooSJlrzgsAv0YXyF0qipUeXa3JqxEeS1qy5yDhfef2rVDw6q1aEFij1rETanmutQYLF9IIU5IBLV+Xi/3Lp7SWJUcfvPKELjt8xavhf4EG1W0rgHtAnSjTEdapzAILvS21jQ2MNLjJOP3ZnhWCr8AeIFbxVlgqZAcWwJzLs7pCK/rMvMCa0JzJYpf3Ub/yNxa/YWMcyWd9G1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYARoL8zinfS7sCQsz4sgkeIUC+qBjF8X39j9NfE1PI=;
 b=iYEPxcaxPLFZ/ioP8vUQ5CA6gmdSywVGGzW5qmfSXYHMu1qESVdsxvWxKqqFEG8LjA8iwnhnIK9imM4wYAVvJDtimrrXoR5BA4qsjk1fU0yaAoxBPesCs1cmNhvmh1swtu4AU+PDs2CiOvjENqBGtFLFq/TiRJ+k6LTNnNd6vAS8waSqrDnkZg59c8yK7VXVahDqNbhrFpXL0hgf4BTN7h3KqZrs74/VRXwr+Ks5VtNSKPg+RZjlpF2JeN0S6Mz3R3V1p06SY9bLHytFQm71AvRNtkHejBqi5k30qp1vIYKk+N785Ijj+YW2D1PnZgIv80GmPg07fsev4bku/Gielg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYARoL8zinfS7sCQsz4sgkeIUC+qBjF8X39j9NfE1PI=;
 b=HQg6EIevbjK4QxWBQTGt4Y+8wNgNEErvKhuk2w0Dwv1cIGvoYDXXDJ14W21TjmvYcFdyH0TzKO9siGLnicVDYOMrFjeUj7YtxJAsRZ0mctsf40iwRoT57awOt8viYlSogvbp73P5oYRhEga/CRFeX40mEkatuh5VUajEJW++GRU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1083.namprd21.prod.outlook.com (2603:10b6:302:a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.0; Thu, 20 Aug
 2020 18:21:10 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3305.021; Thu, 20 Aug 2020
 18:21:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv_utils: return error if host timesysnc update is stale
Thread-Topic: [PATCH] hv_utils: return error if host timesysnc update is stale
Thread-Index: AQHWdlCWqvSLfkbTjU6GfoCxQIcBRKlBTbGg
Date:   Thu, 20 Aug 2020 18:21:09 +0000
Message-ID: <MW2PR2101MB10527EAC115BF49715BF4722D75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200819174527.47156-1-viremana@linux.microsoft.com>
In-Reply-To: <20200819174527.47156-1-viremana@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-20T18:21:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=961e063f-9d00-4898-a833-4f6e975d4d4f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92f36eea-874c-4998-b944-08d84535d047
x-ms-traffictypediagnostic: MW2PR2101MB1083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10833E822723E3CA44382296D75A0@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fC2VMqv/07PBBls4mLwTQSSezcroZH7pLnpNuXOtSyPcQSyAMUVRap8HXKWovF7026E8ao92ecwuS1/Lo+0QXZ2A8GQVb0yc1O7rK9jvRxldvi3o55ZlhRSoMUcYuOZr3Qg2r1iDKXaRWi5js0T5wBxQEBsVPJXPssNjtktFhzB5Ba83tIaGocf5lQomsP2p2Hst9RadCDi6DNeZ4bX9C2FzugXdkfcGtw6ppdjA89/NTSm7hJZvlIW39SvNzaJaEjvWfY0I9BUFMJejnWOFIPW2QgG0a8sNs/e3ATM8G8wqiAYBeC/j4GapcX79AiDYeymDByI7GVOpB5m5J8Qc4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(54906003)(186003)(8936002)(55016002)(5660300002)(316002)(8990500004)(15650500001)(52536014)(83380400001)(86362001)(33656002)(26005)(110136005)(9686003)(10290500003)(478600001)(6506007)(66476007)(66556008)(64756008)(66446008)(66946007)(7696005)(8676002)(82960400001)(4326008)(82950400001)(2906002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5arYCJs+sBqlLDebq9TzrYGVWwh42TWWdIogerJOnPmC9LnOlqMZDz1Z9GvuVo9lo1saUjbRZlZQ+a1oN20vMV0EikPHbGkX8l7q/qg74gJg5xDP9SUnhd0wCe/bcFI0SNND0kEt8/D8EXed4uEQJdrLtUW+/VgB0/QXk+hpnatEAXAyoscfl8Jv2FVgkbz506FhQ2j0X6r1VjQhRLXtEn97SN4yLcga9MALwuFjgTCiOWJZJt1JmZsDNFjNEQEjmfCFJolR1BZD02N6ntWcO8Ss0PZ0lEgekMzs56fViWCYHtkaGUZsVr8o7F+EZ9mhWH08Ggr/VRw+r6vfhn1L8b2cXQmF/ZAtEZ4XfQo+y4cWpKq3AWjkF/jicq68+1O0uLr20ScM0b/+TFnCzPiJV5KpDZgd9qfEBybZeVDbcijwriY6AC/nBF6D3zTK0nJR6tOp/nVO4gyV84yGFCOfP4rEgenIiliu/JwnH7nFdIeXSpLumLCUt7psYPMX9KaOwy4xBrQkDMh+lEVb8u//hGVAn7zByf2s7m1sQxjqVOKGcgfRP4fETxpMEiz/2vVpMW5P6C1o5Qi1qnJeToGrIr3rUL2GWmZrch9nDmZTGb1kn6eTj+4xWj90yXKo9K6T8BlJpJHPo/HWFiL8GnTkHA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f36eea-874c-4998-b944-08d84535d047
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:21:09.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sicxVhAZdyKopvsCgXDT6Owkq5SxGNPFk4irjtBwJgYDJ8gWdBIUj0vkqlqHRjC78i0CLbRvFmERzyL92CwFtR5cqyZOIALHjEX/NFFUuLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogVmluZWV0aCBQaWxsYWkgPHZpcmVtYW5hQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6
IFdlZG5lc2RheSwgQXVndXN0IDE5LCAyMDIwIDEwOjQ1IEFNDQo+IA0KPiBJZiBmb3IgYW55IHJl
YXNvbiwgaG9zdCB0aW1lc3luYyBtZXNzYWdlcyB3ZXJlIG5vdCBwcm9jZXNzZWQgYnkNCj4gdGhl
IGd1ZXN0LCBodl9wdHBfZ2V0dGltZSgpIHJldHVybnMgYSBzdGFsZSB2YWx1ZSBhbmQgdGhlDQo+
IGNhbGxlciAoY2xvY2tfZ2V0dGltZSwgUFRQIGlvY3RsIGV0YykgaGFzIG5vIG1lYW5zIHRvIGtu
b3cgdGhpcw0KPiBub3cuIFJldHVybiBhbiBlcnJvciBzbyB0aGF0IHRoZSBjYWxsZXIga25vd3Mg
YWJvdXQgdGhpcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpbmVldGggUGlsbGFpIDx2aXJlbWFu
YUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaHYvaHZfdXRpbC5jIHwg
NDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2h2L2h2X3V0aWwuYyBiL2RyaXZlcnMvaHYvaHZfdXRpbC5jDQo+IGlu
ZGV4IDkyZWUwZmU0YzkxOS4uMTM1Nzg2MWZkOGFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2
L2h2X3V0aWwuYw0KPiArKysgYi9kcml2ZXJzL2h2L2h2X3V0aWwuYw0KPiBAQCAtMjgyLDI2ICsy
ODIsNTIgQEAgc3RhdGljIHN0cnVjdCB7DQo+ICAJc3BpbmxvY2tfdAkJCWxvY2s7DQo+ICB9IGhv
c3RfdHM7DQo+IA0KPiAtc3RhdGljIHN0cnVjdCB0aW1lc3BlYzY0IGh2X2dldF9hZGpfaG9zdF90
aW1lKHZvaWQpDQo+ICtzdGF0aWMgaW5saW5lIHU2NCByZWZ0aW1lX3RvX25zKHU2NCByZWZ0aW1l
KQ0KPiAgew0KPiAtCXN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPiAtCXU2NCBuZXd0aW1lLCByZWZ0
aW1lOw0KPiArCXJldHVybiAocmVmdGltZSAtIFdMVElNRURFTFRBKSAqIDEwMDsNCj4gK30NCj4g
Kw0KPiArLyoNCj4gKyAqIEhhcmQgY29kZWQgdGhyZXNob2xkIGZvciBob3N0IHRpbWVzeW5jIGRl
bGF5OiA2MDAgc2Vjb25kcw0KPiArICovDQo+ICtjb25zdCB1NjQgSE9TVF9USU1FU1lOQ19ERUxB
WV9USFJFU0ggPSA2MDAgKiBOU0VDX1BFUl9TRUM7DQoNCktlcm5lbCB0ZXN0IHJvYm90IGhhcyBh
bHJlYWR5IGNvbXBsYWluZWQgdGhhdCB0aGlzIHNob3VsZCBiZSBzdGF0aWMsDQphbmQgYWJvdXQg
dGhlIHBvdGVudGlhbCBvdmVyZmxvdyBiYXNlZCBvbiB0aGUgdHlwZXMgb2YgdGhlIGNvbnN0YW50
cyBpbg0KdGhlIHJpZ2h0IHNpZGUgZXhwcmVzc2lvbi4gIEkgZGlkbid0IGNoZWNrIHRoZSBkZXRh
aWxzLCBidXQgSSBzdXNwZWN0IHRoZQ0KY29tcGxhaW50IGlzIHdoZW4gYnVpbGRpbmcgaW4gMzIt
Yml0IG1vZGUuICBUaGlzIGNvZGUgZG9lcyBnZXQgYnVpbHQgaW4NCjMyLWJpdCBtb2RlIGFuZCBp
dCdzIHBvc3NpYmxlIGZvciBydW4gMzItYml0IExpbnV4IGd1ZXN0cyBvbiBIeXBlci1WLg0KDQo+
ICsNCj4gK3N0YXRpYyBpbnQgaHZfZ2V0X2Fkal9ob3N0X3RpbWUoc3RydWN0IHRpbWVzcGVjNjQg
KnRzKQ0KPiArew0KPiArCXU2NCBuZXd0aW1lLCByZWZ0aW1lLCB0aW1lZGlmZl9hZGo7DQo+ICAJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gDQo+ICAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmhvc3RfdHMubG9jaywgZmxhZ3MpOw0KPiAgCXJlZnRpbWUgPSBodl9yZWFkX3Jl
ZmVyZW5jZV9jb3VudGVyKCk7DQo+IC0JbmV3dGltZSA9IGhvc3RfdHMuaG9zdF90aW1lICsgKHJl
ZnRpbWUgLSBob3N0X3RzLnJlZl90aW1lKTsNCj4gLQl0cyA9IG5zX3RvX3RpbWVzcGVjNjQoKG5l
d3RpbWUgLSBXTFRJTUVERUxUQSkgKiAxMDApOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBXZSBuZWVk
IHRvIGxldCB0aGUgY2FsbGVyIGtub3cgdGhhdCBsYXN0IHVwZGF0ZSBmcm9tIGhvc3QNCj4gKwkg
KiBpcyBvbGRlciB0aGFuIHRoZSBtYXggYWxsb3dhYmxlIHRocmVzaG9sZC4gY2xvY2tfZ2V0dGlt
ZSgpDQo+ICsJICogYW5kIFBUUCBpb2N0bCBkbyBub3QgaGF2ZSBhIGRvY3VtZW50ZWQgZXJyb3Ig
dGhhdCB3ZSBjb3VsZA0KPiArCSAqIHJldHVybiBmb3IgdGhpcyBzcGVjaWZpYyBjYXNlLiBVc2Ug
RVNUQUxFIHRvIHJlcG9ydCB0aGlzLg0KPiArCSAqLw0KPiArCXRpbWVkaWZmX2FkaiA9IHJlZnRp
bWUgLSBob3N0X3RzLnJlZl90aW1lOw0KPiArCWlmICh0aW1lZGlmZl9hZGogKiAxMDAgPiBIT1NU
X1RJTUVTWU5DX0RFTEFZX1RIUkVTSCkgew0KPiArCQlwcl93YXJuKCJUSU1FU1lOQyBJQzogU3Rh
bGUgdGltZSBzdGFtcCwgJWxsdSBuc2VjcyBvbGRcbiIsDQo+ICsJCQlIT1NUX1RJTUVTWU5DX0RF
TEFZX1RIUkVTSCk7DQoNCkxldCdzIHByb3ZpZGUgdGhlIHRpbWVkaWZmX2FkaiBpbiB0aGUgbWVz
c2FnZSBpbnN0ZWFkIG9mIHRoZSBjb25zdGFudA0KdGhyZXNob2xkIHZhbHVlIHNvIHdlIGtub3cg
dGhlIGRlZ3JlZSBvZiBzdGFsZW5lc3MuIDotKQ0KDQpBbHNvLCBJJ20gd29uZGVyaW5nIGlmIHRo
aXMgc2hvdWxkIGJlIHByX3dhcm5fb25jZSgpLiAgUHJlc3VtYWJseQ0KY2hyb255ZCBvciB3aG9l
dmVyIGlzIHJlYWRpbmcgL2Rldi9wdHAwIHdpbGwgZ2l2ZSB1cCBhZnRlciBnZXR0aW5nDQp0aGlz
IGVycm9yLCBidXQgaWYgbm90LCBpdCB3b3VsZCBiZSBuaWNlIHRvIGF2b2lkIGZpbGxpbmcgdXAg
dGhlIGNvbnNvbGUNCndpdGggdGhlc2UgZXJyb3IgbWVzc2FnZXMuDQoNCj4gKwkJcmV0ID0gLUVT
VEFMRTsNCj4gKwl9DQo+ICsNCj4gKwluZXd0aW1lID0gaG9zdF90cy5ob3N0X3RpbWUgKyB0aW1l
ZGlmZl9hZGo7DQo+ICsJKnRzID0gbnNfdG9fdGltZXNwZWM2NChyZWZ0aW1lX3RvX25zKG5ld3Rp
bWUpKTsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZob3N0X3RzLmxvY2ssIGZsYWdzKTsN
Cj4gDQo+IC0JcmV0dXJuIHRzOw0KPiArCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiAgc3RhdGlj
IHZvaWQgaHZfc2V0X2hvc3RfdGltZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICB7DQo+
IC0Jc3RydWN0IHRpbWVzcGVjNjQgdHMgPSBodl9nZXRfYWRqX2hvc3RfdGltZSgpOw0KPiANCj4g
LQlkb19zZXR0aW1lb2ZkYXk2NCgmdHMpOw0KPiArCXN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPiAr
DQo+ICsJaWYgKCFodl9nZXRfYWRqX2hvc3RfdGltZSgmdHMpKQ0KPiArCQlkb19zZXR0aW1lb2Zk
YXk2NCgmdHMpOw0KPiAgfQ0KPiANCj4gIC8qDQo+IEBAIC02MjIsOSArNjQ4LDcgQEAgc3RhdGlj
IGludCBodl9wdHBfYWRqdGltZShzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwgczY0IGRlbHRh
KQ0KPiANCj4gIHN0YXRpYyBpbnQgaHZfcHRwX2dldHRpbWUoc3RydWN0IHB0cF9jbG9ja19pbmZv
ICppbmZvLCBzdHJ1Y3QgdGltZXNwZWM2NCAqdHMpDQo+ICB7DQo+IC0JKnRzID0gaHZfZ2V0X2Fk
al9ob3N0X3RpbWUoKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiArCXJldHVybiBodl9nZXRfYWRq
X2hvc3RfdGltZSh0cyk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwdHBfY2xvY2tfaW5m
byBwdHBfaHlwZXJ2X2luZm8gPSB7DQo+IC0tDQo+IDIuMTcuMQ0KDQo=
