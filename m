Return-Path: <linux-hyperv+bounces-3760-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90589A19E49
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4EC161C88
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152051C3BE0;
	Thu, 23 Jan 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V/w7kUar"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022112.outbound.protection.outlook.com [40.93.200.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655641C2DC8;
	Thu, 23 Jan 2025 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611849; cv=fail; b=WCmhEXkHa06uLU9WV4pRH3z/iwTf1x/9rJYo+tMuK7d6cIRs4PGIhtKBA7q9FrcmzVyVG4/vhFmIjiitFwX1KVGN/O0DkLXEXGfWlfUsfLcXARz9rQoVsGENYC2B9bmFSrvrJz4CtPdJwIVl66B1QmZTCH3tW1zSd9IyTvF0nNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611849; c=relaxed/simple;
	bh=90dLovg0RfOvnmP9kgC+thbZI9Wt778NErlOdjKkxKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DzGYssemYYAD3juN7XKWEZ4vQnWWH8dEc4Y77CnH1oTM4ffk7HJxTGjXQVJHKPuy05zV8Anb7iyeqXRRxCDxTQQXvIySJ96EqjjdHSTSFRs9lgp+pm8OrFlLj17tMu/2shIpl5e22equZBc4iIjNPNdvcc3sHxPtmlm3z/urvP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V/w7kUar; arc=fail smtp.client-ip=40.93.200.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYB27ZN/1YNMp62q01MTayGG2f1wM9WLiNo7hw09slrhihwb5V/lI0Kf0jX900EGlPx/ZgbyWGz23SAf0urN80+EIU/eBEyGDtud8r21iIMRhLPGlgzEE6wWQxbiqSL6KMTUz1JIaJvYwBLo3uU3FjN8ZSgtzamFeYD4BjwypPrwN9hk+A5TcPoBcC+WBIysOZGKXrKEfKQvesCBKpnBAer/RN9+nLK2PO/LnD0aHy3hs7FYbvVyNI+L9ijGgiQkl/x5Ifsinv5ToDqswWJaanDM+ybqfX2JyqrABp+AfQkPvUVQX5k7gL8zVG41RuBW2Hxy0i4EUbK0GOTGP9lNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+lKhFjBSlAHu2ynHiBd1MAUHaXW6GCCM34OcUN7qK8=;
 b=zPMtGlgBCjUURVFJ0lZ7StrhITAVnVJvfryO4vA/GHJSOAIL7VuPvcg8BqcwZUKJQd3UtLULXfvN6SqRADzIQoKaPrfo+KyWqdFrDpTemG/hCuM05FTRcvvdy7ZAdccwFh/TzS0yuq5KGgJNNWaq4PlMWkOmP4hNa/B4bcm/SuqxeCrA0iLSDoaVgNG3nJI011r+khTYaT4JFFbZ9OSNaiC3NXEUcL3Gn5qJgew8tOYGwKmnHVXU09oqvvw6gnZ6/pnxIP83ieIbFji0W2xKll6i+igkp8POHzY2wIEuaF2JDnQEgxLtDba8ZxZWhXsUm9l5Z+vYrcXZfeLXTjxEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+lKhFjBSlAHu2ynHiBd1MAUHaXW6GCCM34OcUN7qK8=;
 b=V/w7kUarxXJ1eeJJPZzurUCWke+PBLQKWtv+/Lc1x5vkJrVE+8blx0QW9eu24SWvk8e0VLiyeshuR3T+lZrgn60V0iJFCzZJDplEw/BPSdDCmse9tNCtEfSoDVIUln5B5hqFF/7+UMhsNpnCieatdoTfl4PKCC5ogLh3YM5xQtY=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4462.namprd21.prod.outlook.com (2603:10b6:806:427::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 05:57:24 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:57:23 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 10/13] RDMA/mana_ib: implement req_notify_cq
