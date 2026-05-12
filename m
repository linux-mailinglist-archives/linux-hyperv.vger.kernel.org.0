Return-Path: <linux-hyperv+bounces-10764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEIWD9dvAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10764-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3323517C00
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86BE301CFBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECC57C9F;
	Tue, 12 May 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abSwHEE9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31454763;
	Tue, 12 May 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544591; cv=fail; b=OCIV1RcL2a9ZPg720ZjN2qaKZVltyDe9MO+APxWei0AV7EWNJgUC9iD6OoqOmN43VOgEngaFa+eO6BREO0Rz//2O2QKagQV97635IsxtvFO1OVBZTTvYh20mHYvKoSGJEEvsTouD7DKbZXjCxOrxDpE1sl7j0qKzlGHLYGpROHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544591; c=relaxed/simple;
	bh=ZmN7ofOkzy+BQM/gThjX9lqmdF1+26W7xq1fUCxrO6g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ol1nw42BO4lw+Yp0bvTM2bedXn6cgVNzvkVFZmovmi+evKWlAN96IxOI5iHdciySmFVQkzlkOQeG5avVaOU55d00euOXV5qyzbOY+3WvpTLrK1i7gMwQVMd9+/yalAJjH7TeZAVoiMmXMKEAOi3NzPvipg1JQOKmZJtQU9Wm+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abSwHEE9; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaLI0Q7rPmcOg5jOtfl2hSYUIKpkrOPECqRmhNruk1U9QaE7wSuz3hBCqdmoGvMP4BY2/NeIZF/eU8shh5N6fnfXdGzuQINI2ZR9e6xCv7ynxz9UW9jQbHuM1l/VXDlYyIaalM+3l6hDPAn6zU2yAaIfmYL0i+OpsBV7ElHFwBD7PV8Uvuzhq5WhZk+bYeA6pfWRwSvSmOmPMP6ejcav8dRlTI7rQsvvhBlb0okND+d+Ad9fh2/IfxoS3oDRiTHajRS4xzEiOo3v+Oz+ZmLGeD4fUV20rLWH3MN94VZKjd/aX/zI99rnbWqeHl/N+Uujn+qgGNPkDyTV8LDQKn0UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UP4VfU7UxtJUpmm9YEmJq9NDKDSFXogbsk/a73CzGM=;
 b=obagaqh0mEXDATrYasSr4HfRuWjeYHzWGLX8uhSgeuARVUMREm8eq3JXA7/hEQfTcfZQD7DsQxsVImAr79CK/e9A4NqFBfH11C9Tj42g/vPHShTPw+uWuKmdCMHyBLrszntXcih1PKfB9ZtBs0NOpH1fTUy7QPBh2yp6AQPtlLxWkco6iKzLywnwTSReORIbpN3JWqVd2e6off+X0ZuCt8ef9nitT6MP9RQ6ePQZDK4HoM4szBnpp9Vw9QyeehtPJTueZD0JTJjeDYRTiDgupuvuaf3H7qhF/OgmnXWh8VHoC4JGyo4zjp9qHT24Yr5ppmpwgLtQRIcODFyWK+mUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UP4VfU7UxtJUpmm9YEmJq9NDKDSFXogbsk/a73CzGM=;
 b=abSwHEE9QnaGw1Zmymp0CD0UJonO76N/CHlGO/peyS/lrYU8KJTpxhxtQFAxfZSPjULiFhcMNarAHLuKdAJZ+R8VfPb/SAunDZoUi9SemnU/i98zy2U/ah6psSpDby4p1Ao9Itjg5vcd6sL2MiORr5+gaWDX0pb3BN+xxMgliLnifBLqMNVqB7gm2pTZ6eqUHtVUt8kzvdnxpIERq+mfbVMgPzl9bBGZbPnbX3oOMK4wfbSceJRWTdmankSL1Ho9/TWKKbAmaQID9809U1EscNNBs9TYdVNHvmvt5lulmD4XhHWhZjgSyBrTymFui7tRf4Apq7o2NklXI6GZlle96g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 00/10] Convert all drivers to the new udata response flow
