Return-Path: <linux-hyperv+bounces-9408-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAOoAAROtGk4kAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9408-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:48:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 923002884D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79A593030A3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAC3CFF54;
	Fri, 13 Mar 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/jbwPUz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14653D0931;
	Fri, 13 Mar 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424114; cv=fail; b=P61+kZTpeLEM8oX3Q5E3YAJQUyo4yn68LGXIlaBpS13FUjQt88fdE0/+kcmEOvz8IwC6ezeN8EYyizEEqbnT3i1q6aSSDkNd6iUMfg8GchskFwvIkAKHl+NH30CxjmR+/EP8aIBL9SyahkwJgMJt+GUHqhaBvyBMZz1I2zj92Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424114; c=relaxed/simple;
	bh=+0IhqWh1Wg773+KK0oUXkO2fpowMJ+WxPfgGkXalTis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QyZgjZIoa5qK9Sxx3zuFeoTd0xV/lXzEt8KWCB20320N1J7VauLzJQAOypapa/gUxGEXICmZ17g0RdznqYHdHplvx0W7DGd/Y9keSi7NkMWZUyekI2IKtbu1p8Ka+pQ5qz+dUuz02vHmNgk4UzB92B6LniAyjN84lXITFg22L4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/jbwPUz; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVzR94sFf8RzkXy04JZNp/SBjumFHifuTgFtAqhrnEK5W+JzAO+4McAImykfmq78bJ+K4TCaVywoSI3IDEW8CVTbK5agawJJEwMW2EP3n9CdRjf60ZHxh7wCEZcxuEA9vMy5KaB80mkAmqeOTxpWb3wt+aCJCMjHwxe95N6F1JpKdDqVJnjd3LWX1OGHK08riqGN//CGIyxOQoehtwbkj1XsaS75DPN1pqfeVIn6M0PuldPhX9PQcsUzua/+T4LOJshOmdSiuwFKKBPpShd7Uf16HauArC2MWq3rAGUD7vvowxWUUbVqrNr97FB258IHk71xIwXRspDy9QQF36iktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYXnI2vdIHNvh+pw/Lw4YXsJpxdFkolP02bUfhxYFu8=;
 b=VvS/gA5AEtk3DuEGQEo9cORAYbnbeHmCZl0nx8QKXh3CRlEYHI7uh2JigOYgPt6ciPcwQ1WZDVdWE7d2MKu2kWYQe43u1DMbUh0IaOMebjCw3y9ueKiHBk/fTHkS+NOGfHfoqWfKRWi0jNxXVX2VzCohhbrr0ZhFKtSK6ll0m1nifvmcHSg2sUEvwsqF1/X7gRIqPdm0BpVbI+zXz2x3vFnyFlt4moWgsr3bFTgw0BemSX5m1VDE6cwtaL71rydVzevbWCSumMOA+ppYkFjirgeBWPWjvXke5WbKg9uEdCV5B6AfSisPjXWL1nbAXQxdMVLerIeIIz8hkJt6hhiJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYXnI2vdIHNvh+pw/Lw4YXsJpxdFkolP02bUfhxYFu8=;
 b=I/jbwPUzsqUE9qixPc/NFJQpDdLGVt9Bq5+I+2CAZEUHuHuHDFzxSTu8M9Ynh7T5AcqkbaWrFzTMMbuOaIYmTBC4+2LQNoexkdVN3WwmX7Zy9nS4n+LDFwsspAIPRTAoUqNoUig950zxLR4+W3C/CPnowSMz1L6AEtAkmmPGok0SieJPfb8NTQ42DxkVAqLOSFJW/DAYh/K8nYSZ2DEi9xukUTNoLMKs/GW5wmP4biVqe742CbVuOEixaltonRezqY2+O4qXsnS2Nq/ZpZKw/+oRihw3sXUF/0W7t8a91cvbca6RfY55C+k9lRXD2TiRg2tnwiwmHpAe2AOXqeAGxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 17:48:25 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 17:48:25 +0000
