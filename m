Return-Path: <linux-hyperv+bounces-4501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90DA6134F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9863BC8A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A411F4620;
	Fri, 14 Mar 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIk5j+Tk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF31BC3C;
	Fri, 14 Mar 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961098; cv=fail; b=gHM/+ycPqeeBRuCazTg7ClOV2rZkb6zS30Dc97I53GkI5jY3BOYRPEF7kT1Bab0GSPMdLbvNMhMkXjkEMFkX4SRy9hqkFhnR4gOGD6ApvtHM8yxKSWAneSqDJSpZLasE0KaRrZ7ffCYyp4Cg0oSfKQgf9/kJqAOwfrqs15ip9gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961098; c=relaxed/simple;
	bh=+tVYU/ZhuIWAC16XYDaIm0CeBAtukws8OrwWID8aJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Krf9lbohwU6NYdW5nDI1JbXPXsQELyKoGcAq5dBRIrQWg/vZxG0iaMnqn3eyl4Vg82I7mZrTmsELn+1e58/SIOCC/9ffhVQKht7ntjbHzI5S7REOyuDLqIS1ANUGzK6HqvSBz08vSKId9ZyRdClWV6HhiIaQBuwXzch+b4u4VOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FIk5j+Tk; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxjYKV6JoJY7Dz+4/IDlpgx/PN+igEadWPVQmbD5K+TRKxV//2Kr3FUD+mvYnKON9fB8S1ffjY0Ap+fqniluKBD6v37phf7T1Q+tdibGhX6Y09+u34Ci9aaCD8l1YoCInXN7yC2rXINMbBIUYJe+DcE0RZeRpX8EoWW6JKF7oKwMw/ZYbGyGyMgPJx5mayELSQL7y0/mZ6GKMohMgosPcu77LgOBgshoKh1T5kFepkFovt+Y4LcCKEB+k2u7JjQy3lVnq3a5WwWJmzWtA5c3aAaigHCk0S9rVbaxesG4itKXt/m9Jku4tGKbbnpytd/NJ+wNyl5j4iwPP7ZTN8zEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnnIe/RIVaYUO9HO+OUrmydE3S8jZSKu25ZzaiyDgh8=;
 b=BdZMSuPZEW+hnEZEciG5PEhRk7H3Lrcgt9LnQiy8qJs9KrXctvBrAgjGX7OGLtTY7EFKJ56RqdO3yBRgz4r0PczkVYayUl9MV8RPR+LNIVRW8U8HK8mZtSQVO7XYf9qOwjb+v1Z5eSRVwXWZbSjuHMw8VML8u8PRIwVc5m9dQTONVXAjQpv8SV509oFBcDpffozrJQN2lBRGUa932nURlX9/dTotb02aNoEF331iIwK15vFN9pLqDVzi/wPRSjT0Dj/HUz0GOmBbDTlU3ha4IALCf8JjdbgJKln4Nwbe+/gjmeP82CxHgzPNtyUwADWEZGp9B1bwFh10Xfmo470NYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnnIe/RIVaYUO9HO+OUrmydE3S8jZSKu25ZzaiyDgh8=;
 b=FIk5j+Tknd0GV02V/KATEljRWCYBC+agMm8H70syds/CuYVPVvqmNPzF0IAYZlOTpDDZu6ExxDBJfLVduHEDvwt/0WMQgkpPRUe4bV4/gsT5YjRepgpAkQPAqndTnrGKqQuDdF9OeJTuGt4H3WABtFYgVgcupbfQ0nxdS/IxV1v7JIaQrHUBlm9VmsKZu25qgc3SGC5VKlcUF41g3SeKc/qU8v3ALeGz5GjTtFRVy8S8N0z1rH/6wqrVdRoJqG4rQpbqrEXBWAt9SgTXOOPxZXSgoprGo6YuEDpUWPvx+seQIU/MNegmL2Vk0E+miBq3Eaz0JDOiAT5dDiAmsG1VGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 14:04:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:04:52 +0000
