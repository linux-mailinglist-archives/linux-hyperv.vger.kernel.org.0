Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78058F3F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Aug 2022 23:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiHJVve (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Aug 2022 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiHJVv1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Aug 2022 17:51:27 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AC4C61A;
        Wed, 10 Aug 2022 14:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdU+7qX2K49/osFtxYy0gwdZP1BZ0s01P/HpI1SaamKTuYqfTXZIkwoWzBItnw2PP5jMdIwnUn3r1w8setd3ak7qXvFw6KJYn7wdUM8aAAZBxgfhtOVyKLZvYnFrZuZI9gXOjyOYzt662fTvBVRv0aVoaru0P1XwT18xXwxfrW/nhrQtxE7DsythmlFZzIZhBhydXi1O454vgdXRPshQr0RgVSMSqyo0YB0i6gSpZ2iyoIqyYPXoc6lin1D+G9Iubj8esVIjK9FjqHg6HoHFXu+P3mmTifH/dM6zAYkOidCZm6mhpP7zReHm1m1wLkUNcDnqFEtAGo+TqvKG1bNnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vvaAEkmKWVHlj6IwA4DRHOvVLKaDf/bK0uIYrYVPo4=;
 b=Du3onF/x7WEuG9to12v3JczR5cVKbzhYzYkBw+SWlwsNOQXP9O33MTljEAY+v6z0/nHavB0PrBbEIRx+xE5NDjy3MVqzFzE5VHV10pjXGrcwUfFvLHGMTlz8bm7ht7f7niVWv1B/MUgZTFvc9jh/iJFIOynNoWHWYpoKhCeEG5AvcdQAqlDHUQ6uak4dxmZDwkbbly8hBwpyttysfpMr937Of6hRvJHmD0kayp3g9vNKFuj0CtgHdDMumVdtTq5OA5Zrm/+LEFgcgdUKcZYeB9E1c1CsJd2M5BNIMX8SDWT8JCulIEayD671AVOlZ40oyAuMHb0nReDHjXLfC38PfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vvaAEkmKWVHlj6IwA4DRHOvVLKaDf/bK0uIYrYVPo4=;
 b=Yqjghdw2HUJR6GooFSlvHt14CorulcLN8WeFI6KY00iF4+RtD3pPR70k07NNdYuJYxAD5Fbmf6fKiSvzCimkkdITdASP8Oy179cmDFJQRUIz4MNZVUen9aatxF/wYL+72PAirechMtdA1ZAXMRubAniBfR85MMLF22v4vMd2/1I=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3180.namprd21.prod.outlook.com (2603:10b6:408:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.5; Wed, 10 Aug
 2022 21:51:23 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a440:fe96:e2bc:840e]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a440:fe96:e2bc:840e%4]) with mapi id 15.20.5546.003; Wed, 10 Aug 2022
 21:51:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
CC:     Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHYqA2nr0ByY5vvCEupYVpg2kRVKK2os23Q
Date:   Wed, 10 Aug 2022 21:51:23 +0000
Message-ID: <SA1PR21MB1335D9CF9F0B1C101F15E047BF659@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220804025104.15673-1-decui@microsoft.com>
 <0f19cc67-ccb1-7cd1-5475-d2ec0e1abfc0@quicinc.com>