Thread-Topic: [PATCH rdma-next 10/13] RDMA/mana_ib: implement req_notify_cq
Thread-Index: AQHba2CWNdPd4FuRy0GFruIq872sjrMj4H5Q
Date: Thu, 23 Jan 2025 05:57:23 +0000
Message-ID:
 <SA6PR21MB423171435D6B100C175B876FCEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-11-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To:
 <1737394039-28772-11-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe41a8b0-d202-4919-8315-ce12edfc3807;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:57:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4462:EE_
x-ms-office365-filtering-correlation-id: b450070b-26f2-4998-c84d-08dd3b72ce79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PAQd2abtmcHK3n/psy5M2qDSAGitY3zCV+Odey4rUBPOI/w/3K839mKTySVY?=
 =?us-ascii?Q?LZ5SgmkKLWeMoYVNmmnkD294dbLhic8N5l7t7jjzVRXUtIm7agTeKa5GR4a4?=
 =?us-ascii?Q?Wqb/U3tJZRwjbHXt/h+L2hZ2psmLiZqyaMPIsl0XKyYG8zXCqKC7mloaJQPy?=
 =?us-ascii?Q?H0X8+/zEAVJPxQ0a4NZmOcmBj09UlFqAK8Ehhp1D8FneVa9xNBipI8XsoFDh?=
 =?us-ascii?Q?kYPvzmkHIpiTrJsz6OZpS/77qq594UcNt+/EtyCCsAoMCUjdH1MGYSLUMxNR?=
 =?us-ascii?Q?ByoZS2wTgzzsfeUzztBLTWkxIcQ/lp9nn9tgguzF3VLLDZcruD7+4qQQwkMU?=
 =?us-ascii?Q?Zj6utdnvuNYRqH+svXGmU7ydxeiRRQlDWO/vAJA4G2oOEvO+6RupHYBEy1zg?=
 =?us-ascii?Q?E1zCaa5SQkAoZE5ok3ej8UzIn6xFMc97gDCzcYz0zL7CoCyJKtWwLVk2NoP4?=
 =?us-ascii?Q?nGo1VbIm6qS7zFJmZ/LiYovxWkYSVEQwQtB5uYXYDi3lOWt5A8bLV1j/7c8Q?=
 =?us-ascii?Q?JP8nQ4FkNE/KL+N0ITJrM2aRG6D21eN5aTNMFTkfcZQDmh18sq8UfVIfcQnk?=
 =?us-ascii?Q?re3qfvpxSH2wPQQJktV3lSKSnlXuw1s5vbRAgBIm76KPZXyj2sES0mL81kSE?=
 =?us-ascii?Q?Bxx6LnsQqgQM0WvZ2Vp+cABvGRCF/sZWCbvgCSIV+o9ysHUO1diBy29uF4cy?=
 =?us-ascii?Q?HtNDaGXbJiV/POQnqolnrtSHsRn0u0jDyY0PzV6mxFVBpw0Ezn/ZAw+Wr+ih?=
 =?us-ascii?Q?2DNeaNrckK+Z/YQgBZOH6SxPL9TfXX4cCFF7G27P9OqsiJxlEcp8kEbI9lZL?=
 =?us-ascii?Q?Oi34CJ64i7gVo8Rs0SVBw0lzgI6c4JwbuE6fsGW97Z3QlWhO5hxK5U2TcE56?=
 =?us-ascii?Q?U6NoxKEeptvjD4TsAJcL4fPCxg1ZRbau2IpGQ+tWdhKVh1bJ6/k6pgca5ugv?=
 =?us-ascii?Q?xWIzfGcZBlGVGiRS4JKrs1u0Xd5FUvC071QO5ew8xc9f7kLOBNe2RrjM2U4q?=
 =?us-ascii?Q?wzbJKI6Q5J3cfiAqt7gjkfxCYQ7ixogX15qWTM/vRguhIMJdVIgnVhBsWZPZ?=
 =?us-ascii?Q?Om5kWINTHNcJz1dNNJOm3md9qucfU7t7+S+30uf/olYqtwRJDKNBZ4pwjqHG?=
 =?us-ascii?Q?Xm2ubK0LjRDrGVzwC0ohKDAfHEbWWO4AiDJcPGGl7Wt9OcQeiPwDGXnBS7ud?=
 =?us-ascii?Q?eBUQ5kPD/ixvNiheFQzaoiolVm84D0dzEYk8Xm23cB4+yqwsV4vNBCyo6B60?=
 =?us-ascii?Q?nwpVuNms6kD/I+XGPFT11lKHFAhgikH+qFyuR9iL5cA2fdDYjUfJDHkYYBpt?=
 =?us-ascii?Q?JifVkpbdu5AxQaQ/7a8uEaKSsg9N/0J8cqtkp6U+1eIm6/ixO2XLtI4EJ02A?=
 =?us-ascii?Q?lXiUqe6RgvS9yG8jBTloIiFbk/Z211V/Mid4dyUssa9TV5NxcI5m5XuLtlyH?=
 =?us-ascii?Q?lc+CO0WzclV0B6EEdz9+DTw0hWh6EjgN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kh85Xm2nOJWWasrhWPbYF7Uk5LypSWMqRf42d3z9JDRoXdzEiJvyq+L1KyNn?=
 =?us-ascii?Q?t6luSYuK+oLrhtKWWkr66u8xSKoaUOBJsvU+yncyszWl6x2BGlajLJNczhqy?=
 =?us-ascii?Q?fbzoaWfOPS/JetxQuvvKOxzH9cSXi4rtjVGGfLhlyjdb1szpugPk2E8IRHmr?=
 =?us-ascii?Q?DTl0NxM9nYCA0IxHlXrtxHgOoavMss/4M6qnDIwSk9sM3g1u90bc6cnQba2I?=
 =?us-ascii?Q?vr7LHpWLWe1e6FIbE+W15nPD5lp9UHClSL2YhtvFtULnRVtAea1AQChR/7TW?=
 =?us-ascii?Q?iRywnW4InwYAtEQCEARQ916OIKQuzbNkVB2sY1BoWxYpXa6EOq2/MYTKcF+a?=
 =?us-ascii?Q?ACogtqvMSdeCUwQsFJu2RMXshVAW8VGgdAbbl6Ul3/Mzwg7RyrNhQ1qWQzMJ?=
 =?us-ascii?Q?hrh07MHrfiOZXhxuII0Oc9eb8NBwacqrOYQoYy56pCpDjQt8eiYyP3k5ELMP?=
 =?us-ascii?Q?q16dlCndWDrBdgFLBc70DwzxSoI72ApPPX2LpB/PSNVq3rfPxmOa+bohWV6m?=
 =?us-ascii?Q?3fWbUamQ1dYZ4bhg2KleqibyWokYj+HtbBjOCWDXYMXjl4t25kY1W4n6y/nf?=
 =?us-ascii?Q?C9w6rmvnkDkDqcey2UxGH5fKi++mIANqhWJM7+dQyGekuR6/OgPiZm1+kiuM?=
 =?us-ascii?Q?JgM8ED9/TrNxVgnxowJJY+R2W2LRpEWMN+esXSKsrCwdiDyIJFgz0mMwCQCU?=
 =?us-ascii?Q?x2GUxRKdRk2K5iixeDBm1hA5GnJzAD+QTxzkEss4U6Kdy8mFLCOhx7gnBk0r?=
 =?us-ascii?Q?QyK1aNrmFHbwxvmjgUOg8SkQ7PY21ZmrDvEX6sUsa7RynpVksQb2IvmM1/QX?=
 =?us-ascii?Q?Som3a4P/okILhf6V2Zt98ggG9imGWNEuxn2BAGehYUS5qdEkrK4Sqp30WXY8?=
 =?us-ascii?Q?U6x4COVPiEQIg0+dFyzDVmVzzfDCCUU+W4ZfuiSvPevON+74GBsFhLuAWKaB?=
 =?us-ascii?Q?vd6Iu+mMVzLgSt4y55DIljnl/Yw01Oa+2Gx6t1N9xigZepODCixvnp3r8CDD?=
 =?us-ascii?Q?nLqCoxphomsr9f9XJwX6/X/5i0s4pg2Wr99Wv/TiS63RcTF2OYXDEx3HFkn5?=
 =?us-ascii?Q?nj2MLMOiIeL3BhSpy6ivmCfuPrWnApi+gvjZBqCHkvFljAHEieeIc7BpoFoX?=
 =?us-ascii?Q?zK4OjpGOR1AKPhFDxkdj8O5N90vDwjZay7U8BSYtceBXoJch1Z1vKDp+A/ML?=
 =?us-ascii?Q?9PD2JEjpW/JnOyEcDKTeT0lMFs3f8/d1cZ8oJfcnwY/OM1PohPwompuOkL6g?=
 =?us-ascii?Q?R3AN0dNKzMDSUYg3y0FbBoD+xelheMzIaceu8O68YyCODyXaw3gOUt5/rlU9?=
 =?us-ascii?Q?L0luGVwmhgicIfYRQyIihXhoY13UeCavbcTudWvSwX9zqG8w62dN45Rd96h3?=
 =?us-ascii?Q?661tiPdP9bduzKyTzrW1MUPQEKLdQR8q6zmFhqIpPHqY1dp7ooBoInE9S6RI?=
 =?us-ascii?Q?ykdalaa32reGr9IGvHZtZXMkbf2I3Tjbkw52jvKuHJ3C/QQSDVheeWf5u+8b?=
 =?us-ascii?Q?zMCm+FSiSz0gJXQ3F5r7l11Z8HgEvzQHR5AAiYHmY+6C1M3W7PmHFXaTvO/o?=
 =?us-ascii?Q?rvfnZTawL5LVqR2vsm/twl1x5/PCGhKTLSF1MCie?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b450070b-26f2-4998-c84d-08dd3b72ce79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:57:23.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdeJncfFxzCCYA/l8BVcIRZBBaPYPUR5i/QYqUSNOo6qsF/gC497QB/yKTunXIPt5TcQ7sn0FikSRkMfS4g+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4462

