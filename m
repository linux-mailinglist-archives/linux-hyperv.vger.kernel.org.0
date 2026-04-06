Return-Path: <linux-hyperv+bounces-10014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPSdBgyj02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10014-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14293A3390
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF3533011C5E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3B3358B9;
	Mon,  6 Apr 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWgIkE39"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7F33688B;
	Mon,  6 Apr 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477508; cv=fail; b=Ex3UVIv3GJUggwtbjGFzoQZ0DCAa2R0qYzfAdzjzZ+cTJMMLlYr0pfRF7uZhkyqC1rD/egmPhvrEVoRyuglJItO/WyYoNogHMCm2BDsL8jLdmCIQslml5A64nxL4nJTRBLFSxBHfQIgC/gQ2Y/i4xwHFKp7FMJ2kqgVIHAnihT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477508; c=relaxed/simple;
	bh=hTpAMd7hMfpnck2DRSnKy3KHwM7zCVolVqTufLqQ574=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNR3weaI4bCJNojLMb6ONb/5ExqUoYAYUj7cZOVcrfl+IDq7NjUUuTDMKb5xO/1uCrXX+sLL/kdqIRtcj/WZnE9zRodHLpVlOgf0Ia9fjZPxlLSfsdH5Q2BMAkLsy4SDGmPMVRyzm4doibQ5arrM/qcATXcQagIIVpoW0wC+fw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWgIkE39; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGe7s43N5riZAmFEonSv7/wazflQZnA+x04iHz6sU7nQ2Yhc2OrEDdpTIcp3tArE90c++9GrG4ONcsENsfXKR+i8TdMyIe3oRyvjborPiQ8q2E0UhG9E+uADQy6X8oGe1PDYdMgiDbwwMhes+qHLNKKdfCwxhqEy0CP0sd5lsFcv6/gmQTI4aMlqYgg7bHvuh8IV61UaJLjrmc7zAeRqlz7ri4doZlDnNtG4VUmmhDlgHRwSLZXZX2lBMikgO0JtFGlEyg5NeZcQlqZ0okHpFC9NgmJ6sWUqa7BPYJS2cWnYycyT53ckAeSgNnS1R/Z2qACVt6o0jyPsnZzaP0QgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LGYHGUh5TjWK6EZAgWvO3ByjwLAgZnueG/mavhbRxE=;
 b=FptHIjs4hHaJQcVbsNbW/7QnQiiPfowyKzrUTB6FhX8r5Pxi9oEwja3AiQwa2fv4jP2FDYaX1c2fcW2r1GuHcWlZ4uANlQ7+kDC6CViap7p55CrpFH88+lYmvBO4ki9hcReHUVDQgHKe9dnJ61BzvaZ60lb3tI8zlZwAE7QgLK3J3c0G5DTxZ1PfLKM/hlcdn3ZlQ8zW677ra5W/6bhG8SFuhlXP0ZAbCXrXYtTqOwpUDiwI5IwoVIccpo4NdYpHzy59PDcbNfa7zTJGOmj40p11NEE5unr+PM7i5VhVi1IP0IVj1FchdJUiN07Su9OLD4jeP0yu1CZPQSjwzQcZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LGYHGUh5TjWK6EZAgWvO3ByjwLAgZnueG/mavhbRxE=;
 b=dWgIkE390OHa2M4zh5pys5+3RMfOoaDndfMsZDYFPuswMjsY9qE8WGM+2OQC0NCTB2j1wIWb43bFmx0dTMUlPS9wXOojsPOw7ILYIWX/E4arqI4St4P8vGzKbYTKSMtOGdsEA5T2/a0cWuv/+pg2nNut5LDYIpvZz7xtUU5ZVA7JvU2VKumZf2swZU1WsnHEUdfJhJVa14EGmBqzqAQuhkBU5VSH7n7qBLKe3cNRbIaCD6X8vJPB1aMaviC4oisMmhgqbSBEioFpB4ewGvVw9o0Z9LAurjVVct4rIvfhFzhEaYNFIfY7HgRo/aLyPPIX8uSvRuc3EsejaRyym1aXJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:33 +0000
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
Subject: [PATCH 03/10] RDMA: Convert drivers using min to ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:17 -0300
Message-ID: <3-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:52c::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f68dc1-0976-41c3-193f-08de93d5a16d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ddNI63kTplXirHXMC73c5/cfztLV4pWzv0JQs3JIr7xopJ3p48GjpqKhXHgQ8Zs5z5ZNax0U2YsQAgh16NUJyXDMRW7G5uJdsvHw0VtUoRCQfIRVftv55sa4KyjGe1GTy4M2aC847uFC2P8W0agj/wQIC5kuu52rkKgFo8HBWDq7NXDLJ+yBsxaQEJVOOEp+nESdWFvqT0RmTReA1XSurfoiJxbKyqUHEEGDQ0jXg90owv1GRuRFgrYZ8fRK5ez+bjKMrOmuLOZFW8O2PWScGxYLdeBXR1pAnynTl/22ce6w/A5cKqRWHiMEozI0//cRwP6OJKyTu9uiXKAIL6xZBhrE9WzQDlq/zfnKeOIjK3NZ+BlNNt2nXZlelas7rmSSBLefvI+C9RfKCNY9wF1+5vDtsnBzAEPkxeabXjTwA9RiyJ9qNVmVeh24RXt34kU3Od/rk5GQetu4p0E0BXFfT1WMPfqSR3wmTxL3zbnJkzz80eNAd1DmQZdFHPEdlMXTePXscJGTtz0TpJEOtuXA2UFdssbujOTquCfrtXc69ruE5eZ6Qweno0OnhYNOFSH/SzBfqP9I9qiu/ezpJKHm3iJoY6GnrXIwgpQMtmqxBkNswIssXhM4sMpIijsu6mWcaeDx55FVyI7hghoMbdofTYpxAvln4WD8DTb2GweYjqh/tReaUTeqgDAVKiOjuVrYaJn2kl/TbywnhdxMcPgUJUqpIjFa+O5UQoeqlcsCCPusY2Ujh40Cdj3Y1kAqoGmFa37s/TqMn94RiaJosn8eKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1P34Qv73DC4woxJ8doLAqDpAuMXLy1aKrJKGq7N7Lcf3J9kyEFZIsXkUF/Y?=
 =?us-ascii?Q?r3GzNsJBgiwUTUqt/KFwuM+l2DqPdDsF5GO+vaHK8oc2beM28BlbuMQvau8U?=
 =?us-ascii?Q?22OJM+0WN/ZBi5T8f4tkv53XGeAxveRxRuRCKhFJvFjEuymzm0uq4XnfO1OP?=
 =?us-ascii?Q?bLEGrD1ZA+22FtE0RrOn033pj47NTpHvV28nVmmbz5kLVcD3ux5P7Ja7PBq3?=
 =?us-ascii?Q?UECW/p9LeMwGdxUnxOPReAa/sL7J1HEizUaY6Hzc/1eMz5pCxvwY6y8xetQt?=
 =?us-ascii?Q?O8CkAwOxYuU0JURP6Qulk+3YrykL72yUUi6huhHWyRM8TsqikckT/uiuWDWR?=
 =?us-ascii?Q?6oFA/mNaZE6fQauI4jfz1PiVvj8XaB4efF3wqdhvuo3BenteSAapz/FxnhVl?=
 =?us-ascii?Q?7pfe4T6g2cbVgCa5gyLYFiebPOiaaqRGg6c/xiZnU5cH0CQ7r6CrAuDxAPGT?=
 =?us-ascii?Q?0OOoNaov5XxvlNsEjpM8UiBMW2UWLn7h8bjBOT930Xu2jGF5Vy11Z49vNIqX?=
 =?us-ascii?Q?wdkOyelMSRG6/dCj2U/kNoFDX2XIjYzS4An6Ypw7WeGlLvIVSatRnkGi88MX?=
 =?us-ascii?Q?eG3YatoSG2FMueXd9yJWOLqGycax6rtWe/w6ENbOwe487OD3qN+50oVzTh2C?=
 =?us-ascii?Q?UXQrOrkwLC0GE1xSm/m0OdLw7pth7XHzNUqLxjDvcT+DCouPXSyxEIrn14co?=
 =?us-ascii?Q?Alr2bBD7lYkdFGq60P8nDgLHMNqPXN64+JfmoA53ROBdPxR4aIlKfq4lHOHP?=
 =?us-ascii?Q?Wrx3DqdoGM9eW347tMitaw8PtNb7GT8SixM0NGjgVRA4Xn0bfptqKGBl0jA9?=
 =?us-ascii?Q?vCRBt0AwCkxqxuZoogySxyzA87BK0WrSeOqwvNJShIyCUGLhY8d849qyGeKS?=
 =?us-ascii?Q?dsKQiUG4IsD5F0BIOdmzZZsJUBQ1NCY8TSOw4/UJZazUWXOb0ZpjPrFNAgZm?=
 =?us-ascii?Q?ptMNov1Aj7oX5f3PE0PE6FmhU7T6m1yvFfKCq+QdSLEZOp9RDKtftK/SKZmx?=
 =?us-ascii?Q?NaF8cLw/FfvAzRgkrkim6jsCS88Oid1rvlB5aLiejV0lwQO8pkNSQusBbLeO?=
 =?us-ascii?Q?NtwzSRwdwvyJaHIbzwJf5b9/Kw5PZXrXBHHLuFzlL0urzXReGKz6soO5r2nP?=
 =?us-ascii?Q?44kkKIWe9fBIJ3DzEMe8J+KSECm6aiKo+UdmsvpHCKJF2bDnQBu48uclBodR?=
 =?us-ascii?Q?7UbjwK3AptJ3GQofUItNhPUvaIa+3pzFYVebO920BVJrZudUYLYh7E4VyMqP?=
 =?us-ascii?Q?2re8f3/FHy+KUisMol5uel/l/o5ZNeiNqnRSNeSkjtI3Fn+WKRC/8ZvrQXxy?=
 =?us-ascii?Q?ZUWKlOUKSGpuwwwOG3yYUjSgScYjTu7sPXFilSAhT/BdnQUUnQTRwpzEK0i+?=
 =?us-ascii?Q?mBi9MYKzus6QpcS/RKpPLNpFAkAVePPwvitmDGtcItuKaRjHtK0zNgOOgfiU?=
 =?us-ascii?Q?m9A90ICGUUU8LWhKTBn6mre1r/MgQSXIoiwD0augZkr2J/kQENDwlioZK6BT?=
 =?us-ascii?Q?V5x7TuGA/oqebQ0OFt3woXLCb6piy29VzrGUfMIWP/lfBG5u9n367Jr+1StG?=
 =?us-ascii?Q?TH7HQwYjc1BgSm9Fp1XwsE7/u7VsW8BCqVywSrNE8WfTwTpeCxLLjnY/absq?=
 =?us-ascii?Q?kEApfwpMbSqbNFZOuq+bOTF75TJEItNLyESB+8qtcolMexV9fZPe4Emj9ijn?=
 =?us-ascii?Q?ibPgUuFOUTIree4aX8e5GDa1t7T0tzWWUUnZJNG4wwyVo716?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f68dc1-0976-41c3-193f-08de93d5a16d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:28.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1WshmYLvY2Y/2u7tz+07cuRxUA7BytAHg5QdY59kJmiYIV+V0+zCqFIBPRdrRqw
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
	TAGGED_FROM(0.00)[bounces-10014-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: C14293A3390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

   ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));