Date: Fri, 14 Mar 2025 10:04:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 01/10] cleanup: Provide retain_ptr()
Message-ID: <Z9Q3eCjNfD0WQ4H5@lizhi-Precision-Tower-5810>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.442025758@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313130321.442025758@linutronix.de>
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 029cea2b-20e2-4213-da78-08dd6301311d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r37T0ns4tP1XLVaJBwYiQc9yna1oAMeKXPRM3LfSNQHXsvdHxA11TVG4YWXY?=
 =?us-ascii?Q?EI1SfvGP4UM1a0j9+LzqdchS2jh4SHFjfEQ6gn/UFS8nNxwM5ARuBjmXzFkJ?=
 =?us-ascii?Q?BbLiM/SUBw+Hy4Bh8kNDO1yckNhDQMkXWX0MglEGivRlrCBrVLggyXLnEO2u?=
 =?us-ascii?Q?fboPIbzmTz87ukxrTTnbHlNNCfWq2EwFjIT55wxoiQ8Th2XaRz8bBUmKu0dW?=
 =?us-ascii?Q?9lH+W1FfLtnI53pVIPYGFrrmCNyfUZvmsTk3U78inyWTMh6cfPgI3LWQn/vX?=
 =?us-ascii?Q?tvv/dUdlJQ8TYQU6Xa0v5JxwpR0tu6lfJvj1GrcY43TpRiXJBtYto0o++9tq?=
 =?us-ascii?Q?oem8UE4FbSDsriTZjLCIBuynWJTSHWmjjuG5/gW1ABrD3IbXKAA+UkIbC0fe?=
 =?us-ascii?Q?FHZ+p8E2NABayoFuJS+ogJw3WSzq3HLvfGPVefiH2kerv2rv0YqGdL+B6L1t?=
 =?us-ascii?Q?ZF5nhLz3/5z/ytbdKoq41OCBxQwXBBDlHMvjVzkcz9YnIm4ztjxNttIPoCEP?=
 =?us-ascii?Q?EPj3C+MzJJHHD8t9qOH/nXkBvqwIGAbP7FKblebBUY1+Kqm7/CKjAGsi6GMW?=
 =?us-ascii?Q?cc/Aut9MyNcCdwW05wbR4IYT8kiTknFsM4BwJNJCMkGGrBaix7dec1ds8ucg?=
 =?us-ascii?Q?l9ItfTfXymdBtpNz+IYtPOLVOHIsZ9wYKEdGpivzjwiQBnVU3lk4OqfAmXDt?=
 =?us-ascii?Q?YtVqtKzFOEtKszG2ZUlp8hSO2vgHyg2mi2DGNXB9nX2rS32OXKSztvIcohZZ?=
 =?us-ascii?Q?489aCDNSLTkNg1yLQ826kAXm+HJ+9rpa/N9FAs9tYIfOfIZLxbR8USMgX0uh?=
 =?us-ascii?Q?dY3iMcfigs0chLTfm1b5jBXXItkeaKXr7oWgmvvqOfqB9++DnGfqteHi2Zb1?=
 =?us-ascii?Q?O2iF7KWpeb7TRqLKz6iZmaNra364tM57m2JKKjsVpYyEvfEj9yKD0aYkBQcs?=
 =?us-ascii?Q?9qrgAfUnMadi6XbUHqdLJETPthUikdqAQj0kDtArzmW8iXjCXOzNlod0oZhj?=
 =?us-ascii?Q?9vn4AQr12hFOnF9bT7hhGhVQe2lO71SaPUvqSdr7LivGk3t+FPH3YInSUTtE?=
 =?us-ascii?Q?8CSIwp0RzMGHwfhkU2w4EIym+a8DflqwhNAwwHymJjC/vc6Qn7+s89iHuDSf?=
 =?us-ascii?Q?axCKh8YS2WpJy+jUxJ74GY6W7bmif+UhxX1vmJrPNrXGo8jAXfPRGsl2kzmQ?=
 =?us-ascii?Q?U+AzPaU6hnU/tYY3r3zyHXw7fDzao8okUuZc2p9rElpQ9gKZ8v920bi51zFH?=
 =?us-ascii?Q?K4Z7c7Ra854L+G4sOgyn8FBmyLn3/CHdbZT9ddQiSX2Zx/HPRpEa1WF+IjqO?=
 =?us-ascii?Q?1y8EK7ErjAuquPp9Z+qU8UG3+JqUKnGDYNxu6UkSMjjVJweH6ly0hSDErn8l?=
 =?us-ascii?Q?cf45nSXbHg85vFjTkeUq41kDI9feGb23BZJ6nEU7y31pgbLed9CLVhQMd6/O?=
 =?us-ascii?Q?RQ9FwkitwNHAmOu7EMkuISFWNYrq5kgt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7Tx05hQ72YIAbbTj8Gu5NBKF7TmGtw4UnTSCmfYfeZgWCoCqqhlxX1wSCIu?=
 =?us-ascii?Q?H8L1y7vKkN1I2zRmFXRXn3oC4av7bM+Uw+c/Fud9R6lKjy5JyWdNvGBuuaVa?=
 =?us-ascii?Q?1LjGygvftah2qOiUn7HlQ86A3L4q9wIVHRSiWcz4rk7u/h72ewx3peuy4AnW?=
 =?us-ascii?Q?feb3QscNXPD2HpsaHxnRekHFmoBKCIY1qjJWcd48NFbM7iZFxTAtgpN3NODz?=
 =?us-ascii?Q?Mn1nZ7ZwbykhX15Hs6FTUtJlxnfX5nm053Pi9IJJN9c94LTDKXjmTFQ+r+pz?=
 =?us-ascii?Q?o6rVaEZ7TcpUosy4QrABOWE/vSuWtClcQPvjdKoGsi04lWv0U9+NWmL464Vy?=
 =?us-ascii?Q?aJtPNGysEGVdzHuQq00Pz1UcIXOhsztX6aReZvMYpEl/d/NsMvulZ68wJkLn?=
 =?us-ascii?Q?cguEMGk90QcSpYf095LpEsdbJz5vq+GzSS5t7PFfQtAEMmpjL/NnD+c7BtkZ?=
 =?us-ascii?Q?c8NwTcdYLIeQ4pAhy8NwyurOSYAih+4rJIhGafZEKBTulIBTSFlZ7MJs7kfO?=
 =?us-ascii?Q?q5atn7WAA8L+LlKq3BknUZmaacCG6t6dENhP5lWh85TIKvv6a3Fd3ygUqIS5?=
 =?us-ascii?Q?IMi0IQZMAZ9fLffrw0Xz3zaEeThhOjydMM0fv3v0PgbSjsSikTSCkbgRD8WA?=
 =?us-ascii?Q?XSHL+pbX2OrKGOUDvZmKtm07Nc0KoL13lMgOrKXwjplB1aOPpmXO1eeeA/ep?=
 =?us-ascii?Q?1gou/lyXcBa+yc8HPgeWt3NlCAGNua1gDfB9UikQICxkcjuVqNK1aT/5R0Po?=
 =?us-ascii?Q?L+i9i0v8qxzWZ9J7mfiWWIK7aRq8wt1ljZb8CTcNYaHYYe1h/hfgRbJHp6ND?=
 =?us-ascii?Q?7iKJOs7L+INT/d2Og3h/FJeDcEtashbZl6uvU2wrawBw/aglx1p6evBuM5i6?=
 =?us-ascii?Q?bCROH+sTjt5+AzYLDWvstcn8Oti5Qf7kksZU/OjiNuEdqUR3SUsOPSfWSMST?=
 =?us-ascii?Q?tqgmhZmtiBqKx5uulM/LYlOfvMJVYrN2krCi4YmyBbguT32AECvDezt4dmTZ?=
 =?us-ascii?Q?Wzrl4YjGw8ov7uKeHNt1MmG2+VH0FFQS/MOfM2t4FiS/6ZdgbvZeFCkKzCJv?=
 =?us-ascii?Q?hDIYroIEAZMo+zvoK8eP7VqAdQafUWZGPNQO2x5dyDpWITCLtACHc/RcxXNL?=
 =?us-ascii?Q?8/BeH/XKRQqexW3Tog0Lop/y9jUjC/qDCTgAf31VuyKArMz84vd+BNHBQflr?=
 =?us-ascii?Q?eWRHfYexK1PXKrqDz3K4AHquKeMhKn7RTb6o8buEbWEbePkaCWZDsjAX49pc?=
 =?us-ascii?Q?n1Tz+pcqkPbVjwU+0ev9a0enGbMl+8MUwermnQsAc4Pf08eePjX2sHbPzZwm?=
 =?us-ascii?Q?gptnHpWkAbBUl+Xsb5hLMNNYKj3PcR1FU9t6WdxZESgLUhUPSdnSbbiEPlz3?=
 =?us-ascii?Q?QHCJKW1+LVuvwbyY50PWUaCq0UBB8kj5u60NCEJmOHmi5Wilgqdh/68LcJ4j?=
 =?us-ascii?Q?1aeAeKEDeK1F1yeyfv9FSncfJ9M4fHXgCVJrdnFfeqsnofIRnLqLYD90mmD0?=
 =?us-ascii?Q?vI6gsDTd+3dILUvmGdgxMh4ujgFZAmibcHeR3pvYLzld/6YiY5s0rpN+vK+t?=
 =?us-ascii?Q?2pBedEhtyhBIbAt/rf4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029cea2b-20e2-4213-da78-08dd6301311d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:04:52.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YI07MvWSJmrik0ldlEwyi4VdpeTBPWGTzmQLpvAfYSHwSPesl4baZvoi0HV1Zt7CkTsI1dWvPiE+iUaQXec1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