Date: Fri, 13 Mar 2026 13:48:23 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Konstantin Ryabitsev <mricon@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abRN59ST3uRDS5-e@yury>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <abPdItJ152oMzGd6@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPdItJ152oMzGd6@ashevche-desk.local>
X-ClientProxiedBy: BN0PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:408:ed::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f056589-2632-4a80-3324-08de8128ba0b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cqw79NQ6ayA9+ltS0AGjL8jzoYbmmkaNlFnCKwH3BL4VQ4/QCfCUbUxke3fZFQb4gXRsFBL0wyBXXTT7ZWvJw5W+zqaoae6c43DjFVF/uZulwa6STBU/yAGGbUa2oJ+E0gSBzrL+c1tbm1b7/oy6FGyUm3x7DOhUSYOJs882cLI2rKBt4SP6tpumIZ6HoEWR2JU3uSpP5XZ/1f1rv2jm+e01ILR13nVicLcLA61cGPFm8V3L1JkhYpHN+d67f+1iElNHDkLpxLlIjdMbDOrRnntg29jQn+99ZmuzkCNhYvAfyUMmW8x70WTFllUiQ9SR/3NJW2HxWRPbQM0F09MsU6Fopw59il55r6V0Vi5pVHI65FCjFxbCQZPHCQ6im2aYdxavpVTY4r7HCixDkvR0CxVRUrns722bsY7qgG94BfJkp8PddTmrnFunAyiOJJ1D5M6g7U1EPs5XIJYT3AuA6DKqi5qsbk7KmR3PLGYm6zJL8knpzSdcYFBw8ycXDat/yLEqGb4Qn4FwOnJkUbMfZ87Xtwogt+LrNJLCcImtAyI0F2RIG88PDQmw5fgplcZKymqQd9jQMbzza5ATDhmYQslhMisB+n+OVueE3deQMh/PWRHKs6Q9joTBAde9tyJMmCJdcizRTmdp/xRxX8KFkVqmfZNP6AvOCa4BmGDvMIDvc+iNaQNCPz3mPgA7ffy73ZSOznrg/PtSWkmYw1bY+Krm7DiPmoNiMtbQgX1vh6wK6WBMOSV3alkpF+u1+vzg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZgn0EJZPldzZY0oAqix8rs230AbM7WQt/p7ICM4v3alDTMZebS4+OmeKtjk?=
 =?us-ascii?Q?oO370YPYhxM+emCmi1UGiNSJqPMktA5hsiZ3vGd8ZIw1KLk7Jsz9nOemL1dl?=
 =?us-ascii?Q?xVt6B0M6nsrzRNbTC/sucEtHHgNB9kuYLIiw5onf9vNg0KZotetP1Yeeyhnq?=
 =?us-ascii?Q?tykUPffSXLinzkSgczg9AwODThaH558I9JkD2/j9+mk9JKagDo6ZM8wMgtfx?=
 =?us-ascii?Q?HLayKqtzPNU8rBvtAbqwx5YlKJFdv4X0g9noh/11PJVtmDf0KemGAsU0zSbV?=
 =?us-ascii?Q?p9pNngBKn4kTtpjrUeUhXvXdmBpHC9j5OSLGSHxwvNUMMpymJpCGAzPCqUxx?=
 =?us-ascii?Q?H1654KFENQNXwyLA3xszPNuWuGcIuHJE83f+4hu4cIVRGiyF86zWSm6+4I07?=
 =?us-ascii?Q?RjuB//hStoC6kE56GoBzfavs4w/jTbxyiMtw/UYJbcU9PEfQvgXVRoyYznRw?=
 =?us-ascii?Q?HTx1fU0zkKkqZCpH0zrDbqDStre79Vn+ayRJRkUX84V8wCQ8dLyG56gVWXi9?=
 =?us-ascii?Q?bErrZqck0nxBF+vFtIPCGjdDYpcTdNwKU9TZ1aEbg7qqtOTFoKlOtXJmA70R?=
 =?us-ascii?Q?XDwkiZvDW0Dw3py6WajJfWEksYzzzK4UgWLNoWzRN+jTNzJPZYsHaLuMaeIy?=
 =?us-ascii?Q?Xrbc5P/XajkxoSrUiCwttqsdAe0J7d3b5g0QaBX7C8cJBYU+iba8JjMKfX74?=
 =?us-ascii?Q?0bdMuOiN66avRm8H8V5+OJjUACMEXlVLOVXLd5j1wtaFKqoeUPpvFpBTkV0x?=
 =?us-ascii?Q?NjYztymVClUojU1VaAcWm2vTCIpZ3xs3Y1r9XIzgnQHBan+qwoqs8L6xA6oT?=
 =?us-ascii?Q?Lb+UQphlL2wghkoYMtL1RCoPimtOvh2glmpR3vf707pgZvsoMz2IEaQc0cWW?=
 =?us-ascii?Q?FBM6/Xreb+0FQjz3RP1GYjzgDrm9wmK64jK3SBVSKJTjTlTHXMeCk7Q6UKWG?=
 =?us-ascii?Q?0xo/Sb4A9JCq2yp0oRK0Bux9XBej6FgbGPLUBpwnlnA8/JaVXnWoxY0zwP+F?=
 =?us-ascii?Q?+8dB4mgHIpuyD8g5k8sfIPPdBLRqxzHAnrz+7UvvgQhsY2m4vr4C7aWaFZp9?=
 =?us-ascii?Q?CD1vQFcMIslnXn8rH7EuYOI22hR17oQCZlKnA1Hw+H13+AshlmcObYOGL9N2?=
 =?us-ascii?Q?HV0i+y8CDyrjrLjdq+vc3nFYOy9om0/pSQccDrWxKE0uVXYzu0o8+BehkvvV?=
 =?us-ascii?Q?7Hi0Nn1yy9yqpek63Ea0vbraTx293R00BCNYhBv82FpfX+Lyo2q/3aJg2kqI?=
 =?us-ascii?Q?EZZ/7QLHH19z0ej1HGbt8zwkMvFRKcoUrgfSBlLGdj7mTooJ41Ek3m69w//p?=
 =?us-ascii?Q?1cgr+YYjM/7XO54toB8TNU3meP8eGce1PHVm6NA1uJwgkKDyfcKbgdVzSDBF?=
 =?us-ascii?Q?yY8aM0c9MuipyLpwBi+j3++l5tpmQWe7TEX6/j7H0ClqnVtAWGboBhq1b8k2?=
 =?us-ascii?Q?5EEoZjEUgqfNroT4uUwlOkpPW/ckKsINWEBrMjaYprCr49ivfCz8L/EgA4vS?=
 =?us-ascii?Q?ImXEkODRFMfP2ZCSsZpT2d+UVNffFo3qbqtskwNtF/ic4v0uKdfLb0GAP+S5?=
 =?us-ascii?Q?H9NqQYt5+s4oEDcHYiGWJ7vdQu96rMYqP00Rm9SSiPJHyxEnzjBZ9SKq6voK?=
 =?us-ascii?Q?aCQX4SWmydYXMZpi8AiO/KNpJatn8D8ardDfWA0yrtGVe/FrF0bdEk60HOEK?=
 =?us-ascii?Q?1fymkGatO9wtF76Rv4Y79bMANEnhpXwTSCrZzMqJgekFD1X+//FpgKv9Q4A5?=
 =?us-ascii?Q?NNprO88qKs8L56owxjB0bw2w4Y7QLjGkSe2rJOWdQs/lp8HHLHeI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f056589-2632-4a80-3324-08de8128ba0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:48:25.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEN286Byv1ea2oE5zDEF7ennw8tycDbCzbXwWJAaSqBPJJ5F1ok3JpcfrKJXgXoqYTAXgfE/clHAjllaCU3SdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9408-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim,samba.org:email,soleen.com:email]
