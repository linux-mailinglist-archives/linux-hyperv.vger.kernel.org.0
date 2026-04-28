Return-Path: <linux-hyperv+bounces-10433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIAuEObp8Gn2awEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10433-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:09:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E2489A47
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 650FF35D3F26
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154844CF5E;
	Tue, 28 Apr 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jMqZaAZl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A7428859;
	Tue, 28 Apr 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393089; cv=fail; b=fEy4Zug5OfqtYNq1lgKgNpYjkMxkJeTybsfmxH8QUQ5o+SEAmedRAafNPu+rU6pe5XctjykB9YHsiwfn4uiMQrD5Vi/YwczaWaeHfG6U3ueIC7JRCLvAeCIqAXd445feRUq/cTDywspVVRV4+/wvIQjDpsG468v/FpdEEirsiGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393089; c=relaxed/simple;
	bh=V+LIs7iFbSE4wHAoIhfKLqyRqPR6U3DB+CwolXmjWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uz32aNnaz8wsXhvW+Myq8wNiH/76KUB5mQ2pG9RRK/tfvflg54PIRpbKYGj6ha9FxSkiQF7b26dVWUyRy8NN+Hp1H1jhVFIvXtTBh9MssHnAodKTtOCJxFV6icoZPrjcP/gWVFnYd1j6FTYHU6Y2+shnSx0eAyTJnojW5mll58c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jMqZaAZl; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r74TmDHlO0hPKym+NTO31x03fTTbsfz5et9ANBgLFHPE+PoxldThgyAWWBRKqtrzcAcBCx4eKGD3+9qKizWJ9Bb1ZFAO6r4rb5e2lqYjQvm1utCLjOQ2k0MxP9C7+J8DDCzKwrrOlDalqJNEdGkH76Z2vKfJGhAJruHYF4cZvkrTscLvCtcvIXfvgO3CHBx2IcNAM7GxDwanepU7Nt5SuQ02jrQSt054glzbhhiHnQtyJgzvHJhyVTh9PCZvKH63Q8l8M/OhDNqKXll3Cp8X+rOwP+e+zIVDvVthWNE6qwk1Gif3nq3f+qy7WHkV7T1On/PxzclPNiNhacbZWrDbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5efK9qnvmdJWVGlmSdzMeyVV7LHekh+Tcckc/m7NYxE=;
 b=wXiyIpQ1zyJBcefV3Slxg8d7o6dzToNZuaH5Yu3gRQju+ouKSlyrNPJyzOSGMilLpgbDLFjvRwvLUHX9m8v5QvhOhj9vHlE0qx85B0IxHKnAfr9Sqpx6KxTrtpapPPZ8l7YioDRHPxWCEABy/0nfOhDYuG6N+j+0sVi06zHMF+qZHL+5hPsU5IaxfQ3rvuroyONRhsVYxxLVWHXxpb99jH71zqE833vKtLoJonUKWRVmVfICdcDeFqRYO0iZZ4rjdyDyYt4JTPu6yBy4iXL0nK9bT/8IBa+2Jt6hiSz+sMGXuPu03FP5H+N6Rt/uxtnAYFodusO5+SDc1RexCMxTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5efK9qnvmdJWVGlmSdzMeyVV7LHekh+Tcckc/m7NYxE=;
 b=jMqZaAZlCI779/PfNERD2HdkXhr9Cxq7T9UFxu6zJ9v98upU0Z+fXbcRS17cDoxTX/1u5mXFpesTrkiOZBcyKDH5Dk2bfWHeJbzLirtTnEbrezZD/l10Nwd6mJIwrkm9LvH/4+bFOWjY3Ymbzre23qD7IYuHO1Wwti6/CTEiqScrO9pb6CycbfnYzhAOExAmu0dQCiFZeuEAFbK8mYXp7q2DV6GT83PDZzkOFGwATZO8Q3tSVumVSNI74ZrA0Rz9Oj+I+RCr+Z2AxG4DuXBEIqD73eaJffJ/vaUmgRkz1oVom96DkyMK/TpBrr1Dc2CesXKyhKvFm22yqSw7d9sOQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:57 +0000
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
Subject: [PATCH rc 12/15] RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
Date: Tue, 28 Apr 2026 13:17:45 -0300
Message-ID: <12-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d18199-9a5f-4aa6-8729-08dea541b3af
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	rAqIiP/vuimuEqO/tpUxGcL6dlkOANZ1UWV4EPMB0KEh1KRcgfAK/nuNju7PCGJ1pHPqilt0XTGDeLoe9wxj7Qo7zDojTRG9VsK9ZfH9yQdJGBwJ4c36hGaKPnphOEh2SoZ4StqziwBs4wUkXSHsxMO0KpkqQVMME9Q6yAIDiSBoZCAUrr1fXEw4D0nxFX0RLqAhASZs0chdZ0yjcpudU+uwdALlKCCLae/1awvWXFpfZXfx4p0XI9OtuXIqWFqzIS1oZZ14e/468RDwhlMGwo1EI9T4pISrH4rhV25h7qQxV8Y+uPy7Fp+75fD9uPHOBQIW8X4HxKe06eRa/T2xJsxb8GjYI2jv28vjk1PVwSZd8fB9OY0+5YBQ5BJx5KNKfF23NRpIOqEkr5Qfg7rOORo/Lwu7AyLF9vXVfpyHwLItwKC5LDGK9DkZJFXEMWFfud1jgQkOm9N/wkfA28ZKb44YKhm9t0MAbF2woMNi3kc6WAWd759unjliGXbqmqSjAoyG6cRDogz/rrM8FeaN0nUm8z/nWJsX0rV7SDTQJQTdn6+LzjZ4yHT9k47M8CO3pg7QDSE5+K82+8I3GPlH7sEnXjzKCYKPevL48t4T5D2s1y0m1nAMbkci4GZurwmboD+TJWWvEhjTYK1KMjBWokXQcwieXnlLI/mwPWJ0uyzblANGZx9mX882MZyzwcIK+eJ7om/ePrk0+RLvxkpW0E+et8p9NfWlRe4DcsHA3rYCp5ZrIKgMd6emwLzJD/IdmR/TDkAzXAMKPRlVqpzoTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fta9Fmug9nTUYRSrX4Ps+DfPkWoryhKFWRPUMZ6BG1x380QwHA2IdHCHaGv?=
 =?us-ascii?Q?LvW3tJ/bo/2vdIzsoXtkNfb77yWc7KLvaNHizj5jFFCSuGeCws61vGy10lUb?=
 =?us-ascii?Q?mqLpX2j/IPTp7ZNMskWD8O8qf+00a05y5ApLTgCjunnSxFZmTwdpWlk1hyPK?=
 =?us-ascii?Q?x2ttoSdBJ5VjUbZbr5USlNmHYdLDhUycAEU3/4+66GvY8+8bqjvq4kRnQitn?=
 =?us-ascii?Q?82q1SqQqraWNAXcazTk4dqInsFJMKIbuqxou9xDtLgPEggIjvQYd274AVEJR?=
 =?us-ascii?Q?EmuNHrwNThHGHIYTcFNlZVpdZtmzY2YxEroB9A1+yEN5N9NSTSKdupJuSE5r?=
 =?us-ascii?Q?hUpfvqdpUBZMQ56R10JuIyur0BMwoWVV3t9QFo/HOLmFpo2ByYX1JOCoje61?=
 =?us-ascii?Q?BCeEH0+tGPzy77d/dEQKj0DruzwHgmubkanq1x7Syv2k1maTcEk/jNJVuEPm?=
 =?us-ascii?Q?Tca301gbDOdTI1/SIeZxW+RvrRpo47DWErXZ5SQNLbbn1StXqvhr+VcdP5EU?=
 =?us-ascii?Q?yKDeYrDuTIG76P0ZIDJ4/RqNX8XBs6GptgFP7xGVkLu4SiKd67eu4HBawlhB?=
 =?us-ascii?Q?4oOtmJJiJ4hamOLJKwrLMUd8dKToxkpASmbW2vycfwIEN3upBA0O9BrEbtRD?=
 =?us-ascii?Q?zNv+qcBIsYbXPtp+3jCbLnKC3YsUUFIFkdv0XvKqpdIOmCw3jyxGAnv9aKCR?=
 =?us-ascii?Q?ialbRVbhE4LqA5qBitUioAJKCEMxtVWok3ifjVXXoornD51SGUt9ic6xfHJQ?=
 =?us-ascii?Q?OtmjZap+fZNrnx9qZAee90hSj6fmTgInq0IPnmOrVbxISU79ZZ2N0LlrLcO1?=
 =?us-ascii?Q?1GnlcOLWCQHvFKRPNqV3ZyClGE0DEOIoBWYLTR3M20pqbbMUKoqBBUilOAxx?=
 =?us-ascii?Q?Z+2CoKLF9PbcFYKIGZL3wMkb12jYo7j4iKO8zvRHC+PZUcKZQyWZEpPfPv0B?=
 =?us-ascii?Q?XKzIH7wAe1y9PKmxFTY7uLDnLaLlLf44lTPo9R9UHB7HqMMaWeFVDJIurXO1?=
 =?us-ascii?Q?z+WZZhciT4XwmLev4bdWXbFwD9VWBLGCKnZvhdEyYl7JgTi5mclIw0AGxl72?=
 =?us-ascii?Q?FhDeYm2dQQhaqRMJT/TTiuH6ejr64Ao1GUnaYRFPlQPtBe9x1CPTDVftwFqv?=
 =?us-ascii?Q?UU9vNJZsibZwsh/bNwJ1Z3CYV3bvuF59iFKmvolyYZjCNDdSb/y9/MyWNi49?=
 =?us-ascii?Q?tKxFMk2+z36cdu4fkdYL3ZIaqsfpa/FMw/+5T2CfWO/qHuYU8CSvgEAAegQs?=
 =?us-ascii?Q?CipFAQdSisAI2OQ+qsd/K0al85SkwOZ3592k5nqvOscu8OqX5agNYKMCWB9P?=
 =?us-ascii?Q?tu1sA8tGZqVnZ/Q8iPZwed+upW1zSH5sTKJZ6vZcLXRHjqmqQyNU0EAA7AvT?=
 =?us-ascii?Q?JgnPrtDAsXIwnTqUNj9ufVU+vjN2/pNseGjJLLUjtcobA6SA6rILJ4+NjJwh?=
 =?us-ascii?Q?L60lub8kApD+DsEVN4G02/2itQf4TzNpZMFCHESlfUuLNjxNROGI5cCLq+F1?=
 =?us-ascii?Q?jcUwUw1UkPzwF/DmW+xcpSGNueqpacd+WqXtt0LZehJGBUVSEmlwJYTWogQ8?=
 =?us-ascii?Q?zF9uciXruWN/m9xP7b6HdT+dyzri/g8Wbql248jAOPiEyGvaVq2/QAG7RS8P?=
 =?us-ascii?Q?7vGaE/kzLfCLGlnENXkIBb11cvZrOHlaf+uVbK2AXc09n4h7tCzlNmXV4qKg?=
 =?us-ascii?Q?k3E2NLcPSC0rXuEaX8pkSp3qsQt6mQG6qnWghv4baKOO6xa6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d18199-9a5f-4aa6-8729-08dea541b3af
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:54.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTwvuzpQOGJGT40mUo17Y+3SoxtjcWcBxen8+7oOzvg9gX48r2Gh2v3Wk78RF9+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 3A5E2489A47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10433-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Sashiko points out the radix_tree itself is RCU safe, but nothing ever
frees the mlx4_srq struct with RCU, and it isn't even accessed within the
RCU critical section. It also will crash if an event is delivered before
the srq object is finished initializing.

