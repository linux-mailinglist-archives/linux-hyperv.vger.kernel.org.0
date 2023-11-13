Return-Path: <linux-hyperv+bounces-883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC87E9538
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 03:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE21F21152
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7679D8;
	Mon, 13 Nov 2023 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cbZupJpj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0BD8466;
	Mon, 13 Nov 2023 02:47:50 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021006.outbound.protection.outlook.com [52.101.56.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF526115;
	Sun, 12 Nov 2023 18:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldl+LfuUbg/RnUURojUoLGT9CS10AC2y1xEdbKmOOhUQZ0j7ipEdkLO/7Cem5nf1RSUIA36dc8VRN2oAYpH9mR5MKoBQgyC6Z6kJ0pV0iCgCQnO7mUp8jiWkjWlEsOjHwtUQrAr3rRHPxnNbJsffa/JBsgcfLJsJ/oZbkK6NjYXWCPjJZsdZ4l93XP/REjvz/pOteAtGWPe8whuOdEKtL1gNFCnzx8hkjDY9lqPb4KXAxFs0OyPn6+Vg7TWrvfhQddsRqD2J1migIUMwZ+CGZoPcflLtgk1gQEV2naNhmEMhnzXbnCsMCy4/G/zeM4gya0Nwy6ucEb0Evdek7+P9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY4rgrXwtRFEQwspEhnZN45CtxwPlbbU85bSf6vRooo=;
 b=K8pvHhv9Z4TwtGNUuuEjNkOf5ob0lyjTNaYleU6DRKZT57DZgsM8JaCbI6IC+N+K38ck5J98p0gDLNVIeWrR0SrPIrF2jkJUjqMiJ940JiHreNzYlWhQ4za1eWEOW3Pq/LoGu+DbLXogewm7/DoozkSentXRj9YyZZ/w7lTwxKiKhcG3w2Obj7xrjC8srjiuhmadzTcKwzBddAkHnW/3jjXAqEQ4IUCFEHiI4sR8Zor18uwty1Kv0s7dHi7nLDID0xzjakGqUphbT78/z5OZJAti9ycGYRcLd2EvBCQ7SPKkcIp5Q2aDQNLP0dTASBfxYvsyCd6lvDGQ+QpWLhpzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY4rgrXwtRFEQwspEhnZN45CtxwPlbbU85bSf6vRooo=;
 b=cbZupJpjzJ+AyBT9IkVY8GYKE6w8jZDJFOtovEoCggSRlRow+YlpRYXfXBrDLSFpp+gc878D/J5WTDX1hDFcIyrpjp8dZkuqVVRa0OuNjspAOdcPXuE5/Kptq58KC2LSb/BqDa1WHLoTChzHShLIHCx80ZgtZvrsm6iEZb8B12c=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3691.namprd21.prod.outlook.com (2603:10b6:208:3e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.3; Mon, 13 Nov
 2023 02:47:46 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a%2]) with mapi id 15.20.7025.003; Mon, 13 Nov 2023
 02:47:45 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v4, 1/3] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Topic: [PATCH net,v4, 1/3] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Index: AQHaE+O1KhHXoobg4UuwUafU9fMaCbB3j4jQ
Date: Mon, 13 Nov 2023 02:47:44 +0000
Message-ID:
 <SA1PR21MB13356883A590CFC37A0AFDE7BFB3A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2fc07345-5ae1-45d7-8005-c478f8c8090e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-13T02:46:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3691:EE_
