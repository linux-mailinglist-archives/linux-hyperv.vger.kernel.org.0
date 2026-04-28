Return-Path: <linux-hyperv+bounces-10420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CRHLPng8GnZagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10420-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:31:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E27488FBA
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BF5E31B4DEA
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440743D510;
	Tue, 28 Apr 2026 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jV7riX8P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19743D51D;
	Tue, 28 Apr 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392138; cv=fail; b=ewkRbwy6KQn9wfVPIpmxfI0AYgwR7F5A/yj/gVxd6cdZgSHVa+ceI28qo7OACYvAnkxFF+MODnS6mnnHqpFuE5b8siggD+k8oDBm0hoOL8EWuABy1fyCYVqUsOS2Yy6l6MS6xa1bF//FWJB/PCQ08bXuZGhkfbLmKJN1ZQRoqng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392138; c=relaxed/simple;
	bh=+CR3xeA+8obO/Pm/UfY1HI8Pv3x/AEO6yOs+BZMXAAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LmN33xxy1gKYXRVYFm4oNFt3dN2+14YZrLWit826NFUvxnt/yYSSCQa+dzTtb1/62rSXmeaIF0BpMQnOKis2B9pqFB8cajP+CGvHAeLMDlRkzgVXZgc9glAnXgbf0NHweCKJE9O8RbgKSs4VUePewU4Gv4fcBPPisewvepjlfWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jV7riX8P; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3Ta5aQ2LNQwg9NHbmjwpt0z8J8L5T7dyYpDs4DGPDXWXsugfQc7EX7T30h/YQaU8lPP/0U/u/tOJkMoFsVfC0SRnmpdPY9cZuA16LoWUvwJucPhHA34KzpPjzvGMFES9itWJ9qVSEw1Kx9HKSo8HC7xEeYqKcDmo02QYUt2dQTCgUHil75m+btnCRXaCfT+qbyOm7XZHi6pzu6XyhISyd42BkxJkNTOgSnrNa7iYNTTQfzY4vq25G3btMpIdSZacY4opNlGyQwpeaVypmLMCrb1ZfYt0Nw7nqpRy0dUEm2U4Wu8/4ktfkd9tsO+c+07AW/V2HNTIGcTTGitQB/BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRcfNHw+FnRIOsdd9DHLP9nN7nxmlG665yOTsuxl0rA=;
 b=PDlqgh9Hd19rKKwu0sCVdWVmcd4XpI9nThk2QpT5MN1lZaf+Z8ap6AES779s8hVhBp1VXhTLE9tJkQoWUKTfqAj6DBJltUhQdYgBOxYQ1mNwkR0zTmw9Zsf4ldIbdZp7sB0kn0+fMTzvFWzaUH/e3rqpOYeVoHHm1qJIh/KziPT+O5mSunTYmXTB+E5hYbfJ0STHX4z3akmDQ3UC9aycwm778S42kAPUQFXDzR+MvTRqHY3J8ztKg+YzCvWE+fXeEn0GaI8R7jwLjE6oPKlCRie4jISfpLxOJwfp/s7PPfg+2L7XoWPWSZgmO2NjDX97jw4E83RihkQLCekYUUQuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRcfNHw+FnRIOsdd9DHLP9nN7nxmlG665yOTsuxl0rA=;
 b=jV7riX8PvwxTEEAH+9uBFT7tnK0rSafLJjaUDqKiSgrK8QhpJGNZPfabXZQ0bASO1auM9ucgiwLtVjOL/tyrtlFDR7NbrClD+Iy41K8Mbr0EInN5AwmEpJ3rn/dK+eSsRgFYOxz2uY4qTE670T6/qmHq7jYIZhb/gToL57QQDqWCWLdv8NQoTV+yzq5zBioLPqLAh73zKkZQc/4s7yvuzhqC9MIAmtKjVHOW0s1bU+AQIXmSwMvq1h1+4og0LgUDWoQI0GT9sN/7gW4VBHQT2gIH5stOHQPNVczYJwCCIlBi1yVqCVuMFGyDnCI1jkBBlcaj24W+h4pfCtXEIpknsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 16:02:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:02:12 +0000
Date: Tue, 28 Apr 2026 13:02:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: validate rx_hash_key_len in
 mana_ib_create_qp_rss