Date: Mon, 11 May 2026 21:09:29 -0300
Message-ID: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: c759dbb7-df91-463d-f76f-08deafbac3f5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	2Dv503WCXfQwUryi4EXqCwtt+U3AkSO3yz29RIFpkp3J7TpiDz3o9lOCF6AR4/akVCh/vDvphUkQ0yj8cGX2Gb4vkXO3/N2MzxaRxOjE+0J3Vy9cvU4msjbearlne5si3mAEUucE1JFGaWYsCOMCSTuxzPdEaPGJydf2gvXfPFUEdEET7WDfAVOxaCIuzJACSQxU+HKsD4Q3WbBzCln8VuWPLT2Ii3qqXKjK8YS8LEiR1oMhA1MT/8mL/+pP9NOKwC3aNALUsyJn1E0ziJr9I3OTXQkjLu3SubofhTVn9J0bSuQN+LN2BTZh/bmEACOyp98suCMgAIwRacum8vozI1KzCO7un4Vipp/QjcS0KiFpyKSl33e1J5XA/XfSg+5IHpTLlqqHrfhpdsbdo6Q2K4DO3PLOPQnur7WEo0tTSEJJNt40SijKYf8xm5tzusY2d+foXLA3Uf1iBWNoGfWemdoZpBEIHIdfesMEcf2ZDC0Q9R62DbMKwzZBmSSw5qyNoPQUBxmHRIu44HBawsz+1mIKjm6S+Ye0KiXwmE77YmVfkAPMLzSymhlvAy69sL03ioVzVWyjgCyrkw4T1EHsJQrnx6t9xNOYTk1MOFls/YxdUKOx7rcGDNTiVWDKc+wBh2E6JVLSHNgF7rpiASZYyz/nZYV9CzWfjpvuQriYGl6tiVthAMQFwhakVz2xQL+cRqqPV10+eTXYO+MpJOZSbV8iSuTbYlTtzrMt0ZbmmYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Lfjx91FQjTFlQROeYgQdXUdJTLOMLGH/ze/HKbB3aPL6LAXzaJ42g+2u0aS?=
 =?us-ascii?Q?tUSFtEk/ubHyQ5PRXTkdCeFW+CxoC1VqtmRZozLfuoKUo7jZKUBSJm/Vsxx7?=
 =?us-ascii?Q?Xvi6g+RKkB+sJqmaelophlM8pdV+SXpnl5NrQizysWrfOJ5IRZCnbHJ0Kb6d?=
 =?us-ascii?Q?NC5RYknhTcqmkOpxlhHjRKIn8WOPMefjy/NYd9QLxntMCJyX6oQbLh27CRe7?=
 =?us-ascii?Q?ixeWq0mEeoG3ZiVXb6MxDG4OMaGj9tIqxtvUPjMLoUxk6MexwpOUbfAe2H0K?=
 =?us-ascii?Q?rCgglT6O+VklItjAVjBmkagNrJHz1XrNtA+DjqlfbRi+3c5DfVD5qfobZ/EO?=
 =?us-ascii?Q?+OIAFXpJjx+EmTLIfVmCBaG4autllQqxfBniPjG/fFr70pegtateTsJPyIYK?=
 =?us-ascii?Q?0IM4ZrExtwMbxmT1yolMr6BHu7tmIctHU9MOxkO+bFkJKJ/QBAWqHszoEgTa?=
 =?us-ascii?Q?ySxJN4yA6GbkZHVgldexNTH8DkZiA0oI/jfJwpsolON3bK2mB5+CxBxx6Hkw?=
 =?us-ascii?Q?FyTAIsRKJpz5dcSUeoWejGW6SvXBxLgPYMzdgv8FNpoRc6qFVzOaJgtJnOen?=
 =?us-ascii?Q?omICbeWVGEBXAoKghnFrio9Vc/3o0nSg5QHnFPBuBV6zgGdOa6ZMMHeyYcPt?=
 =?us-ascii?Q?wFASWX3wqYVARTiXK+jBmZBWILVHZB26Ob9NDmt9j07UOf2JgrtET0fGNFs+?=
 =?us-ascii?Q?qrWjp1tqgK51hZ5pLGdawiBUlqmYS517kcmskinkSQUax3sGRb5VpYRKtBgb?=
 =?us-ascii?Q?1vLm94q3D1Gtabo4D0PGCQ29i5QxvHiqEj0pi4TIk1yBUmoYBM/tQb1ICqXV?=
 =?us-ascii?Q?ddD3bGFnhIzYM0ZcZU3b97o684DCJQ3K9rd8wxL+jD2J5f6neBCHU34fOSuO?=
 =?us-ascii?Q?5q0SlYzSvRB/t9GQBm1F+mNXn3Pyfw1rjROmpbBlJd1jpbg+LakdslFplocZ?=
 =?us-ascii?Q?upLgiEOxWwQxMnBTEFNAG/ZU7iv2gtqZrw0RqvY6ye2jBOsOVXLWjXAVo0lE?=
 =?us-ascii?Q?Yb2k39WfqabPoicHUNUzNp46j7LBlNAiwCCMHRpIg5l1q8iZ1TUQhNyOGPP0?=
 =?us-ascii?Q?2GIiJJmfzNg8f4YwnJVSXFw5/bjIyRtboNYJnqVWSjs4UCTcWlh2mboHPbJA?=
 =?us-ascii?Q?bdNKagTjvhr/TeNb5NPZExVUMXHWooZKIrX2WVWBF/amkxfl4QG1916Gx9mh?=
 =?us-ascii?Q?KljwFsTqZuOFWmxEb2kKJnC0pXhXfV+i4DQjEo2SpsthGaonRvT/omhmP1WS?=
 =?us-ascii?Q?3FR73GQvDs9DOCSgEWw7ENAmsQWdpaV3vBZa4qdOWjENrUg9EnwQ+/oVsB6f?=
 =?us-ascii?Q?F3rk2HaW1mVjGuEuytWcZ5/atrjL1IvfdmNODd0YKa/2iqYRZxa7PrnIa4A6?=
 =?us-ascii?Q?KmCDXDlod+lUP06O7gEzb/PTy+wlsYf0Pq3ijAncwUCh03VOJ8549rLoYJ9B?=
 =?us-ascii?Q?1E7P+y/MBC7wmTZCS6OOTDLcx5uDSPjaqrmm6rslG5bSdt+SciE7pzW2TQOg?=
 =?us-ascii?Q?nIMTJBaUlJLxBG8376Oej/MgOvZJmJvgTP4MZwz3Q+5Bot1fdUBbwUlVMAXx?=
 =?us-ascii?Q?YAaC7/Hvd3U56Ah/jNpYI402Mc3LUbswibIKDocq1F0yFYksKHtI8hzqCZXl?=
 =?us-ascii?Q?BZU+UpW/HiJ7JOrgPnb9kttINfQEKABwns3TdQ8vfWwEvnZqOwBTMcTIoX2J?=
 =?us-ascii?Q?Jzqj0GgBKz3UJsgKG2vBFjEfp4l92iBn65GkPD+qu1i6EwCi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c759dbb7-df91-463d-f76f-08deafbac3f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:42.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjMDUFGBUVEzTATvoHy3o9tFX1ycpcCaCgPNaDYA2PzOXBW+2d6Ry6iJh2B7zKBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: B3323517C00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10764-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Go through the drivers and migrate them to use ib_respond_udata(). Remove
