Return-Path: <linux-hyperv+bounces-10013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMegNAej02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10013-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D983A337A
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4A18300FB4B
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5503358C4;
	Mon,  6 Apr 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ir+YpS/l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BB3358DA;
	Mon,  6 Apr 2026 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477506; cv=fail; b=FeqZNaBWq1Xv+BpwwlprA4HeQlCfZiWhRTihgOOW1BwzXao+bZKBgKwnSw/qiRmWHTZ/Ew1usVjvYDwmnqOHEiGU/mSCHwvwrjuNYssAIbzhMJk92daH7mA8kfMYFFpmCwTJaCvEm8BCeKw6KVmPLIrxdQLqy8UmaMaQ/n2cn50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477506; c=relaxed/simple;
	bh=vrQX/FKmSLENzE44xYfBWxTgeBZDC8wiAtRVq72+s7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YR7QAdZ0WGibLcUbHTyRQyEhg92RBc0N4bbA6SgVTQkiTYHwG/gqX+g+zxT94PSn3wmqqIqL2MSytFxcEo2pLxQNlD46vMmpPHccCYMKCP0w67YxHF6uvVSs7Xs8j5jYMWQq9CoUJb8oOA/DC7AOLGchaHJj49fqF0Mb0SxVaz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ir+YpS/l; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFjWkn9jcJqhgDIEsbQZPA107XOopBxHiEa1DYFxmVG20xfSkm583/N6uJcyuj2T6HSMWShLLs9DqJ8+g+JXL34wOdgc+q+7mXSz0q/4J+DTVr4/HbalxE/O95/ahBy2RPF3yew5fQWj5gxu5OM/pecPHb0i4bd2Mweu/NEAoz4f4SE2cXZBauwQiw0tsplDjOCnAUDjd7hYZHkwYsiajFSfCYSLLIze9BcmbCFHfu/DU8cIYCZrwbKqvr81pC7IU6RscPDWUDVlxgxdsoqHgYl0yM7hkLS89qd0QN6ugT1+ldfhO+4MgjFmQZPuVMGhJX9Y2+PVXDDKV82lW8p1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiyv+xPmO5BzB3d/eKCFdP8RIcQcKEZ5P+mYEpWJuLk=;
 b=vUJEyPvtj9I29hMDAWyBzikKKLpXrIhe1Th/3xILJpdUGHBPRLh9NJueSejGy5MJvsnXNgFQBJ66b3+pPH4OLvxwgBMxb+lnd/cKNGhqRSRcR/K4U47nMcDMEuBv6QiPfLyw3gius+Sq1AH/QXCyATxtNO2TIc2bqqiLHc8Hy+mTFe01pSNKp2cPYNEa1dsA92UkJwtb3LcZJrIr0IWQPUwLvAeOu1kSIliOT3JapZ9W853hHLi72elKI7L4zQb/f6Rx3wBhfbcg9cbbidRfvBdQ1qZpWONOoxgligs30nga3vAlTlZ0APbIsikL+coDMVL3gt2KmF7b4XF4G6881A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiyv+xPmO5BzB3d/eKCFdP8RIcQcKEZ5P+mYEpWJuLk=;
 b=Ir+YpS/lKl9urfZYpCbW+FRbiyiSW/gZbRAnZMWoi9Em59cxVsinqSv+18pIAcKwrOkWJGNctiz1q0XcgGxuI7iEkhEmhNxVvhPhUZul/sTrkAOp7H/qHFgyiGaNrUy88eR7ilIc27Cvf/HG40mHfLPERMEdW8Izw9OTvKPEvtdOSTsTE3Lj4/xWI8VWPJZQWyiVKtVhwp3G6UCQ+9fdjtCzQ2IUsUdl5qeWycTxFY8WXXo0aMHqepIoYkyZak3OcAMmJcrDIHY16bKwhevLMz8+TcHzeZuj/HJfex5fGycFl0LS7gyB3bT7Bb2lVyHhvgO8djHxTEJRUQLdkXRyNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:31 +0000
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
Subject: [PATCH 04/10] RDMA: Convert drivers using sizeof() to ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:18 -0300
Message-ID: <4-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:52c::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 70885dfa-7e87-46db-1233-08de93d5a134
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	pQ6LgbY2QUK8NeXtYLHRSeMqCdFoueycvduu6RWxiXD5hGf2+8AO+rlyJgkA0oDmlL2oRbqd1FUMFKgEMIuVOKvj/zBEKqfChnBTxdbyyzeeUKWCRarFTAXZQ87dBQAzSi+tX1gWyPkg9FIz7upPEfmZEhXm0T9mvyaITSv37OZn9eCMirTiwBwyCeOEpqpXlDv2UIFZjHOPDGcHQA1F2+s90BikUTFaEq4fGUmiAcYkazGSefjJLknnwn4O5piz6ycrhbu4Wm7sx9M840Eo0uxZzk1P/ne+IfYJgwjPmAViyI6XndC5cnbG+39wiwcnszu9DhDwRFajUUYVCN7Hc7uGAOSgwdBuF/eDfJfjHP8v3ojDdoMjOWl+yPer6gXaxGMgjIJkS36q4GmRH6J0Mp2ylIHWDIX/o6ukcnQBOeqsQGOI/F+xQ1i63P7ez1WjMEpKmRT5USLNAWWpx6VD+4pE2SZP80RpQlIJWlvPenbAkZJVaZHQIU789OVsmpwkNbXFgWSXAnaTzwsHuqAjYarAm4ytUEcMOnccCM9vDUN4j/70+p67qFYLz77Ta6QbcS6OJ6CGUyPnAGzrWTm/MbtRQsOudZruq/qpdWlWlRespj4YPJxvn8FjF3VkQQx39uIkkJXDLzECTiqP02YahOlVeUIBvDrjWQ2vFbA/tVPPOfq+rjnxVdFVmIMO+FYyYQsBPg8aBVgL5aCXWh4J4LhoX2U9xPn4ke8kbqgebzIHlBz9CBB2I3MsFLrgc1Fks1dDs6KRY57XvxThWiMWSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvdHaxpj0eMfc+A0iLcbVzrRBKWYqvEp5EB1J683wEZn6FSTafkuGi+0Uf5P?=
 =?us-ascii?Q?09pIM830d7aUa8iGKs8LKXu+pGtkBMX+je6YoMlwE1xuPiMGT4f0wWuSKtT/?=
 =?us-ascii?Q?jkhhGtsv/DySCZ+fI/i1Lxi5AUt7Q+amYap4vdLKtdY5yIDbrgqUG8qxy06p?=
 =?us-ascii?Q?jBehNsoAsipCeTrw5ViWFgILZ6bdlriid8Wvmab9q2KfQnDY9AIUfll/7QPB?=
 =?us-ascii?Q?Uo6NGHJh810WQs+3yfoBDkqo2pUUpGkAUkzw3nj2VEN6VFaHaRoAHQsAaWa8?=
 =?us-ascii?Q?AJvG/BWX/JZMRHRN+L83Nh2QlFEKDAMJmOwpwq6LwhRXTJ1Zmx1Z1MWKOaur?=
 =?us-ascii?Q?AsrwCyxNC6+G8R1Wi8t/gR14N84V/EllFKMtiSx2PTZUNUzPl6iRW5VY7/XU?=
 =?us-ascii?Q?o0knPHY0H2z3kTODv/abPgBli3nXOUQjJkIww6q2HVfkNgAAR4AsecZ4pD9k?=
 =?us-ascii?Q?7TbnM6ttkEdLq6V5bovMr6FIwDislOXK4y8/3m+wXq6V119agd6zabXQVJfy?=
 =?us-ascii?Q?hqhpQjHWAD4YdeAdtGmOkYuuhZAWmNWJIlHcFM1un3pcSD56SHh5ADxiSeIx?=
 =?us-ascii?Q?nosX2KRQOR5kokRpi1hifZrN9Hy4ieh9y3z3mLfQlSDcSCKvvFo6V8EljuEq?=
 =?us-ascii?Q?au8zS5KPt1vfRkU5xfrCMd5/z5Kz+HeR7JMghjmBZrnJtAJcVxTWGbO9knrs?=
 =?us-ascii?Q?g99W2q6S2SzJAKEJcp06g/FRqgf+z6gs/KAqaWGP4qNmd5vQWGcne/ROpF4k?=
 =?us-ascii?Q?LUp0LQ2EHk/3l1N0fHrh/CmK90KxS5p4EHA99fEnj6eZo4CA/lOY+ES2cWGW?=
 =?us-ascii?Q?3E40wSH9mc9t4YhrZyrqjpp87fYwqVmEXYcamIiEI7ikvJloV7TsR9S3KR0y?=
 =?us-ascii?Q?ksbcVnfRE48bWCNqYdrnA9CcZ8puT5NHkJty11iGqgq9gz6TPQY5eJQXw5nl?=
 =?us-ascii?Q?EwjPipurbS7kFiXgi+kQEjv27rblgV0Zxlb5ABZePpGMXa1tTElPpzdZkZbv?=
 =?us-ascii?Q?i8lTwQsVWQeRFPQ+fod8GMRGKqliT6KBgihp6XFMeWo1ZdVz+r7WzfEb0nJ7?=
 =?us-ascii?Q?iAAjDAB/ReGzZ4006HqPnZKoJuW4p9piQt5Y322enxNrzUgf+YZE4PIcTNEx?=
 =?us-ascii?Q?2kCAPn8XT9vmoFdlJ51qI0O/Lur4Zo9eD4+U0IWKhfAWjqO9/12J5VD9T9sA?=
 =?us-ascii?Q?gikWfU6ONexymB+c4+xMTckx81hJnHfEoTUH0sJ3SkWzeCw9ueGELXwLFtga?=
 =?us-ascii?Q?iYvo33zd488x9cMFuv2slpLBLs60z5T7Lr/+p/sk/MV8fmu/jqMtHfk67czK?=
 =?us-ascii?Q?aE9Tx41Oa/zxZcKB/RBwJoUGkcKRJkrXv9Asroi8BB/PnO+4cqbH4HLnG8ti?=
 =?us-ascii?Q?PZ6jLLWGNn/kYXHPSd/jdpRSwITB5IuSbJRfPa8mR2nEJmIms+Xs45JBFASl?=
 =?us-ascii?Q?H40142EWQyRRh4+UJWN6l7i6NEbY6Ep+oHj07NVfw6r46FHP2mmj7g4adlRh?=
 =?us-ascii?Q?5Cpt1/UGAWBVoeILL63TpXhg+qg+rKBrN1RS+An5cLr1fMOZg1bwTaNSdzVp?=
 =?us-ascii?Q?aRpq60svWkzPBvvircvm3YwtnqlXMKu3/Eozi7SYT10DoVAxeMxJtih7qNgx?=
 =?us-ascii?Q?TMHtwdXQIgBup1yBWOAU1tColmq9jkTkeGVuwgLsAsvIQa5u2BVJHD5eek+4?=
 =?us-ascii?Q?RmNrIZD+QEBm9KQSDG8+L1kEqROqZHFmbX6jC6bNtIEdI/0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70885dfa-7e87-46db-1233-08de93d5a134
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:27.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb6sAVSb07yh2w8Lk0xw3pk2WOw+D+4DqJPmxncYQJQ5a+GIA0sYr8mmu5TQw7rA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10013-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 91D983A337A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

    ib_copy_to_udata(udata, &resp, sizeof(resp));

