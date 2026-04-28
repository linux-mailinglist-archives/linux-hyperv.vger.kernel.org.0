Return-Path: <linux-hyperv+bounces-10434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLacAwnx8Gn9bAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10434-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:40:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BE48A1B9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82DEF307A9C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45989450911;
	Tue, 28 Apr 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPN1eD5z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A404508E0;
	Tue, 28 Apr 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393091; cv=fail; b=Fx2B0FLuqaQHUO/KwrWMh5HE9550ANfrHmnZ0huzWpBePmjS1Q83ZFRMIVCA1B/rQ/NAznWwdMm5AN4HzSVCpZsXdPdaTVwGbNliynDSoY93r8uHMmYLiitBLWiNiHbswLUF3dalQZ3Rp584UD5EqSbSd3KtxaCUAuvDIS9dANk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393091; c=relaxed/simple;
	bh=JuZW4F0SqQp+Tnxnmpi+416byl5t38mdlC3ZWcLHL5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaHLSliAdsl5BW8hvqnrSTGZ8P1JQM1Chr1Ptzy4iqENMN54ptjMae84hOvEo1Aa0yBwC1/wfNot0Vb3exsEhYZvGZ57ekX8AvW6lVWdf/ryHr2/w+O/4b0xu6BE9x80SL3Lj5nEd9dXgugujNlSumpDLUAZkBMRlTTvQLyVK5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPN1eD5z; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7DvFOSUHpJbWALm5ygRH2il8xAJTR9EXgItqZIfbs81AntRyVRuYFO4DW4IrYko1XuOF1/b5v2nQ6qBtDRZDV4b2UWw4lWy6j9eak9DNSiau93qdYtybPy0C2jX4fGYWC8gBNAm2egVHNQ7bkRRCzjy6mPKtTSfeTq5pOCOizxlcG85xB5mRWeXNCH9FYqpJ9p9k3pb6fP2row3nZZOoZi+qExepFUa8X+2FcWUTHWiSNwQyeR4pFb3wYQaaNTJLYoFY9ABnYD7f9yzx1FclPlhqGb2UugXB/HiSwQlT03cZfFOiHRrU92ugtpHKVbtjqO0fW8lhUZg8MvxBPkv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfWH9jtLCl3cVt//NJvsSJbt8ykdHN3x/O5YG2qM1x0=;
 b=LiMpu1Em5xxr0r1u6R3QiTwSvtQF5vjkPHfs40zceSx8tU1t3cc3pHecVOVTqqKwPeCGlJxAgcG2lsfoiuLCgcAmG2M5+CzH9IiXaqpnmYCBdruVBBWG+KLhTGQZCBhQoS0u5ZdUC7BieN/VHeAcGYHg/2s++o5wQrJBudUG/WJMblvk+wTQZCjK7NNOHMJVb7Z+oJTBlIdHaPjf75xaxVkoxCqSL49QgzIw483aaSn9FRKiEeWCQaUaG2n9re0o+htsq/jTQyIrFJJIO6acVMPolHdUz/SRC3RhFiOdoFn3pLkNRpH0YT2eTrrQItoDuvZc41mZ0lbe6Eskaqsn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfWH9jtLCl3cVt//NJvsSJbt8ykdHN3x/O5YG2qM1x0=;
 b=jPN1eD5z4ELBZoQM7ZWLgJVgEnZU4cVqDF8ezHLiIOwm8fiyJiOJgiAFQJsLBn8Hl+EwoJfE58YqmoOxyFEwZU3YP+TLA71UfOEt9tfykbOFpl6aZga/65B03gjzQy1UCN9jUYoxC5oONXcw/I2WFSNQpqWdYSyAxs0b0NyLMUPHQ6h43ivK98FcCMIAg9ODG0p5jKZsvE2asRTZOMw5qRbGk5mP1St5CxIBDrCPUAx8ddbkpv9Ivqhlhtyao2BR5O8xHfg2kKJZpGQ1Pl6MH39J8NPXWg1RQFzNPEU//DDTie0VpVs7l188h0YBiMMvXBhYto2z6m8hKzGF6DW0/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:59 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 14/15] RDMA/hns: Fix xarray race in hns_roce_create_qp_common()
