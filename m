Return-Path: <linux-hyperv+bounces-11820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1YisGxKrRmo1bQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11820-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:16:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50DC6FBE7D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZugGdJpG;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11820-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11820-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1D531037E5
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70A344D8C;
	Thu,  2 Jul 2026 17:17:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACB30C37E;
	Thu,  2 Jul 2026 17:17:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012671; cv=fail; b=rDgtfBHDRnorRME+yJ2nUppOqLZ3cwMFsZ/605YksgSUUkNX8mzZC2O2rXOd15nv6O/d6mMVKfKGRYcbL2X4o+MspvwABCIFkofDmyk4Ra6yKV7gJeBMDkLq7GVQCr6gYjlBSMsjH2D2R7trEHC0XkGJQGnakzX2bjogYkmJP4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012671; c=relaxed/simple;
	bh=mG7nXfQwDeb14ms1fRL6kpo+Lbz+quQxap2pnd5KtHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7Xp2h5iE15Utj3AGaw0p3Nb7CIs9kyhPcSvN0Wycq5GH8gS4w03WspvPn+FBIX3dgpT9cd69tKMqD0t6Jw4zi4MwpEIBZKbwV2zkRsQtdyy52yx/8NT2YUM0n7TMnTkykHY2G7ImtC9xUewuhQjBoUJbkjrS3UCx0W52Tn1K8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZugGdJpG; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZOT47OJf4tcFBqvC6oAFnJGlg1IkY5q/91Tdcab8ZuXjBFZfvaSvV8EKtxFnoN3Dg2N06FKzcLTIOzXrQhPm+ifovf0IohxRYPKrJELtYw73vI0SIbAyN2FNxzp7b9vEfDhMoajb6pMGgEXp1NoPU7/+iZ6HRvjfEUZ4OWgkTx6VR3g+8v+J+J+4nQ80Iii0iwoFMJMxjD6Z4R/BMJFtwM9DfIFYw/m2Rn+uyyow1jNvvv0VEke2gYmpR5PLnJBzUdGcgVhzze504bbFwNSTaKOfWgDl3lLtix3jkSv+2Na2hjvG37gFKLwES084nzjcFygizQCHAEMjdjNUIGmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6bGyWpKuz7fT8Y19JCxhpzFgxMWrcMXEBIcy6Q3ozc=;
 b=QTj9Or53n5fovX1qC9jpog55gJNSBY1RCfNrAlklELhUBXHvmF2tZe5RpVuAtV26oHtniy6/5ZRvUYvLlFVYycsCIX1RRRBudbSNNx4UAmHzyIxdwPm2e0KabMULPcVTmavYrCYMPX7fHLbz9+SXOhXlECsbL0K3vkTCG0jbMpaBpEkF8O/ILleVoQ71IEfS5nKJid0ltIkHlfrvjrHiOSerpExYLS8k4qfazVAG2525n53ApHoM6a4ECTA2GWdMCEUFQZLVbcckUXJT84WJTI1HdKWnyLvpkWJZP7p9wZGeYzkmUrj8WnB7v1/DcZgApJTuSpnOEMh/AqF8+9pe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6bGyWpKuz7fT8Y19JCxhpzFgxMWrcMXEBIcy6Q3ozc=;
 b=ZugGdJpGoIIP+cs5n25wKuhc0MkgMuVQC/e0BeuZbk4CWuBfG7aaJxN57A7ZivgamcrMKrKoUa+42oyW1N1Mfnt3k6oDHgwurwuHCXjiItXfFMXAYSz3aDQaMhPSulHrqCb/b/+ugbIKiHnXdJ8bqat6aO/hVJp3U5298PuRDadgrjxelXsVQq0XqNcA0L9pIr3PFEZiN5DtvvRZZRD8eF4bE/cZFyn4SiM6Ef8DU4bTndFumDmfidWX6II/f6OPOkoX14nICwoRajPncBL6vLrRVnamyWDG20KSxw8oTZ6f92v/6iWD/PS3K3B5Gxtntrat0F/j/8OcZUeZ8Tt/Lg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:17:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:17:46 +0000
