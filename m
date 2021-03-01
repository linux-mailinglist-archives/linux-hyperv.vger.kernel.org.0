Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883F0328F53
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhCATs4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 14:48:56 -0500
Received: from mail-dm6nam11on2100.outbound.protection.outlook.com ([40.107.223.100]:30913
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241230AbhCATqb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 14:46:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csIyXyFne27X7VGjXb1eSjCZXFIYqzHvNBEqlcVv4iQtg5wUorDpfPeGSOVJlboTmANbJKxQ5CgYN51SAmugQIGsO4JKLf24TpOlUnHGBJzqDLLA+lskOXous6puOQbzW7nJFLgJUyVR3SkNy4+lgwBoKbnHs+QX2ubO73jPsl5iqYJOO2ndOoFbkic75gJ73KCDKrVuC0C7lkk56ibfVWRgpA56gD0eQxLAsptGTkzzyk+Nh0ezvDOVR2m82UTgi1SIzPTT3V2d4pTvl7QHxq3qzT8mMOblvH98wEyD+JV/WYWMkr+cND1NV4hrwHSmHTvzdXFrZ2lfjmqc0+NiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHlKEwDJzaL4SwhdNVB7Wt0ByPtwjhASs4DkzDQji5E=;
 b=RE7TjpiOC8FIMxdOrkeyOHvXvnfKe3fCAXpaYPR4z6aZfdwXJGwrhDwlsoYLHlDRNV1gIGE3K2CQvJcJj/JsAOOb/B7saBGDO9Ca3UqsxEDQfTIlaku1vcbGH6HAtsapLax9Cr+SDn4dVzu8HKK7A3ZvvoI3pDICKoGG1rrB+fhi6rkPMIDBUJRGQzcR4gpY2GFh77kvdHNInX2O++DStfUDsGjQUl8IIOQJsvoBv38wXrmkYSZkVxJkz2BgPhX4qxRcucC1HN0FJ46Xy4h/Z8dWQ4GIan235bHhB8Et11PLgRYM0vTnptfFZNvHnNhQN/bJhCKK70UV8toY/+eXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHlKEwDJzaL4SwhdNVB7Wt0ByPtwjhASs4DkzDQji5E=;
 b=aJiZIyezXZnJr7pvLyEJ32AARpGzhmLoLeCH8eP6AhgTNoBIATVTpwI5NJhEqpDgeB/ATr7U/5QDAg6926yQC1dCveFHioAex6U5bgIknSa59uXz3X+f9yf6JXXZGuH0wnP17lFYar7rJkVGcBayAb8LFGnYwbDOzxARsoU/OAo=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SA0PR21MB1931.namprd21.prod.outlook.com
 (2603:10b6:806:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.7; Mon, 1 Mar
 2021 19:45:36 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Mon, 1 Mar 2021
 19:45:36 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH 12/12] HV/Storvsc: Add bounce buffer
 support for Storvsc
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 12/12] HV/Storvsc: Add bounce buffer
 support for Storvsc
Thread-Index: AQHXDmfO0fvNFykeJkmBM42v1SPHxqpvJPyAgABjvZA=
Date:   Mon, 1 Mar 2021 19:45:36 +0000
Message-ID: <SN4PR2101MB088022E836AEC0838266A8C6C09A9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-13-ltykernel@gmail.com>
 <20210301065454.GA3669027@infradead.org>
 <9a5d3809-f1e1-0f4a-8249-9ce1c6df6453@gmail.com>