Use the spinlock since it isn't easy to make RCU work, use
refcount_inc_not_zero() to protect against partially initialized objects,
and order the refcount_set() to be after the srq is fully initialized.

Cc: stable@vger.kernel.org
Fixes: 30353bfc43a1 ("net/mlx4_core: Use RCU to perform radix tree lookup for SRQ")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/srq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/srq.c b/drivers/net/ethernet/mellanox/mlx4/srq.c
index dd890f5d7b725c..8711689120f302 100644
--- a/drivers/net/ethernet/mellanox/mlx4/srq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/srq.c
@@ -44,13 +44,14 @@ void mlx4_srq_event(struct mlx4_dev *dev, u32 srqn, int event_type)
 {
 	struct mlx4_srq_table *srq_table = &mlx4_priv(dev)->srq_table;
 	struct mlx4_srq *srq;
+	unsigned long flags;
 
-	rcu_read_lock();
+	spin_lock_irqsave(&srq_table->lock, flags);
 	srq = radix_tree_lookup(&srq_table->tree, srqn & (dev->caps.num_srqs - 1));
-	rcu_read_unlock();
-	if (srq)
-		refcount_inc(&srq->refcount);
-	else {
+	if (!srq || !refcount_inc_not_zero(&srq->refcount))
+		srq = NULL;
+	spin_unlock_irqrestore(&srq_table->lock, flags);
+	if (!srq) {
 		mlx4_warn(dev, "Async event for bogus SRQ %08x\n", srqn);
 		return;
 	}
@@ -203,8 +204,8 @@ int mlx4_srq_alloc(struct mlx4_dev *dev, u32 pdn, u32 cqn, u16 xrcd,
 	if (err)
 		goto err_radix;
 
-	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
+	refcount_set_release(&srq->refcount, 1);
 
 	return 0;
 
-- 
2.43.0