In-Reply-To: <0f19cc67-ccb1-7cd1-5475-d2ec0e1abfc0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=53221d8f-3ae4-4101-92f7-d435fe84f512;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-10T21:40:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80959e3-8814-4a65-4341-08da7b1a77e7
x-ms-traffictypediagnostic: LV2PR21MB3180:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLM2Lo/OXxGJ3R+tdgfxybZ5LgpWZoXFMW7rh14UzyJIF9AhKGQ75i9Ax4WJBYfLLulLhQkM2Xa4Lidne0TM2k9RgYiJjnXqT0FK+R+xrTc1bT6JqSjYxcGZzifadDYugaxdfiRr3CXDdPoLUT83mU1gunufh79pal8MdBZNB6ZBAZHEdfu6+n9L84vwJrFwukl5KdUS//WzPqYy5GbtWEhmxwCCyVdY+gtOtyROAJLmZyq2XuxSACmhJ02+UWtPFY007+UwuXFOm3ZZji7S3DQyOGLVdyd7POQEBG28wrrjHRl3G5Z4ULti/B2ou6IhAo+PjSxI/yTEgkxDeKmsslqS6jqeb2/jIJtNkAPatCk7T2nIIGLi8C5jgm++MM2lEiaaoOlV8/DQy4rr6KsmJfAKsZsYjZnjGh1ECOYXAGeFg8ZndLgjXMjkN6zwqwAmKu4nLTBNDhqmjOUoYi+dkUDXLGtVsbVRnNVpX3yswG4bSSHeqojSPO8TyG93OSvcPQqFIbsjc/Cnv0lvc1C1NQOQ5P4pFEVmZieOdrCvaD4KK/lBrTphI+P3WEhGypGA9EYLJtWIlhSH86e0BJxHzhSK6QdzncKIp1k3WI5aq22fPE0XRJjFrO/oDVsiMlXOM/qc4fOQN8X7udcHXjPxiaI3ec8pOgoj0PFHZCVWHzBvVGmkCKooW/5qRf+ZQdagc3FlZP361syUSZ0MLpOIjKXcCJWUEeX6iAHXATWyKkrvssWkO2xFzh3Xj1v0Piftt8BibASS7V9kAyGcMtQ3pMdPiUHlho7tzSIxNFTVPRW6m0Nm8V7FM/qbxS9xUcgpLUQttXcWASZKfbdPa2AlsyWoaxZB0YkBsf4jzw6ofBnAJ9AWP5SmTivSx8oRHPJ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199009)(2906002)(4326008)(5660300002)(76116006)(66946007)(8676002)(316002)(8990500004)(66476007)(4744005)(6636002)(66446008)(64756008)(66556008)(122000001)(7416002)(52536014)(8936002)(55016003)(38070700005)(71200400001)(38100700002)(33656002)(82950400001)(86362001)(921005)(41300700001)(82960400001)(478600001)(110136005)(10290500003)(7696005)(26005)(6506007)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZvcmkvVEpmdElRNHZyWmt0aWZqWFU5QkUzR082Wk5NRGE2TDRwcmtOa0hR?=
 =?utf-8?B?L2FUWkkybmRIS0YwbTV2QlRma2s5T1dYT0trbXNHM3VLK2g1UUVEb2dkNng5?=
 =?utf-8?B?VEVLZFloeXRhM3FvZlAvNHlQVWVIZEFvU1ZJVlhmK0NnQlVuZzBsbzZxeE1w?=
 =?utf-8?B?WG1zQzRycGZpZHMyMGJGdHVqU0R6ejlsalZzYWtNUGtHNjZ1b2QwYzF3TlV5?=
 =?utf-8?B?UWFBcExFUVRBUzhqSlVrYTdCYUFMQWp6QmJMWVZKR1hHRUZubmk3dHZDUGxp?=
 =?utf-8?B?S3lNajNNZ2lZU2Vsb1I1YURlL1RrYkQvUDdaaVJJeTUwZDlFdE1NeTNWU0Z0?=
 =?utf-8?B?WVVLRkhxYUMzSWRIblRhMHQwWXd1eXlvVlZjVUZ2UlJ1Ni9KL1FCVWc4TmUw?=
 =?utf-8?B?ajJmOXljZTFPb0JiY016S2hXOGJjWEpCTG8yYUhtOW9vSVZXazBoQ2Zwc2tn?=
 =?utf-8?B?SWRMM3JYNlRhK3BRRy9ZSnJIUjlLc1NpSXdtQnppamdUOEVSUlhDZHVHaXlI?=
 =?utf-8?B?MDYrTVBzeE9JQS9TbXNkdWpsUGswQUZmMHR3Sm45RzB2dGJhYzk3NHFtMUhT?=
 =?utf-8?B?T2RVN2VxUE90Y2ErREpoenJNUXVuQWxtUnVQN0dzemZLM0lHSmI1VURHdjdk?=
 =?utf-8?B?Mmx0V25hbkZ6WVhhRFA1dzlKdVV3NW1mSEk5R0hpRDBjUW04UUxlaWQ5dlk3?=
 =?utf-8?B?OW1Cdkh3MkRMVEtXN0pxNUVzblh5TngzMGpNa2t4dlRhSjJDRVplVUJEVDJS?=
 =?utf-8?B?c2x3c3ZqWmFuOEg1L09wQ2NBaHp5Q0FRS2JtcEJNZG5aK1JVdzVmSGc0OWQv?=
 =?utf-8?B?ZzFrZ21SWmR0MmpudWRacjFIcDgydkhSdjNyYVNiWTB3emhFTlduYTc4WXVn?=
 =?utf-8?B?RjBYTFZYenlSaXBWSFE0M1ZOTlJTWVdTVmNkbmVYNEJ2Rm81TStIc1QxWVQ4?=
 =?utf-8?B?T2pjR2dMY25qbHY2R1R4dFd5cE42NG1JMXUxanREZXNwaDF4OGZUMExjMlU0?=
 =?utf-8?B?bHd1emZJZEkvN0YydHQ2bW9peXJWalFsZmdKTWZSREEreWtoQ21lZUVlQndG?=
 =?utf-8?B?dXYrZnRNM1JaYzFjQ2VrYlZFY3RMcGdOaTZCZG9kQWI3b2ZYNUY0YlAxWGRv?=
 =?utf-8?B?TTRoYU14YXdGUEhDNXhYdjhDeGNHQ0ZCU2xTSEtXWVRMcC9sWFZ2OGJ1RlNJ?=
 =?utf-8?B?WS81eU1qRzJZK3FlaTIrMVVKRVY4MWV1cXNVRzQrTnRGVGhydFhMYzd2bHJV?=
 =?utf-8?B?MVdKRTlxd2lnL2tqdXNwVlkra1N3bG9uZ0trRzJBMXFhbGNnUzl3Z3hPR1o2?=
 =?utf-8?B?YmVzOHNOYVpOZnhFTlBuLzkzV1lYZDB5UDBKdTl4bW1vL08xazJ2SkNyVmFT?=
 =?utf-8?B?aWpPbCthd1plUExCUzNuR3dCcEV5dWk5MXhFZGMrdUVEYmE3d2tFMEVtZEFh?=
 =?utf-8?B?b0ZZQVVVdHZFanhUM3JXak1lR0FNMGUvU0h4Y3liY2ZrU09TVGpIVG9sQVZm?=
 =?utf-8?B?ZlI3QlVYWkU1UjJSWWgzeVBodUNnaEsxYUpsYjlKWHlvUmxkYnZwbXVyOHRx?=
 =?utf-8?B?eWdTdnV3THl6cFBVM0ZLS2hKS0YyS0N5K3JwVWZEUkNETnZHYkhjZmZJMnpI?=
 =?utf-8?B?bm9pdHpaL09QNEJwU1RiY0toTFhsd2duM3I5SHNtZUlEZW5jVUExZkRBU0Ny?=
 =?utf-8?B?b0xUMll2MlhyTXllQnpNYXFQWTNoaWNkNUtBNkNIYUpyWmoybHpCTnRXeElr?=
 =?utf-8?B?SExHZ0thNFdOR3FRZU50RE1hR0diWHZvWDh4WTlWa1NLSm4xMjhMN0JWYnIv?=
 =?utf-8?B?LzV4ZzZoTE0rNkt0UVg0eHBrN3NsSW5qT2RKQVZUYjNMWEtmVWtXbS9JaWZu?=
 =?utf-8?B?UjhtYzJVQ1ZtMnVDcDVFV0VIRlZaTW9sazFnSkNrMVErY21wS0ozTzBqZlla?=
 =?utf-8?B?RUkvWXpkY3U2YlNjRHF2VUYwUUtlbE1GVCs2WHJRQWFUY3JGak5hSlU2YlY5?=
 =?utf-8?B?bjh1RHB0R1BIOXBONGxra04yZW43QU5tUGFwNXJHWUJuWXRYc25qY0tSZVJ3?=
 =?utf-8?B?b3ZuTUtLUElzVEZOS2dBOGV6Rk15RXJWTVVrZXhaWUdhakhCSGRxOW9vbXpi?=
 =?utf-8?Q?TK0eljyWoJlvfVAfc+SuO2jvP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3180
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBKZWZmcmV5IEh1Z28gPHF1aWNfamh1Z29AcXVpY2luYy5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBdWd1c3QgNCwgMjAyMiA3OjIyIEFNDQo+ICAuLi4NCj4gPiBGaXhlczogYjRiNzc3
NzhlY2M1ICgiUENJOiBodjogUmV1c2UgZXhpc3RpbmcgSVJURSBhbGxvY2F0aW9uIGluDQo+IGNv
bXBvc2VfbXNpX21zZygpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBt
aWNyb3NvZnQuY29tPg0KPiA+IENjOiBKZWZmcmV5IEh1Z28gPHF1aWNfamh1Z29AcXVpY2luYy5j
b20+DQo+ID4gQ2M6IENhcmwgVmFuZGVybGlwIDxxdWljX2Nhcmx2QHF1aWNpbmMuY29tPg0KPiA+
IC0tLQ0KPiANCj4gSSdtIHNvcnJ5IGEgcmVncmVzc2lvbiBoYXMgYmVlbiBkaXNjb3ZlcmVkLiAg
UmlnaHQgbm93LCB0aGUgaXNzdWUNCj4gZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLiAgSSdkIGxv
dmUgdG8ga25vdyB3aGF0IHlvdSBmaW5kIG91dC4NCj4gDQo+IFRoaXMgc3RvcGdhcCBzb2x1dGlv
biBhcHBlYXJzIHJlYXNvbmFibGUgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogSmVmZnJleSBI
dWdvIDxxdWljX2podWdvQHF1aWNpbmMuY29tPg0KDQpIaSBMb3JlbnpvLCBCam9ybiBhbmQgYWxs
LA0KV291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgcGF0Y2g/DQoNClRoYW5rcywN
Ci0tIERleHVhbg0KDQo=
