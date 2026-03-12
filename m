Return-Path: <linux-hyperv+bounces-9393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /dUWN4hJs2kLUQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9393-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:17:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228CF27B389
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 00:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CA1305D6C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7639DBEC;
	Thu, 12 Mar 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ON5f1mCS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1A175A7C;
	Thu, 12 Mar 2026 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773357446; cv=fail; b=QOHeZkOdcTfMMUNjtWTPM08GGlYP1LrtzhtOWfZvteXoZjs53JMOWSAApP6hJ5k65SX8REJTBwmhV6XuRmDPofQQCnNuhiKuLQaDI3AF42732scboJgQQ8r3wncfja3sRBYPRHiI7/FlDhXwk5iWHLIkKDBtWCDkjo3ow4BNAZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773357446; c=relaxed/simple;
	bh=x8fM8Byr79pBSOMAYW9KfhlRRARXE9dbCQ3t2WJEwyg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q1ewjvcotJHSfKbo93brqYfCt0Ubzs2ktnKlSs5ODhiuGPKdvmU2WlrK1hAXYDkl43Uw0wCERsV06zklAmH/FI9ZvbggorPLJTJV6//N2kISs2t2zgj2/Ak6TZbL/DVVsn/H+UNefGXf7F2Ve2Inc2vZ48tiLMceimU4CFiKng0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ON5f1mCS; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+N/PPVw9ovkVLrHTw05akAKhYs060WtV/dwfeW/844TnHB5mpiJK5TTkyz0NTBxoyDidkb6LwpvohcYgqqLA5IvZY49uUZ/myxYC32jA7t9QYuZ/JcoqaEuFWX/WPxduUiQ8FMHjsNFN4ZrsO6nPvzQ/B2XnaxSuDHBl70dQiWpPEZULIvf0T1/ej6zZwR0GWi63evV5OmUg5KRuVb6GHN5I757hivZYWKB3vAB1wR4YKFc7qF0RIpdWT60lG83wU1VLpB4ohJhqQLM+/YuYdBSr93lvMCq7n+CG9fMZ7yR0RlQ9gRxDQkqcaloDnT2eeZ3sbpE5bfVCyBmEY2Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1vPG6JafKZbJXr8M3YgsCzayv4FHyW6an8+dF+wIJk=;
 b=ZKDJfR5SvtZ7UhiUwiz6VJO1rtdgsv8MX4YbsZzfih2d4cTuZJCiRRIbzN6uiuGFV9rpWLbNE7lAvK7CVJJHqoZCzjBmQLsMo9IrfbthSjpJEVMhuuN/Ub8e0fPuGo3WnLVS2ZsyuGqE7bRO2TfHyy0o1tgqmrVFh9/Glq6QqQUk/Y6QW+349S2BEdhBPzAIMcUlX9JTn1TmUlMXqI0tyR17Ujh2ziJ982fCeJB1AVeu2utBX7lT0yQND25b1WKka4qPpYAp4mXPG4RbRah842pNpSYPlKQBJbfQM/xyX45gVnV1H3nLDVZYSBpxJKM7MckYWdiktby679iIUOtL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1vPG6JafKZbJXr8M3YgsCzayv4FHyW6an8+dF+wIJk=;
 b=ON5f1mCSzPQqdWRjNZDgLmuVD0AEwQL1FktpSumjZrY+56Be9EjdOkjcNuu/zB+eDZv1DAMpRfnNeJOEC7+yKGlL9rwXLrFw9Y6YITkFQmizIw57hPAA9eALixhY8xBLiow6nISUO+kBTmpiHQ3owhzMZ0nq+he/98IuBtb1fuYllj2HBIF6/DEThl70nPsN1nrIwdQWF9QfST4KNzSYnXGkPT73BE/YwwJbDyQlJnWscayk4vwmbBCgGjDuJ9VUXTLYnq0id+W85fwJGXbS7W7CLk/tXtd7B+mV59JfCa4MKRGJskyQFnU7PPO+tsbHEBBjGd5Gjrsx7g0+6JG00A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 23:17:21 +0000
