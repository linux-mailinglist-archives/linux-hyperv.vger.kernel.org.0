Return-Path: <linux-hyperv+bounces-10024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RZzEEUTw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10024-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855733A5C57
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235C6301FAAA
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039D392C5F;
	Mon,  6 Apr 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLZalvmb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A13932C8;
	Mon,  6 Apr 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497257; cv=fail; b=fKKyTfm8UYcrgxv3tj16xy3w1A8jbjdjtixZDiPyOR7aTZIr9QDKBifmM/VQYlTnQRiufW2agBBU9lNL0k4AvoDpubK1FYpotO3cihRkQAgukE0rHJP/UlVFonOcRLBPh+YDRyKDIGfkF0mfZUKdUUu+9Q9cyuvIA97kzZx/bTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497257; c=relaxed/simple;
	bh=kBeoMo8kpUFtcwEzcuVm3DPwOGAhWoIjFFUuPC++jZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyrNGtN1XZCKBEAvzS1r8nUvBO5lt6+yxKEVFX1zgbq0/3gpOPDvvq8RP4XIx5yAWf27OR1F+VLampQq/8PypghXnAepgkyXl7MIcN3llcLLioMSMjqqKSbGBm+AqAjPSLu1OpIQz4ncqhphO9tQ93TXEKPD1GkyuJArrthr09Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLZalvmb; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8UujFLLe7MQVrmnDV2lsSAk+mVp5TSpvZ2FYo13CWDtpnTw5V+H3lNsAj/aDsERKy2u/FE/PyArvmfXIiMs4aZi6Sh1psUbsfq+q2Q0bWxgAbkN88uI0NAIOKF3FhxQCV0EvqUbjltiDea5XNBzQqzvO4VSP243SfRsXn/YE+vZ1ZoA4rGVok/oGH6th+vgZZoaqnyQXwwHWwNz44fct2usDB6CJgByCad3zB9QeIMpQCp9qQ6DVUA9fRIqBLtmVK01rJR1BUbbhJDiwJOEZw/k1D4t4oN3ZKpyYh+OvlLHk3Y9u/RokVh0towZznu29WrweLEVSNkrQHftIvSEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j6RxooUIs9ajYmdlLTeaEEhEibB3KMlNhyGUSSLh8Y=;
 b=orvcti9MRGdWSyzwrn+6jy9H1lMWg/yyOYP6VQpRsZqM1RTIomaUES1LVuhMhniDrKmBBclZSwHmaUWU5CSRH7xQcJlfKERbGmt1Cn6/FevXt1+hTvAtQICLFoDFwoKOha/KSolj2y+ThLuCTQ/Ie0oGxDtB+bC4j2rNffuoHsx8fnzxK6esgoDkGe2MA942Q01QGgBp+QdBxLknDFNT0hE78dvIHTcIm+mKWowzNGPczBSCz6zmNo8Rx2VkfojkkRsXPlaQJpYL0cupVEXa1bMA/SYHpwG1pRWovl1YWqAIWpu6oQLDTqig/0ZdSV82zlyN0znl6U6ZCcCF820JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j6RxooUIs9ajYmdlLTeaEEhEibB3KMlNhyGUSSLh8Y=;
 b=fLZalvmb70hYjADMk8rJK/bGgFu/vbBdkMmQl//ta2aFN92Lj/NvPNbCY6FHBPuAXn2dOhlD6bJmQqBf8O5CXoQMJTPhzWUvJr/TQGNGOayASx7DOj/GchAWCRvKr1GzeDf/JG0v2VgwJjELh3e6/1pGtT0Ghonr1tkJ6sNWAqJx+fX8mt9hsZ6kuKMlGmyNPKdxH0Bia4LnGBalYlMvAbCbxckZ8wPgmjF257JPooDD3Ix0P/13KBm9zPuqrhgb0ij4HNOLVV96LpDfyc9VFi4QFVA2JOCEokKAcGab9yzv4sSNiAZGkk/55LzpJL0h8aoH4+mw4Ul3LVxTPYrpmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:45 +0000
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
Subject: [PATCH v2 02/16] RDMA/ocrdma: Clarify the mm_head searching
Date: Mon,  6 Apr 2026 14:40:27 -0300
Message-ID: <2-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 281e4b81-a3a8-4cd7-795e-08de9403a0fe
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	eym4QFszmr+MqeqMcojiBBb16QtlZvs2cqoxCwwuXdOYZbvHNvbsgAGKK7Ztn5WQzIQuKZoGvnUF19k5ffNGSRR4SYnGgkd+Giwxl7e+zq998BS+P8seZ3HZsN66bB5BDrqJs2KLpNHgSpsxRpc2D+zUTutcnaFyCxGexQ7j7bV6ltz3g/hfCVbVnGmY5q0gf/oz7VoIiOx/mJCiwZXQ1AnGc6ex4exKhbnMbSyvUuwScC36XH9Ztcr0grkLSbA7w9klWpye4PYGjnr9i1SGeU3gk/ZhuUIwdcU7guFjCq48qrrEZrBuUsAmpshZ92pNSnZPASNOUjIzK0np8KP2dPG3QLPafOWo1S6YersPoyImIrGeyjoQy7xKBfJ/fbNcK3xpnC/09ztbuOkHseV6gF05EP+VbRFcfHOJgq32+hc1RA+rf09UkfXyyGZXD6Dyp9A0/edbjO0IniIWXYwkd26sEz3XNG7on2fjOac8dXYVauzcHxK8Ug4YVa4ChWgZXGOgztuCKtd2dQ8T1r0WNB3bvgSflGY8wF41gQzvmGPo7lrvv4SwqtLudr05n7GIy4FDl1PxBEQ8C7Ugd3mn3eHE+zeXN6rCnLUkbceY8+ockjplexOVqh6o/frzGtkaJ9av2ldcxTecqC7j8EQ4gHlCqjkvvCnRelCOe/kqqu2TjVVeC/0KLctqxlfj2vHgEeXjHr8nHoEu8xhXX/pr5khXbQlwx2t11extM10V9GPTPhWb6YYpkCUEOsWT/zJysboHapCc5WXVys/dFtzsng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9gOF8fdV+X0bq9AAKAHgm8VZStjoaHT9I7mC2paCo+NJiBVzkhpWEZErXw/?=
 =?us-ascii?Q?N6U8Y2lEBqFJd8T6zAeMSBjhtuc5BIFeeUJz1aoNQ0zMRQWX2PEn/29TxNvI?=
 =?us-ascii?Q?rgSwJciTgi/jQ59+ZQCmRaV0ZLYu4xTE2E2Fs8jI3r0DIlbjj4T/Fz7DAvpt?=
 =?us-ascii?Q?egiGq0rzTV9UGviUzzdqq1aV9Tcm9M5rpUxNN2KMHPTdskMAMDxkWlO1fv7F?=
 =?us-ascii?Q?5fWROryss1p2FbSzx2ygpPMakJLcd9BBGf/DhoFg+aYiGjP1k8baxhBg7YaM?=
 =?us-ascii?Q?1O4QHPf7tHqdUV06wnGcU8711xc2asUvOEx6fxr1AaAuhLIShRgL4t8OTzZ5?=
 =?us-ascii?Q?qaWQe6y9tMNtDfFVP/Wcz/kKsz7m5hKxAujEESmhcKvOniFCLU7dK2t1dMbu?=
 =?us-ascii?Q?ygsvIWOB+zsuwv7yp/zqI0eyyiXGcDZ+Uxi+Yc0jCbs8sEH6iwjeGY+8fbKL?=
 =?us-ascii?Q?AyoXPzBM8bM9KZTpJqRq+xTCTGFHv5urolOJdGavxDziJGyZ7QoIRDg7XyE2?=
 =?us-ascii?Q?qLXamL2cKBzxDKQcvsRFG1tMd/gd8xCG0UUbnC2ikYdYTNdi7Jri5hz9PkUc?=
 =?us-ascii?Q?CUUusiNzjUYJor6q3lzn6mLa+PIhZR+9BCTAwHoNCVa7OLg58jgUYB/bUNB0?=
 =?us-ascii?Q?HswBeRV5cafPVXIMgb5OF/5qKmFbq3MPlaW09vrp7aNG+//zVo9RxhM8tgG9?=
 =?us-ascii?Q?cERfHnXcYx59LqAQXVyCV2A9WTBWZUrdduYUqPmWLa2YqowN59iHED0SsuAk?=
 =?us-ascii?Q?YDEjlP7g2Dz7ClH93weiv+LAzy3aT3q0tvBZW2CmlTHx21OsNSJzOM1fb6/T?=
 =?us-ascii?Q?LAA3eIMk4ka2NfKv/KbZnczx84rvSY0I6IWmNh/HayMlpRfA4ma7EZVVZbEJ?=
 =?us-ascii?Q?F56GHJp+oyf3Ulj/TtbHzaVCyLxf3thBuz9qFb9APyVLh4hN7aRy9XHQMQVl?=
 =?us-ascii?Q?5IzGAbaLc+kYeW2mpKN07tdX12B6ey7nsEjc/8gNbbjMyzEx1M2tA2q/uM1X?=
 =?us-ascii?Q?Fk2JzhZ4O03NDX5eYns8wvVib5U8SGld+GlZTvJ2NfdUp+tKFZc4UnLIDGj2?=
 =?us-ascii?Q?0Eg3cmlfWr/DsafzUuguBQyys7rvyd7lNcmjLySwEkKXW9OpEeMB3mC0klU7?=
 =?us-ascii?Q?N60MomG9mIdqQxJ701iqFANwDx8FDCiDgNL+6TywIlWBXRWiyQK0U1tdgVmm?=
 =?us-ascii?Q?kD1koi1oGiDLjrNdXUKbY4Xjkbqwln54e4uI+cqFv6TolLPdTwGEyX0NWbi7?=
 =?us-ascii?Q?s2ou+JnvhID2Dm4U1FxD0ffTr3sRHTFOOWUuX52sxjNRCNupSKFoLYX1dpZJ?=
 =?us-ascii?Q?WucPlph4BcqQdKhfqy0lIbAWZS1l9qJFE6eEY9UUxDIDxpIItwGUnx0eLT2U?=
 =?us-ascii?Q?gXmZ/Pduv+8YA1JOOWn4i7dAzeNYIuHUM92Bh5jH34NY9iHzdJSqY3T7bUP3?=
 =?us-ascii?Q?ls6XURlp0lCPPRH3gFXwZ9qFWli61gesOmUE786g/yquoa3b3+YK0q6rBopx?=
 =?us-ascii?Q?7NSDx0A+EsseQie42MILNXEWtD+3nFu9gGD82dC9DPxrxR/ZMg9HtMHtZc8Z?=
 =?us-ascii?Q?lM4QmRxe7zD+J04nuDrE+/BSw1hvY0lNigjOyCIgAqc3kT96jB50y+UV0Q+r?=
 =?us-ascii?Q?6imOerMNRXG2kZhcYrhFfGWiNw70xqCegWgFamA8CZZ0WukXCmFD8PjQ/0uU?=
 =?us-ascii?Q?Mavuj4A1wlzlRRbfc86aNNQ9/iacyNpxJQVDKqR9AOKTNROZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281e4b81-a3a8-4cd7-795e-08de9403a0fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:44.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwGdO7hczQbCBB4oVaiCQpVg1q27m4ScxUs5BXquYbB0kVTvAb+uyRCJSqRnqQqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
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
	TAGGED_FROM(0.00)[bounces-10024-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 855733A5C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The intention of this code is to find matching entries exactly, the driver
never creates phys_addr's with different lens so the current expression is
not a bug, but it doesn't make sense and confuses review tooling.

Search for exact match instead.

Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c17e2a54dbcaf9..463c9a5703fc4e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -215,7 +215,7 @@ static void ocrdma_del_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 
 	mutex_lock(&uctx->mm_list_lock);
 	list_for_each_entry_safe(mm, tmp, &uctx->mm_head, entry) {
-		if (len != mm->key.len && phy_addr != mm->key.phy_addr)
+		if (len != mm->key.len || phy_addr != mm->key.phy_addr)
 			continue;
 
 		list_del(&mm->entry);
@@ -233,7 +233,7 @@ static bool ocrdma_search_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 
 	mutex_lock(&uctx->mm_list_lock);
 	list_for_each_entry(mm, &uctx->mm_head, entry) {
-		if (len != mm->key.len && phy_addr != mm->key.phy_addr)
+		if (len != mm->key.len || phy_addr != mm->key.phy_addr)
 			continue;
 
 		found = true;
-- 
2.43.0