Date: Tue, 28 Apr 2026 13:17:47 -0300
Message-ID: <14-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:610:56::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fb41ee-81a8-4968-7773-08dea541b40b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	rAK32UhxUwmQQJhFPBECGFZ8Shre/nenr7I74MmOKrgR8L2jUkzNjirYngfoqAoZxDTfAfdGYEQYmz04RQKcUQ76Y0A8agPg7PdtuscuNvygrXUwEfszsTJlnp/FCnLP9l63SAs8CHCng8JUl4L8S/yv4Yvu49z3G0SK+cXYfaqfU2vpAeGfTth3zBXeFPnHPqX4sK/rP1HE6P8JypGTmnqUn5OABVKzEpkTxTo16EsxKCq8QonYRUBXE4daGPkw/Jw88n11rOjkspA4xs+0lzX8HfDjTv7ttDv48yuBhZ+MUj2v89mrKAqURX43ToerMJcmWdLc3CbZDsE4ot1JaISKqVSz8qTwDj0ZIxjH6cgqelytAuZgT7HIit+/55uTrG6RFCtm0As8BvseNnS1AeY09kw3+CtCxoXRJn/P2LGc18NuujNLiEAlA28AKQGHkil83OEL/4IP5MXKNL1OYesyzpN8yKxzZbIebzaGEZGAV125h/aPlHYfR19xbDAWnO9DaPjTeefS9Nmm8RncXD/CdCyUO4F6wL4SHPXqVo1qt4ChaoZ4n2eCVYqCKKONaQx66JPLWA2+q+mWorm0G0bbSrU1l0rSqWds/DhhhKDVc62kuV/mLHjTP969UCYXlbY9UGVwG2v1owR3Ig4vFU0yDu+9h/0hY2MtBfl6leD57AciY3/dfn2ZsL/qQuy7t+rTBwKEOVdsSVrH7q2uJ/+dlnIFR6Sfre3YlQvtsc44TlGnVWkvmw1PJFu2yjDqb5TKRCkd84tRRTf3fJXfhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTnbCa+gHCd5sXG0NkrYuJ1AOLISDP+VUauzgFKZRI4i7d7Ue8PjMhFAywLE?=
 =?us-ascii?Q?ObsWC5l262oMmqUUjrzNmmJzNU2Ub1/UrmnLZ40N3z/VxdH2/3NPUZxFhKiF?=
 =?us-ascii?Q?mUFXVrDx9P1JJ0q+gwUHVHb/qxm9uiyHsEN9KLia6FIXv5m2iL5EstEEdpi6?=
 =?us-ascii?Q?uZeQ/yc57iciwbdAb9OBjiXu7gKV9e9iIK2sVV9/5VTcWMLZE+gouAbTsXA2?=
 =?us-ascii?Q?xFTWg3AzJjYYN1+g80R76SfvlpqxT9RCsKw9gAdCoKmhd1mJKYxHsYwFp/qW?=
 =?us-ascii?Q?2Vksz1KFLRYFj4FCfFul5QPKDRYXmICxHKVdYwb8UHaf+4inLmEDBc/7CLdI?=
 =?us-ascii?Q?UKSSozlHAdNNeuyRTeEx4ym/o8pmDwYUnjzVMOMcI2CFryWHS/KgOOeiPfVW?=
 =?us-ascii?Q?0HOY555pK2w9n4NVUA2LA1JHf1R5wbmqorPvwuKfXsZyTfvyPVbSl7kQqx1x?=
 =?us-ascii?Q?yy3faIgz1icuj+UXbRvQxb10mUQmsGHI7WP/ghOQPIFLE6Yh50hAwk9l1pZX?=
 =?us-ascii?Q?Zj4zd/S0Jk9h8VXJAyIBcW8dnQQIIZTAdihX3XezzQzCx/0PC3rAinCPT+dW?=
 =?us-ascii?Q?R3tNUv2EX+/8Ra2LXe519jJNvdllZfo/dYXQ+q84ZDyv4nRLPKiDj2rr+j8+?=
 =?us-ascii?Q?MZkZxkOuXj306dXiiuoBVGVjAno5ijFjSNd9jArF8su4IEkvHHkjJtp+Wzez?=
 =?us-ascii?Q?Vunfc47s1SDF0w0WyapiJnZ+mHzY52rxvLrVX1N/ojfXpvRXD0oEbtxUsNxY?=
 =?us-ascii?Q?BtQ9kr+5MzEXe8AVkomp9Nztnb+kWHrfsRCIwv4crcikuvzG+jatqS+xgnU1?=
 =?us-ascii?Q?avExwmQMwrqR9VzDQSli/NXDiVGgQKA5fwKuTtgCUzpr1FjvUSRC0R8F0vEN?=
 =?us-ascii?Q?18MiJnArYvwxidhtEZs71y/sHDqQ3DULrzLgPG9J0n5+lpIwk7Ko6b4L5hxS?=
 =?us-ascii?Q?NMvPqhUEQ3MqIl739UkA3XKhx7YQ31PA2UaHrRDhmJfrpsFLEV1PHAZexhHM?=
 =?us-ascii?Q?2LR+z6uQ+fa0YV7xrJX3m2IY1Yl/rW7K3Cd+uRqdWaKKR7XH2AVsH9DBfq+t?=
 =?us-ascii?Q?LFBilmH/oaJj1PTK3QdjBpfWgAsjwM2b4K5ZJNqobCnQwv/nZcSTFWyWrxGA?=
 =?us-ascii?Q?TV0GY6Ordm9pmDK4djxTJYr48X+T5pDOsK3idsojFqkR+13pOsOTaeT9WAsY?=
 =?us-ascii?Q?A/D3yYMvuevIQ06gBIYmi2ctHZYZm6yOpeyK8nJvFT98Zg4zSDp1hLPVGM3E?=
 =?us-ascii?Q?bYHlcw7KrrvsKr203LL/I89wCmApAxSZwW4H7fuA6UzJMYLXQ9nnmmEuTRQ7?=
 =?us-ascii?Q?sCIQERVIlgGtP1zJ7RLzTXGvD7cfXFvoilyN++O/YV5GBDtkv8bdi/AXcpEv?=
 =?us-ascii?Q?2mCft6G13fb3D7QUqjvsHS/IwmXeg867kQ6vBHmQflmsJd/3dhHZ/MUS0OCy?=
 =?us-ascii?Q?UE5/SqYWDLPs1SAfSAQ/gZ4prObnmaowKvIq79VM4Jj2IkYQs070HnPrfCEG?=
 =?us-ascii?Q?jW25wjgT/YaVW/R33VZ/HC5nuklIBZW+l9Y3wXyIbJlyRKgRdRuLNGeeBQuH?=
 =?us-ascii?Q?vZE4zZJOaZuJrZ2hfbkrzd0NibfHIlMVqsPY44ufV1qBcFg4uIUmphFRc7IJ?=
 =?us-ascii?Q?CZNb4PPmEmU06t+3iVcXoMwQmUT5J+Rc0F6fHAlMyMfwk5wXrXPBhOLdinq8?=
 =?us-ascii?Q?9Ix7YRTJNwVks4P294tSG9riKVYsMIz61EH6UBHhF3ZSkzHJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fb41ee-81a8-4968-7773-08dea541b40b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:54.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJh0c2umt9p4jVYZab11Ld3eI9FgqeqRTUXuALKTIH0I8Wi5hlRJl4UMBaGqpGCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 072BE48A1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10434-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hisilicon.com:email]

Similar to the SRQ case the hr_qp is stored in the xarray before it is
fully initialized. Unlike the SRQ case the error unwinds do not wait for
the completion so keep the refcount 0 until the function succeeds.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Suggested-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a27ea85bb06323..f94ba98871f0d0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -47,8 +47,8 @@ static struct hns_roce_qp *hns_roce_qp_lookup(struct hns_roce_dev *hr_dev,
 
 	xa_lock_irqsave(&hr_dev->qp_table_xa, flags);
 	qp = __hns_roce_qp_lookup(hr_dev, qpn);
-	if (qp)
-		refcount_inc(&qp->refcount);
+	if (qp && !refcount_inc_not_zero(&qp->refcount))
+		qp = NULL;
 	xa_unlock_irqrestore(&hr_dev->qp_table_xa, flags);
 
 	if (!qp)
@@ -1251,8 +1251,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	hr_qp->ibqp.qp_num = hr_qp->qpn;
 	hr_qp->event = hns_roce_ib_qp_event;
-	refcount_set(&hr_qp->refcount, 1);
 	init_completion(&hr_qp->free);
+	refcount_set_release(&hr_qp->refcount, 1);
 
 	return 0;
 
-- 
2.43.0


