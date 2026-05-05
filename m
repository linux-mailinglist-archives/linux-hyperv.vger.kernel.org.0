Return-Path: <linux-hyperv+bounces-10637-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDWGHmMQ+mntIgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10637-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 17:44:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D544D070A
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDB7306BFF5
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C3481AB7;
	Tue,  5 May 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaPp+PNG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4A156C6A;
	Tue,  5 May 2026 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995815; cv=fail; b=Bu3IM8MtOJdVtWCyT4JFM7QtXZKASUJLiGHV1D8e9BS+dgRS1ZXIPwUyW/bbLnoCK2de4zI9PJ7xSDcNEEby+SJkdlvQ2xG/u/u2IKRn1/CYHSA0e5zBiskH4jnj3bkUgG4HmhRIuRZOOQIn2Lv2fg5kI/ejxYGSmsl/d273Yo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995815; c=relaxed/simple;
	bh=/F2GKe9gUj3nY9A/zkZzyFbrKBTc16KxVO7s7XjYwCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5RhQ6s0/nnQxOZxBlf0fHaJS0I6qh34aZlpi38WgRn/WaVdQcygWHi6xRg/rDTSrFFoXbAl0GlyZgiMqsYaf1R9cDh9egU6ZTcRcRPcBUra0gQm9eugCrcW6LN4iT5plzB9dn3q8H5xtbaPw6FLia0YWw9A2YnUTjmKTMNksGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaPp+PNG; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpMvY9xsXPm+C/epFFzqxU8X119YSoU5Hy8QarYqnTo1klB2tH5F5iYhNUG2EkIH5TRHPRmanjID4whs4TnKGxPvCwaRBvgNt7AmOTuVFLcm3oWMXiqOJZuLiEut+fPRE/MyK5zpDrvOC5c3lZeRq0ssPA9g35xbMq5Lt3yhKnjExKE8mb0B2e0rXt0YMTX9JxPsX0Lrsh33Gu71Fxhpvp4OB1VjAmwXdwx4mth16omeuVbXlJjPbvE3n41Kce/fY+li1s2XBP/X5kzHFvMgoB3ndbKQMwZkIWicqDZTp/RglVZRftFQ1P3KRaP1yHN6DPEscNfQVgk9zhi3BH4yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KGZyCaAV+Qxl5NHwZxvg6CQJcSpXLcoN82OoFR8A8M=;
 b=r30J0L5MGWPwIfZd7OPpHVASBfMqUxKS/bgn/h57SDLEtTkBSi1+ar3KS/gQzaGok1Z1VeAjUcqOQLax31VFcDN2tig307xz5pzcXId1sgJkn+6vGJGHxAecvXiNXOnwGornQesfFWdOQ2rMx1XUmIKgftAKug/ml4UoU46qbta5wF7GwRt3c6K1QT1MYvvJphBZOpUtTvG8ssQReWIJbVGCmFtbYQ5bp1OofsMAsShhWDCTzIVmu8rZk0BaszNPB6DHEPgLMwksedqEP5jOzsYBWXv8p41xqjuLiXog7UVrEa0GYQHLccS3S1F+TEnqC7Xnv3nThW5S3qaDSxgZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KGZyCaAV+Qxl5NHwZxvg6CQJcSpXLcoN82OoFR8A8M=;
 b=kaPp+PNG7vuNL+GNanNre0YNzI/QboaKkEIR3Df43Bw8h2sWR6m+TrufATaovhG1n4CUwlV4yonLl3kWwAZT7CtoDUs9HnrjdaALivzJJgXHh/aL+NWOzbtl3Jnwv1Sou5j8vGQpBxPG440pFChkf6r59h37JWgiH+X/dxRso3u8KgC0BT+BXUHfcAchG+Nv+BAfhbLWUCbp7l+44rPLv8XWjlBfuZvMXrTHg0fLbCa9M6e154yUEoBgt5NWicgwbwJ6FzW8qKLDMG5HZG8ZD0F1mt26lO+k502gTmzuffWbC3FsxpGEpCykeJDPi3/d9kuxKsLO7KIG6BIGY55nXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:43:29 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:43:28 +0000