Using Coccinelle:

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen))
+ ib_respond_udata(udata, resp)

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)))
+ ib_respond_udata(udata, resp)

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c        | 44 +++++-------------
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c      |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c      |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c      |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c      | 13 ++----
 drivers/infiniband/hw/hns/hns_roce_srq.c     |  6 +--
 drivers/infiniband/hw/irdma/verbs.c          | 48 +++++++-------------
 drivers/infiniband/hw/mana/cq.c              |  6 +--
 drivers/infiniband/hw/mana/qp.c              |  6 +--
 drivers/infiniband/hw/mlx5/srq.c             |  7 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  8 ++--
 13 files changed, 49 insertions(+), 110 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 3ad5d6e27b1590..395290ab05847a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -270,13 +270,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(ibdev,
-				  "Failed to copy udata for query_device\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -442,13 +438,9 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	resp.pdn = result.pdn;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for alloc_pd\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_dealloc_pd;
-		}
 	}
 
 	ibdev_dbg(&dev->ibdev, "Allocated pd[%d]\n", pd->pdn);
@@ -782,14 +774,9 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	qp->max_inline_data = init_attr->cap.max_inline_data;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for qp[%u]\n",
-				  create_qp_resp.qp_num);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_remove_mmap_entries;
-		}
 	}
 
 	ibdev_dbg(&dev->ibdev, "Created qp[%d]\n", qp->ibqp.qp_num);
