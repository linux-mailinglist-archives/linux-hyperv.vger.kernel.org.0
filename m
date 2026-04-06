Return-Path: <linux-hyperv+bounces-10026-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC9hKVLw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10026-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413423A5C9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2D0330233D2
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB113932CD;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olMFBvD3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBC392811;
	Mon,  6 Apr 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497258; cv=fail; b=dczUE9B2Hcb4NBQuscfJm0yJgC083PQWgCCFv1pVvXCnSq9AuhMkCkCkPPnWEwejDwxc+m5GICBNmD/N7pxGihbnjE+hgPN10a1lSSYcPEXuusZnktXxXBFXuRqR5dCCfOv1k+65jZ3kmjqeaggysrqd82GZ45+87GtVGiZ/5Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497258; c=relaxed/simple;
	bh=GllkTDngXPx9t6Ewgarxko8+TFVBCw0VryF3liy2WHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mm/Zj83Zmk1Q5w9eBWApgb/xxjfrv/647vBpoYKdF0ScKIcRQ/hpDHs3fniuSoLiWIL7FxvjHdPk98IMWEOgfouSoYENAPTU8YGAEgRYDzWB0NB6eFYqs76PayrH/wfOgSVbDBeKYyeUBi1fbv/jvbonxTE54TdaWBXd8wLugBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olMFBvD3; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNbm99O1MGIZKL8FJK+ZrE0A1EGrxn8a4utHl7FpZ6vpVHT8CaACzJ3SPTeK95UuF2rcfflRDt17QMcuW4kkTZqsTGfrR4Jwf6z9zd2zIZ+n8w9vtZUJIq4kywHpbsM8G2Jb0Vn/CESycpIs3tLryTmUoV7tKkaJ9roF60feM0zfFBaBKppzpLJuhWuyaLKs1Yf3JaLvACkpRctdrq5HBP4EEOwOLPWPa16y2/V3zZirMGB7C6KKTWjhJ/x4TskjB3H/NFBDgu2sFYp0hLlVaIHIDa8ZGvzlOiyECJPsXBY4u6dJRfq2zi6wtB7fxT5zFZlKSBH86ksdoimjkGNDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLZ8CeaTK8I00OzY5/4W7rbvk22vhqfaSSwJU9tkzsM=;
 b=UZ9xyeC9B6A8hl6xKSkWNPuqhjqiV1261eEBHYVYt07lHj325JbnZ6ofC4at2eAkfdiYs06UawOYEdEzp0PJDD8V8+ARH0YmQB3c2a4Lncl4qEcziobOj/NxKNJKzk8mBclsXV7rLEhZNgDdYJhhe90wswoPPO/SF6+C+dYrAY0dXuS5GOtsqIcAgnnLTBpKXWm/6Jox4uVe6dwJ4MYEDpjHqFcp/N9FQUmDg0l9kLjltlHgrp/5G0knqhE/PhusfxVz1c5M19QmA4uz8S2vwfYpsL86VjIo4NdpWoESwlzN/aolvhEuSZf4J8huPc1KHVD+287+U0sKGCHpOyZD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLZ8CeaTK8I00OzY5/4W7rbvk22vhqfaSSwJU9tkzsM=;
 b=olMFBvD3l6bXPwc4hKAN/OOKnXKvP7Qv1Z+ux/h3obQBz1xwBxBzLRDPz/96HGGcgG5EYYIs80oE4QglVaa7fMwP6YwoWBRZlYDFe2m9adfPG7GockwsEDGJkf7C0SqqW1fZmsyQasM3obigjeuCoxhEOSu7hQDrnqRRPQUCvf7P56h5wDCDJ1CxlNynVZ8q31/zsZhI0/NHvYK1Tvtjle0nKdOMRD/lHApCuLIVyTYvllGecvTbxWGLrifZ7PZVQthQLpqQEsXdbJcFl68JVmfOHcFFxtLJaJZF+kzjbVDxkatztUeZ6+EAn4IF99vYyhjtH94RjXyo6rPkCIr9wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:48 +0000
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
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/16] RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
Date: Mon,  6 Apr 2026 14:40:26 -0300
Message-ID: <1-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: ff64608d-75ec-417d-243f-08de9403a242
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/4Z0wprvSUvDo6B2w4LHsLUdaF39uGB+wh/vjE1a05aLxYgDmGnt9TetdRtuBRVN2e62nmrXNjC2zoS7DBP/tlFMmcF2jOgIJgtjIainbHt0OP1u7h4RHDITnAo28GtjEDf6j2ZZIgE24wHYheVP1jy5iD5DRNrx3VxWiuGNKoloESQqfAYFmssnIFf3xTEBg5hH/9U+l77PML6sFg8xJ5WTvcBWysNIcGy8FHybJu5bHvDc2dswgw93HLGZtjY+Df6vhj6utxuE7N9jcrq0YlwS0B/mppsE9B51AvShuVhePBgYBh/4yTSeOU0r3wgSCBz3IMWt6/4pRs0rQWq20kGu4KQ07Y2k4+suEmMC7L9LS6mWETtdpIqjdMhkuNN7kltQ8xlzUmynz9S0rn+fgVjuUlJmihwCPK0CGbMHBC0/PsVl1KYudxEP+mFTqm2ud4Cf1JJABNv+fCloqsn1WHp6ks4zVBrC6POv6/ZpbNFIVTMXWnFf9din1HA1zX9/3RujFWjKUIxKFcKzdVKNBPs9zPKbI5gsrbdcQhDrggF0fpapk1KOBA9S0UfEs2z0ho1/c7AyMaNiqWy+uEBRVDJT4hOfb/pgup/+Im2h+y2d5yKs/JqcxEHabIQHhJ4gdA3eWsOjgItGKUFqLhf1tlhNogwXi2dvnSDjamhqwv2l9rbFEFcozi7rC6NLT862hq9OJY5hKHOMNcSY+1QaPVutvzbFAyFrQmqW3cXF6vib4gHpjJ8l/sbxbc+UIfxL3uioU8MD/2unw59/LeaBeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I09K9CH9YEe2QnKizUqu7gJpqwyVuj1tT7L5Dg2VYYtay8Q9ojMM0APpxXsD?=
 =?us-ascii?Q?sGPWBeCNkimPyfbBgfASs15m3zT94pUAofM/J2MEooHJ0xYdfHcuHgl31xn3?=
 =?us-ascii?Q?O5mnOPpp5leCOjRiqVxoxdFTZyTuH5fxS3l7iT7RTIPQ6/Ch4ksE7wRAGncr?=
 =?us-ascii?Q?xZcKVSjtMzxjc90V6dCDjUSEBHy4g8WxmP3+kX0VV0I/C+9ATPmb2rotupPp?=
 =?us-ascii?Q?ffASbtsS59I6iyxW0zfuRfj8Ul4Htxdb9G8BRSyN+wocdCfl4G/DiEaWkZvM?=
 =?us-ascii?Q?R/ia3UAHRKNGsK/nKelCX7J91euPFQ2FQAIi6mtVfDLoWUqiMYgSxb1BccAR?=
 =?us-ascii?Q?mZYiq3Jcly6/sEYK3tvloM0fiU5S0yANAqyhZX/gfg3Lx5NYNGkQuM6WbqmD?=
 =?us-ascii?Q?AQyrCNIPPnzvpkDj9kdxU9wzGCy7QdFfEmGHC6LvUEhLEOcTB/EqLkhokCpj?=
 =?us-ascii?Q?h23a+H3i0QjOnJxQmtN639EKgWA2OvbkmjJq5ryN+vSYpsb0Mao7w6P8b2di?=
 =?us-ascii?Q?tBdo9Hm7qlnh3DQB6D3OtklC5mK+zaOJt+xAMEmM/1xqJT9mWWFF/h56xK5d?=
 =?us-ascii?Q?2V8P9bi4ANNGAWqV7Mf7544BQ+QOQ2TrRRb7Du/BjzXAMWGnxye6W0qw0w0s?=
 =?us-ascii?Q?3h5TLzEW9DUmXFrMrqA0nY4OMcujQNebmjvNSid4IuEk+fUazgJM02vX4rpc?=
 =?us-ascii?Q?qEVTKDrlNSCfkROgBRyXe9HC2DWjzfE3YoxADawXCoVNxGYs6MKlvpjX38np?=
 =?us-ascii?Q?06vZreCAMLXynSJcQNphRX1izrfdVMOM5djHX/59VdTL11WzWK2l9EocqQQo?=
 =?us-ascii?Q?/DQ0NuitEJxCjHQrNnbqwv4OyMcFxtZJIFKwCKA9Hm0Seh8rZdyzHTpjQEy5?=
 =?us-ascii?Q?rudXNF4rJuKfdCrzH1lsshLlZVA7NwtTJCnr1d5uvcPWOyYwM3DhOOkBcWp4?=
 =?us-ascii?Q?KudRuirZMVzuKm30ruHu9DCpvYqIwIT2fp4gJPmXGeek8kPmXQHtQ8PwyHBS?=
 =?us-ascii?Q?TVgMhqSzHiHpTkBBpfTkADAdHqcD+kUfDa8ztrfNqZ3LiPhElm/IlaAPKqVj?=
 =?us-ascii?Q?pE2bSS2EhC4l01mH0ogUb7dwFYkcbOBIoiTE29Eygt8LA7y9Kodjxa5LRA/G?=
 =?us-ascii?Q?oTITy6UZD6rzFybAcOCnH5kBQVb0fqFz2ZK53Ak9IbOQDYH8TRZUYA3Zd7xa?=
 =?us-ascii?Q?bRwsod2KpmMhHgL+GZSnRSUvM+92q+LvlzHepzEjH41r1/YMC4rvRYVQQkMC?=
 =?us-ascii?Q?FPlAe5pIUyAFzq67XteTNZxSeRKhK8/1BZv6Vxw/ieWOQqSxzktvDHmdBuI6?=
 =?us-ascii?Q?+b+pW1viUUsUA8WZ9+oTfsuge8tCsAwd9X3gFrEJ8A+tTRNJ7J7xMlNElIbr?=
 =?us-ascii?Q?FOA1z5Aa8LPphxU5W2Gf/bxwnrEo03htRq7X+T3NoRDRxoGnJZfZ0qydyz6d?=
 =?us-ascii?Q?xGZLMC6G1/VEJ0nVVcz/4GDCVHM7UlSJbCQtfQF4b8QxutR+2QtUMCU7hTwK?=
 =?us-ascii?Q?sb7lM5YkGvcvrtGlUhDTWJL0ZRoBdQmrn0G8jb4Zew6/GuU660anJFBkAD5+?=
 =?us-ascii?Q?XyKsqGuMgrFxwaGYkgkyCSIvTtJ9d59rTIzZXs84fad8nIWzILOdITGQMs4u?=
 =?us-ascii?Q?1VeAcGFsryuoXmX/9NHTKegMwKzCNJQrVFr+fBdv2D7AdicVO7+Ee8oNnRGc?=
 =?us-ascii?Q?n7jbJO6ExM/wag2DBA8YrhGz6mI8z+inoP1tTM5IzvRxNdYG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff64608d-75ec-417d-243f-08de9403a242
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:46.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQbTTdAnm5MQ7Tzr4ooWh59Jp1A5WUqKQMwWplGx2vdBz9vyCtQbHtZaPJelh9DM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10026-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 413423A5C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out that mana_ib_cfg_vport_steering() is leaked, the normal
destroy path cleans it up.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 645581359cee0b..f503445a38f2d8 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -215,13 +215,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
-		goto fail;
+		goto err_disable_vport_rx;
 	}
 
 	kfree(mana_ind_table);
 
 	return 0;
 
+err_disable_vport_rx:
+	mana_disable_vport_rx(mpc);
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
-- 
2.43.0