Date: Thu, 2 Jul 2026 14:17:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/erdma: initialize ret for empty receive WR
 lists
Message-ID: <20260702171745.GA1504633@nvidia.com>
References: <20260618041752.481193-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618041752.481193-1-ruoyuw560@gmail.com>
X-ClientProxiedBy: YT4P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5431fcf7-1c85-458f-5321-08ded85dd5ce
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zlPrRlcfRDg0hdy7+G8nM/P7e30T3Dra+1LKbUVViAIY0nCecVlhf9A9t+Huv8qT+UkdRn2cjJuGuylg0+AE1nqI1gH4uFNf1U/j+CS8Mm/el4/KgweRI0tbdlUrYoBIgeCYzeGg5HaAiMUkdCUbFBrQ0EQU2qmdYzmgtDAAMx+fl2tmhgbpL2VvOT+HdP3jHEh3dpndbDSxX6/obXptZkFBttsobxXE57joKjkZekgWFNNrvKXYo3Cm6i/LZa/dEffztzF4FqwoQkJfPmY9RqflIkWA84tECMCR3IIPkBFZ7cDo5FjTo45zwnyUMxlxH8VCjJ1Wt+jTwVeeoHCxauUhzHKKcAbzTMmSSLRiEVV5Td0c1xmmVrhjtI+1C10BuMgAvYwb6mjowgelc5n0cs7ljDmhr3f5m3qTCGjD3YZuWKVrwYlvFWu88kclXpgGroc6xXxShtAbnGAm+K1VwtXn7scVKResso9MnNvgJgZoEHxb6zhRqbOKNvIPcApzff1fXwt/YuJR0j3tco8kBml7Teot7hA3Gco/5XrvKRvAR/ZlPjYhMzrMMSJcXabiGMC8GW7AgZpP6g/t/Eb3SPPnukVpzYRR+Cc26noZHtjm1ilwc1KkuO5iA5R3Fv7cSR5HhIDS1Gk2OjQz5D6MyV9iu8Il3TMnA2eRGjVfVoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGA1E2hERODavckH2gyTHLjmWP8SV81iMP5Up0m8Mf47AaTm0Sye1mG2U5FW?=
 =?us-ascii?Q?lTqXkDtRTc6+e3fKS9xR9b2grviinAM0lSPc0r+21igSeo/po3t83rSf69j3?=
 =?us-ascii?Q?9OVc78Sr8yGWxDK91YJ/9MPwLlLn3UvmdnqFLOTlACRrKo/naNUoisayZ2HS?=
 =?us-ascii?Q?mdbnxGd9VRbG7Nu/0pxE8Yc1QT7Czk1KlsSv+vUfYwL/oIvzXXPynn77zGbe?=
 =?us-ascii?Q?hgBywSWdoKW/LRCgqg8Y+0JBQ3TltWIwuent0pRJWNZ4JanTQdPsU3H4NUVK?=
 =?us-ascii?Q?/NPpjkikur2qqZGxQbdornA+5cZcjvLT03Z/sevH5xQsoFDFlv3Ai/JxsTrX?=
 =?us-ascii?Q?1T/yJy3AbP2iYzw7K0coplZRI9iTTir6Bka0ELiDD763W0KXZ4BhuFXoOpY1?=
 =?us-ascii?Q?+sOaxoDd5IB/ll+AdYLkEOkQ/silLFEsW/9zjLAUl/GOukmfgFh7ntAI5GJI?=
 =?us-ascii?Q?gGUgcHESHq6PHu3lYI64e1dF4B5qYa1QVrMHF3NYArW1bB0LL/WaQ5ffPg4A?=
 =?us-ascii?Q?V2TmE9VvDyT+KekOaOUSx59oYoStcgAZyzlq5eQpT1vVC6B4HHilg4kAEv7W?=
 =?us-ascii?Q?JAQHSc7YKsAiVwKVOCpLH2TmM0viwAgF0bx1ek5qVUytIWBCvGCyxBMEzOO7?=
 =?us-ascii?Q?tp3l6cz68hKBcUPmsix6SYuasfu+sva0DCHDddBR6OEDrjgOgwPw025qCgWY?=
 =?us-ascii?Q?28c/LDCUdLdXY603uvFwZCkxu146WxyXe1uJkzDnNqFxonPC5oC9VuGTk182?=
 =?us-ascii?Q?VaxBofeGHAtdtB9zXmKE/bH5OvPyjeD+fZmByhufZuiijOFUie/ZGWSXlJyK?=
 =?us-ascii?Q?Zz9V32cels8qje7YF0AMIQGzafFjdBJ2UeVCXqOpa/STegpCoymNgnX0bwW4?=
 =?us-ascii?Q?L5aK0wUOvc4gZYfjsXkyFUMVA8ct4JMi8nA7updYKgwkzTEoYgPJPBUL2ybG?=
 =?us-ascii?Q?3WqRv78Q/3iP2h7agfd9nry6HI+s50GDFselRwG+DSAgp4l+MKC6vkiinJw9?=
 =?us-ascii?Q?rje+Fbe4u8caZArA4hOw9KUFYzfxFdULp/nm7S8RDW6actI3ohpyuGDavtQL?=
 =?us-ascii?Q?UmhCEuToPQxwetEHrRP0VFfmHTSlUl9nLe6IS9vss5O2a7r4wI1H1cBubPKE?=
 =?us-ascii?Q?jLKTFHyT53a/1CQq9tULQ0fJcKLnyOvZlGCS96qN5mgdXnZNM8atRwSgFGXu?=
 =?us-ascii?Q?IlFRnx3CHGgg3InIRUpgByACqsQGHWKAs+Js2uTHYVtXbYQT3Wzt19pGwbyO?=
 =?us-ascii?Q?nDanNeC48OoJTqn9q9E4kRQzUJPidCPAIcAGlqJWF+AQDu247E9+zuFa0QAs?=
 =?us-ascii?Q?NaO90XtnEC5ThANCgQZLE6xJ8/q0UPWic/hW3W/5MpB8Z++fFFdLeKiYdNKp?=
 =?us-ascii?Q?EAcUIiiGqMXOHyZ9RqG9e87ggfr80CM9Nlca2wruLDkBsoNWpkzEGUfOF1YI?=
 =?us-ascii?Q?LEJv+9NBcNIpW5iLtVAgCxAHU+WAy25Hxq2Xsx7l3Igot/kwdSE/hG7atDI6?=
 =?us-ascii?Q?guIOEB5QjBmCJrgi0V2bJ1C/6y0HXGD7eMT+XRwksqkwNMwwfSXuupy7Cv4t?=
 =?us-ascii?Q?Wi3gyujt3rQsbmPOXxwuhPqW/YUelJTMC25GKfCZ6ngy99EcaNo4TQ93mA4O?=
 =?us-ascii?Q?vraPzM/lV1lmahpzGFcrqg4jx4dAgFLaAe0KPS+4GuA8j7l3J27Edvv4dJ58?=
 =?us-ascii?Q?SoVEtW9atabLifPWSLnKOWSX4rJEXFI1pn8NRg5e0fhbVQae?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5431fcf7-1c85-458f-5321-08ded85dd5ce
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:17:46.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +daWS/UsQ+BEzfz4u2YG0TEPFQty5BGolQmIdpL3CuICPzYGtuIDFqSaZ+J+gRqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11820-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:leonro@nvidia.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,alibaba.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C50DC6FBE7D

On Thu, Jun 18, 2026 at 12:17:51PM +0800, Ruoyu Wang wrote:
> erdma_post_recv() returns ret after walking the receive work request list.
> If the caller passes an empty list, the loop is skipped and ret is not
> assigned.
> 
> Initialize ret to 0 so an empty receive work request list returns success
> instead of stack data.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
> v2:
> - Split the erdma and mana_ib changes into separate patches.
> - Add a driver-specific Fixes tag.
> 
>  drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches applied to for-rc

Thanks,
Jason