On Thu, Mar 13, 2025 at 02:03:38PM +0100, Thomas Gleixner wrote:
> In cases where an allocation is consumed by another function, the
> allocation needs to be retained on success or freed on failure. The code
> pattern is usually:
>
> 	struct foo *f = kzalloc(sizeof(*f), GFP_KERNEL);
> 	struct bar *b;
>
> 	,,,
> 	// Initialize f
> 	...
> 	if (ret)
> 		goto free;
>         ...
> 	bar = bar_create(f);
> 	if (!bar) {
> 		ret = -ENOMEM;
> 	   	goto free;
> 	}
> 	...
> 	return 0;
> free:
> 	kfree(f);
> 	return ret;
>
> This prevents using __free(kfree) on @f because there is no canonical way
> to tell the cleanup code that the allocation should not be freed.
>
> Abusing no_free_ptr() by force ignoring the return value is not really a
> sensible option either.
>
> Provide an explicit macro retain_ptr(), which NULLs the cleanup
> pointer. That makes it easy to analyze and reason about.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/cleanup.h |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -216,6 +216,23 @@ const volatile void * __must_check_fn(co
>
>  #define return_ptr(p)	return no_free_ptr(p)
>
> +/*
> + * Only for situations where an allocation is handed in to another function
> + * and consumed by that function on success.
> + *
> + *	struct foo *f __free(kfree) = kzalloc(sizeof(*f), GFP_KERNEL);
> + *
> + *	setup(f);
> + *	if (some_condition)
> + *		return -EINVAL;
> + *	....
> + *	ret = bar(f);
> + *	if (!ret)
> + *		retain_ptr(f);
> + *	return ret;

Is it better like

	ret = bar(f);
	if (ret)
		return ret;

	retain_ptr(f);
	return 0;

If there are more than one f, like f1, f2, f3....

	ret= bar(f1, f2, ....)
	if (ret)
		return ret;

	retain_ptr(f1);
	retain_ptr(f2);
	...

	return 0;


Or define a macro like
#defne no_free_ptr_on_ok(ret, p) ret ? ret : __get_and_null(p, NULL), 0

	ret = bar (f);
	return no_free_ptr_on_ok(ret, f);

Frank

> + */
> +#define retain_ptr(p)				\
> +	__get_and_null(p, NULL)
>
>  /*
>   * DEFINE_CLASS(name, type, exit, init, init_args...):
>

