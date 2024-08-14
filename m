Return-Path: <linux-hyperv+bounces-2771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B43952202
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2024 20:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B23B22E6A
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2024 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB71BDA89;
	Wed, 14 Aug 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZxYfZS4r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022101.outbound.protection.outlook.com [40.93.195.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED81B9B43;
	Wed, 14 Aug 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659842; cv=fail; b=UeelSdmvP+pPJSuEPT9JcW6RiLYztrrLI7y42YqTr7RtbD+JN/JO2AfGVdA884fIVIt6svb9KtJdfTV7Xjf4KFxtrot4YryQpvBTlfekjTDvaedizxUPblamkaWqWNxrUdIlWtJGbzbCeoCt9SnOKIpUVR5WnNemWndX91cSdcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659842; c=relaxed/simple;
	bh=3iWHI/lTuZzt1OZ1vFmKbh1pILDh3TFZzxvIG87PMj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueCkw5VAAduKTgbTpg72lJ+KXahCqTTWVPtU2hRDDW3Ebz36EdNQlkPSpJqBjEHTl5YB3zwh5Osk6Vjz1jXXclZ5XymL7+9naPyRaqYkQ3OAPMLNkgfbt/OkUwVw6VIK5lutrJoejhEeJmfqEFN8xLDeomsLYwic+l2RyeF4yRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZxYfZS4r; arc=fail smtp.client-ip=40.93.195.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4ENtDWYWuYTaAyvhwDzyjUxcGfriDdVsgblRWdAZqRrKIPFvdG+wuRnnmfdxaIUpSyqn23lxbVI6S2dz7F1xo59mCuTJAFhM9qaSUKA26cDYShZGM9Jn7aihANIXiQnZH8hzBU5a/Kc4JF9Z00p0YYr+PPUBW9w9ZdqKjNoFsykLgSiGX6PNyAD8hClOW2KKJ2Dj3NnKK8xsFwHWnOQVhz6CbCWmVm1HUmvzJB3cDcs83r81XJAxkEr7IpXfDetclHU0re3AeTg0Lq9sKVl+oxIrJKlqtzijZkc2XEF3nEaId+f90qiiKgFT51PoCNVXO10GsZcj6Khjn33OuR0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXJ3ksEr7ByFCgPzRhEtbTdEGxa/tRejglef9NS0Rug=;
 b=MlgTIt9Ww6Z75O2mB/iAmgZfgCYIfd/H/3RLs6jF9lvexT1t9fMzze9Rw1wsnL4+VpWcMUtCtKm7EMVQZlfe62jfwNDKeYfuB9wVX0hufiLBxvC0ZOv4VDPLY79upiNJYrLF3Q5jSkS0EApnpHATgm/Xs/psm93/sKEDTVEGkCizIS6OQRSvgjT8rdRTn0FXWkFlr5a4vjzHUzspEkFDma8iUrqMjTRZA7bl3sbimZwwHEVjhatWGpTC4WMiFdrCjvnhDV9N8oMT11nm2RDjE3KnEmLxpy0uQriPwwx3H1+9ynWjLtIurD6LRcfpQ5+Kx/vaR88/R1YkcPuZ7ZrBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXJ3ksEr7ByFCgPzRhEtbTdEGxa/tRejglef9NS0Rug=;
 b=ZxYfZS4rtxRTD+xnBVc1xUxJ1lQIE5UtGTBCPY++mOzt1rvcZOG6Z/6H2Sq/dMz+JHLyoYfCBSef6qDNNuTrRRb8DUxFl2QR1W8gcz7iDoP47Zmimuhne8mMls+/pnl5V4Gioi5IOQxdhqLgGkUpkYlNUSX+7njgVGUAqzmEOWI=
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::14e) by BY5PR21MB1441.namprd21.prod.outlook.com
 (2603:10b6:a03:21c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Wed, 14 Aug
 2024 18:23:56 +0000
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747]) by CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747%7]) with mapi id 15.20.7897.007; Wed, 14 Aug 2024
 18:23:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Erni Sri Satya Vennela <ernis@microsoft.com>
Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Index: AQHa7mtV2XlZOJGmCEaDVZjl//CytbInEPXA
Date: Wed, 14 Aug 2024 18:23:56 +0000
Message-ID:
 <CH2PPF910B3338D6A9D957F4BB241ED695ACA872@CH2PPF910B3338D.namprd21.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f181a12b-dc16-435a-9b7b-7681c02949b9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-14T18:22:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF910B3338D:EE_|BY5PR21MB1441:EE_