In-Reply-To: <9a5d3809-f1e1-0f4a-8249-9ce1c6df6453@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:fd59:a3e1:4478:2baf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a70fb6b9-5e39-445a-dee4-08d8dcea9589
x-ms-traffictypediagnostic: SA0PR21MB1931:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA0PR21MB19314EF64964A574E6F5F761C09A9@SA0PR21MB1931.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfl1rdp4rEh2NHOgbno02LE52hpFsr7BKuEN0YNf4ylowfBDsgqvjTdCZwMlV6/zcNIsUafpABMk4Kw9w+9AIvo8BTHDrgGPMrr0LM73IMIP+87e3/IqJbGGSziE3HbhtagdO79xK2t0E5hCrzcEXNG8ykwI4SAiG3IOrkfpEHtnoInRFXROZGbGaPhP8tuuDo/aHsmR5PNulKrjYoEgaiauA7s8EqK8eG9zGoC8tlsdAvtf24t+uqxALOZriH/5d6RAfCCwn3mprfSI0G57aKSZSNxgl3Zn5EYVnXGrWM7SzNxReU4VExSyitrv5pkGgWozTTq64sZPJfjaajcDsb4qRuDBrbPSPFf3fyh3l/z25CBs9qUSnd1TLUWo6wJTO1EnKQjea0/eJFkIEgP3NjpD1ezJ/rp9tICJq1abSHwUZEk4pRtkY/ncdNVb3G7lLV6x6+BgnFEBBQoFuz6ykGaQf0WQQVq5nRkobpqt7YYg1c2GuI+psOVAvBuCOvU7YcifNBov7arFSZbq+//YsAqZdMg+Az1rrkWNRxMvcSV2Hj3M2r6H2ag9QkKC0x2K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(4326008)(5660300002)(53546011)(6506007)(55016002)(478600001)(2906002)(9686003)(82960400001)(316002)(82950400001)(54906003)(7416002)(66476007)(33656002)(66946007)(10290500003)(71200400001)(7696005)(64756008)(66446008)(66556008)(52536014)(110136005)(76116006)(83380400001)(8936002)(86362001)(8990500004)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TGNyQkRmcnZNVldNcW9Vcm5hK01OVlNNTXNoUDBMbmR3ZUFDR0w4V2xFbXZL?=
 =?utf-8?B?Y20xazAvcnNFcjV0ZkIwVWovUmR3YjJaY1FhRzFIUG9jR2Ywb2dvQTBTMEZV?=
 =?utf-8?B?bXVpQVdYU2xHZ2xiNFF2VVhMT0lkNURnVWVQZ1BpRnRkT3NpT1Mxa2JBY3Nn?=
 =?utf-8?B?MzVsbVpjYUw2SWtpNDFua0twYnlOUHQ5aUxuSFJlVXJiSGRoOUxPc2RDaHRR?=
 =?utf-8?B?SVc2L2ZEdmtPMzh0OWpDeVoyQmpmU3B6cTFDcjE2MTNuZVUzV2R1c1Jpenl6?=
 =?utf-8?B?K1pOWVd3MGJKbnE4b2t3Zmw0L3pveWdZb0cyVWpIUUUxbkdlYzBpVlFKTWRq?=
 =?utf-8?B?SHhVdDFOSnA5UWNvbE0wam03dWorc0RkQ0pGRG9GMHNnN01xcHBkUmZmNWdQ?=
 =?utf-8?B?VWpFUGlSNFE1bU5EVXg5d1RHK3lQVmJkR0tJZTFXYWNkd0Fhd2twREZhekxY?=
 =?utf-8?B?VmZ2L3dQN1lrZm5rN3BPckJJU3UyaitjbUVwaklrcEtLc21kNDltTkVXTXR0?=
 =?utf-8?B?cUIrTTBhMDVwSWRiN3BZZVBraUl1R3p3TEwvRDNaSCtHalJLc1k4bVluV2tm?=
 =?utf-8?B?b21lSVhmQWFUM3IwcFA0V2tTRGZSL21vYWpQakxDQXIxbUJXNnpiaSt2dWFD?=
 =?utf-8?B?Z04ybjd6YU5pNUc5ejMxanNkU0t1THA1M3B0YURlc2h0eVdNanViK1VTSEIz?=
 =?utf-8?B?OGpXWmY4cTJpV3FHdGxOak0xNkhiK1lJWno2eW1kYVZtdVJlMEVPN3hOanJt?=
 =?utf-8?B?eUFhcmJlZkltZVY1cFVqVEZrZTQvbzFSUUpTbU8xblpkYlpCbTFUTmdOQUdZ?=
 =?utf-8?B?bzQzMktxaWh3N3RMT2NYQWRadkZPd1pjZ0RkKzJ0ZHIwK0Myd0xQQ0lGaGJo?=
 =?utf-8?B?NzFPMUFwa2cxT0lYUTJLVm1pWTJkZXV5RU1MVGIzMFRHT09FZERBTnpSUEF0?=
 =?utf-8?B?eVZpNGdVaE5qcStzZ0FrZkFINTh1ZC9SYUs1dnd0cDhKZy9JcFVob0twbVd0?=
 =?utf-8?B?dkRVaVM2VS8waDlHOG5lUHB2U2d5K3NnQmd6Q2ZaaXpvUE9VQUxuY01NQmhU?=
 =?utf-8?B?Z1pWT3ZyNzBCT1NDSVNXMmlxRkluenp4ZDM5ZkRwRzMvZldsQnZ5bStrc3N3?=
 =?utf-8?B?ZTIyZWc1L3lxajZieXBIRXFrakJaTjljc3JRTXlPUzd5YnY2Y2tnMHZzTDgz?=
 =?utf-8?B?WlhCd2xuREdPelVwSlhndFNPSjRiVS82cFkxMmRNdUwwV1hmRG4ycGRFMGJG?=
 =?utf-8?B?TGRuQ3JhUityc29oOFlrMVhuVk1CZVNhdFlFSi9tdWkxZlNYZlpna0ZJbDlo?=
 =?utf-8?B?NkJBVk8rNlJuYWtBR0JQWXZIWFZjajh3a2xYM0Z6TW9Jb1FoVUw3UlRITXhm?=
 =?utf-8?B?T0hLbnBBZGF0TnMxY09SYmxFZUY1b0hEcWlrRC9vbjZpWG83VlluL296OXlU?=
 =?utf-8?B?RWFDU1lYZTJlZDZNVExySk1HNU9MVXF6dzkwS2RiZzFSZTJDZHMvR0laZysy?=
 =?utf-8?B?Y2NUeWNXV0Z6SkV6S0lINzVRa2dGYmhGK1VoWlNVVk1BSGU3dEVna1NqUjVE?=
 =?utf-8?B?UkRKTWhqYVl1bUNGN1o4ZVlTa2grOTJGS01TUVZNNDJRcjNRTHlMMVo0MGV2?=
 =?utf-8?B?YUVpdXlyT1QwclF3dm9XcEdybUhuU1dKMHk1WFRpVkFMVmRxVUZwTVZ6NURC?=
 =?utf-8?B?R3JzUFZwRFhPTEh2ZjZoc1J1ZmlrbmlYNTQ0UGY0Q3Q5ZEJTVFRMZG9ueHRv?=
 =?utf-8?B?eUxxL1d4NUVPVW5TUk5kbk1OenpTQngzZ2cydW9XQXdKUk9CcUhjVXJpbVlv?=
 =?utf-8?B?TDUvYkRvdW5mY294eEJCYWR6a2ZkWFRHa0duc0NucG83NnhuOWtYZlc5R2Fq?=
 =?utf-8?Q?EKqP8Yt6KKUS7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70fb6b9-5e39-445a-dee4-08d8dcea9589
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 19:45:36.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lph7HbjLGOfYqUbt/aFgRPZzmhYDLoFY8WuE7eaj3Laf+YD65v8dYOb23xnM4XV4w1Oi9bP3GgJHUpXVh1nQgcno5aP2PTFZfOAdhYQc3oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1931
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBIaSBDaHJpc3RvcGg6DQo+ICAgICAgIFRoYW5rcyBhIGxvdCBmb3IgeW91ciByZXZpZXcuIFRo
ZXJlIGFyZSBzb21lIHJlYXNvbnMuDQo+ICAgICAgIDEpIFZtYnVzIGRyaXZlcnMgZG9uJ3QgdXNl
IERNQSBBUEkgbm93Lg0KV2hhdCBpcyBibG9ja2luZyB1cyBmcm9tIG1ha2luZyB0aGUgSHlwZXIt
ViBkcml2ZXJzIHVzZSB0aGUgRE1BIEFQSSdzPyBUaGV5DQp3aWxsIGJlIGEgbnVsbC1vcCBnZW5l
cmFsbHksIHdoZW4gdGhlcmUgaXMgbm8gYm91bmNlIGJ1ZmZlciBzdXBwb3J0IG5lZWRlZC4NCg0K
PiAgICAgICAyKSBIeXBlci1WIFZtYnVzIGNoYW5uZWwgcmluZyBidWZmZXIgYWxyZWFkeSBwbGF5
IGJvdW5jZSBidWZmZXINCj4gcm9sZSBmb3IgbW9zdCB2bWJ1cyBkcml2ZXJzLiBKdXN0IHR3byBr
aW5kcyBvZiBwYWNrZXRzIGZyb20NCj4gbmV0dnNjL3N0b3J2c2MgYXJlIHVuY292ZXJlZC4NCkhv
dyBkb2VzIHRoaXMgbWFrZSBhIGRpZmZlcmVuY2UgaGVyZT8NCg0KPiAgICAgICAzKSBJbiBBTUQg
U0VWLVNOUCBiYXNlZCBIeXBlci1WIGd1ZXN0LCB0aGUgYWNjZXNzIHBoeXNpY2FsIGFkZHJlc3MN
Cj4gb2Ygc2hhcmVkIG1lbW9yeSBzaG91bGQgYmUgYm91bmNlIGJ1ZmZlciBtZW1vcnkgcGh5c2lj
YWwgYWRkcmVzcyBwbHVzDQo+IHdpdGggYSBzaGFyZWQgbWVtb3J5IGJvdW5kYXJ5KGUuZywgNDhi
aXQpIHJlcG9ydGVkIEh5cGVyLVYgQ1BVSUQuIEl0J3MNCj4gY2FsbGVkIHZpcnR1YWwgdG9wIG9m
IG1lbW9yeSh2VG9tKSBpbiBBTUQgc3BlYyBhbmQgd29ya3MgYXMgYSB3YXRlcm1hcmsuDQo+IFNv
IGl0IG5lZWRzIHRvIGlvcmVtYXAvbWVtcmVtYXAgdGhlIGFzc29jaWF0ZWQgcGh5c2ljYWwgYWRk
cmVzcyBhYm92ZQ0KPiB0aGUgc2hhcmUgbWVtb3J5IGJvdW5kYXJ5IGJlZm9yZSBhY2Nlc3Npbmcg
dGhlbS4gc3dpb3RsYl9ib3VuY2UoKSB1c2VzDQo+IGxvdyBlbmQgcGh5c2ljYWwgYWRkcmVzcyB0
byBhY2Nlc3MgYm91bmNlIGJ1ZmZlciBhbmQgdGhpcyBkb2Vzbid0IHdvcmsNCj4gaW4gdGhpcyBz
ZW5hcmlvLiBJZiBzb21ldGhpbmcgd3JvbmcsIHBsZWFzZSBoZWxwIG1lIGNvcnJlY3QgbWUuDQo+
IA0KVGhlcmUgYXJlIGFsdGVybmF0aXZlIGltcGxlbWVudGF0aW9ucyBvZiBzd2lvdGxiIG9uIHRv
cCBvZiB0aGUgY29yZSBzd2lvdGxiDQpBUEkncy4gT25lIG9wdGlvbiBpcyB0byBoYXZlIEh5cGVy
LVYgc3BlY2lmaWMgc3dpb3RsYiB3cmFwcGVyIERNQSBBUEkncyB3aXRoDQp0aGUgY3VzdG9tIGxv
Z2ljIGFib3ZlLg0KDQo+IFRoYW5rcy4NCj4gDQo+IA0KPiBPbiAzLzEvMjAyMSAyOjU0IFBNLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiBUaGlzIHNob3VsZCBiZSBoYW5kbGVkIGJ5IHRo
ZSBETUEgbWFwcGluZyBsYXllciwganVzdCBsaWtlIGZvciBuYXRpdmUNCj4gPiBTRVYgc3VwcG9y
dC4NCkkgYWdyZWUgd2l0aCBDaHJpc3RvcGgncyBjb21tZW50IHRoYXQgaW4gcHJpbmNpcGxlLCB0
aGlzIHNob3VsZCBiZSBoYW5kbGVkIHVzaW5nDQp0aGUgRE1BIEFQSSdzDQo=