> Subject: [PATCH rdma-next 10/13] RDMA/mana_ib: implement req_notify_cq
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Arm a CQ when req_notify_cq is called.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c                 | 12 ++++++++++++
>  drivers/infiniband/hw/mana/device.c             |  1 +
>  drivers/infiniband/hw/mana/mana_ib.h            |  2 ++
>  drivers/net/ethernet/microsoft/mana/gdma_main.c |  1 +
>  4 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index d26d82d..82f1462 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -168,3 +168,15 @@ void mana_ib_remove_cq_cb(struct mana_ib_dev
> *mdev, struct mana_ib_cq *cq)
>  	kfree(gc->cq_table[cq->queue.id]);
>  	gc->cq_table[cq->queue.id] =3D NULL;
>  }
> +
> +int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags) {
> +	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct gdma_queue *gdma_cq =3D cq->queue.kmem;
> +
> +	if (!gdma_cq)
> +		return -EINVAL;
> +
> +	mana_gd_ring_cq(gdma_cq, SET_ARM_BIT);
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 1da86c3..63e12c3 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -47,6 +47,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.query_pkey =3D mana_ib_query_pkey,
>  	.query_port =3D mana_ib_query_port,
>  	.reg_user_mr =3D mana_ib_reg_user_mr,
> +	.req_notify_cq =3D mana_ib_arm_cq,
>=20
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq), diff --git
> a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 6265c39..bd34ad6 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -595,4 +595,6 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struc=
t
> ib_recv_wr *wr,
>  		      const struct ib_recv_wr **bad_wr);  int
> mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>  		      const struct ib_send_wr **bad_wr);
> +
> +int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
>  #endif
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 409e4e8..823f7e7 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -344,6 +344,7 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8
> arm_bit)
>  	mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, cq->type, cq->id,
>  			      head, arm_bit);
>  }
> +EXPORT_SYMBOL_NS(mana_gd_ring_cq, NET_MANA);
>=20
>  static void mana_gd_process_eqe(struct gdma_queue *eq)  {
> --
> 2.43.0


