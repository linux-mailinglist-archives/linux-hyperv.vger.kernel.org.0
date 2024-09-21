Return-Path: <linux-hyperv+bounces-3058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323797DB30
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C0D1F220C7
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2024 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F312904;
	Sat, 21 Sep 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EkdKrIAB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020128.outbound.protection.outlook.com [40.93.198.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFE1878;
	Sat, 21 Sep 2024 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726881797; cv=fail; b=XM4ErsJTHN3KOLzCwmD3t8gaNIb/a5gGV/Gi5Gv07OvnVBzY1NNMgKDM4UxpyAMl8TbLBoi6C6kJef7rAu1e2xeOYlkkCoTU/cEk1Znew845QidGNNss8PnA80Bq8LMk214Dlmg2DpWOj1LX0lN6ngd6W2z8fo+JuJ23sa4l8Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726881797; c=relaxed/simple;
	bh=2l0wZecVIdiWMbqV1kOcBLtJpsJNIIX8Kv/7FkImwVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxjTD13fRDYtF+HH2lkrMX2Dxd9ov3w7fnR66rtnIh9SHcLi5YXFFFbyOunPOwpwp+VI+OON/C2OHJAWslWrqiw6a1x7O+j3yBMoRMtUVqlKLMLLzj1LAx5hCErQgI6TW6Y2htljliU+uJUPd9uVdImvj7YSyANxhNgA2jL1vjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EkdKrIAB; arc=fail smtp.client-ip=40.93.198.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+5B4UR8Du9qTEzMxMTEQL0HXORibBfz1WPzIMFpp/qkKJIZo9RD84yI4TM/o0zPujMbHP8ni/yFw49rGJGzHNz3mKzxoKpHxDm0MxJE++6/zFTiYoiqToYll6kEBYSTDYuFA6g8GhzasuyVIa2IAYq4f3Pj/bAwjHLqu6Z3kmjUwd8C0JWCqQu0Fb3sw2W28bk2bGDnqtlkKCVf9I7SN2rqtqwXmbqmv6XfUpROZlXkvbbIz+TaiWPOkKYUK0JtECoAma9gKesqcj3dBQBjUGOABbjuLYfEbgyvu+uQ/vtJow5vP16549HexmsjBeLG20LqzR3Dq63SNRwDyQvGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/PqEy6hgbPVDO2hl9KHeGr5p9fS5DjGe+bIz94W25s=;
 b=r/EpTGTkVKrqNtwWfeMppzB4rlbLM2crmZ0dwR97bpK4cHkNqhTvAUMgwerSbptAi0FLpP43Jzorfr/IfGR/Ei7DBbqMVCSdG2ybdMS/Zdl9XGqCNWnjbCgSS4gnEf9iEE7jtcOmbv04gD36y1bxhkYSDf67CUKhYY6dl8TAu58bDu6wKF90tWRELdyWDIqUpD9575EA3vSI+qncpSGd1EOA1pEKqAFjKkXStNOYMINncesLXb2yBYH11vKYs8w8Mec4stwyYM5blyPU2PwIK4Z34CL6tSSXpQ4LGszRWV5WBPk3K8O+q4VrRKPIpJHEemH2Ty9jZYMJxox4RyPWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/PqEy6hgbPVDO2hl9KHeGr5p9fS5DjGe+bIz94W25s=;
 b=EkdKrIABFCRjVGjhdgVYyX7qhk1ZLM9i31klil97Le2UIukRGEUrgu7jZ8+5v9eNUoErJZLTuzp8zyrxzxuEMsMy/wWaJFZhmabEu8ehp+NKd2Me7oy9lJvRM8YUN47Vnr0C9/jf44yUR4pBL84JT3v9GXz4z+rLRV/cClrw7kU=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by IA1PR21MB3474.namprd21.prod.outlook.com (2603:10b6:208:3e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.6; Sat, 21 Sep
 2024 01:23:09 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%2]) with mapi id 15.20.8005.001; Sat, 21 Sep 2024
 01:23:09 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND
 DRIVERS" <linux-hyperv@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] tools: hv: Fix a complier warning in the fcopy uio daemon
