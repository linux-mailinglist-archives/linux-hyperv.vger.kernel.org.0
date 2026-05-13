Return-Path: <linux-hyperv+bounces-10881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OUwGQwIBWpRRgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10881-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 01:23:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D187453BF75
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 01:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB1B300F152
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC038F63D;
	Wed, 13 May 2026 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n2ompQ6J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CE2030A
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714624; cv=fail; b=AhXuM2k1s/ULcOLTl20o/9Bf48gAfBEroCf9EMVt0WOHLP5/wYAEeNPDbQ0uVlzjOHFXJSwHBARQbgM975kO6rpcXDR4fkR33LEqqlfQiBhrffKMvlyZriP7kcLzWbmCmWmhzCqRkrGFAWZKA7JcuckAcQchAr8PaEy2teGCXAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714624; c=relaxed/simple;
	bh=aaB/whdWsHJEEDr6Xi0e9VrU3BfrZ6iGfmp9RS9EfJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Usj4HRnED9MCVFUPqbiuQYXJfIO00zQRKHc6gjFn2Z71sYUEvh5b1pOHf4FCkzMS0te5IyeQpToZI+ke67nSsxa90UXFkVP0+kymCf8YmXAnePt4sUuvee8OUh0QKvnWKFyCp+5t+RIy50WPBCtKmFH8u8RFETfJu6pSFMXYZBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n2ompQ6J; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiLjmNnddeXFvwEqDtdVzwm3iZFN3NQ07vAzSMw0airTDqJRN+IooOqOC7/c2YTVK/hsC5spaXUb6MQGCpuzOZ+Ybi9hoPHbyA2OO4oPkT65VV07O/JHwmBjWZseLx0OKnqnYgE++msjcSygQi1vj2dYJ/UxEwvUgSHAdknlRyqU15Vol6nLzu61jUkbx2b0SVXVEEmYoLWQoGD1tubWxE0gslHEDPsdrfdY6TF+QOiITw67clfIcVlv2/MUMD/hmbTnOxMNJttH4OJpzIETXtgVPQMu84QfLo0gQJZHOeg2dvjoX462LVNGrGWqTsv4USsnoUbHa74f9xG3O4x60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaB/whdWsHJEEDr6Xi0e9VrU3BfrZ6iGfmp9RS9EfJA=;
 b=konxHFwkBYjyleN4jgvo0Ny4YzxaYm58EcBs8DUyRrUztMJzKJzQRnuX5bfcpzgUWVaGvYnoFJcXoX+OL6kY13Mc8L1o8pF1hXL2dCr7AA1JylRv+mvwnkNxK0AAmoXF5pTJG+kaWmHQMAgBl5CGBgiHn1TwnExGdEkjoK15s7S/S+3o50qmifcCFdq/mLoYqZfOTTOJjAZWNDPA7stgTE6rU4Riqbnw6tTszMWXPqN+/r/o2BInNtrTvUuLT40UJrbhuuV1lCL5ygzhKENhW/eJHPTfPisBNZrXkhwJHBFkD8X5axF0jKCgv1419/hevChxY17vdxvQXWUeKH0bZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaB/whdWsHJEEDr6Xi0e9VrU3BfrZ6iGfmp9RS9EfJA=;
 b=n2ompQ6JtrVyAWQsC/y8JIiVhj/vmAGDD8SbCFyBvFY6+DuOle1XA08w7bH9g1msZ1sqnROzfrKeQw54WNqEwOBIR69dbgiZWlnQl0hc2SyNUEmqtwDdW7mUUBV36fdExCgXPuiGlBKXvS6nYM3CpSrHcWQpdxbvOxRe0DT1sc+2LtnjfsczjYmhP8anBkK0fFt3ILTtW5iNwTml0AN5rAapk5aOejEbb2Lkgb39IctcL+5oKRCcfwg6nCyDe/gqj4wQ1ejVZ47ySIjNU+SZi2eemYl8DNqZhz0yb9T7xeJ4G+wQsgJv5ONMtqaFqYinUQ+CJC3DuJcglEJn/88fdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 23:23:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 23:23:37 +0000