X-Rspamd-Queue-Id: 923002884D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:47:14AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> > Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> > to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> > ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> > 
> > The 32-bit behaviour is inconsistent with the function description, so it
> > needs to get fixed.
> > 
> > There are 9 individual users for the function in 6 different subsystems.
> > Some arches and drivers are 64-bit only:
> >  - arch/loongarch/kvm/intc/eiointc.c;
> >  - drivers/hv/mshv_vtl_main.c;
> >  - kernel/liveupdate/kexec_handover.c;
> > 
> > The others are:
> >  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> >  - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
> >  - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
> > 
> > None of them explicitly tweak their code for a word length, or x == 0.
> > 
> > Requesting comments from the corresponding maintainers on how to proceed
> > with this.
> > 
> > The attached patch gets rid of 32-bit explicit support, so that both
> > 32- and 64-bit versions rely on __ffs().
> 
> > CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
> > CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
> > CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
> > CC: Leon Romanovsky <leon@kernel.org> (infiniband)
> > CC: Mark Brown <broonie@kernel.org> (spi)
> > CC: Steve French <sfrench@samba.org> (smb)
> > CC: Alexander Graf <graf@amazon.com> (kexec)
> > CC: Mike Rapoport <rppt@kernel.org> (kexec)
> > CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)
> 
> Please, move the Cc: list to the...
> 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> 
> ...comments block. It will have the same effect on emails, but drastically
> reduces unneeded noise in the commit message in the Git history.

In general case, I agree. In this particular case, I want CCs to be in the
main block, and eventually got replaced with the ACKs from the proper
maintainers.
 
> You may also read this subthread (patch 18) on how to handle it locally:
> https://lore.kernel.org/linux-iio/20260123113708.416727-19-bigeasy@linutronix.de/

+ Konstantin Ryabitsev <mricon@kernel.org>

(Thanks for b4!)

Interesting thread.

So, my workflow is:

 1. git format-patch --cover-letter
 2. # Edit cover letter, add To and CC section
 3. git send-email 000* --to-cover --cc-cover
 4. b4 am 
 5. # Address nits/typos in the mbox
 6. git am 
 7. # Address substantial comments in git
 8. git format-patch -v2 --cover-letter
 9. # Edit cover letter again to restore body, To and CC sections
10. git send-email v2-000* --to-cover --cc-cover

So, yes I loose recipients on every iteration, together with the whole
cover letter. But to me it's not a big deal because I can just pull
them from my mailbox.

In the better world, I'd like to have:
git send-email -v2 000* --to-the-same-people-as-in-v1

In the perfect world, I'd prefer to keep the cover letter under the
git control, once it created, together with the recipients, once they
are added, and be able to edit them just like regular commits.

There's a 'git am -k', which is seemingly related to the matter, and
it keeps the [PATCH] prefix. But it's not what can preserve recipients
for me.

I'll try b4 prep and trailers as suggested.

Thanks,
Yury

> >  include/linux/count_zeros.h | 9 +++------
> 
> ...
> 
> > +#define COUNT_TRAILING_ZEROS_0 (-1)
> 
> Shouldn't we also saturate this to BITS_PER_LONG?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