Thread-Topic: [PATCH] tools: hv: Fix a complier warning in the fcopy uio
 daemon
Thread-Index: AQHbBa7gIEV5tinScU2GNNSWWBWHb7JhfQKA
Date: Sat, 21 Sep 2024 01:23:09 +0000
Message-ID:
 <SA1PR21MB13172712A02F3C9EEB156131BF6D2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240910004433.50254-1-decui@microsoft.com>
 <20240913073058.GA24840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240913073058.GA24840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cb713484-3b3e-45cf-931f-d02213ff3885;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-21T01:18:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|IA1PR21MB3474:EE_
x-ms-office365-filtering-correlation-id: 40f5facb-4498-4fd4-a55f-08dcd9dbf415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7ly+KI9qEMxDE9kuMjn4ym4CNUy0J1FexJCnEI/eKCWWtfvsvNjjOHes8YHh?=
 =?us-ascii?Q?7bWZXQA40VckbLnwlbujwuAmiaL2oOPj//2/7aF0pH+t4+de4CoW0pieNIe1?=
 =?us-ascii?Q?DPrGyNKv6V7+XHyGeDF+shk+0FuNbo5oyzYyC270Gg1tNIoAGEbFDbGQtgeL?=
 =?us-ascii?Q?Zt3PjK/6XCkgFI1u+T21lrxAjLIWrnwuqhcYL/NMtCLjtw9KsG7TjNZ4/fQu?=
 =?us-ascii?Q?mIZmFGlFTga2s0l/kiVBh/499jvf7fM8yR8LV4DRmejsw9WjysYlZyZN9uZr?=
 =?us-ascii?Q?OrVUCshCCJlyZreSVOipd06Pu1a7xf7KEgQu4OeRIEttELG2zdRjNZyB4HO8?=
 =?us-ascii?Q?Z+eD4znLCgXw70tduxjnowuXO94CyeeDVSxEp0umVEhUoxUFFnfKQHO9vk/D?=
 =?us-ascii?Q?P2CcEcb4IhkQTiDG2CzkB5croV1Kkz0jVMAYo/RwJ4Zs8IHuetnoHviwfqO0?=
 =?us-ascii?Q?eC13t6yK4h1rAmcrNMFwAaQauFY+gGouK3w3UF42hK5SZUhGEarhBf4r+8+Q?=
 =?us-ascii?Q?gGnIwzgwO3b2QK4N6LiamS8ETfwG3B1n5MIXJfxZK5s279/H0FFb+KdXqR1R?=
 =?us-ascii?Q?zfDO4Jvw7YnfFDCzupOMLb6TLnvbf3yGQ7bQ+IP7bQeQFuP2K0vHE7oYk1l8?=
 =?us-ascii?Q?agTsnXYYn2M54/VR5Q2mJw17vrMrPTMUo7y0aTTkTmqq34p/Id42hmc6AMJB?=
 =?us-ascii?Q?uK3sUPvd61i7R8jdfNcFx5W+MDhFGAKhFZxWiCJdJBcgTJaKDBMm4k1Ajgvh?=
 =?us-ascii?Q?n9PAawOBh4jFuP2+rv8LkWRbhAcexLDrMT8Q7JlzmYiHPKqkltzqEtm9C1s8?=
 =?us-ascii?Q?SpcvQYvJGwdaPk2+uUHos+oTPBdINnHQyJGGk15sG0n64Oc5nI9McqQVfWxW?=
 =?us-ascii?Q?6hHzr+bPELVIccWiGzfXiPliuXGR77ENwa0Uhj4egt1jknVWmS8NpSnMn24B?=
 =?us-ascii?Q?iugRKP8FFdRaYLkLMpOIw4+9pPtGgnlSFrGiP6gP9fe3PI/Ni75iKQHk6kbp?=
 =?us-ascii?Q?XMeZQ7dOhfskCbP9CiWZANLECI7PW2omZqQm/DmbOJbkdBtrKAwtN6fvT9oS?=
 =?us-ascii?Q?HcBoLXlir8/SnHsgMbxkrpx1TMVeFSC/Z67/t6yBSNVPRHhqR5X/eakh2VIC?=
 =?us-ascii?Q?fFNMsXEyfIo3segH0Yyy32v6QNh0Gn5MkR03BaYvNoUfIQPnBdv4KAp+0kxq?=
 =?us-ascii?Q?ZU9qYTs/ruyW3XPBp0zrLbIhgI5en0iLnKcRrHk8IlM9Ixlffxan7t2IXFgY?=
 =?us-ascii?Q?RwAWlwRznUapKJ8EBOg9f68ZFG+CLI75Cz7f8U4tcODAqlKSM8qBtPyZVoct?=
 =?us-ascii?Q?pJFjFar8tx+TvNVcwIKdY+Af6lteYR2qzb9vb4NoHGxlag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AREWmI53akUzuUmAuRqqz7tVbCHDsNZZ8dVXY9+BALp5uD7r8vFhntj5becK?=
 =?us-ascii?Q?/3ggy6IshNk2nmM+dX+itNQPdajZDuOTR74yNi9IuKtRDEYfOSZzIKSpWhF3?=
 =?us-ascii?Q?S9irKFLRzCOgfgHQ7aYJOIqSUOMhb5Ow9NeItfMovhAA5W2McwLr9tnpUz5z?=
 =?us-ascii?Q?6x99KvyEoNKRk/X27SZaTxUS+vb+Bc4xXE70+wWPI00K+68YsZH6A5aSR9sf?=
 =?us-ascii?Q?b6Ly4fjeBnjVUwT9gr2jbYkIQrsvKS9jCcvQqabUMZftvVKA+kLVGKxw6Vhj?=
 =?us-ascii?Q?gf4v7sg6amfdQIkOor044UNb8x4uYeM10J9TBF9IZEz9HRIFZq0QE9rmOtmk?=
 =?us-ascii?Q?eMyx6/MFPJtdhicsORcE5nFUSsBx6xflh4pyUFYk0UR/BXOV6I5mb4Ai5arX?=
 =?us-ascii?Q?RKayIUDCr5jxpzl6chjoSmg5Vg8m/UheW3aJTTNCY6GG95A3DaXChIrQoOB/?=
 =?us-ascii?Q?SSzuTgHHWAtPqv4CELDPXKM7P4EN0r5u6DxTtNqSi3T2SAiFzw1epysXBdqK?=
 =?us-ascii?Q?e5jGyhSe16J2p5pVmbxrjqs0sWYtfMe3D+OsDgQ29QNQCHkbzFHime7ebqVj?=
 =?us-ascii?Q?GopbL/UBMd54XvlRRhVUgIl6e7wuHTreYIwCN3A8Q4PVhqv3Wjw8VjaWnssm?=
 =?us-ascii?Q?KeiLinoEjfd8/jNP0JVeLoHgNT1p1qxckLhzOFOpCl9eXN07HPn1/zDIneCF?=
 =?us-ascii?Q?bFvey/05214GYKe3DPW+lClxu4XQ7E9pBhrT8R8F3bFTQHy3hD90vWa5mwIN?=
 =?us-ascii?Q?KhWx6VfBsKGvgJHKOaMslyQajAcKyJ+mDz/9RJjmEVlx9CaLBWJcMxkbVyny?=
 =?us-ascii?Q?tisDgXgnkveZ51Gah07R+SmvPV2k62aeYH7eeGHrFMxsPH+XqyE0/NgYbPaP?=
 =?us-ascii?Q?LBiDTf272hXic/mZ8j9qcSJvQkVhLwxjtPDwipkvCd0FX09J9LhlMFJSl0d4?=
 =?us-ascii?Q?y4dWYiwpvWNrbuS0kBc/q0gFWQvu9GoKXuy70EYur1G4rEMMYpOCrNqha4R4?=
 =?us-ascii?Q?driWPrkVt1AsLLJ3RVOrb6ZqDAXtS1p9fCCO9leRjPa9u7Bc1CHtlt36+DZ1?=
 =?us-ascii?Q?6Etm3Aagct3IeIFX9oVYZmgu7+9BkxxB3nuO4vtQKR+XhCZNKOFZW1lWKpjV?=
 =?us-ascii?Q?Cb8ya8EMoXtYT2/38zILZttTsgNjelfgbI8ETJWepjx4lWdxg9Bi3E4PRIvz?=
 =?us-ascii?Q?YkGO7KCrdN6WAb1o/VeUztPm9VFUyN0KOze5ycqd5YS97LKsZzoU5Ywf/ZXP?=
 =?us-ascii?Q?nEPq22YPwTu95OC1bTWX4ZOr1z5eDgB7VCDZnpMfsK+PZEB2InpD02agl3zq?=
 =?us-ascii?Q?7xHtl/Bdx6EoVGG6Z93WQc3w0Ere11+5mtsXJ2uDmxxxT7wcEw2+Z+uTlNwO?=
 =?us-ascii?Q?uFFJBVgH+jii0HhlxfX6vP0KuPRKqaLZ8jiPRZz1mEZL3i6vUA4G5FFMJ/Bc?=
 =?us-ascii?Q?D9cPQjX4Tnf+39bycvwr05Ejgb64f0/05wS0NKeeA8x7J0sn2Ykce8WQk5dA?=
 =?us-ascii?Q?N224Jy1QV4HaJlm6tedBD+mVyFr7462U0PMzJlllCVEIdAQyDQyCs4Ng/CQh?=
 =?us-ascii?Q?i9uzHsUighZYuolQ/NaibpahfOaG3hJMJb8cniPPHMQqgZYtjEf/mQyj9pDz?=
 =?us-ascii?Q?GXwLBzedVeAjp2L+yA2inGOYIMWTDV0Jc/XCn2cZIfqO?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f5facb-4498-4fd4-a55f-08dcd9dbf415
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2024 01:23:09.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/NshAvl2aRsCJjvEHX10jGXzyOzC/u95xxKsuF8QmfRp6UcqLGyrNjtkgCCUasWR20YatzstrWLPVAKDXhLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3474

> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Friday, September 13, 2024 12:31 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Long Li
> <longli@microsoft.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; open list:Hyper-V/Azure CORE AND DRIVERS
> <linux-hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
> stable@vger.kernel.org
> Subject: Re: [PATCH] tools: hv: Fix a complier warning in the fcopy uio
> daemon
>=20
> On Tue, Sep 10, 2024 at 12:44:32AM +0000, Dexuan Cui wrote:
> > hv_fcopy_uio_daemon.c:436:53: warning: '%s' directive output may be
> truncated
> > writing up to 14 bytes into a region of size 10 [-Wformat-truncation=3D=
]
> >   436 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s",
> uio_name);
>=20
> Makefile today doesn't have -Wformat-truncation flag enabled, I tried to =
add
> -Wformat-truncation=3D2 but I don't see any error in this file.
>=20
> Do you mind sharing more details how you get this error ?
>=20
> - Saurabh

This repros in a Ubuntu 20.04 VM:

root@decui-u2004-2024-0920:~/linux/tools/hv# cat /etc/os-release
NAME=3D"Ubuntu"
VERSION=3D"20.04.6 LTS (Focal Fossa)"
...

root@decui-u2004-2024-0920:~/linux/tools/hv# gcc --version
gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

root@decui-u2004-2024-0920:~/linux/tools/hv# make clean; make
...
make -f /root/linux/tools/build/Makefile.build dir=3D. obj=3Dhv_fcopy_uio_d=
aemon
make[1]: Entering directory '/root/linux/tools/hv'
  CC      hv_fcopy_uio_daemon.o
hv_fcopy_uio_daemon.c: In function 'main':
hv_fcopy_uio_daemon.c:443:53: warning: '%s' directive output may be truncat=
ed writing up to 14 bytes into a region of size 10 [-Wformat-truncation=3D]
  443 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
      |                                                     ^~   ~~~~~~~~
In file included from /usr/include/stdio.h:867,
                 from hv_fcopy_uio_daemon.c:20:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:67:10: note: '__builtin___snpri=
ntf_chk' output between 6 and 20 bytes into a destination of size 15
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - =
1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      vmbus_bufring.o
  LD      hv_fcopy_uio_daemon-in.o
make[1]: Leaving directory '/root/linux/tools/hv'
  LINK    hv_fcopy_uio_daemon