Received: from DS0PR12MB8786.namprd12.prod.outlook.com
 ([fe80::cd1a:bacf:6ab9:6f91]) by DS0PR12MB8786.namprd12.prod.outlook.com
 ([fe80::cd1a:bacf:6ab9:6f91%2]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 23:17:20 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in count_trailing_zeros()
Date: Thu, 12 Mar 2026 19:08:16 -0400
Message-ID: <20260312230817.372878-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To DS0PR12MB8786.namprd12.prod.outlook.com
 (2603:10b6:8:149::17)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8786:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 9502d587-1921-4eec-d653-08de808d82c7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bmIgEK6QpC6sNWu53l9LnjHkTE7bJgM6HrZrdw29cDWNrtJ7D6v/aqwaZn9xl1l31bfWbPPSn4IsC04NldASLyTG2U92F5RJURBzaZRK32hKWPOz4U6kWPnI6UCINgdSmdxV+5Fjx02JidmdN97OJxC7DtiEWblM8EkUt7A1j6dxWyK9Kc/1xR4iYJZBIQ9GJITrIYD0RxcRn3gBBKXL3AR8Pe6CMDbv3B12WMPuLxauvmnmbUVjs0HlW3RRC4QPd3/vmHtj1LdfZLNUbp5uDIjGkS6df1BdGwnkBYBXFxVMI+0H1nPXRB6F5MBThHOhGIdGBEwNrV7FUQk7zB7xK/RYRDLwFKPMuLiwjO555RLUDP13txwlM5bCKxuKWxUfm7ykwTmgwQHWQgrxEPZx+nBuT2vx6iAJqyfj32rUX7tZ0+PnJFCbgtnVqqPrluF4EHm5faKaxpCXHsJk+QlyyzSMfl2GJi50mgKWS0+I/A93/J7UG2jQblhrBE6Tc3NFfYhPlTeiI3Zm4bHbMn9hu12YJ0A4A+yrKSlez/OCbivpQzlsA/sw/zz0Pa8LcQ7x4NxXznpvwIlv3AaoMMe/8jFR5f6rgLxgb9U6Pg4e7SgHGl9/dyeGQVNXNEioUJUZcr8PzTqL4NrPNDTEh8bCbusz8uLdUwQFemNG3nO9u7R1jPjH2TK7fWT6HX/EdwpzQ+uQmuycZ7avSWNIKYvVXGf1RtA5hu9XDwP52R35Vik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8786.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxpYQIEJWjBDznn/77ns1x9muGJirF3jpktD9WkybCbZT1+q+K5i2R031QYk?=
 =?us-ascii?Q?59YafLFA+/CCPT4mAd2XLuA0WHlIg9Vq8b35adbRYkiwiMAovRVzQNNuacR6?=
 =?us-ascii?Q?u7PORcbOQtB6/Jl2vfkxlGA84wurA3251aT/T95bpjFrqbfkFxZwJGLrw1RH?=
 =?us-ascii?Q?padBfyWbl+I1XiEqM4oXjDV7qbIXGJvZVxzO1oc4QgvAF/FgaRWcnrMNAi1i?=
 =?us-ascii?Q?fbVwZG0cZumz/vF8WgAm5dJaSj5TUc+/LrJe+82M8bNrK0rFfUSINUk2cUsP?=
 =?us-ascii?Q?D5xzdylK0qMtsIQs2BZKHjxljVvn7g4V2KLw+C6OFGFvXYKacx5Mzw94rtU1?=
 =?us-ascii?Q?j5vTBrnUh4g8QV+G/1Q8kpWOtP1AFR7yo2p27mAKw87xsRnR9P4wHiFtpaag?=
 =?us-ascii?Q?6wewhAVhEJ3ENh2B9FRuufWSjoGSPA3ieZYLS+XolgDeO+CZHEfQZqFKHAC3?=
 =?us-ascii?Q?yJFQBRIofi5CadDpIqN++8isMCfkTfIi/2B+4pE7U7u45Swt/od/EWniIXl2?=
 =?us-ascii?Q?E7avGU/gOtVqf/+BRNRjBOvIcKONZwilASF7Qq2fPM7XKKuZMwSsRY+Sjh11?=
 =?us-ascii?Q?1LdEKlRDIHBsgZ/ciZyNPUpLP1YacKDTSn5BL0cr07mb9iGvfFgFu7J8rGzD?=
 =?us-ascii?Q?ske9s6MvEAOwcB1kfg++2O13LvhkUDqUbx0dNmCh3I0ZmDYV2+Vl1DLy0h3z?=
 =?us-ascii?Q?frwVpbOq/6VyDwqgMyrj0c3eURDOaOMSpT5PFlSweCXokBWqZLnHpyn3zt6s?=
 =?us-ascii?Q?3FV7Xq0pvjfdi5JRoKKCeQzbEy3NvlZPqYyhI0AxQM+6wNW+p7b75YolZSfr?=
 =?us-ascii?Q?Zt2FKIHpefN46N7Cswg+DhElTS3FEL/zBoYCoFDB3bffBwVllFb1meSVIhrJ?=
 =?us-ascii?Q?E4cUp7JBl1h+I41GQSEIJe3U894YI7xrGCr29bNCDCQ5wX0ZXS5jRJrlU8uz?=
 =?us-ascii?Q?0pSSe3JibPMZPdpt8oBBpZteoZlik4vaDjF9xfSAH7r+uJgIPdpAQpknxY3L?=
 =?us-ascii?Q?5VgzJ16FxerWTIaaMdSUMJDxRRY6rFw+910NSyFBRrD+FNBZX0SOexFf6OhU?=
 =?us-ascii?Q?NXyUbwnSb46o//nllokKsAOkbfaT/6c3NG+1qevxBQihYtwsCgRU4u1PE885?=
 =?us-ascii?Q?xk9wdYPzNRMlr4FonRpefvRI1cvPXSKJ9fpy2JHsV4Uj7ZilU8VPj5LruJAo?=
 =?us-ascii?Q?90/97kteiEwA+hFx8Y6tXGg/AVnYkn4KtCbwbQnqIw/8/nM9VQajy2ZCefma?=
 =?us-ascii?Q?PY9nNOdj5gujncuJGea1uBw/TTnsw5pO3He+femo3WgST4gCWU0T4dBxxJV8?=
 =?us-ascii?Q?M/26P/m73w95TGHYxI20gPBMGQeCrTITDz9eB7vOnK7N/7LQg+N1tE8+vl5a?=
 =?us-ascii?Q?AXU7dPeMh5lEvNWfY+Z6xFKz7E4WMNWbkz3Ww/os4NSFmfXOsOUz0A6eR0SJ?=
 =?us-ascii?Q?ZiLVF8/5o2IGFlZtbemdvLX29WlxyKLrnf53IIbcTFlzGuL9L310kZWv8az8?=
 =?us-ascii?Q?zVSiOVCqJoHK3p2D8w0W3uophAM4EFi0lISLYkv+zKheCaPVq3VvMOu0adfW?=
 =?us-ascii?Q?9TQf4yq2dUh2Ew31BZTfWKYdv8s4SMpQvqTExZDqm4CTQkK/OylwBslYKV9X?=
 =?us-ascii?Q?YeFX/eupQitcqa7Gt8bi6yndVJjlMYd9yne/sLU2LuequTeT7fZVaK/hhOSu?=
 =?us-ascii?Q?qY+K3m8ok8q+UqPHofx853seXWuBmMMHuTY+71JqrtJGCA/hUBE+FOlTKMjt?=
 =?us-ascii?Q?VIABc6fuGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9502d587-1921-4eec-d653-08de808d82c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 23:17:20.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaWLlEYUVNeJsrN79NtYBAANRP9m0Ae2qWsUXQz9qWVhdvyfH3T5M3HiZAsE5lqhCzPUfORYLfS/0WhK/9m9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9393-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email,soleen.com:email]
