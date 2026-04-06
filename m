Return-Path: <linux-hyperv+bounces-10034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGriFVPw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10034-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C83A5CA6
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BFCF300E5B4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735393932F1;
	Mon,  6 Apr 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLDZEiq5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A70393DD3;
	Mon,  6 Apr 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497263; cv=fail; b=N8yZR++seS/7v7j486/xWosqW1XmkCpkzrwJRvMedWCt3m3uZnP6y5rLBhkcxnXjSBwj9JvxVJCSSqxX1u8GKRrmN4JsxtW08jkQjAgVAd6W5sMiFn0O52OH9NCViNFq5PmUmevVZRjelZoLNUEJpf3gBET05hvyGoPAi4TB3PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497263; c=relaxed/simple;
	bh=nh2Cpk/qrT8XpVVb625OK5YFn1wWuHBlSzkqrW5haCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PntFEKWzN2E8HEy8VwnDyNUZjTmW46KC5TOawP587WSERzkb7x21XFyGqlrOa97XnM6d6pubYJVchM0/7636kTafwQ8RiYJ7LzV0BqcLaIBKo3OnKrKXLHCE/RjqjEC+hKUIFI5Cie9dAZO9P2R8T9PfWNDvHT+eLzqTEIqKQmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLDZEiq5; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVb0QKfSkNqKDY33J2ZhlYp7i0y+X9XIEB7El4UhDha8B0QHB84vO7z0asrBbeCk9OZBMl4RIMK9THn2Xq3a2e02cNcmXsa1J41sXEVQXHeiKhgeOBQUizL9uuMb2VnvYThDWaMLZNQFbTkjBwuSZ5k+bDshBkkk68VHJmUFQ5xhTXMcXAcTkqsehVFLqPp/dx9fEXYJMLtWvVEdY9DZ/bjN3tQgyMkMVbLFpniPq+m9/2zNwfQpFvadYNKICo8ZI6pXBvADTlbaMxpyMVoXh7VFPPVAmeZaGwrk7BJXgP6GyzC5HulespHf8KAfU7QN3qJxa520OBUUQDsQOlvHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI5VDLVBtgvqFV7XVBtl+PQyzb+msH7Rqm2YeeV55/U=;
 b=Japjlk5U9B4AM5pc1HCBc94o1fV9keSj3uXngtBeuS3LA8xhUUaegJOJW8VNxJhTmrb/5fGRV3lSZ6VQbRRhmCfgiivLcIuPLtQ+6ErnUOinQleMw4aY8p2OaC21HLcN2/GHmsgVvl86KQxznTifihlpq1ky3Vh7nn6T1FtYCjTJLF1vwFhtxDYnV6WmDvJEUU56KxSYqLjLkSutqN/LdMRhLC7YY0MI2J4MqUEBZGZV043Q/v0S5xGwm2I5qVrr8H0XTKIvrt1mlHbClxw/a2Ny63PNfI9ElJjq1gm1Uq7JhFzxf2lzealajqWV2M6TDuZvbs2mibt8PkMzDFFurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI5VDLVBtgvqFV7XVBtl+PQyzb+msH7Rqm2YeeV55/U=;
 b=RLDZEiq5L2tTz2FJCAyxQin7Q99u+Bcomtv/n9ksLcwydOVWYo40n8hF9KB8kXosulUdJtE+YaUpSh/p4HrET4myn+mTPqss6yIAIhxKqU6+n2rcbqiurs8sKo+AhBD9D0m++e5b2xdmK9lnEgRuekFf4oAcsV8lTMvQgj1MsRRyngY1pIZ6NJu4YUNHXvX9v4F9VtRysucO/e0u/U8WP38KNUETKVdu23SVfCGzEQFFLFkk43rb8V+qw8K8+fHMwNHjN1DXULyoStdRz1YElrM7a8IMxx7m46chqrljHn5oz6bdAz+qmbtxHb676qpW8DE1OF86jXbbc3wCbWbe8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:50 +0000
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
Subject: [PATCH v2 07/16] RDMA: Use ib_is_udata_in_empty() for places calling ib_is_udata_cleared()
Date: Mon,  6 Apr 2026 14:40:32 -0300
Message-ID: <7-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: c0665d93-293a-47f3-20dc-08de9403a27c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pWBylbyexq62A33DoL7NdFkCIwni+/zB0OWoTza4VcIK/SqIeYRzZh5GO4PtI8hZTR4cmsaHbCMlyTLRYdxTIle30MpKEV44yrt1robwKR499swTW3p8mYXYJLInktkuabkBEVd118E0y2yiacEwghm6OvFmym1YO7wlqMGjypVtqDge9E64fi3mwe6EaRLHud4M2fWie0hN2moQbjqQRlefo0Ak0oedtvh3T655kypp+WhpsDrD/LWqb1w3ZdWLYKEBpMFWpL+eZrwLbrAhGkWIctN03ZqxrV52PyNxESWpv7jucigWKJhYrhTfbChFsxD+pkxI3+/Luzp6kN66xhqzriYzxazlxzbTzVcG+LyngfXa0m0+c1UrvZuF3rFOfs96BF5jaggkjjfNt4bmJo9qjR40JNwxgUrNrYugSuPhKrudhDVS7EPVODpwGxnN4ncfsIVCw2KxrvqRA8GRNNUTao3Q3bNym4EHK2Qko9bjaiLQZ0P6miAwXQADWHq7g0iPUyKaj5LYyXN1BMhEBu4VqDR5P9YzeTa5gaQaOXgGRQG2OHh8ksQeIbpEK7O6jt/b5o6fdR8aPM8KWvm7vGlfy+TAhF8O0cqsQCESWAutOqVPDxC/Qkh/oJZPsywhyxRyfmTUz4Y3INUsr/IZgmvNkMw/+2T80xu3Yrozou9NonNtV/NP/DWkqaXRrKPqd82DHFP5hyFbGnoaUZah40xbTSsh5vqbQglb9z9LZ67jNfFDaXnpGQ/H4JqJcUfrNF8ghbSVEPaVGl14bu0xow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MSyQPppe41GqK/5FV3NrYXj0+AuraqxHP++IJTKl02zAue2qrjX3eVjJvboD?=
 =?us-ascii?Q?EfLasLIN4tAimpln5v/BH1wUYe/0InZFZHsLSnYb/NUfCwzri+lCTxCE43Hm?=
 =?us-ascii?Q?+CjpfdHqQbLVGhCnGsxTzAxsPSW3jQsQqoI+TZ+5NnrFqGycpn6JYQG5Jj/G?=
 =?us-ascii?Q?BDK7VJxJ3SallBOwxHEDM8ln5q0IIZOnkZa101B0GTn6+Geok3bwA7v3Ai9R?=
 =?us-ascii?Q?uKpigJigz5cmB8pWObJbHJp/p73P9x9PigTtdI35RgP0hjkkNftuyi2AhCjq?=
 =?us-ascii?Q?nETF3HrX55SYS31hvxMX15EH7FlQ/cNSDvDfwmS4z6DCzCK3N27d0h4a6NdV?=
 =?us-ascii?Q?f4OVH6EXp4vTCDEOnRszwrQ7misFNnMs7cBdFecmdzKqsXVPL3gwVyAPPMvH?=
 =?us-ascii?Q?pN9hjAFEEpIFNXffh7DmCJQ+ci1+jLtEsvL+giMWNy336XiOd7CoMcG2tWBb?=
 =?us-ascii?Q?4ZgNNYSxs5ZUvlDU41YaYbag//3owKvcmxS57TjqKTI0LCiOaBZgTIDAMwiN?=
 =?us-ascii?Q?QhpFZnJBTXEnsGVJ7hPSIFNiUmb1wfXD5M/pPxBk0F2J5ShX+xIcBHFCcU/c?=
 =?us-ascii?Q?w13lIEtSM1MP32zG9s+ZGoYz3ke6lx2sVtmg3/xpPyEPbXcIIiJ8YBkzCej5?=
 =?us-ascii?Q?mNG8ra//WrM9pmtodwceDObyoYzYNi0FYPs4CxuJWnYCVd0Y8OBPd0XMhA85?=
 =?us-ascii?Q?2mX3n33ZUGAgbcX86Nsn9DVwl2AsNzBX8DodoR30lbWrE0+jt238rF5OjHzt?=
 =?us-ascii?Q?D2Urwjp6N18yCaMmMgm/3edXj9MzMFbiMWws3R+h8N1327vUpgh3iDYPBdLS?=
 =?us-ascii?Q?ip+1WxQYFN6TPSfKvOqjbHaYZnDMYo55HtQamiS47HytNcR6YWIUQyjLYyt1?=
 =?us-ascii?Q?4HBpfoY0mvuduU+OV3UIhz9p5BCGI8pNA4+eaDoc8jRw98rtr9Qj2NSxLNL6?=
 =?us-ascii?Q?kGfijPS2Fgudu0Qm5MVXK1qm40A+n6rPLxUZNuFa1WM92/95TWfeq2jfFCC7?=
 =?us-ascii?Q?zzeBZi27N3Rte018afC96jI0m03d7lJQkzJv4MOWK9npgzadbaXx22O0Dnhz?=
 =?us-ascii?Q?QL5n7feicU+DQ6UpEHq2eBkOjHRE/JkSfNI3PxAGjTA/M6NQwmMINOLPGD4B?=
 =?us-ascii?Q?go2OKdGWwTZ3Gt78br5SgGld6F4PSjOLWe7Ft8JkNzBVbGfM525IWM8cAIta?=
 =?us-ascii?Q?9HWLmlILbhDtXbPScfzC7dMiXggIswhmeOQ2u6q3RuEkVpqZu07CBLpNK2As?=
 =?us-ascii?Q?KrgG4VNe3t4+/zDJDaU9y9L4YM+RDHETNdXC67Bxww8GEQdm7VHuqDToAv4z?=
 =?us-ascii?Q?XFtqLIguiYZou3u08/NK8cmcOwDwNH6fal76h1LWVJNGmW1wokLXc5tE+jM7?=
 =?us-ascii?Q?fSTopsGFv0+g+HcfsubaIw/KJBE/RvASZ+wdmavDvhrDhD0ncuAjKXfUnUXX?=
 =?us-ascii?Q?L7Jg15a/mY6xYS3Ma3zoMOEvUcHNtFBElaPlViFHR0DIZiTNZzGNmfTPxMb5?=
 =?us-ascii?Q?WNnO9VD5FnJryYugqWoW9xzJ/yIoims1KVYcBuTNGvmH63vHE398MTmIShdL?=
 =?us-ascii?Q?jyBaYmXkVEJNoH2GoQf+z2ZMCQMsH78tkBVpoWPV0sL8rVCI800wFH4yHVyN?=
 =?us-ascii?Q?80Fh1bf53maKY9ZVZS8bXozlnBzTkRB5jTUvPd2I78GCNRhmbEMlflZWKzJv?=
 =?us-ascii?Q?rdTFT9YoyUzCBHw/C8hMFQdYhwxvKo4fwP/JfD7/lniZye21?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0665d93-293a-47f3-20dc-08de9403a27c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:46.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syaSUMZ6w7j2LVD7HULGOjOZ3Q5UF/q6VqwwlP7qF1wGPgfpNcflnRHAPgwYSZjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10034-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 1F6C83A5CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

  if (udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))