Using Coccinelle:

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, sizeof(resp))
+ ib_respond_udata(udata, resp)

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/provider.c        |  9 ++++++---
 drivers/infiniband/hw/cxgb4/qp.c              |  4 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  4 ++--
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 ++++----
 drivers/infiniband/hw/mana/qp.c               | 16 ++++------------
 drivers/infiniband/hw/mlx4/main.c             |  8 ++++----
 drivers/infiniband/hw/mlx5/main.c             |  5 +++--
 drivers/infiniband/hw/mthca/mthca_provider.c  |  5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 19 +++++++------------
 drivers/infiniband/hw/qedr/verbs.c            |  7 +------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  9 ++-------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 11 +++++------
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +++++-----
 17 files changed, 56 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 616019ac1da501..a119e8793aef40 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -52,6 +52,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "iw_cxgb4.h"
 
@@ -209,8 +210,9 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct c4iw_pd *php = to_c4iw_pd(pd);
 	struct ib_device *ibdev = pd->device;
-	u32 pdid;
 	struct c4iw_dev *rhp;
+	u32 pdid;
+	int ret;
 
 	pr_debug("ibdev %p\n", ibdev);
 	rhp = (struct c4iw_dev *) ibdev;
@@ -223,9 +225,10 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	if (udata) {
 		struct c4iw_alloc_pd_resp uresp = {.pdid = php->pdid};
 
-		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+		ret = ib_respond_udata(udata, uresp);
+		if (ret) {
 			c4iw_deallocate_pd(&php->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 	mutex_lock(&rhp->rdev.stats.lock);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d9a86e4c546189..f9c7030ac6bfd0 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2280,7 +2280,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 			ucontext->key += PAGE_SIZE;
 		}
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
@@ -2777,7 +2777,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 		uresp.srq_db_gts_key = ucontext->key;
 		ucontext->key += PAGE_SIZE;
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_srq_db_key_mm;
 		srq_key_mm->key = uresp.srq_key;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 9bba470c6e3257..92a65970ab6fa1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1055,7 +1055,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		uresp.qp_id = QP_ID(qp);
 		uresp.rq_offset = qp->user_qp.rq_offset;
 
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_out_cmd;
 	} else {
@@ -1571,7 +1571,7 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	uresp.dev_id = dev->pdev->device;
 
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret)
 		goto err_put_mmap_entries;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca9420..2b01345848ddb7 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -414,7 +414,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	if (dev->lif_cfg.rq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
 
-	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto err_resp;
 
@@ -752,7 +752,7 @@ int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	if (udata) {
 		resp.ahid = ah->ahid;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -1263,7 +1263,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (udata) {
 		resp.udma_mask = vcq->udma_mask;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -2315,7 +2315,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			resp.rq_cmb = qp->rq_cmb;
 		}
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 1538aec6d85ccf..c50a1eafee58c8 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -210,13 +210,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	if (ret)
 		goto fail;
 
-	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy to udata create rss-qp, %d\n",
-			  ret);
+	ret = ib_respond_udata(udata, resp);
+	if (ret)
 		goto fail;
-	}
 
 	kfree(mana_ind_table);
 
@@ -349,13 +345,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed copy udata for create qp-raw, %d\n",
-			  err);
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		goto err_remove_cq_cb;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 16e9ce8138cb30..ce77e893065c92 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1121,16 +1121,16 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	mutex_init(&context->wqn_ranges_mutex);
 
 	if (ibdev->ops.uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION)