@@ -1226,13 +1213,9 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(ibdev,
-				  "Failed to copy udata for create_cq\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_xa_erase;
-		}
 	}
 
 	ibdev_dbg(ibdev, "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
@@ -1935,8 +1918,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
 	resp.min_sq_wr = dev->dev_attr.min_sq_depth;
 
-	err = ib_copy_to_udata(udata, &resp,
-			       min(sizeof(resp), udata->outlen));
+	err = ib_respond_udata(udata, resp);
 	if (err)
 		goto err_dealloc_uar;
 
@@ -2087,13 +2069,9 @@ int efa_create_ah(struct ib_ah *ibah,
 	resp.efa_address_handle = result.ah;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for create_ah response\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_destroy_ah;
-		}
 	}
 	ibdev_dbg(&dev->ibdev, "Created ah[%d]\n", ah->ah);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 5523b4e151e1ff..9bba470c6e3257 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1990,8 +1990,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		uresp.cq_id = cq->cqn;
 		uresp.num_cqe = depth;
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       min(sizeof(uresp), udata->outlen));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_res;
 	} else {
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 8a605da8a93c97..925ddf15b68102 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -32,6 +32,7 @@
 
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
@@ -112,8 +113,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		resp.priority = ah->av.sl;
 		resp.tc_mode = tc_mode;
 		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
+		ret = ib_respond_udata(udata, resp);
 	}
 
 err_out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 621568e114054b..24de651f735e03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -452,8 +452,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		resp.cqn = hr_cq->cqn;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
