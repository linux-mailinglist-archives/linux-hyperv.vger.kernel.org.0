Return-Path: <linux-hyperv+bounces-3633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15CA06BEF
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 04:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA86C18826C8
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 03:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE623398B;
	Thu,  9 Jan 2025 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UZgFi9ne"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011024.outbound.protection.outlook.com [52.103.7.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF510E3;
	Thu,  9 Jan 2025 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736392569; cv=fail; b=EPz6J3ydM0BuD1OgnOAnb/7mAnL5IKiDxQe7mrEdTllvdr/cRc0jtm0ZPL9ORH1Q94Ti3vu3REf9EmPXh+f2qWw+dXpYtbCsUt6+ad73TI50Jr1ZDXQBuHsiN7RJHDkJ6qIG2gscHVEqUcQOh3dANJqhV8cGEBppVCTbqJ/MciU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736392569; c=relaxed/simple;
	bh=XB/ST1ZwFig6wKhniNfUM01VIceZfbgY3jg2qfx37Uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AE8GyiDvlnDy6KpgxjSGlq7lMPiKrEkHmO+qMBXf1fOsTxM7DiBBhB2dyK0ZoAm1Ag1evvuhZQgnegnsE8MClaWS5Tb4oUEpWTTP7/YOjmD6Q5NgBXbdSqOr5ljnqpCXys2E0FYR3hHs/C9JdTrpLyQ979b522LM3TU845c+DDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UZgFi9ne; arc=fail smtp.client-ip=52.103.7.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYU16/565gn2/pUM/Ahe6fCr9D3a0yNQV3YVBSinw3K9jAWxzex9ip5FG3kEkGXZyIBFE9LqIRrl3Ajy26IOJfM0kSH1N+eQy7V2oyCmC+mqXw5r+54jsTvqgOYElg8ZPORaFGA6hcuHAV4V1Pd6Var775CEeRowyTxz0H1O+s+DqWHtZWLNO5Q4T7nzlhYq5ZVaiRueo+cq3/axjqRylf01qQE+rv82vbmlEFtG9aiaQeTW21AI18fKyF4eiXYejNpqAKS1EOrIpQKTGIkTI0P37ZISnpxqE51CVI0qqDeAZJPKawbN7ws/W1D915k7gy7dWbEA84SIcnwQ5FbLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx9c+ZcM3RROux6WhLL2IDaLKcn8+cCVEbnGTwZhN98=;
 b=siHz/hxVr2ylWFo+Z1AsVmJdxvNxy5opURviB0uowhKQRIrP/ocBClAUId6uTzwiA7WSg3x6JjS2Kj7I0pDCZ3pOPIbIKcp7hzXVXn+UacQ6yPIaF/eFc9HwC2GSRMarApUk8ADiddbaInVVxUMra0SrIcI93XFcmjBW+dJCIMM63zSWnK0mPXQNDK0epVDwHt8cAgrksyydUbNE1TT3VgD+tS/AxPuX4rZwo+TdIsmtyZ20GOhicFCqQVGagM0iojtaKskHdEy0I7cxnfJ6CkgD1OJhcrkv8ArCk/hyhDCr/FpT3rlL5cjLGXgrZ2vzhwXKJG0ieHxZc79NbiPeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx9c+ZcM3RROux6WhLL2IDaLKcn8+cCVEbnGTwZhN98=;
 b=UZgFi9neS4XjJCZsHdHfpZAOglrNScF4NHzCuEarJiM60y8F/WYQKKHcFy3Z9RaAHW5DEZ6c2i6ig0Hr8jI1dkYi2EcdxFaxa627TNCUl7uy6m1iX1Apc8TYBrxHtLM5aPpKdoxW2mDIZ50od6YM0k9OU7pTeDlm6rCVk7M8C8QISaCIRX8N7xqIpM5KUUk95wreWeOU5sv0EUUdUZw8ZH4wLK4ktUiGNcN6gy8nGTSchBk+Xy+GD9oECReT1/uO4fo3xmRWY12doPOjeYIto+0XXWpSUJ3dgSGMXPX0EbM8tWfXlpoL7wy+fPpJuubinQjvNuablFBJB4eW8IkP1A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7105.namprd02.prod.outlook.com (2603:10b6:303:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 9 Jan
 2025 03:16:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 03:16:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Breno Leitao <leitao@debian.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>, Josh Don
	<joshdon@google.com>, Barret Rhoden <brho@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Thread-Topic: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Thread-Index: AQHbQY95SClr+cbj4UuvTBfw6jI/QLLioPuAgA3rQoCAEu8ngIAKajkQ
Date: Thu, 9 Jan 2025 03:16:03 +0000
Message-ID:
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
In-Reply-To: <20250102-daffy-vanilla-boar-6e1a61@leitao>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7105:EE_
x-ms-office365-filtering-correlation-id: 5d8aa4b0-06c0-4ec4-c962-08dd305bf31a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|461199028|8062599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ngRVP6HC1GjqW6GCvFK2PxJmNL1wfaR15m/ZEc77xCASZAyGrrZxGt/InqLY?=
 =?us-ascii?Q?lhrSQHLD9Lxv6e5CsQLdHf0N5uMrgIbpflEuA4fEENGr2fO+JnRad08hwArt?=
 =?us-ascii?Q?0htTDIYsGTJT7BfT1Ge3H104MQYjPSUVDsvhzHYMQyDVSTY6u0KRg71bYc+I?=
 =?us-ascii?Q?MIRoMdyHMRpMdXrVbGy2uv67KFHrvL3m83y1dwgBOFk+kFHB31C/CL2dODu0?=
 =?us-ascii?Q?E74UI4kOjPcEZCGPGzaSsGh7G0crU2hBq0eNgtJp6GXJy166cx/vsgmSkzGp?=
 =?us-ascii?Q?C8tPXYX4945kA//tOGHWM8fTH7OIIWKrk2lArGWyL+Ec9tVhy7hMlmEZ57uG?=
 =?us-ascii?Q?P8oaZ3cjAGWzYpE17bxzsL26+milid4OMbYC1L0AsBgvBAJ+BMelsIZILeHN?=
 =?us-ascii?Q?pt433RMAdoBo/CIpoLlbne/uhYn17V+cIB+tR9b/ldZY0TftFngumWoUM6zP?=
 =?us-ascii?Q?Ejgi34UY1fA1fkwldYhlJLpF1mrmO98//KICS8xHjuhbXk000LoLeB5ypFDq?=
 =?us-ascii?Q?fQpKaHCdfgq8l/zUHNXtxgksZj5WJt4ZPV5l9NVxUFfXnzJMiRg5dTIi+Ey0?=
 =?us-ascii?Q?3YwZd8+o9tk/4e+7WPE6Y1RTRBfMp848t/uHgwlr9SR01jVNf/N2Rln9OI57?=
 =?us-ascii?Q?m4mMZxyPsCeYZXM1ZKaHzgqA7tZG53UnljJaR+t/tYatRaT66WXstnGUmutO?=
 =?us-ascii?Q?/zQ+SSTsIJcN3ydyaUhnDmvmOuxDIQzmWxEf2yL3KeYynmJnrGC7ohFwuhvW?=
 =?us-ascii?Q?4gatxvMJ6eLd1xUFrdFm5A0SJKqxhAnjwLdXGz97Tz6Bs9rQGqOqb6d/AQa9?=
 =?us-ascii?Q?TBViSaQgWgFabz8GdkomW4fxY+sQPS0UX+7WemdLSGjtBzXaNsDfN01AGgAz?=
 =?us-ascii?Q?H1FZQCJI9MNFi2hbfO3qVsiEESNl3YiHRfRz4pB2JY/evbJgTFgGo+30UuKG?=
 =?us-ascii?Q?YwGY7yjiW5t613WHiFVIO/z2NtIGRQ/pnry8gB2PVgIsl5mZQ8CA0mHIbqLH?=
 =?us-ascii?Q?tp8ZY9uAVLlQxgTK++HN9UC6U47joMhemuLvm5OsjnlYL7U=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fUVQ9nBQy0FD9zdOqfc2lTO+Q+JzcGNQJ6dP2pXtSlMipXGz12wMtaEDfQfH?=
 =?us-ascii?Q?rzlfECB6g5FygtU6475Hww0HDifEPi14O+PTHrE+z21+jgqSuQDbnl+5rac+?=
 =?us-ascii?Q?Cu6LlMg+0Hzhf+cyAKMEvSW+K5JDr0M4QLyHcLz1+PJs7A9K5XbDlTGJzFnG?=
 =?us-ascii?Q?GV1H+k2dfaQY30IG1w2oDd2RqQaBbcxe5c9RsLx+rMu/bBAKkUTSSYpX1g3A?=
 =?us-ascii?Q?xxZSRqT7fC96al6R7cgCN5vS1qvo2yIJWqkvNXDyjvJAxVzxJOpJvJ+P7zc4?=
 =?us-ascii?Q?kwYuki9FvNZY9vwQVdJ5dxE5RB0NDklub6rV2xKNVXiQmlqTJC8nCmgAt5EL?=
 =?us-ascii?Q?ostGwjYpHdDJ1il+VzbLVeFBGZsDdLI67rrJNjVgybibd2D1dvhDUsy1zooG?=
 =?us-ascii?Q?P9cx3iSeE3SJVYlEnL2/d+zvevhzbR4RC06F0KbwLhIJ8G+l9GZHdw3dj0df?=
 =?us-ascii?Q?UaSmqGzf/AcmnO90K8mD1WT31bPvVyxa3FMcyIymfj8fFm9LuAxtOD+KJtob?=
 =?us-ascii?Q?Qq6SNjIeCUC/0yXj8b08h/He81AtHHcibeGiLtDIPKJdv7ZKdyMSjwFCCdvO?=
 =?us-ascii?Q?ld2Vyolsy5XVGAuot5VAQBKqIYvzlDcz9RiItg5CGhyuV20zOo/V9zH9Ifzc?=
 =?us-ascii?Q?DboyoMYl2hSO0aMqFdfK4IYIZEwx1K9kHCUB838TWbwdA2gA5AJRR43yAFbr?=
 =?us-ascii?Q?LmfWAuYk31zQLlYTfgAC18phHdsO6Q1O0YWd1AnMaOutPI/1PgxGlAo/6zF7?=
 =?us-ascii?Q?cjCly8evMJz5ka+d3gNEepdJ1l+BrHuDqmdVC43U0rytUbPb3vAdcjQ2f4xM?=
 =?us-ascii?Q?jgflbBfyIIFtTvxuGm9zQn4QwhnQJ1Xi/nIl9GATmofbO3Sgagzpk8DUCXCp?=
 =?us-ascii?Q?KuVxOgFD0PQQJC26ea7YtgEoRTRa3hMGuZKTpDK+JeIoTC/qkRNxOUPIYicx?=
 =?us-ascii?Q?HZ6RhS05O+PHwIyS0skXG6vFqh5kCAcDVXgUDTOstGTYlIx8Q9vrkdxoadZo?=
 =?us-ascii?Q?9krD5LXMv8O9NcnW4kdr6Sr6UwzNDhS+P3oMXjcSNHEa1nuTF3o2EFVhqMLP?=
 =?us-ascii?Q?8H6sDd1OeECgPpaMezRcEScl6QuEDMFQlbsl8HW6AWNeH0YM5QA6P9QUUcqe?=
 =?us-ascii?Q?1zgNIM9cwwyD2sjJGAtIalCvLbnd9UXS/ECcT0JTKC9ypyErGiYAYjtBGbna?=
 =?us-ascii?Q?FWxVHvU17cYTlIqUSJiJcv0UTFcvj8uoVDVPDWLK9MNv7tpr/agwbf9ewHI?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8aa4b0-06c0-4ec4-c962-08dd305bf31a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 03:16:03.4728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7105

From: Breno Leitao <leitao@debian.org> Sent: Thursday, January 2, 2025 2:16=
 AM
>=20
> On Sat, Dec 21, 2024 at 05:06:55PM +0800, Herbert Xu wrote:
> > On Thu, Dec 12, 2024 at 08:33:31PM +0800, Herbert Xu wrote:
> > >
> > > The growth check should stay with the atomic_inc.  Something like
> > > this should work:
> >
> > OK I've applied your patch with the atomic_inc move.
>=20
> Sorry, I was on vacation, and I am back now. Let me know if you need
> anything further.
>=20
> Thanks for fixing it,
> --breno

Breno and Herbert --

This patch seems to break things in linux-next. I'm testing with
linux-next20250108 in a VM in the Azure public cloud. The Mellanox mlx5
ethernet NIC in the VM is failing to get setup.

I bisected to commit e1d3422c95f0 ("rhashtable: Fix potential deadlock
by moving schedule_work outside lock"), then debugged why opening
the mlx5 NIC device is failing. The failure is in the XDP code in function
__xdp_reg_mem_model() where the call to rhashtable_insert_slow()
is returning -E2BIG. The problem does not occur when the commit
is reverted.

The function call stack is this:

dev_open()
__dev_open()
mlx5e_open()
mlx5e_open_locked()
mlx5e_open_channels()
mlx5e_open_channel()
mlx5e_open_queues()
mlx5e_open_rxq_rq()
mlx5e_open_rq()
mlx5e_alloc_rq()
xdp_rxq_info_reg_mem_model()
__xdp_reg_mem_model()
rhashtable_insert_slow()

I have not debugged further as I don't know anything about the
rhashtable code or the XDP code. The only repro I have is a VM
in Azure. I thought I'd ask you (Breno and Herbert) to review
the patch again and see if there's a path that could cause the
hash table to be incorrectly detected as full.

I've included the linux-hyperv mailing list and the mlx5 driver
maintainers on this email. Someone involved with Azure/Hyper-V
or the mlx5 driver may have seen the problem, and I want to try
to avoid duplicative debugging.

Let me know if there's something I can do to help debug further.

Thanks,

Michael Kelley