x-ms-office365-filtering-correlation-id: 4f543085-e4bc-420c-17a5-08dbe3f2ea00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mvR5EM9a2nmnE9ZSiIVr/K8c2c/hjnqXUow/pcRSGvamstCSpTl5IfZkpU1ZlR47UNJaqBJ0Hi2v8BV2Sq2/Hc5m4E22ckwsyGMv5YBsw9Q5XWSaquRej02kyQWR4KUUGbLxeZjXWSsoQ35QtqWBvTqgUL0oOXzGe1r71gd6cL7kD9rCV1n6FfZ/DISF7P9ucIZHhMx9thRIL5Zs6am2sLRafKe0i8RdFUEyhrneaWqztLao0u/u4huHyWrrt6GwBMIN5FlrXBgxQexzjLNmCjrI5/OzMbJhaR3ZS2UJ8WMOc1rVWvoNAsWROa1ZX1Wjp8YAxJPzKvzSyInQYksDk5+jFlZoN9KuSXJNhY1B+TolLjBnrs+YLNIB1uIdbBzLQqLjUao6DOV85J1kb+Q6IZx1K6CdMmygwZ84XchMdPf7kh5635vSPq3x/L9J6QsybDCAjy1MG45VV8rOGmQc/qeL5Fg3czjp0j7AieSLDTMBtBSxlV7zmADe5VQfeBQBStPuYQre/0WQqYIV3n7ojHNf6Xkm7yW5DAMBUgMGlAwf7Lg2+qkpq4pUy9EVOKgzYZJzNiZnzuwY3j0pI/TK8KY0iW+TfeNAPNFrn227ECRCi0DNYU3sAbT9CSuTDDZ+hzw1YVcnApdV/C0gHD1QzBJHWyLesMuze+vK+ibMZGw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(54906003)(64756008)(316002)(66476007)(110136005)(66446008)(76116006)(66946007)(66556008)(8936002)(8676002)(4326008)(52536014)(10290500003)(478600001)(71200400001)(8990500004)(33656002)(41300700001)(5660300002)(86362001)(4744005)(2906002)(38100700002)(122000001)(7696005)(6506007)(9686003)(83380400001)(82950400001)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TZNUwPhX8M+Jekv1mS6W4gIZPpnUMbgTcfAdnVTQB8bGns2vzcvXeKt5CO7+?=
 =?us-ascii?Q?YsCzsZnzzEb+9CAuVH4pyRYLvijYnI8bgEX7zOWCttVGqIlcDD02vNg/NbtI?=
 =?us-ascii?Q?hD6mP+zi7HnvvYDLLPeP38xYvb21wtPP8XoyArJHDdY8s1JkkYKxYmPpA0yv?=
 =?us-ascii?Q?WRLMWZ3jhuIGbQzsxjBQDIL/ELcxjJfm2gG/5S8XDwFYp4CLNzTrw620nG3r?=
 =?us-ascii?Q?APrkLgkxdoFyppIwN2I4AR1eYpuGrPVV1oNC1ok66UPVShFYRwZ3U55sjp/T?=
 =?us-ascii?Q?beAABm638ax8AbClxhGg0sh7woNXz1uy5/cSywUnUaam/ly6TKvD9ilnPdZU?=
 =?us-ascii?Q?jlLMLbjah/C8NNbRwWvYROLKoBDjQHIT2qEF+dpDrXUSLi79dqgNRvD9PvlV?=
 =?us-ascii?Q?GCIC1o6yysQr5shSeZ5ybE4/C72ZopGGbs7jD0/hVjDqbUYRHPo6K+hoNZyZ?=
 =?us-ascii?Q?e0388cAxDaTyJVOBsj573+bZ/IW1O+CHyj7QXEdJqTmHN4+qS91/yvanyZA4?=
 =?us-ascii?Q?0SphK4O6UiNbb/zzzBQEKILLPLZQ5j7CYJao0tKLcVXEoOu/Dqr53VYDhdlJ?=
 =?us-ascii?Q?QvpqWSvVat9bjvpYWsRALkq4v/h5IZ7wxTIYNrdMknXGUS8wUaVp3sL6LhFK?=
 =?us-ascii?Q?NJNgsgRVu6N6a+CnuonSKY9DncHrBssIe/FCoerHD5MG5G9szEQeMiFvm+Fm?=
 =?us-ascii?Q?lbZIjannUebjUdJKEkaBwUQKjR4OwLo/cMJmy/S2IswcBrdKKwjNjTjfkGvB?=
 =?us-ascii?Q?assO7tDsKP7tGqMF07jXFAErSWj2VIvuvrcoX1C5pSw+rUuWfEBL7vclAcwU?=
 =?us-ascii?Q?UaAhXKa2F/+/7gdWY7ZC2DgzaNiTO5WnavFICo3rSi7zDqEyqqBS0bY8fJZe?=
 =?us-ascii?Q?vr3uP3zMlJi9xRfurcRy1h9UWdXgiQwNbgZmWyZW66nKLwLZzTHQGXbfOAwQ?=
 =?us-ascii?Q?9BCJwBu83xH2YzgGp3iAQ8R9nU6eJGzgidfQ5vv4pFIsgE6PC1Ct7ZzMIgO9?=
 =?us-ascii?Q?YftgIV5YXkxsrH1Nr8cTj42VGrpR+23Zc6tL+STyWbqj1pq1y7HoBN6tCxNb?=
 =?us-ascii?Q?kjrgr4x7m8oAv3WF7GS60p88Nkbim2Tjs6JFFCtwjlgMK9EzSIbOThy4N6gG?=
 =?us-ascii?Q?malHAPBS7ykBh70DC3gmSTv1hPMUQ4OBFLqsgk74a1OAJ4Ythr1shfEbaQQA?=
 =?us-ascii?Q?4B5DFuTNqN/ZZyV81in2QsQmsNQw9zcjyy47tLwWthQphu0Z8AWaqIN3WczW?=
 =?us-ascii?Q?2Uw5VWhzn5Zm/5m7zKb4i94zKJWXQS9mvaqd3MqXaqRtYpI1xfpsjWRRJKBq?=
 =?us-ascii?Q?tyKl7jEQUKf9jriw217JhiPpwwL0Hc9BkU9e8Osq7CxgM9/nYEn1knvuQMbY?=
 =?us-ascii?Q?5IJSGQ+iH12IIwS+6ZIS1iAqudrS6DXd882fuI1aq2gqEnqQcei/vHQ4Z3Xu?=
 =?us-ascii?Q?Pvg8ZZag5YbkBdZJzJNXD6h8W+51nrQQ+g3/gJAsJG2RKEbywsJffsPWa2uP?=
 =?us-ascii?Q?yhj9w0yVOExjsKbYQJ9hrBibaFNDkz83l9lZ1WWNLDtpn/ei3UR8C7GZjw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f543085-e4bc-420c-17a5-08dbe3f2ea00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 02:47:45.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0ORlN9qTiswKowjJ2Vr+EheR65YAM8d1lowdCMK/I4gYfjtAqjwcyG6u3FG/MZoj7JlTU7gImEnyYnKr+FXrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3691

> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Friday, November 10, 2023 9:39 AM
> [...]
>=20
> The rtnl lock also needs to be held before rndis_filter_device_add()
> which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> VF NIC offering and registering. If VF NIC finished register_netdev()
> earlier it may cause name based config failure.
>=20
> To fix this issue, move the call to rtnl_lock() before
> rndis_filter_device_add(), so VF will be registered later than netvsc
> / synthetic NIC, and gets a name numbered (ethX) after netvsc.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earl=
ier in
> netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