+		ret = ib_respond_udata(udata, resp);
 		if (ret)
 			goto err_cqc;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 0dbe99aab6ad21..c17ff5347a0147 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -477,8 +477,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 
 	resp.cqe_size = hr_dev->caps.cqe_sz;
 
-	ret = ib_copy_to_udata(udata, &resp,
-			       min(udata->outlen, sizeof(resp)));
+	ret = ib_respond_udata(udata, resp);
 	if (ret)
 		goto error_fail_copy_to_udata;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 225c3e328e0e08..73bb000574c50d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
 
 void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
@@ -61,12 +62,9 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	if (udata) {
 		struct hns_roce_ib_alloc_pd_resp resp = {.pdn = pd->pdn};
 
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret) {
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			ida_free(&pd_ida->ida, id);
-			ibdev_err(ib_dev, "failed to copy to udata, ret = %d\n", ret);
-		}
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a27ea85bb06323..6d63613dcd5a9a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1235,12 +1235,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	if (udata) {
 		resp.cap_flags = hr_qp->en_flags;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret) {
-			ibdev_err(ibdev, "copy qp resp failed!\n");
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			goto err_flow_ctrl;
-		}
 	}
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
@@ -1487,11 +1484,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (udata && udata->outlen) {
 		resp.tc_mode = hr_qp->tc_mode;
 		resp.priority = hr_qp->sl;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret)
-			ibdev_err_ratelimited(&hr_dev->ib_dev,
-					      "failed to copy modify qp resp.\n");
+		ret = ib_respond_udata(udata, resp);
 	}
 
 out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index cb848e8e6bbd76..8644c3916367b2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -473,11 +473,9 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (udata) {
 		resp.cap_flags = srq->cap_flags;
 		resp.srqn = srq->srqn;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(udata->outlen, sizeof(resp)))) {
-			ret = -EFAULT;
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			goto err_srqc;
-		}
 	}
 
 	srq->event = hns_roce_ib_srq_event;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7fc..79e72a457e7983 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -325,9 +325,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.max_pds = iwdev->rf->sc_dev.hw_attrs.max_hw_pds;
 		uresp.wq_size = iwdev->rf->sc_dev.hw_attrs.max_qp_wr * 2;
 		uresp.kernel_ver = req.userspace_ver;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen)))
-			return -EFAULT;
+		ret = ib_respond_udata(udata, uresp);
+		if (ret)
+			return ret;
 	} else {
 		u64 bar_off = (uintptr_t)iwdev->rf->sc_dev.hw_regs[IRDMA_DB_ADDR_OFFSET];
 
@@ -354,10 +354,10 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE;
 		uresp.max_hw_srq_quanta = uk_attrs->max_hw_srq_quanta;
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MAX_HW_SRQ_QUANTA;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen))) {
+		ret = ib_respond_udata(udata, uresp);
+		if (ret) {
 			rdma_user_mmap_entry_remove(ucontext->db_mmap_entry);
-			return -EFAULT;
+			return ret;
 		}
 	}
 