Using Coccinelle:

virtual patch
virtual context
virtual report

@@
expression udata;
@@
(
- udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
|
- udata->inlen > 0 && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)
)

@@
expression udata;
@@
- udata && udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen)
+ !ib_is_udata_in_empty(udata)

These cases are already checking for zeroed data that the kernel does
not understand.

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 43 +++++++++------------------
 drivers/infiniband/hw/mlx4/main.c     |  6 ++--
 drivers/infiniband/hw/mlx4/qp.c       |  7 ++---
 drivers/infiniband/hw/mlx5/main.c     |  5 ++--
 drivers/infiniband/hw/mlx5/qp.c       |  7 ++---
 5 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99e4..3ad5d6e27b1590 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -218,12 +218,9 @@ int efa_query_device(struct ib_device *ibdev,
 	struct efa_dev *dev = to_edev(ibdev);
 	int err;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	dev_attr = &dev->dev_attr;
 
@@ -433,13 +430,9 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_pd *pd = to_epd(ibpd);
 	int err;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	err = efa_com_alloc_pd(&dev->edev, &result);
 	if (err)
@@ -982,12 +975,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return -EINVAL;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	cur_state = qp_attr_mask & IB_QP_CUR_STATE ? qp_attr->cur_qp_state :
 						     qp->state;
@@ -1612,13 +1602,11 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	struct efa_dev *dev = to_edev(ibpd->device);
 	int supp_access_flags;
 	struct efa_mr *mr;
+	int ret;
 
-	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev,
-			  "Incompatible ABI params, udata not cleared\n");
-		return ERR_PTR(-EINVAL);
-	}
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	supp_access_flags =
 		IB_ACCESS_LOCAL_WRITE |
