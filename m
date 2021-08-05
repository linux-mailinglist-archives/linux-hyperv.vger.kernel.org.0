Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DFC3E1AFD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhHESLM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:11:12 -0400
Received: from mail-dm6nam10on2126.outbound.protection.outlook.com ([40.107.93.126]:2401
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239986AbhHESLL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXyLdO5o9KAUkz6F+Z8GBrwQal42tpt9Jn549WRinHXD26D/HhIOFi2OPinJWyUg3NTOhzjR56E3O9sJgihrUuFXy62hwhRCIq2NBjtTdrsK+9dZ5Zu48K6wMzm2nL7Zy8dg+nnUqEGQ3S/ke72/ikdzd7zmXTelB5FTq6E/reh3bBhABaSJBjBnc8N9OMGXfJGFThQ0ssDguxpO4br7FT1o6DhEsbgRlsSdhLUaNud1vSrLyKfzQzq7FJkVkPuzpxr1k9S11SROLLag/CbAFWa3T1pZRsl9FQcyLaJb7OVl2Xcv8RMifbn20SpfJ0HD8n5sLj3T6+bFqshnic3WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMgqO69trIHIoKkmtTb3ltXCqbRkdnXlHNUs8a8FLSs=;
 b=G4z796HJFAv9YhwfCrDAu/J63lMNCKJv70wTD9QCeWH08wz66pFbadCbeKitqNCXMjhgbfxWO99DmUcDFPxgHbl0SMfy/8SgLc1aEphsnSCq++47WuQMzjSr3JI/CjXkF9zvsXW6jkkJiyhHjxE7F3yp3h+Y4PTpNo6rXAwbkoxFSJVpUsdL4bW/wdCodQhBqyvGIPD8OyJNy9yD0UOSwqMJLP11HGJWe+as5PA7vtAw4DVuOMZZa4TlCZAOXLKyfoYQo60grGpqllJFgFfH88PMYrWIrFqBoUuy+xsUNcQxKDhZn6CkoXI0gWD0fVQ5Ng1i4Nwu0deCZuPqFAev3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMgqO69trIHIoKkmtTb3ltXCqbRkdnXlHNUs8a8FLSs=;
 b=Udnhh6P0Nz0EE22EPeXOXOXzgmGy/2LttSRUDcErrEkrMRUOuBtmpi3IxU32MChZfiGUhDVfDLgHStra/crp8bbYosG1i1+9hZup7sef8rJjTCMrKKQw4g8fwg/uGGGGkIwyoCfXh79NkHGHAJCRuLEdUhpUyakk0Sh1HQJGaeY=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB2023.namprd21.prod.outlook.com (2603:10b6:a03:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Thu, 5 Aug
 2021 18:10:54 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 18:10:54 +0000
From:   Long Li <longli@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXicedDOclmRZNxku+6+eTWPWUTatlJMiAgAARMBA=
Date:   Thu, 5 Aug 2021 18:10:54 +0000
Message-ID: <BY5PR21MB1506EA961AEBB493B08FBB8FCEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
 <b6404b38-9ea2-b438-dc1b-1196f8e4a158@acm.org>
In-Reply-To: <b6404b38-9ea2-b438-dc1b-1196f8e4a158@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ea32a756-66e2-4833-9598-fa23db9a8a84;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T18:07:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b9af1cb-027b-4e87-f075-08d9583c5daf
x-ms-traffictypediagnostic: SJ0PR21MB2023:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB2023E6DEA253B9BACB4D600CCEF29@SJ0PR21MB2023.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oO37tHs21SmZ6v+xyGKsf9D+l/5ngXbClrgwdeT1GpTuP1dqR5yiBtce0IYfoIJLwbKQxH/p4diBTWnixDrg9Ba0zLz/P03HruhSA2PK4GnJ2jLICKmEGvtTwZo0cn6MonnrDnqqOHNKVHsaKBHrOSJrYo/2L27V+b3jYDvR6r4hXY4QdmyJCAW2c+qOSYeB59rKxWtJs9BxoOOndYBE3KfZdBYyXQBKRywCTgkLO3+fajGiIHXAH2u+IR7GUyJPJpkOgQdNyOyNMz7QeZXkj1vzSHLAtVXMUUjtDaNEJmIdk15uoQWNNDWB8BwTWm1ugASyp8/ibnGr7XmKrgix6sxB2pLKSPjftXbTqpP20NVLZpYH5CH/OoR2nyuqzrNza4G3kjXmc+1KFcpqk/zk3t0Dy5fbxYw4PNN5/UlLPRcbtewqpnH0r01C6UERgNdQRak+kkmRK6Tnsr9mRRWAompH5fl3ZcmNQJ4BtQU38DJoc6WfwQnMRcKPxfRur5pyKfpmHo3uzAbZqV5HU2aXbboRWLzqgiJM8ioJXk3f6bdq833/Yr5sN7qOf6asv8U7iAZTloVSHqG17F4QdMNQaFZsZsFni+3jX/lDwN8jdjTTf67rkPM5+uZDcDRLqLMeDDHF5CF8myuV568pA0Io8JGCLt5BQS5ItcAV9HserdVDiV774LcwHKzjc2JXU2Y3wtxsEWhMHROXmdMr+/Z7iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(9686003)(66946007)(82960400001)(54906003)(38100700002)(66476007)(64756008)(82950400001)(66446008)(8936002)(83380400001)(55016002)(110136005)(5660300002)(508600001)(7696005)(122000001)(71200400001)(26005)(316002)(53546011)(6506007)(10290500003)(186003)(4326008)(8990500004)(86362001)(52536014)(38070700005)(76116006)(2906002)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFrY29tbWRxR21Hc2NncnJPdG5kWFZqSGJhRGdYZjlYSTBBUUZTVmhJTHdj?=
 =?utf-8?B?ODhocVpqMWF1Q01RalZFbERza0JockhyL2V6TTZpUVczR0tPR0o3dy9tSm5E?=
 =?utf-8?B?UkZ3dGZpdW9XdVdzM0V6WndTWS9uc0V2eHhCdWROSnFnSVFnWFVTV0FKNkJ5?=
 =?utf-8?B?QzBwaks0WlhUZTVzL2xrWlpJckczVm02bysycS9oRGhDZm5iV3JIOUtscDBB?=
 =?utf-8?B?Zmh4YzB3L2loZWRqSTIxNEF4NFJTV0ZwUlNaRnR0WGdDQUtuZ3hCTmlaejhk?=
 =?utf-8?B?akJFdjkyZWRRTC96UCtremxFNEFYc1R2UXRBUVBTcHhvMDhvRWFVQ3UyMGFq?=
 =?utf-8?B?Y2wvUmdYcVlibnVwZVY1dWg3ZnVLcjV2SmpFbEJvOTVOWTFpQTVFUm90dzRX?=
 =?utf-8?B?Vk5VYVZqMkswdHFoVlZjdFAzTnJVN0xQWkZwd2oxZzdxMHhxcnQ3NTR1SUt1?=
 =?utf-8?B?ZzUwV0piUWJpdzhYRUpYQXphMGRPdmJQZ1BzaUV2OGR4ZjRWcGhKcUxNc29u?=
 =?utf-8?B?bUxQa3lYTHZJbTUyWU9qRGVPMklDS3F4V2daSkFCcldBRzY4M3VBRlJGUkY5?=
 =?utf-8?B?d0RkOGNxRExNN1QwRml5bnB3QjNKSVdMdXp6VjFUWGZMYXMxM1VMR2p5a01P?=
 =?utf-8?B?UkdjU1djNVBvY2pGTW9tb2NiU2EzOGlDdHZQMnlxUDF3Um1RaHRFV1B4SlNz?=
 =?utf-8?B?TUVwb3RkNTFidExJTmpjVnpwbTVlN3RLbnBFenpjck16YnV5ZEZqRzQ3QUxv?=
 =?utf-8?B?RTNqL1NDNGcxbHJ6NkRoRHpPTFNIbnZ5ZUNxTjJIQTBFVExPYkIzRTNpcUNK?=
 =?utf-8?B?R2JSakFidlY1S0p2MUVWUWEyemNZODYyalZQZy9waVJ4RWp0UFB6NDg4N2or?=
 =?utf-8?B?Yk9CWDU3WS9WTE8vRHRCdDU3blVxcU8xT3JjTVVqUTBBZWZ6dm1Tbkw1SFJ5?=
 =?utf-8?B?TFZxaXp4QjVvc2VVQ0NJUERWM0lIZS9HVURIWCtoY0preTJZQUgzQnNmMzhN?=
 =?utf-8?B?RFZpTGxzb2pBajUyWnlOTkJFUURLR3pDYi9vQk1vcEFqZ2N1b3BuZVdMa3Fv?=
 =?utf-8?B?Rm4yK2dzeHEveUpxVWhDRlBCWnlFajNyY05vZnRjaUpsZ3RSQ0Y4RzBwSHEx?=
 =?utf-8?B?c1g3SEpEVmhaaXE1Z1YwU2VaRnpyekVFNmcyay8wdjY1NWd5c0pUemxVa1hL?=
 =?utf-8?B?R1FMOEdJTkNlWDRsV2p4SWsxTkRhdnNqeXRkOSs2K2ovWDBiOTlLemkyakRR?=
 =?utf-8?B?ZXR0ZldiVnR3VEY0UmZyNUlrRUxjcEd3L2tudyt6SHhLTmFoS0ZobHBPSVpT?=
 =?utf-8?B?MEozRFRjZFE2c3pzUG55UDhBclhmbGg0Vmd4aXpNWmVUSC9KOTJObk1vN0Yy?=
 =?utf-8?B?U2JOQWVrR21xRjBJMWxyTU5Eai8vdzJjMmh5a1BwTnk1TVRqOUlNbEYzT1dF?=
 =?utf-8?B?UkNnRnVDZU9VNnA3dVdjODNMUjh0VEZFcTExakY1VUYxeEpoc0RFajRyZkNH?=
 =?utf-8?B?dC9KWWUzYjZsM2R0aTZaYWRTcDdvZTk2elppZzI4S1pReCtQbzVLN1ZBYld0?=
 =?utf-8?B?Y3dpKzE1UXlWbWw2aGczSzE3dlY3ZUs5KzlCak1lRk9sRmRQQnNGbHdEeUty?=
 =?utf-8?B?TlBFQnBSRGRESW4wQXVJTy9UR2p0bXlxWmVLdWJ3dlRuOEN5OTdwbGpyQVN0?=
 =?utf-8?B?L1lDME1tdVRwTERZL1dRTXNlUVg0Zm5JMTd2SUxLYUkvSWZFQnlNQWlQSzly?=
 =?utf-8?Q?1Ux0P7WlLM9p/EmCUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9af1cb-027b-4e87-f075-08d9583c5daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 18:10:54.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACnDSUrf/eeSxuG8DGhLIh3HhBAYT8wQROZVBGHKlvm6+zBD8i6VpLHkxQu+9EwRu2axqZuGhu6BJk9ssaEAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2023
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHY1IDIvM10gRHJpdmVyczogaHY6IGFkZCBBenVyZSBCbG9i
IGRyaXZlcg0KPiANCj4gT24gOC81LzIxIDEyOjAwIEFNLCBsb25nbGlAbGludXhvbmh5cGVydi5j
b20gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9taXNjL2h2X2F6dXJlX2Js
b2IuaA0KPiA+IGIvaW5jbHVkZS91YXBpL21pc2MvaHZfYXp1cmVfYmxvYi5oDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi44N2EzZjc3DQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9taXNjL2h2X2F6dXJlX2Jsb2IuaA0KPiA+IEBA
IC0wLDAgKzEsMzUgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seSBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZSAqLw0KPiA+ICsvKiBDb3B5cmlnaHQgKGMpIDIw
MjEgTWljcm9zb2Z0IENvcnBvcmF0aW9uLiAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBfQVpfQkxP
Ql9IDQo+ID4gKyNkZWZpbmUgX0FaX0JMT0JfSA0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4
L2lvY3RsLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC91dWlkLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPg0KPiA+ICsNCj4gPiArLyogdXNlci1tb2RlIHN5bmMgcmVxdWVzdCBzZW50
IHRocm91Z2ggaW9jdGwgKi8gc3RydWN0DQo+ID4gK2F6X2Jsb2JfcmVxdWVzdF9zeW5jX3Jlc3Bv
bnNlIHsNCj4gPiArCV9fdTMyIHN0YXR1czsNCj4gPiArCV9fdTMyIHJlc3BvbnNlX2xlbjsNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBhel9ibG9iX3JlcXVlc3Rfc3luYyB7DQo+ID4gKwln
dWlkX3QgZ3VpZDsNCj4gPiArCV9fdTMyIHRpbWVvdXQ7DQo+ID4gKwlfX3UzMiByZXF1ZXN0X2xl
bjsNCj4gPiArCV9fdTMyIHJlc3BvbnNlX2xlbjsNCj4gPiArCV9fdTMyIGRhdGFfbGVuOw0KPiA+
ICsJX191MzIgZGF0YV92YWxpZDsNCj4gPiArCV9fYWxpZ25lZF91NjQgcmVxdWVzdF9idWZmZXI7
DQo+ID4gKwlfX2FsaWduZWRfdTY0IHJlc3BvbnNlX2J1ZmZlcjsNCj4gPiArCV9fYWxpZ25lZF91
NjQgZGF0YV9idWZmZXI7DQo+ID4gKwlzdHJ1Y3QgYXpfYmxvYl9yZXF1ZXN0X3N5bmNfcmVzcG9u
c2UgcmVzcG9uc2U7IH07DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFaX0JMT0JfTUFHSUNfTlVNQkVS
CSdSJw0KPiA+ICsjZGVmaW5lIElPQ1RMX0FaX0JMT0JfRFJJVkVSX1VTRVJfUkVRVUVTVCBcDQo+
ID4gKwkJX0lPV1IoQVpfQkxPQl9NQUdJQ19OVU1CRVIsIDB4ZjAsIFwNCj4gPiArCQkJc3RydWN0
IGF6X2Jsb2JfcmVxdWVzdF9zeW5jKQ0KPiA+ICsNCj4gPiArI2VuZGlmIC8qIGRlZmluZSBfQVpf
QkxPQl9IICovDQo+IA0KPiBTbyB0aGlzIGRyaXZlciBvbmx5IHN1cHBvcnRzIHN5bmNocm9ub3Vz
IHJlcXVlc3RzPyBJcyBpdCBsaWtlbHkgdGhhdCB1c2VycyB3aWxsDQo+IGFzayBmb3Igc3VwcG9y
dCBvZiBhbiBBUEkgdGhhdCBzdXBwb3J0cyBoYXZpbmcgbXVsdGlwbGUgcmVxdWVzdHMgb3V0c3Rh
bmRpbmcNCj4gYXQgdGhlIHNhbWUgdGltZSB3aXRob3V0IGhhdmluZyB0byBjcmVhdGUgbXVsdGlw
bGUgdXNlciBzcGFjZSB0aHJlYWRzPw0KDQpZZXMsIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
IG9mIHRoZSBkcml2ZXIgb25seSBzdXBwb3J0cyBzeW5jaHJvbm91cyByZXF1ZXN0cy4gTW9zdCBC
bG9iIGFwcGxpY2F0aW9ucyB1c2Ugc3luY2hyb25vdXMgbW9kZSBmb3IgQmxvY2sgQmxvYnMuDQoN
CldlIHdpbGwgYWRkIGFzeW5jaHJvbm91cyBzdXBwb3J0IGxhdGVyLg0KDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBCYXJ0Lg0KPiANCg0K