@@ -420,11 +420,9 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 						  ibucontext);
 		irdma_sc_pd_init(dev, sc_pd, pd_id, ucontext->abi_ver);
 		uresp.pd_id = pd_id;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen))) {
-			err = -EFAULT;
+		err = ib_respond_udata(udata, uresp);
+		if (err)
 			goto error;
-		}
 	} else {
 		irdma_sc_pd_init(dev, sc_pd, pd_id, IRDMA_ABI_VER);
 	}
@@ -1124,10 +1122,8 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		uresp.qp_id = qp_num;
 		uresp.qp_caps = qp->qp_uk.qp_caps;
 
-		err_code = ib_copy_to_udata(udata, &uresp,
-					    min(sizeof(uresp), udata->outlen));
+		err_code = ib_respond_udata(udata, uresp);
 		if (err_code) {
-			ibdev_dbg(&iwdev->ibdev, "VERBS: copy_to_udata failed\n");
 			irdma_destroy_qp(&iwqp->ibqp, udata);
 			return err_code;
 		}
@@ -1612,12 +1608,9 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				uresp.push_valid = 1;
 				uresp.push_offset = iwqp->sc_qp.push_offset;
 			}
-			ret = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp),
-					       udata->outlen));
+			ret = ib_respond_udata(udata, uresp);
 			if (ret) {
 				irdma_remove_push_mmap_entries(iwqp);
-				ibdev_dbg(&iwdev->ibdev,
-					  "VERBS: copy_to_udata failed\n");
 				return ret;
 			}
 		}
@@ -1860,12 +1853,9 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 			uresp.push_offset = iwqp->sc_qp.push_offset;
 		}
 
-		err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp),
-				       udata->outlen));
+		err = ib_respond_udata(udata, uresp);
 		if (err) {
 			irdma_remove_push_mmap_entries(iwqp);
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: copy_to_udata failed\n");
 			return err;
 		}
 	}
@@ -2418,11 +2408,9 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 
 		resp.srq_id = iwsrq->srq_num;
 		resp.srq_size = ukinfo->srq_size;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(sizeof(resp), udata->outlen))) {
-			err_code = -EPROTO;
+		err_code = ib_respond_udata(udata, resp);
+		if (err_code)
 			goto srq_destroy;
-		}
 	}
 
 	return 0;
@@ -2664,13 +2652,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 
 		resp.cq_id = info.cq_uk_init_info.cq_id;
 		resp.cq_size = info.cq_uk_init_info.cq_size;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(sizeof(resp), udata->outlen))) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: copy to user data\n");
-			err_code = -EPROTO;
+		err_code = ib_respond_udata(udata, resp);
+		if (err_code)
 			goto cq_destroy;
-		}
 	}
 
 	init_completion(&iwcq->free_cq);
@@ -5330,7 +5314,7 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	mutex_unlock(&iwdev->rf->ah_tbl_lock);
 
 	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
-	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
+	err = ib_respond_udata(udata, uresp);
 	if (err)
 		irdma_destroy_ah(ibah, attr->flags);
 
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f4cbe21763bf11..43b3ef65d3fc6d 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -79,11 +79,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		resp.cqid = cq->queue.id;
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_remove_cq_cb;
-		}
 	}
 
 	spin_lock_init(&cq->cq_lock);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 645581359cee0b..1538aec6d85ccf 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -553,11 +553,9 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 			resp.queue_id[j] = qp->rc_qp.queues[i].id;
 			j++;
 		}
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto destroy_qp;
-		}
 	}
 
 	err = mana_table_store_qp(mdev, qp);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 852f6f502d14d0..3fb8519a4ce0d7 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -292,12 +292,9 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 			.srqn = srq->msrq.srqn,
 		};
 
-		if (ib_copy_to_udata(udata, &resp, min(udata->outlen,
-				     sizeof(resp)))) {
-			mlx5_ib_dbg(dev, "copy to user failed\n");
-			err = -EFAULT;
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_core;
-		}
 	}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 16aab967a20308..cefcb243c3a6f2 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -406,12 +406,10 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		qp_resp.qpn = qp->ibqp.qp_num;
 		qp_resp.qp_handle = qp->qp_handle;
 
-		if (ib_copy_to_udata(udata, &qp_resp,
-				     min(udata->outlen, sizeof(qp_resp)))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
+		ret = ib_respond_udata(udata, qp_resp);
+		if (ret) {
 			__pvrdma_destroy_qp(dev, qp);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
-- 
2.43.0