@@ -2082,12 +2070,9 @@ int efa_create_ah(struct ib_ah *ibah,
 		goto err_out;
 	}
 
-	if (udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
-		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
-		err = -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
 		goto err_out;
-	}
 
 	memcpy(params.dest_addr, ah_attr->grh.dgid.raw,
 	       sizeof(params.dest_addr));
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 464c9ab4251636..16e9ce8138cb30 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1696,9 +1696,9 @@ static struct ib_flow *mlx4_ib_create_flow(struct ib_qp *qp,
 	    (flow_attr->type != IB_FLOW_ATTR_NORMAL))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (udata &&
-	    udata->inlen && !ib_is_udata_cleared(udata, 0, udata->inlen))
-		return ERR_PTR(-EOPNOTSUPP);
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return ERR_PTR(err);
 
 	memset(type, 0, sizeof(type));
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 790be09d985a1a..aca8a985ce33cd 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4297,10 +4297,9 @@ int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
 	size_t min_resp_len;
 	int i, err = 0;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e02bfb1479f5c3..7d435cf5a2fdae 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -964,8 +964,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 
 	resp.response_length = resp_len;
 
-	if (uhw && uhw->inlen && !ib_is_udata_cleared(uhw, 0, uhw->inlen))
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	memset(props, 0, sizeof(*props));
 	err = mlx5_query_system_image_guid(ibdev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8f50e7342a7694..81d98b5010f1ca 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5533,10 +5533,9 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 	u32 *in;
 	void *rqtc;
 
-	if (udata->inlen > 0 &&
-	    !ib_is_udata_cleared(udata, 0,
-				 udata->inlen))
-		return -EOPNOTSUPP;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	if (init_attr->log_ind_tbl_size >
 	    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size)) {
-- 
2.43.0