Date: Tue, 5 May 2026 11:43:26 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <afoQHm28qj8JnKww@yury>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afYxOPL4DNjXM7tL@yury>
 <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: BN9PR03CA0499.namprd03.prod.outlook.com
 (2603:10b6:408:130::24) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c54c53c-dd2f-426d-09fb-08deaabd0d85
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/1NiVhKuzzRkL/+AIDjRSND2h8kJ/jgBEnMxVuW8R4qMTd9LBju70TPpGrKi/IdWraXPqCXul5Lq0QGzOA70RFACL+/JutT4D9/GRvi0t4pwd3VuAh1A54udHBpA2S6SoAGq3+IbvCA51Wf6utlNwikNb+orDW4nZg70D+dQZFDondHHmyPoblYUBrq8LP3GEybNx8QsqHfu01ew1JNlbSckbGsa/FBqkhU18hancY4mRtmYFyfKpcBgMZQM3SJjvpWjk00Tw6sWorYe13nvovJeF3iR98F8LqZ2MncwuJLXPAgq2Rd1B8e2wG1sDMcJMTA63G6oGtDCHj5KbymYeZgJIo8XmToedVInsFxHgeEexx0+Cahk/J86b2x+JERotzCRBPczau8HU9zSJFO1Uc+THpFYLuJGG8d0Hw+RxGsqSldiucEbuVsacSazx+p6qWkfsGigNeofeV0Kv5UywqgBfX2KFnOEp2ofMhIeBY6CeGcDW//BZl7Lkb7PoajiqRlb8M3/Ctjq4qu/DW0v3Tn7TFUfP3ZJjqFhbPUwZa1k+6tipUqJ62LZ0DDRMMlJR3W7VfnaDOWrXrdTRwexkG/6rcEzUxvX/D1hh2Bzm4ZG8hvI6U8DZpQxSp9HSVvzKo+IQOn2KLFEVbH814KB2g2yL5FLL0hVUQ7DPxKeHjrJyleSdjiUapZD9rjS5lEl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbh6rHvl2M3DDyw8ZvpD6WB2i4H82MknP/2YqdduGap77PPinPfHn5HchI0t?=
 =?us-ascii?Q?TgE5/tMdtAKBjDuIybCroGfTRE4WqPbyPNA4dn+JO0QyquIhEZ67v/J0p+VK?=
 =?us-ascii?Q?gwPej3DbBIIxMGI5f5ywvdSMgxmRt3U/6/DggZ0+aeh9M352XbkgbVkVk9O3?=
 =?us-ascii?Q?DdytCr37cBQ6NDGODuvvurlXCX2SSeidmyYL7Px6cSWYY3f5EFnTQ+bq4nJu?=
 =?us-ascii?Q?eovY5QzhqTYfLzmMSAfwDm2bz4KqFOItKwDSt85vtrLh/bpIRWeSZHmE4XEu?=
 =?us-ascii?Q?rMhQ0a41nsZY7EPrKuWEiaX/HvCvWU79mNWb+Q9/VGXCa56vOPbTD/58sujo?=
 =?us-ascii?Q?6G5+d+EMLjQ6/mSWvlPO34eteVH8RIeqM7Zb+r4Yg6EmjfQbpeikMXlkJ9+S?=
 =?us-ascii?Q?e4sEQuFNLBFQdjPHxBvmipPApdqhyeIrnPpSRGNXrWWkK3Ck99XcoCL+3zPt?=
 =?us-ascii?Q?oqhANLVuqzF+MLBrnLxLA8ZIP/2JLFgvGeSRB6DpT/WHNNa65OFHguCz2n7M?=
 =?us-ascii?Q?8wtyIrYtkIB+Se4QNyKI6G2oEHDtrIn1JTpXMN/DPGanoWPgEFD810rpV0b6?=
 =?us-ascii?Q?WySppfbb6qDOrw6dk9FYki8fIXi/SsgC/Ldzs21ZDm+LicTHEm2Yjr4FXE/F?=
 =?us-ascii?Q?p1N6bZbbhIDkCDo3IToFg6W+VpzIomZ//kAMOetT3eYW++TzRqVvhPPW8cdN?=
 =?us-ascii?Q?qNOxXw2cvxK9rlIT07wm0r7bRQKfdeJHRo0/ti9fFrTGxQXX9FDaKcClMtSd?=
 =?us-ascii?Q?BD6OGSZugSt1dn+LWgQh1qViWdSlCVVJzYCVGCX2KihMDENewaMTFuWfD+cg?=
 =?us-ascii?Q?d37x+BXTdWHkoU5qroH+GTBCqgIga7M+CCLNnDZXEZgHE/r1ZGd1K+WYOcNN?=
 =?us-ascii?Q?PwIE/Yv0mW6faLf0aD1JN1sLTgxYrCzvKeTRqAKBbrQBxb0GWvTV82xHA6Pn?=
 =?us-ascii?Q?E0ZOdmNj5ya+iYX88EO7bKt1GPvZa3RQDFNsZP6T4rHk9fFYep9agVpijc/+?=
 =?us-ascii?Q?IBWiLkgWwy7xFWDlkhL0mT/ve+enDlZ/FvXnqXqCcX4u66QxjuUHnFZHCMkx?=
 =?us-ascii?Q?/ZXj0s5JQsp/KGTn4JAi/zP/nWhy7Y6/a3EvXCltye9OHYCTsqh/3gWj2lFK?=
 =?us-ascii?Q?Tpu9rZ8hbgDcEvqGl9AaVM+kGr3KNYkdejxEwdJWbMNabV11gy+XBxhVVyBU?=
 =?us-ascii?Q?fdIYTsgSebHPSgpdwL0zirCh3XSEQf8RuksyKQlAQypGDxgkgKIy+XQOUk0o?=
 =?us-ascii?Q?dNqvjvCkM72nLi53fb4gd7/JZFqsQ1wQEnrJ9EnNZtYbMuvfnBaDuSurMbH0?=
 =?us-ascii?Q?5OZ3Ul2qPwfBTgXP897k8/D4kdBgpYfxag5COQlxufKXDVsTFJX3tIYlA5Qb?=
 =?us-ascii?Q?1TwudI0WGETVjyd011/G6S9JsmAbpWZR8qlJR4ID8NMhhig9V5rG7ZqbnujD?=
 =?us-ascii?Q?5RmLT/U7Ywk1jW/ctTeg9m68G35NiBRu1xHzZbmD8+NlJdUWBwna6gVZo7oR?=
 =?us-ascii?Q?J+liTgkoTi3erGmVlW/PQOLZWbVwb99yUucVoTY6XYVZatGsH/8Px5CW3NPz?=
 =?us-ascii?Q?FlCkfR5uf6U58Ia+BS9UrlaaxHQqLoD3nOyyHaNXn1li7b4sTDdZlnD/L9y7?=
 =?us-ascii?Q?e4pVW1MCvTxgD6G0pfvRb/RDZjVxTAjIJfbbsVrvqGLxgyR15i2rvyNrue6c?=
 =?us-ascii?Q?CXy01vQM+sIGO2tD+8dkqGIINx9mI44+Gb7+Lm+R+cpXJpdSvvyGTHjb2XU+?=
 =?us-ascii?Q?jj8iw8AzTci/ZCGKqNv1lqK1U6UXHe7n5ztqzG/QvSjclSp7agkC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c54c53c-dd2f-426d-09fb-08deaabd0d85
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:43:28.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOXXigKNbSkv4MQMo/9rFgANqP3Ys9VHq2B2YjdiG6GoX8yYOVYZk+fc6iMJ9p2yHhFybT3VVAkcARcQWGiA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
X-Rspamd-Queue-Id: E6D544D070A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10637-lists,linux-hyperv=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,Nvidia.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 11:15:03PM -0700, Shradha Gupta wrote:
> On Sat, May 02, 2026 at 01:15:36PM -0400, Yury Norov wrote:
> > On Sat, May 02, 2026 at 07:37:43AM -0700, Shradha Gupta wrote:
> > > On Fri, May 01, 2026 at 12:22:20PM -0400, Yury Norov wrote:
> > > > On Wed, Apr 29, 2026 at 02:06:37AM -0700, Shradha Gupta wrote:
> > > > > In mana driver, the number of IRQs allocated is capped by the
> > > > > min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> > > > > than the vcpu count, we want to utilize all the vCPUs, irrespective of
> > > > > their NUMA/core bindings.
> > > > > 
> > > > > This is important, especially in the envs where number of vCPUs are so
> > > > > few that the softIRQ handling overhead on two IRQs on the same vCPU is
> > > > > much more than their overheads if they were spread across sibling vCPUs.
> > > > > 
> > > > > This behaviour is more evident with dynamic IRQ allocation. Since MANA
> > > > > IRQs are assigned at a later stage compared to static allocation, other
> > > > > device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> > > > > weights become imbalanced, causing multiple MANA IRQs to land on the
> > > > > same vCPU, while some vCPUs have none.
> > > > > 
> > > > > In such cases when many parallel TCP connections are tested, the
> > > > > throughput drops significantly.
> > > > > 
> > > > > Test envs:
> > > > > =======================================================
> > > > > Case 1: without this patch
> > > > > =======================================================
> > > > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > > > 
> > > > > 	TYPE		effective vCPU aff
> > > > > =======================================================
> > > > > IRQ0:	HWC		0
> > > > > IRQ1:	mana_q1		0
> > > > > IRQ2:	mana_q2		2
> > > > > IRQ3:	mana_q3		0
> > > > > IRQ4:	mana_q4		3
> > > > > 
> > > > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > > > vCPU		0	1	2	3
> > > > > =======================================================
> > > > > pass 1:		38.85	0.03	24.89	24.65
> > > > > pass 2:		39.15	0.03	24.57	25.28
> > > > > pass 3:		40.36	0.03	23.20	23.17
> > > > > 
> > > > > =======================================================
> > > > > Case 2: with this patch
> > > > > =======================================================
> > > > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > > > 
> > > > >         TYPE            effective vCPU aff
> > > > > =======================================================
> > > > > IRQ0:   HWC             0
> > > > > IRQ1:   mana_q1         0
> > > > > IRQ2:   mana_q2         1
> > > > > IRQ3:   mana_q3         2
> > > > > IRQ4:   mana_q4         3
> > > > > 
> > > > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > > > vCPU            0       1       2       3
> > > > > =======================================================
> > > > > pass 1:         15.42	15.85	14.99	14.51
> > > > > pass 2:         15.53	15.94	15.81	15.93
> > > > > pass 3:         16.41	16.35	16.40	16.36
> > > > > 
> > > > > =======================================================
> > > > > Throughput Impact(in Gbps, same env)
> > > > > =======================================================
> > > > > TCP conn	with patch	w/o patch
> > > > > 20480		15.65		7.73
> > > > > 10240		15.63		8.93
> > > > > 8192		15.64		9.69
> > > > > 6144		15.64		13.16
> > > > > 4096		15.69		15.75
> > > > > 2048		15.69		15.83
> > > > > 1024		15.71		15.28
> > > > > 
> > > > > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > > > > Cc: stable@vger.kernel.org
> > > > > Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > ---
> > > > > Changes in v2
> > > > >  * Removed the unused skip_first_cpu variable
> > > > >  * fixed exit condition in irq_setup_linear() with len == 0
> > > > >  * changed return type of irq_setup_linear() as it will always be 0
> > > > >  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
> > > > >  * added appropriate comments to indicate expected behaviour when
> > > > >    IRQs are more than or equal to num_online_cpus()
> > > > > ---
> > > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 47 ++++++++++++++++---
> > > > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > index 098fbda0d128..d740d1dc43da 100644
> > > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > @@ -167,6 +167,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> > > > >  	} else {
> > > > >  		/* If dynamic allocation is enabled we have already allocated
> > > > >  		 * hwc msi
> > > > > +		 * Also, we make sure in this case the following is always true
> > > > > +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
> > > > >  		 */
> > > > >  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> > > > >  	}
> > > > > @@ -1672,11 +1674,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +/* should be called with cpus_read_lock() held */
> > > > > +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> > > > > +{
> > > > > +	int cpu;
> > > > > +
> > > > > +	for_each_online_cpu(cpu) {
> > > > > +		if (len == 0)
> > > > > +			break;
> > > > > +
> > > > > +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> > > > > +		len--;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > > > >  {
> > > > >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > > >  	struct gdma_irq_context *gic;
> > > > > -	bool skip_first_cpu = false;
> > > > >  	int *irqs, irq, err, i;
> > > > >  
> > > > >  	irqs = kmalloc_objs(int, nvec);
> > > > 
> > > > So what about WARN_ON() and nvec adjustment before kmalloc?
> > > Hey Yury,
> > > 
> > > I am still a bit unsure about the WARN_ON() before kmalloc, as after
> > > that also, in the same function till we take the cpus_read_lock() the
> > > num_online_cpus() can change(or reduce). That's why I introduced the
> > > dev_dbg() to capture hot-remove edge case.
> > 
> > OK.
> >  
> > > Do you still think it adds more value?
> > 
> > It's your driver, so you know better. I just wonder because you said
> > it's good to add WARN_ON(), and then didn't do that.
> > 
> > > > 
> > > > > @@ -1722,13 +1737,31 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > > > >  	 * first CPU sibling group since they are already affinitized to HWC IRQ
> > > > >  	 */
> > > > >  	cpus_read_lock();
> > > > > -	if (gc->num_msix_usable <= num_online_cpus())
> > > > > -		skip_first_cpu = true;
> > > > > +	if (gc->num_msix_usable <= num_online_cpus()) {
> > > > > +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> > > > > +		if (err) {
> > > > > +			cpus_read_unlock();
> > > > > +			goto free_irq;
> > > > 
> > > > One thing puzzles me: if you skip first CPU with this 'true', and the
> > > > gc->num_msix_usable == num_online_cpus(), it's one more than you can
> > > > distribute. What do I miss?
> > > > 
> > > 
> > > Let me explain this case a bit better then,
> > > 
> > > - num_msix_usable = HWC IRQ + Queue IRQ
> > > - nvec in this functions is only Queue IRQ (HWC already setup)
> > > 
> > > When num_online_cpus == num_msix_usable:
> > > - nvec = num_online_cpus - 1
> > > - first CPU is already assigned to HWC IRQ, so skip it
> > > - Queue IRQs fit in the remaining CPUs
> > > 
> > > please let me know if I did not get your question right
> > 
> > Can you put that in a comment?
> 
> Sure I will. thanks
> 
> > 
> > > > > +		}
> > > > > +	} else {
> > > > > +		/*
> > > > > +		 * When num_msix_usable are more than num_online_cpus, we try to
> > > > > +		 * make sure we are using all vcpus. In such a case NUMA or
> > > > > +		 * CPU core affinity does not matter.
> > > > 
> > > > If it doesn't matter, why don't you assign each IRQ to all CPUs then?
> > > > In theory, the system would have most of flexibility to balance them.
> > > > 
> > > 
> > > Okay, let me fix the comment and elaborate on this. It doesn't matter
> > > because in such a case we want to anyway exhaust and distribute the
> > > Queue IRQs to all vCPUs.
> > > We don't want to rely on the system's balancer in this case as it could
> > > be skewed by other devices' IRQ weights
> > 
> > I don't understand this. If I want to reserve some CPUs to solely
> > handle IRQs from my high-priority hardware, then I configure my system
> > accordingly. For example, assign all non-networking IRQs on CPU0, and
> > all networking IRQs to all CPUs.
> > 
> > In your case, you distribute IRQs evenly, which means you've no
> > preferred CPUs. So, assuming the system is only running your IRQ
> > driver, it's at max is as good as all-CPU distribution. In case of
> > heavy loading some particular CPU, your scheme could cause
> > corresponding IRQs to starve.
> > 
> > I recall, when we was working on irq_setup(), the original idea was to
> > distribute IRQs one-to-one, but than I suggested the 
> > 
> >         irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > 
> > and after experiments, you agreed on that.
> > 
> > Can you please run your throughput test for my suggested distribution
> > too? Would be also nice to see how each distribution works when some
> > CPUs are under stress.
> > 
> > Thanks,
> > Yury
> 
> The design of irq_setup() works exactly how we want it for our IRQs for
> almost all of our usecases, so we want to keep that as is. The only
> scenarios where this is an issue in terms of significant throughput drop
> is when we are working with low vCPU VMs (vCPU <= 4 with high TCP
> connection counts) and where there are additional NVMe devices attached
> to the VM.
> 
> The current patch about utilizing all the vCPUs helps in that case and
> doesn't cause any regression for other cases.
> 
> This linear path is only taken when num_msix_usable > num_online_cpus(),
> which is limited to low-vCPU VMs. Larger VMs continue using irq_setup()
> as before.
> 
> We can definately get our throughput run results on other suggestions
> you have. And about that, I just needed a bit more clarity on what to
> test against. Are you suggesting, with irq_setup() intact and in use, we
> configure the non-mana IRQs to say CPU0 and capture the numbers?

Can you try this:

       while(len--)
               // Or cpu_online_mask or cpu_all_mask?
               irq_set_affinity_and_hint(*irqs++, NULL);

And compare it to the linear version under your vCPU scenario?

Can you run your throughput test alone and on parallel with some
IRQ torture test?

        stress-ng --timer 4 --timeout 60s

And maybe pin the stress test to the default CPU. Assuming it's 0:

        taskset -c 0 stress-ng --timer 4 --timeout 60s

Unless the 'linear' version is significantly faster, I'd stick to the
above.

Thanks,
Yury