Message-ID: <20260428160211.GA2781641@nvidia.com>
References: <SYBPR01MB7881D40E494BF61A4B298252AF2C2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881D40E494BF61A4B298252AF2C2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:408:f5::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b5bfe5-e42d-46b4-df2c-08dea53f8234
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xWMfpS3BUqv4cIrQ6s4DRtsxJIDBjMgP3dIY40CkaerraZzyKIyF0udA//JFaLIifKNGMYMkB7ZiHHe41sbBceyt+frPF0hOwxaJ2w2fGUpl7rm0WxQi2aJqY9DmW3tKX7gxOfLJKL2ffwWIxYBj6AvPdGJNLlJbBaAVYXm+0qylXmt42MepSPfH6e8mHktfmznuTvwFHf6fd+a1LRgkk0IWsLrZLPUrdQtxIg/hGsDIX29wIY1o8NWnh1oEve+DMxZGYIGEtdss64Vxot6KNNaB7l9MBoJxvaYGdCuUg4/xZNMCSDJtW/DqSc3pvEwx85+ewhUzcM9F+Qs8QA+N+EsE/n+DfgLUHxtCw93JnfgwVUDBIfNv8Jy8ho03ITOMkxiKuqkxA+PEAADaZvpUSOzjy/NGO5ZQUD0IyuBbuT6129dZWPIhjsyA4nROIZwwd8e4n3s1FYcktLTd6hxr6cWj+A84VN//WR3nzA9lds2Lt8qKd1QVy5Xuig7GXtrKI6LXoWSUN6abSWHZ7zrdrJb/tPezde11l/ndwCTUZCyJpHq9OO0hiAmJwzG25bqCGSPHR/Ff6NJyKN1IiPA0fCB4pA/fg6du76IGL0DnlP+O/fT+7Yxc17VcgZqSPUuvSmFnUx3LRbcOsp61l5whsYy1AB+QwfpecEINh+k/U8ydGqvv/XBH1lv85jIdTAbAcASydtlepXjA040xqkILitU9nvxfw0VM91FllWtzdjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99otUr1vxTQZvWniHvju2LEMQApBRrY/WtqDz+y8fB62QmPsbeUqj1pHTxh8?=
 =?us-ascii?Q?fABgtSTHiQS6/f4rSgemjgOPTOkMHjrRcUf/YZddw1E6+YA+xUr6HvVMYp4M?=
 =?us-ascii?Q?xhA20jUiZcLHI6sf/XHOaBA5ojPyPrRpHBLV1AYPnPW9RKyRT++//lU8toLt?=
 =?us-ascii?Q?3i4mk85n5GvEuSMhl0lvSjokBnUi2t7JNcwKT9aR3d1InL5MkzjL8Co32NPC?=
 =?us-ascii?Q?vbZ4MnDu9Sarr3gEpmtwipJWsMIARlKdSNoASIIDmDH61SYP2HweeAqRo28N?=
 =?us-ascii?Q?pNN3iImBJftZ/XP09gxOYVSOry7diQOKsynmVl7Ap8VRXXrNPSqOiKVkXu9Q?=
 =?us-ascii?Q?8DDIETblbrgmYEuFy+cNRzIX3/XJvSc01wxwQ9Na6pXmkrScwzIP44S6iorE?=
 =?us-ascii?Q?WvuaS6+LW/0Ds1A0ngAU4ZXldy5gnwWfS+dW5Srj26QOXeq2B6caAKXcauX8?=
 =?us-ascii?Q?UxkKSsf2jaR9kGhM1v+3EaKyUBSM5/uvV6+AB6yl93ID0ymFuCjjYnw6CgAc?=
 =?us-ascii?Q?EuTn9FfRds8BnbYsuoyp1Q+MoEKkSjNiuwO7tp72XsblfwlWS9Yy44SfkjB3?=
 =?us-ascii?Q?i0M+kuLF7xnL2X84S5igBt5ENYK4YPcukpXudnQQUcO1x78oN8pv+tZOs9d+?=
 =?us-ascii?Q?xYZEfMXJaZwAotgbimJCJVx29VraaSO/8S8Og5g6Tztflz7PpdqSbkJluJo/?=
 =?us-ascii?Q?gsUR6qbis3oqhN+pxeUCEUyHot68NYeSzSjSLdbIX1r4cHtoujQlPlchwKmw?=
 =?us-ascii?Q?RRchqP9poMsvl0NIq1fQucG0yJzJAtj7aItgPvcbKWeuSySX8QiSVEgWpqGd?=
 =?us-ascii?Q?MJhslZ9/nQGxrONSyQ9dN3YnNIkcBZfw9i8Q35qUMW0BF69mNUFMw85eOoSS?=
 =?us-ascii?Q?pOzaFmy3kF9vV2O4ov1GKSQuVxKT6nWswFm8HP6ziOOQwxHhd3taUf1Ll++t?=
 =?us-ascii?Q?q+K9qBCOicfBekbxaDupXKmUjx4OxKRg5KYJKnb65+VPVnlNC3O1RaedxmFz?=
 =?us-ascii?Q?vZDe8OKYAT+1kom6dWRqN1Bf6Vhd00ZmmfFzpXKMXK1oIwJ6Fn8oG7dreEgt?=
 =?us-ascii?Q?9MzhpEemcSP4B+hVkmyjcpetTYs6fuIj+Hdosb7ZPGjuQwkdlImPtMad+UT1?=
 =?us-ascii?Q?2XyVpY7uUBcF6sEEP76OGrxrTneuktOFZC1GMAW2tV4zYTDzoF1ERRqzfntM?=
 =?us-ascii?Q?e07SAUZ+Qz2HF2h/xNgnb29xgLhsAk/72krpeUqLrlqf5La6qrAAQT7pW7Vd?=
 =?us-ascii?Q?UQDVi5fYYK9rnFJhtnTlE2gc+G6vsmk827+53Ahiuh56BJRX7hqq9KO8KyZq?=
 =?us-ascii?Q?K6FlOpzfqG7q0xEtK47HJIuvJ6UloB68nK92Vp3qvLpRJ74POGIcKzIoN7i2?=
 =?us-ascii?Q?BOf0iie0AmLXEzPKUxdV3rH94eEMAoL4zhuNeXJftoi6+EPX2wi+gTrUPxwO?=
 =?us-ascii?Q?WwPYKrar0E0qqMgORtwc47Ew5QZdY0e901S/GhvextgNxRdP7nes7S7DBQo+?=
 =?us-ascii?Q?P27tenvZN7g6tlp2SLcGwfjSEEGX4m+n6shRoB1xiZmtcEDWOyfJo6EZIGmc?=
 =?us-ascii?Q?KwUF0oAm+LPkmucE2qSRD2mGrCa56R2sPBYJxTYLttj6DgGUMC6/Tp8GJSnL?=
 =?us-ascii?Q?yqh9CgmilO5vr/mPvClXbVAskJR5TECBxg8jvinfE2WsF9YrU8fwwvwZFFfn?=
 =?us-ascii?Q?wYNh+zm2Lr4NZHMdMTZg6OaeqZyy6PBoDgoghNibB67VwVmc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5bfe5-e42d-46b4-df2c-08dea53f8234
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:02:12.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/TKowimem2Xol9Ai11BIMBOQcGpm0NWkru3mdoDptTxizk/j8RhSBq8Po0JI6s6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Rspamd-Queue-Id: B2E27488FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10420-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,outlook.com:email]

On Tue, Apr 21, 2026 at 06:50:21PM +0800, Junrui Luo wrote:
> mana_ib_create_qp_rss() passes the user-supplied ucmd.rx_hash_key_len
> directly to mana_ib_cfg_vport_steering(), which uses it as the length
> argument to memcpy(req->hashkey, rx_hash_key, rx_hash_key_len).
> 
> A value greater than MANA_HASH_KEY_SIZE leads to an out-of-bounds read
> from the kernel stack and an out-of-bounds write past req->hashkey
> within the kzalloc'd struct mana_cfg_rx_steer_req_v2.
> 
> Reject any rx_hash_key_len greater than MANA_HASH_KEY_SIZE.
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/infiniband/hw/mana/qp.c | 7 +++++++
>  1 file changed, 7 insertions(+)

I have a fix for this in my pile of sashiko patches that I prefer, it
is better to put the check in mana_ib_cfg_vport_steering() and not
print.

Jason