debugging prints on failure paths.  Ensure the error propagates from
ib_respond_udata(). Use the = {} pattern to initialize the uresp.

There are a couple of oddball cases which are fixed up in their own
commits, but otherwise this is fairly straightforward.

v3:
 - Rebased to v7.1-rc3 which has the error flow bugs, now removed from
   this series
v2: https://patch.msgid.link/r/0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com
 - More patches fixing the pre-existing error flow bugs
   found by Sashiko. I left the rvt issue behind because it was too broken
   and scary.
v1: https://patch.msgid.link/r/0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com

Jason Gunthorpe (10):
  RDMA: Use ib_is_udata_in_empty() for places calling
    ib_is_udata_cleared()
  IB/rdmavt: Don't abuse udata and ib_respond_udata()
  RDMA: Convert drivers using min to ib_respond_udata()
  RDMA: Convert drivers using sizeof() to ib_respond_udata()
  RDMA/cxgb4: Convert to ib_respond_udata()
  RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
  RDMA/mlx: Replace response_len with ib_respond_udata()
  RDMA: Use proper driver data response structs instead of open coding
  RDMA: Add missed = {} initialization to uresp structs
  RDMA: Replace memset with = {} pattern for ib_respond_udata()

 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  2 +-
 drivers/infiniband/hw/cxgb4/cq.c              | 11 +--
 drivers/infiniband/hw/cxgb4/provider.c        | 14 +--
 drivers/infiniband/hw/cxgb4/qp.c              | 10 +--
 drivers/infiniband/hw/efa/efa_verbs.c         | 87 ++++++-------------
 drivers/infiniband/hw/erdma/erdma_verbs.c     | 13 ++-
 drivers/infiniband/hw/hns/hns_roce_ah.c       |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  3 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c       |  8 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 13 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  6 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 +-
 drivers/infiniband/hw/irdma/verbs.c           | 48 ++++------
 drivers/infiniband/hw/mana/cq.c               |  6 +-
 drivers/infiniband/hw/mana/qp.c               | 22 ++---
 drivers/infiniband/hw/mlx4/cq.c               |  7 +-
 drivers/infiniband/hw/mlx4/main.c             | 31 ++++---
 drivers/infiniband/hw/mlx4/qp.c               |  9 +-
 drivers/infiniband/hw/mlx4/srq.c              | 12 ++-
 drivers/infiniband/hw/mlx5/ah.c               |  2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  7 +-
 drivers/infiniband/hw/mlx5/main.c             | 16 ++--
 drivers/infiniband/hw/mlx5/mr.c               |  2 +-
 drivers/infiniband/hw/mlx5/qp.c               | 17 ++--
 drivers/infiniband/hw/mlx5/srq.c              |  7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  | 40 ++++++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 31 +++----
 drivers/infiniband/hw/qedr/verbs.c            | 48 ++--------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 13 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 11 ++-
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +-
 drivers/infiniband/sw/rdmavt/srq.c            | 19 ++--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +--
 38 files changed, 225 insertions(+), 341 deletions(-)


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.43.0