Date: Wed, 13 May 2026 20:23:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 10/10] RDMA: Replace memset with = {} pattern for
 ib_respond_udata()
Message-ID: <20260513232335.GE787748@nvidia.com>
References: <10-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
 <20260513205916.926F0C19425@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513205916.926F0C19425@smtp.kernel.org>
X-ClientProxiedBy: YT2PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b9dc6d-456b-4593-78b9-08deb146a8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1B16rXitsrn2pOKpqW3CuJvZ1V+otU0CD2WGTHzr1NNPavqd1+MPt+MDQbICzJtIEriy/M58o/au1Hz+U3tcPwfcPFOKZwSAQErhYcL1VQ1bxB7fpPzmhCMKHi6uaLPmp7yADZRRhjngQE+rcL1hvQdgSTWNgxMmucbXjTWO9K4xf8+olIx69QkF3oZCJcv4mnsQRaatRAWiJZIi3G9R2WIGxg+pEahEYuAiHR/CTf9tYOkG0Cf+zC1uSipZ9u8WMauNaZvUIYEwjD/+9ANuUPgcGjoZ6ORbtCdPXyFGgtWKNa2QUtlG4DOzzXfm5dVHRP++wdKonRypShaIbpnah2dxQFi4MrklO/O6sPILY6nrWFTTiGFbn/NwZmje7f7OA7nHM3hzi1uFXkL7R6WMs4RutO84dmOxxiw+TmHSyNFWxA/RK1W5B/QbeDRwrZUoabYKQrItTomo551zWqCkYCqJzpkyc6lhF0qyNUR3dSSKxPTvtEvrbX1hb33cSNqOnr0zyjy5YsuvpfQ/AF/jPiznZj2f2JCKwkQUHIVusKEe5qJ1Yem5P+Eza7QP1f/9YcA4DwjGXRfV52GQJz3ncgCCuRZRqgfnPJchaaDi1U9qXDP0yrKF5Gf2J2a5h84h0U3EB6qEyvziWAJ5EHUDCVSprVxFxD9vCpUp9T6srpNLpjiPzViKPmtHsuOs47It
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5cUftQDJKiLy5JOXr/iXnvjhXYSKkRF5C+drYIlZ8grl3oeg6OoaChzkmiV?=
 =?us-ascii?Q?txSPjyt6apVuuQ4d5hLghl1AMM4KPHW8+578rU26kx8b5JC0j5dIAoR05Ont?=
 =?us-ascii?Q?E89sNdwGJP1toN+/Cmm5lsRZtUWu3OUJKSTBYHC9A+SO58iizIGXzeNP1UPI?=
 =?us-ascii?Q?B9pKokJI9kE0OLTBU0BQ6xCaZhpjsez2RgeYCqpZKjJVnw+W3vVWH0oLfQBG?=
 =?us-ascii?Q?t0ChWFwkr9fH4YCuoDpdDtbonq+Z+jmPYde65llsTp9FnK9FJJk7csx+rhEh?=
 =?us-ascii?Q?t7YaHRlIFoKNrrc9DbxIIXfByTKjPC9CsJdxgPibpBXdSIWNDxVbT+SLk3xq?=
 =?us-ascii?Q?57eAP9aNy5T//7mkxyqgKFUzx5u1HRrOOasZ9lbrLKPsRnvepCzWkqTcJNRE?=
 =?us-ascii?Q?rLzcjMwYp6bu4TbiZ1F3wpZForKw8/v/egKmt+27Oqp/oVoxKvGVTHOmm53B?=
 =?us-ascii?Q?2XKswSN8oFaMLTvLmJQsJmuyKrxfUoX2kb4n1d17wkxKwP/PN/h0cPBeZsno?=
 =?us-ascii?Q?FgDPEv33s0anuwA2SBaD8Xb8vcI8WO3lWC9M/XIq71UhyJKwf0TZq8kkTMpe?=
 =?us-ascii?Q?UDq+uG8yE3+VfPZVu5FPDjLsykLe6S5rLL6jOwZNtJQjHNDZrK6zeJLpoth3?=
 =?us-ascii?Q?S3N/At/t/xP/4NFk4OFF0duZ8Wptq3vhRhzot2eJdtcgh78s3cFaYU1HBSzC?=
 =?us-ascii?Q?9j1/0dmCr4mDbJ2NJ8iRPnvAbIxKvvFf2gldEs0bu1txIoj7R1d4NH+TYqtU?=
 =?us-ascii?Q?E0p10cPEhAaDo6l3f2KC2sXOA4CY5hWkMcZkeaGYJ1aPdyYIz6c+h7uhxEhU?=
 =?us-ascii?Q?a+TeZbzB7//zNNnI3dLbvTmwcD+2vMZe4fbrFXaeQi5JTmLq/1BNhX4qKZ7A?=
 =?us-ascii?Q?Zy5JmDwx/84BbN3rJXxLdvNcNSso/6zVNrEe3Fg+l4RTeEok9gLAM5u5p2CX?=
 =?us-ascii?Q?LM/oDDRolO/96PnphH0W6XsQUeR/zN7pY3v2ngHG2EGyp5zo9MfUHGfjAqLv?=
 =?us-ascii?Q?9E99Hcw5tLw9hx6+lbeX8G4dXecIxYGznhBF+fwhsv+LItJ4yp3tgkX3SzU1?=
 =?us-ascii?Q?BIskOlnCvEbziAhyd9j7/5Ykan+6Z13iHkcvRlDp+BrWvWL5BUVy7SUK77oS?=
 =?us-ascii?Q?W/MiL0SsS30pBeBqSy6opHTeKbPBLwnzBIvdWoxuOd1rJgMOzPvu3jPRA73C?=
 =?us-ascii?Q?vuT6jgPq1QhDiWVFDAyO4FyCAMhvugVeYRKow/dR32E4UPNo0bPVPNN16OsS?=
 =?us-ascii?Q?R0k3bHQxchMkShnG5t51Sp7h0jGTvDdOddo7nc5z9nbLJEqMk2kzN/XGw1Af?=
 =?us-ascii?Q?tak3BMOoNP2xi8NaRo1koZEN0uE1ioqjcYBP8E9uwInvznXqHH8cXEim7bPK?=
 =?us-ascii?Q?iS/P26Daqsuw5B5D9OB+E1VIc8C35JgGtgbFJyTxRn030gUHbdvsQqsfTCDx?=
 =?us-ascii?Q?T2QbFl0J1WmGGQM5YyhpzKTCAj4OYIMENnuSA3RVU7FmEcem9kxXhL+tNrvu?=
 =?us-ascii?Q?iwVgqgLwxGmWomBhdThQyAE8+iCEXLfDz2+P40YY3P4ZvOJkPdoLOiUlCwd0?=
 =?us-ascii?Q?X5jTfxmWdZAb6tQKyjMxouf35eBmt0UQKVWQjHcel6nOr0FK9wBhit3L8/5N?=
 =?us-ascii?Q?NjeoZmAU9zTMTPquWBoPI3zDUER30AzkpPfqjVgCCvin9ZF2qDJf8JsDCSGW?=
 =?us-ascii?Q?dRvuYDa0HHw7ofZNV60aNMb14IULU/oAzwNoTtBy2qMU3nCM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9dc6d-456b-4593-78b9-08deb146a8ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:23:37.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqJQs3mMRzAU8iIad6rVQ80dAKW6oYGdCOS15i1vsROQrk39SGOQ8H5f6y3IXo/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
X-Rspamd-Queue-Id: D187453BF75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10881-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:59:15PM +0000, sashiko-bot@kernel.org wrote:
> The commit message notes that qedr_copy_qp_uresp() is already called with
> zeroed memory. If the caller is using aggregate initialization (= {}) on
> the stack, this may not completely zero the memory.

This isn't true, c23 standardized ={} as "empty initializtion"
clearing padding and the kernel has long relied on this behavior.

Jason