x-ms-office365-filtering-correlation-id: 38571c38-fc5f-48d9-8b26-08dcbc8e426a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JFD9Nzfkq5BXMN6x/RH0XMXeJW/XUE2UIrdhBG/NcNp3eC8KB9szwy7w3Iyc?=
 =?us-ascii?Q?pVHxE6Mo8SHLopgsLbzMhnm4UMnqEwYsm71EtcoQzRbvhD4Zy1XKmLFHwo99?=
 =?us-ascii?Q?hQpzR3AcHkwKyWtJ6I1gol+GK1Jmk514BR5Zpzjfy5dW+joRtl9sJ7ZO3y5A?=
 =?us-ascii?Q?d7h6unDHd+6SRSWUheq5qQW3obAwVkut9cEio3+HT9AnORFxqQj+qB9NE4gd?=
 =?us-ascii?Q?XIizbSfX4GSjR3UrDTimngeWFY3ksi2haoCWoD9QmZ0CIHo4FiRCKE0pzlYp?=
 =?us-ascii?Q?14jGhnogt/zoT1HHgVjSfXEdHMf0hJ3cuCQHzbkhs3EhWrxpGM0bSaRZtufD?=
 =?us-ascii?Q?F72CNZxSJsJ7abGOjuBwUoOp8ZmjuTcGbm0tmQlPmc+BLxZJQxmn1zih7Re8?=
 =?us-ascii?Q?IGVv6NtKsudT34v3QOe7gnP2Ei85B9vUWeQe1bt/DePnJpM0JwTvqasI9f6d?=
 =?us-ascii?Q?mm7i95ai5xdrwbn370tbf1Hqaa8fZM3VXF3RqYlvVY2qO9Je6d3Jdpvpj+xO?=
 =?us-ascii?Q?bDEvZNJN4yw5DeZxvPdp76dei1XkVHgG8R6fD7a4wXTi70dQvsOHSWH5J2Am?=
 =?us-ascii?Q?kWNvpLwxKR3FbJhbLhIizT8cJsQ8jdbua3e1YX0cktxMGP7D0NbzBdlkG9wn?=
 =?us-ascii?Q?V1nPms798UfADC+qH+n1auF8kC5uHkWRykKPzkvRhZwq4Ag98dLZjb9DzeKN?=
 =?us-ascii?Q?oluZEPIlkyLp09VthLi4O5Ld6WSxe4M3sm3BEGkbAr/1piaqJEobtmXvQM7N?=
 =?us-ascii?Q?tJIUzGuQKqlM6/cdIh2HVtehsbVkeCCeuL34KIY9lyuQfc9AGcpFn5difuhX?=
 =?us-ascii?Q?3SuAG+pGv/djTUyG5jodNe3YkL9P4BucQBWDTWY0NQMsWgYqF8JQ00jLo5B3?=
 =?us-ascii?Q?0i/u6sebFv/T2xbVPIXIS+BMbif7zrO8FH3Le/25PqM9Fvzi0TOcHATdayMC?=
 =?us-ascii?Q?2c/Rsw+gN+kCEFkuc4f5kgLYdJPd+VGQmXO3J97Pmwd3rmYZ/RFnslzT9qHh?=
 =?us-ascii?Q?U4ophjPXBUoQKdBUiZGKgywBNRCNSyVeLKfl6VpcpPjSA+8y1s2MJEbzyYWz?=
 =?us-ascii?Q?NF+Wsh2twNPKzIK1wIAmRCviRfzaVDyIFpFdYHmrhnzMzqm4FSMOEIDxNjUE?=
 =?us-ascii?Q?cx2udqCx0GdS0d146two5PcR4+kUzTSQvu6MFReCq/JCEzRWAd7BIMKsRWQm?=
 =?us-ascii?Q?kDXa+HNjcfzonYLaXUuGoqy2RGp8gpVcGNn2c0YFsghkzKUXrJD4PMFoaaUF?=
 =?us-ascii?Q?sYfueuW//U2KOHdNr68SbUtfloyPdswwG22VyHk51O+Ob+XCquZ1cxY8WtHc?=
 =?us-ascii?Q?ycBJJzEDRaQ09hQUl9VQw6lmExB593wb8mqmPrIJ0P1ykCcApFuDWCEb4cqU?=
 =?us-ascii?Q?f1aYzlhlil8xvzjeo/ztD34sJJJuj4zNVVPQMXO/ZTTGv0U42Fwe16vWoKWB?=
 =?us-ascii?Q?n1kcZy463Nw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF910B3338D.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ch5UlssJHMTSlRjRZsfHRuO5cbCjhtfTD3eVwC0mnBnNAoVip+zUUmJ8c1ZE?=
 =?us-ascii?Q?OZynTRSEAYYacrxT0kvEkqjUK7C8M5xhiVuxjh51a8+4/6YrLArQT9ig9lMo?=
 =?us-ascii?Q?5vVFp1Nx/wABj8gHkcXITspkTtdhhpa8B40r9uWEvsWQ+Ti/9pjK+/E42yQ3?=
 =?us-ascii?Q?IPZjENCSFg4tubX/zTh2OIepbeXFJTk7H1G2KVAJq1O/tMn/QoIJUHhI38jR?=
 =?us-ascii?Q?YQMJXg81uY8koXU7V4ggB0cAWZpMsGcn3sjX0gWZ6JXyv5EYvqWzRS4AfBO9?=
 =?us-ascii?Q?eEnk5KHpH8ckepivfju4dWXrloA1I5EtDpf/9novJh5uMuDgF7Ku6aA9gp0O?=
 =?us-ascii?Q?u3SQdejtvc4NsxLYL7PLuafBE9jdWGZiI3YPswVmer7JtljXI06nYnEBdiEh?=
 =?us-ascii?Q?+6WaIWxyJFA8nSwOfxregyEU42uGMN9Kneu0zX04FAWam+/Fvfd/ZxQBcccB?=
 =?us-ascii?Q?NAYF5xPPATA5VEIgoMmXFHA58icel/3wLTlktxTt/3dWi3y/NI1lyudeAJG7?=
 =?us-ascii?Q?iQrbsZOXcvFjd6Fic26clZuIymZwyna1V26lqN/o9vpirGpNwBQsH+qoL+Dk?=
 =?us-ascii?Q?cyDVfrq4IWnwIJzkbt8UhmXwCFmVNdKJ9U1XQjcPzjcNPqKr5Lx8fUU6JKx3?=
 =?us-ascii?Q?S7rgfBDFqIFf7mnV+e7DxPGrlhn0Z7zHFJYCR/kWi1lbwMba+Fv9qi9nyIim?=
 =?us-ascii?Q?+UmZx74wWbZ37zkX7+drVIQo3CvkLLiiDz8BnH0rkJHQVZnCYVIhmLVHlGUG?=
 =?us-ascii?Q?Oulrze/DWmqvJlkFt0BNZO9dn88qNa6ES4OpIg5hFBEiNjVd7PCs9ED2/+CB?=
 =?us-ascii?Q?HvrbpkZiCOhgR3iaM6oJDMnnaMwopvOp49l1k804TUWEYxvLqrVVMl1svo18?=
 =?us-ascii?Q?1vgJkkxaEuoL9uCeWXwwhXPStOT4DxhXcNr89pFJwgkgAR2rKNsBOZtTOZ+H?=
 =?us-ascii?Q?AnLBbdif1MTZ7RIHQJWhHr0OAatuwvlP1AiZO/KUZL2D+fiIlbkBB7Qgr4N6?=
 =?us-ascii?Q?jy4Za7pYZBGpBKOUvPGpw92URjL5qZeDEHdLBUKxylpoaxT5cAFSSzndfnUs?=
 =?us-ascii?Q?v8dy4mORZpfF0e1FmBfXaEBFQytyHkq92tfcQ4rSRP6mxcfqgxNDxWUh6p1j?=
 =?us-ascii?Q?fhg1Ne8Y94oHGJ6DOlvOTC2swNEzMCw8WpK7bOi93szskVsGwmVx+qska9dw?=
 =?us-ascii?Q?nVBuoADOldeu4HUsWD1zEKWL5qusH4MVSAns3b/Rf/Cd6vPjU+2kTLTr2vHQ?=
 =?us-ascii?Q?fiQTcQkLAxVjv+3sleJGarTQkhJpjQJyMgqMKtcdzRHyfGnoHrOUSeuF1d2Y?=
 =?us-ascii?Q?oL0z5OF3pyZfJa/4PbX5GKZNtOzBYDN8ssp8Hr8wjq/91ankQ5m1eS10+HGc?=
 =?us-ascii?Q?cu9h53bMVwb6jFrOKOEysvmfqPM8VlCZoGQAuIV6iensH5Yu1w11/upcvgl8?=
 =?us-ascii?Q?eXrqPAl9MreGgNKZECQUspvKQRrRqsprU1ssixwj1df7n948/33GCtmNm7lg?=
 =?us-ascii?Q?0DOtxX45wig0prVybokMCpfd2VnskO5KwGJWNsZf+rH/+/K9/7WkogfA/Azd?=
 =?us-ascii?Q?WHw80xHhYt+Lzl55DfYAg/WWXSVu74uQtdT7qf7l?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF910B3338D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38571c38-fc5f-48d9-8b26-08dcbc8e426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 18:23:56.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPMIxJb/vXsjQrX5puC1jgnIbpdE2M/SExdyHZq5UND71va7g4H2avrCJIvVvuZs47GBRoB0oQyL5mCgmziujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1441



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Wednesday, August 14, 2024 12:59 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Erni Sri Satya Vennela <ernis@microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>
> Subject: [PATCH v2] net: netvsc: Update default VMBus channels
>=20
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
>=20
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. Between 16 to 32 vCPUs, the channels
> default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> set the channels to number of physical cores / 2 as a way
> to optimize CPU resource utilization and scale for high-end
> processors with many cores.
> Maximum number of channels are by default set to 64.
>=20
> Based on this change the subchannel creation would change as follows:
>=20
> -------------------------------------------------------------
> |No. of vCPU	|dev_info->num_chn	|subchannel created |
> -------------------------------------------------------------
> |  0-16		|	16		|	vCPU	    |
> | >16 & <=3D32	|	16		|	16          |
> | >32 & <=3D128	|	vCPU/2		|	vCPU/2      |
> | >128		|	vCPU/2		|	64          |
> -------------------------------------------------------------
>=20
> Performance tests showed significant improvement in throughput:
> - 0.54% for 16 vCPUs
> - 0.83% for 32 vCPUs
> - 1.76% for 48 vCPUs
> - 10.35% for 64 vCPUs
> - 13.47% for 96 vCPUs
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.