-		err = ib_copy_to_udata(udata, &resp_v3, sizeof(resp_v3));
+		err = ib_respond_udata(udata, resp_v3);
 	else
-		err = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		err = ib_respond_udata(udata, resp);
 
 	if (err) {
 		mlx4_uar_free(to_mdev(ibdev)->dev, &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7d435cf5a2fdae..57d3b80e7550b6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2791,9 +2791,10 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd->uid = uid;
 	if (udata) {
 		resp.pdn = pd->pdn;
-		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
+		err = ib_respond_udata(udata, resp);
+		if (err) {
 			mlx5_cmd_dealloc_pd(to_mdev(ibdev)->mdev, pd->pdn, uid);
-			return -EFAULT;
+			return err;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e8d5d865c1f1f7..07c60797c86091 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -311,10 +311,11 @@ static int mthca_alloc_ucontext(struct ib_ucontext *uctx,
 		return err;
 	}
 
-	if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+	err = ib_respond_udata(udata, uresp);
+	if (err) {
 		mthca_cleanup_user_db_tab(to_mdev(ibdev), &context->uar, context->db_tab);
 		mthca_uar_free(to_mdev(ibdev), &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
 	context->reg_mr_warned = 0;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c17e2a54dbcaf9..083f23fc687b31 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -502,7 +502,7 @@ int ocrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	resp.dpp_wqe_size = dev->attr.wqe_size;
 
 	memcpy(resp.fw_ver, dev->attr.fw_ver, sizeof(resp.fw_ver));
-	status = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	status = ib_respond_udata(udata, resp);
 	if (status)
 		goto cpy_err;
 	return 0;
@@ -611,7 +611,7 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 		rsp.dpp_page_addr_lo = dpp_page_addr;
 	}
 
-	status = ib_copy_to_udata(udata, &rsp, sizeof(rsp));
+	status = ib_respond_udata(udata, rsp);
 	if (status)
 		goto ucopy_err;
 
@@ -945,12 +945,9 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	uresp.db_page_addr =  ocrdma_get_db_addr(dev, uctx->cntxt_pd->id);
 	uresp.db_page_size = dev->nic_info.db_page_size;
 	uresp.phase_change = cq->phase_change ? 1 : 0;
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) copy error cqid=0x%x.\n",
-		       __func__, dev->id, cq->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(uctx, uresp.db_page_addr, uresp.db_page_size);
 	if (status)
 		goto err;
@@ -1206,11 +1203,9 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 		uresp.dpp_credit = dpp_credit_lmt;
 		uresp.dpp_offset = dpp_offset;
 	}
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) user copy error.\n", __func__, dev->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(pd->uctx, uresp.sq_page_addr[0],
 				 uresp.sq_page_size);
 	if (status)
@@ -1754,7 +1749,7 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 		uresp.db_shift = 16;
 	}
 
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	status = ib_respond_udata(udata, uresp);
 	if (status)
 		return status;
 	status = ocrdma_add_mmap(srq->pd->uctx, uresp.rq_page_addr[0],
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63bc5..3b86ea1cf88883 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1251,15 +1251,10 @@ static int qedr_copy_srq_uresp(struct qedr_dev *dev,
 			       struct qedr_srq *srq, struct ib_udata *udata)
 {
 	struct qedr_create_srq_uresp uresp = {};
-	int rc;
 
 	uresp.srq_id = srq->srq_id;
 
-	rc = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "create srq: problem copying data to user space\n");
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void qedr_copy_rq_uresp(struct qedr_dev *dev,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 615de9c4209bf1..e887f03a84d063 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,7 +82,6 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_dev *us_ibdev;
 	struct usnic_ib_create_qp_resp resp;
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
@@ -92,7 +91,6 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 
 	memset(&resp, 0, sizeof(resp));
 
-	us_ibdev = qp_grp->vf->pf;
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
@@ -157,12 +155,9 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct usnic_ib_qp_grp_flow, link);
 	resp.transport = default_flow->trans_type;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		usnic_err("Failed to copy udata for %s",
-			  dev_name(&us_ibdev->ib_dev.dev));
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index bc3adcc1ae67c2..d5bfdbfe1376d1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -203,11 +203,10 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->uar = &context->uar;
 
 		/* Copy udata back. */
-		if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
+		ret = ib_respond_udata(udata, cq_resp);
+		if (ret) {
 			pvrdma_destroy_cq(&cq->ibcq, udata);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d31fb692fcaafb..e69eadde6c26e9 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -195,10 +195,10 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	spin_unlock_irqrestore(&dev->srq_tbl_lock, flags);
 
 	/* Copy udata back. */
-	if (ib_copy_to_udata(udata, &srq_resp, sizeof(srq_resp))) {
-		dev_warn(&dev->pdev->dev, "failed to copy back udata\n");
+	ret = ib_respond_udata(udata, srq_resp);
+	if (ret) {
 		pvrdma_destroy_srq(&srq->ibsrq, udata);
-		return -EINVAL;
+		return ret;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index bcd43dc30e21c6..69a89f609ada9d 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -320,11 +320,11 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	/* copy back to user */
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret) {
 		pvrdma_uar_free(vdev, &context->uar);
 		pvrdma_dealloc_ucontext(&context->ibucontext);
-		return -EFAULT;
+		return ret;
 	}
 
 	return 0;
@@ -430,11 +430,10 @@ int pvrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd_resp.pdn = resp->pd_handle;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &pd_resp, sizeof(pd_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back protection domain\n");
+		ret = ib_respond_udata(udata, pd_resp);
+		if (ret) {
 			pvrdma_dealloc_pd(&pd->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 30904c6ae852db..45404611c9ce56 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -372,7 +372,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata)
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		__u64 offset = 0;
 
-		ret = ib_copy_to_udata(udata, &offset, sizeof(offset));
+		ret = ib_respond_udata(udata, offset);
 		if (ret)
 			goto bail_free;
 	}
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index b519d9d0e42913..5fdc37bd64e834 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1194,8 +1194,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		if (!qp->r_rq.wq) {
 			__u64 offset = 0;
 
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
+			ret = ib_respond_udata(udata, offset);
 			if (ret)
 				goto bail_qpn;
 		} else {
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2db..b34f3d6547ffc7 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -102,7 +102,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -EINVAL;
 		goto err_out;
 	}
-	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rv = ib_respond_udata(udata, uresp);
 	if (rv)
 		goto err_out;
 
@@ -472,7 +472,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 			rv = -EINVAL;
 			goto err_out_xa;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out_xa;
 	}
@@ -1205,7 +1205,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1386,7 +1386,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1646,7 +1646,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
-- 
2.43.0