X-Rspamd-Queue-Id: 228CF27B389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.

The 32-bit behaviour is inconsistent with the function description, so it
needs to get fixed.

There are 9 individual users for the function in 6 different subsystems.
Some arches and drivers are 64-bit only:
 - arch/loongarch/kvm/intc/eiointc.c;
 - drivers/hv/mshv_vtl_main.c;
 - kernel/liveupdate/kexec_handover.c;

The others are:
 - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
 - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
 - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;

None of them explicitly tweak their code for a word length, or x == 0.

Requesting comments from the corresponding maintainers on how to proceed
with this.

The attached patch gets rid of 32-bit explicit support, so that both
32- and 64-bit versions rely on __ffs().

CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
CC: Leon Romanovsky <leon@kernel.org> (infiniband)
CC: Mark Brown <broonie@kernel.org> (spi)
CC: Steve French <sfrench@samba.org> (smb)
CC: Alexander Graf <graf@amazon.com> (kexec)
CC: Mike Rapoport <rppt@kernel.org> (kexec)
CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/count_zeros.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
index 4e5680327ece..5034a30b5c7c 100644
--- a/include/linux/count_zeros.h
+++ b/include/linux/count_zeros.h
@@ -10,6 +10,8 @@
 
 #include <asm/bitops.h>
 
+#define COUNT_TRAILING_ZEROS_0 (-1)
+
 /**
  * count_leading_zeros - Count the number of zeros from the MSB back
  * @x: The value
@@ -40,12 +42,7 @@ static inline int count_leading_zeros(unsigned long x)
  */
 static inline int count_trailing_zeros(unsigned long x)
 {
-#define COUNT_TRAILING_ZEROS_0 (-1)
-
-	if (sizeof(x) == 4)
-		return ffs(x);
-	else
-		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
+	return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
 }
 
 #endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
-- 
2.43.0


