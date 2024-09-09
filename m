Return-Path: <linux-hyperv+bounces-2994-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65319725D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 01:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885052849C4
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE418DF7C;
	Mon,  9 Sep 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="is9+b+Gt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AF18E354;
	Mon,  9 Sep 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925708; cv=fail; b=tTt7EGNukyhkfpAg5LLra+KlJNjnxKo8zlHS3LCq5F6ob3nKyEiIwys1wt2exgzGbnS/C7tQ7Nq+o8Re092s76zqbjLRfcUkRhdD7NI+ecBDzimHsu3ZXJq9wMudC5kWZVwy/jn/Q6hKrZl0PWgE+sHlI5QqzBJAuAk5+uBtv9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925708; c=relaxed/simple;
	bh=oEkidC+usc70HeLJemgXf40CTnEkNFHTo0G98x3ochw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rcx74K6o7nBlnYV+dzjf4/JJ+bvI324SG/pC7suc+LMVWCwQqK0UK0UzoDaRAGVVbEv1nofqukoqRKMlm2rhdk/Znw/7euEGR7T3AfvuMfKBgzmB7aZAhaaC+qTcS3kuS6hWXpntDjSBQpqFPrRPKXz6X87khytxUvTkfH2qvvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=is9+b+Gt; arc=fail smtp.client-ip=52.101.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlrGqEDL50mmGE1WTdhxyP4xBKX5HqtJNLe2Yu0JKUqJSAgpvVjxTNju0wxtIQB97mBFQtMMmcCZn9P93UT094ZHVLB8dpBzArgaH4By+EnLc2+CGBygn7SabmoTRKerXjLG8Lbq7MOTqP/nlLEn/fvkIXuzFKRKdwOrS9W0B7oOwbCKIeoHcpJDnxkVDJa5P6Twk2yIhW5wrfrF11wg6H/A2I7WeOyC4ugUPuzupO484kyPMG81xy6Xf//MCvBtJMU/XQ3/RrTySABwG48l467vrMRXCSq+mXCWQ8eNpb7XsrlMq1R+L7GTbS+3sHJXjEdIGYN+u3YvFavEo0g5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRsXgfAEiFHwYm8R46dp6WsADTije42Cic58rGvBdKQ=;
 b=XBpoisQYYogt6JQKZIs2K9v62SYvA08oFPAZxl9EZtyLB6vpvXWq5fcuFG+ULA3npQg9k/LTs8aUffs4IbFFIylAKONENpzNFS2ttTDUGczYhY4s38+4AXbnDhcAiCp42Y9cX/ywpmRsE8FXK0XnptER8YXZOED8nzw7I6tOmwAhpt6ssLW/DVOVB+gixNXBSZO/OSE7LoBrJbyVaVxgtBJQpmCNe6kXvj2aGhqrULGcOZ4I0+pbAwMuUulphIjflK/J5gYsmJvxwguwBR4KiuWRFE3ACXXcF83cQKUpkML8GcjaTvB21OZZhg+Rl443KU33qyYJxl4dy++nlzbDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRsXgfAEiFHwYm8R46dp6WsADTije42Cic58rGvBdKQ=;
 b=is9+b+GtUb2eTopwNhPKV7YT8x5Xb9TpLagBEPjE6cu1VRNMh6gfqlK0SURcHf05K4odhGQvuVPOMUmnp0/FzsHn/KWStjCgFW/7bO/umIqCk9BY7Y7ZimX8XNZ8GQ2KsfiQvuQHGUHfsLgtwdoC0NcGGe9V1ThioECJdjCMYAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by SA1PR21MB2019.namprd21.prod.outlook.com (2603:10b6:806:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5; Mon, 9 Sep
 2024 23:48:24 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::fa84:e37b:af8f:a1cb]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::fa84:e37b:af8f:a1cb%3]) with mapi id 15.20.7962.008; Mon, 9 Sep 2024
 23:48:22 +0000
From: Dexuan Cui <decui@microsoft.com>
To: mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org
Subject: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not initialized yet
Date: Mon,  9 Sep 2024 16:47:18 +0000
Message-Id: <20240909164719.41000-1-decui@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|SA1PR21MB2019:EE_
X-MS-Office365-Filtering-Correlation-Id: dbabe04b-3f3b-49fa-ab7b-08dcd129e38b
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yx8qfhTJRRLNJNY76tgfnMxWozptyORUYIirAq/rYJ2RpMQ9glXUPOU4ezGT?=
 =?us-ascii?Q?E+QryOqvsX5jRNN/OIMiAOW7LmdLHCegwcWuAkBwz0vntSCFSE0ZA2+nfsUQ?=
 =?us-ascii?Q?bEJwyqOP7MZQhaJcpYWZ02EgyNsH6JsbeM7LJyrOPAFXFdi0KI+1CLncHGQQ?=
 =?us-ascii?Q?Vwwx7H9DuejjnPezOs6m6LBgpOsdrdzLPpF0m/wUfj6W0sasDfMfhdSRqI2n?=
 =?us-ascii?Q?vITw9Hmfg0HmXNXo2ubUvrfsc80sVfheT0Z4cmseScBcVkl8bvdgM22XZYn7?=
 =?us-ascii?Q?dgGZFamVcAW7/s6O1pjSMt6QuH7e6dzf1/bp0Bo0Vc8uXwfBvYdir4YAKUbb?=
 =?us-ascii?Q?zcn0xVgZMdZfifUV1JITFntzIK1qvDqQ4Dc6Q0AzzI+5dOiEMKpwD6g30e32?=
 =?us-ascii?Q?S4AxLjWexl7ktCyC9vjMZu0n7Tw2gH4h4eY5un2z89H18rbSGdQLPW8cUdSc?=
 =?us-ascii?Q?/27+YoKicgoiXgSqze4mrRb6B1QbKSNGACNcSbXw9ORKvY9OdlgYbsfpo3rH?=
 =?us-ascii?Q?0uSlBq6VnD0m9OmnAErHWpTX7onaKuhFLRkFqs8si0R9KJf9l5KWJ9oMm06o?=
 =?us-ascii?Q?EkHJ/UK1A49kwN+37IceSyXX1hzy6o0oZfys4Ipry3EzA69RiuvSscvxA9k9?=
 =?us-ascii?Q?gf/slw9QFskdZ/ncOSE+EaUztlmZVmAPlBSz7M+sLQx16dAZNHyEkIqkoNgE?=
 =?us-ascii?Q?+YXCQuJIhRZZ+awy1aphttxXcW7CAjeLn9Nm5jkcLYSH7jOisiMi5ZLRCZSW?=
 =?us-ascii?Q?REeGWuhdHGX7lTYZoajaQSudMU6DUv0SgOqVGaUolLnmUIK8NcUQs7R5whs3?=
 =?us-ascii?Q?IXl6pPAbEkP1Mc3+/iyXuz3j9WOzz66iRyHD1j4cnWU2YdgUEvkmiaQ90sgl?=
 =?us-ascii?Q?i27PtnWmtUevViW5S7EW9i/Bh25Cm3WoQ624sXCpKzVuY5GUfgWSzw9JZcxB?=
 =?us-ascii?Q?KwVsYhlMKxWyIyBNo016VgryWu+DPJyIt8yfrrzIDgggd9toIs4wYEacjRUY?=
 =?us-ascii?Q?VzCoLLFWVX48/0IFl4kx7HqWlbngj7e46KewcnKmodxkLBAw00zXALWG8Quq?=
 =?us-ascii?Q?VkGt3TEMZETD8scIFKyAE+uc8HiX9YvwKI4Wl+3VZ8qzxvSL2McnZkBtoAdV?=
 =?us-ascii?Q?b0mVG6NzuXloRo9sVWs7NpG/NPx6aEkJOlI4ve/wCXXy46KeddhFqsnkEpPs?=
 =?us-ascii?Q?T0x5JmQ6Xl/ZI/l+mBzUq8ZV5dtDOsPqn091HUgKRoV9csICI8+fbf19359e?=
 =?us-ascii?Q?FpsQlceCiAsGnQMh9cefg8yrhg2Pt25jC+uKiE59JWYuL3btmODpZVQihkRb?=
 =?us-ascii?Q?05V79cysxN46NCVUzcJXQwO60lN8vuLBWCLQGLep3/YMcA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?fsjyaNQAGFScc+FblZ6boBWcha9qGaH/2GaReKy470OoQcAN6IS6Z9c4zAVH?=
 =?us-ascii?Q?BhOHtOTi6fBV0N0GT692+XqFfxBrPWXIcWZ4wsDaMZRnHwBkuW4dRE6ACM/v?=
 =?us-ascii?Q?hkWLMeitdczWBzkSKBaXdTx9083yzVsPGRHhu0UtxjiYDdLvThw/JFMnKslM?=
 =?us-ascii?Q?29kWSMcp07AsniFrQsdr6M3l1FZILLkJEaJtTPFwDf3/VrC47ZNvF8uedP3a?=
 =?us-ascii?Q?s6lwyfk+h5lQpxMEthLNjd5KQ/1CoiJvzXn9H/O6NXslOxM+miMMZgiVhWuZ?=
 =?us-ascii?Q?tI79MmI4ZEmj2CRQw5UBbAolhNazCF8MYnor5kOvmMyKcTekBFLpNnxPi0x5?=
 =?us-ascii?Q?U28k+usl2pYTVvda5+hs1d1s0+hvXVgnH6gBPWcnrfD4kWGZjSVQ/MHQ0ziF?=
 =?us-ascii?Q?kbnYIv7ufcaE182jRz1u+dA/Fkvn3bUGV9vfLn000/4Qn6ub+zoXGqc62LFw?=
 =?us-ascii?Q?8yzCli4rE1rznoDRa7RnyaoYteX+RN0x+ULoClgZjZdcR/v9Dz1PUFVas3yy?=
 =?us-ascii?Q?Apy4Xj48VPkeDdsXeuEhnJaMCnbv3x3u5JUILCgijoJORng5kn8MD5hGhEnO?=
 =?us-ascii?Q?Jv6KxLqcac3GWb+kEov2T4kP9gGISYpzclWzb2575TPHFuCB/pPZ8xC5lrfA?=
 =?us-ascii?Q?wPP60RWZn4SIp77PPT6NeEQpmVZzUdGD0SBVOkCqlgx0V+T0CIRa2nvTU/ut?=
 =?us-ascii?Q?n7457Qyc2lIGDVx6woNVdxLGkoKYm4TKug7RkFYKPb3BeUbpU65Kt00HBUGb?=
 =?us-ascii?Q?DWeENoJvOc6u14q57rm7qbPUaazgVZ+Lzidc0NwGbSee8b//RivgRF7k1B+2?=
 =?us-ascii?Q?OyGWn5LWnFjrx6PxEMbqSkgvot26SGW4wRSQEd0srtyrUeIAwmeWr5NJrdDy?=
 =?us-ascii?Q?yQGPNmvS5Hlt86fgb0LiZFIsM9Wr4n/XeJsNbbxUNocWmKMYens/FtYEkx1c?=
 =?us-ascii?Q?e/864unE6SUs9CO7tlq8hfywI8vMkZsCfuaBcySRDN04nutQU3qlgKjvKo3z?=
 =?us-ascii?Q?v5Wr1hAgBXeiibFdEpRM/38GreAfBvrJmolWdRUfKPu41tAnHmB3EUXUAtbx?=
 =?us-ascii?Q?mHvug23UvZwSm32EsWOapidlRvjPeCdxG3TLRHX1Y8LPkiUTQf1cahHhcd1j?=
 =?us-ascii?Q?XHp2ox76vf+03sk68oJnWauvt65Jo3CE0Ct89JBN7GC0GLJVVulAh1ReTY0h?=
 =?us-ascii?Q?8DAdjSAEHLJr9wKtRDkdgT+9IqigArpj4Da8hckojm0DawWGSCakVdygKpWN?=
 =?us-ascii?Q?EI9Wo705/1g9cdus1CB6Ft14bqd4zBoNINCGF0TwwetXD5/PwViXC3yP3WB8?=
 =?us-ascii?Q?pUPzpEOhAeXK1iF9Nl0vhNdN/sEgqtInLugvKREW60nhkDM7GCjCkcpf3du8?=
 =?us-ascii?Q?YY91O+Zo6pLSGYrGYi2RbXuS6yl0ZdRYxH2TVfEHyg/zEefM1268SW1uIJ8x?=
 =?us-ascii?Q?VXwv0LJvKAkf4bnMF46WKhji0iu2Iab3cHHUdsSj45+fWhTlJb0c6l8UZGhr?=
 =?us-ascii?Q?XYF3fVdWGj+UJ75gV+TUWujU60zs9wBMHK+G2FLkTsnVN0spmPcxsE9M68P8?=
 =?us-ascii?Q?JFUcdpDE3jR3hO0wuQcUnjKmKLibhD6GeAe9szceynm8fY7cVHGTC04GGeUj?=
 =?us-ascii?Q?lyaMPdj+pL3pBKGfp2QdP/4c+A4o2ln8ql9aqV0Z63BC?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbabe04b-3f3b-49fa-ab7b-08dcd129e38b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 23:48:22.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CrjogQA7cp0giIYBJVTCFQnzIXuIF4+fiNmDpbqaTVtaWIlWg0q7sWOXdUgOXDSfmX2gsRMcmUnxIchqq96hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2019

If the KVP (or VSS) daemon starts before the VMBus channel's ringbuffer is
fully initialized, we can hit the panic below:

hv_utils: Registering HyperV Utility Driver
hv_vmbus: registering driver hv_utils
...
BUG: kernel NULL pointer dereference, address: 0000000000000000
CPU: 44 UID: 0 PID: 2552 Comm: hv_kvp_daemon Tainted: G E 6.11.0-rc3+ #1
RIP: 0010:hv_pkt_iter_first+0x12/0xd0
Call Trace:
...
 vmbus_recvpacket
 hv_kvp_onchannelcallback
 vmbus_on_event
 tasklet_action_common
 tasklet_action
 handle_softirqs
 irq_exit_rcu
 sysvec_hyperv_stimer0
 </IRQ>
 <TASK>
 asm_sysvec_hyperv_stimer0
...
 kvp_register_done
 hvt_op_read
 vfs_read
 ksys_read
 __x64_sys_read

This can happen because the KVP/VSS channel callback can be invoked
even before the channel is fully opened:
1) as soon as hv_kvp_init() -> hvutil_transport_init() creates
/dev/vmbus/hv_kvp, the kvp daemon can open the device file immediately and
register itself to the driver by writing a message KVP_OP_REGISTER1 to the
file (which is handled by kvp_on_msg() ->kvp_handle_handshake()) and
reading the file for the driver's response, which is handled by
hvt_op_read(), which calls hvt->on_read(), i.e. kvp_register_done().

2) the problem with kvp_register_done() is that it can cause the
channel callback to be called even before the channel is fully opened,
and when the channel callback is starting to run, util_probe()->
vmbus_open() may have not initialized the ringbuffer yet, so the
callback can hit the panic of NULL pointer dereference.

To reproduce the panic consistently, we can add a "ssleep(10)" for KVP in
__vmbus_open(), just before the first hv_ringbuffer_init(), and then we
unload and reload the driver hv_utils, and run the daemon manually within
the 10 seconds.

Fix the panic by checking the channel state in the channel callback.
To avoid the race condition with __vmbus_open(), we disable and enable
the channel callback temporarily in __vmbus_open().

The channel callbacks of the other VMBus devices don't need to check
the channel state since they can't run before the channels are fully
initialized.

Note: we would also need to fix the fcopy driver code, but that has
been removed in commit ec314f61e4fc ("Drivers: hv: Remove fcopy driver") in
the mainline kernel since v6.10. For old 6.x LTS kernels, and the 5.x
and 4.x LTS kernels, the fcopy driver needs to be fixed when the
fix is backported to the stable kernel branches.

Fixes: e0fa3e5e7df6 ("Drivers: hv: utils: fix a race on userspace daemons registration")
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/channel.c     | 11 +++++++++++
 drivers/hv/hv_kvp.c      |  3 +++
 drivers/hv/hv_snapshot.c |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..685e407a3fdf 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -657,6 +657,14 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 			return -ENOMEM;
 	}
 
+	/*
+	 * The channel callbacks of KVP/VSS may run before __vmbus_open()
+	 * finishes (see kvp_register_done() -> ... -> kvp_poll_wrapper()), so
+	 * they check newchannel->state to tell the ringbuffer has been fully
+	 * initialized or not. Disable and enable the tasklet to avoid the race.
+	 */
+	tasklet_disable(&newchannel->callback_event);
+
 	newchannel->state = CHANNEL_OPENING_STATE;
 	newchannel->onchannel_callback = onchannelcallback;
 	newchannel->channel_callback_context = context;
@@ -750,6 +758,8 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	}
 
 	newchannel->state = CHANNEL_OPENED_STATE;
+	tasklet_enable(&newchannel->callback_event);
+
 	kfree(open_info);
 	return 0;
 
@@ -766,6 +776,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	hv_ringbuffer_cleanup(&newchannel->inbound);
 	vmbus_free_requestor(&newchannel->requestor);
 	newchannel->state = CHANNEL_OPEN_STATE;
+	tasklet_enable(&newchannel->callback_event);
 	return err;
 }
 
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..ec098067e579 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -662,6 +662,9 @@ void hv_kvp_onchannelcallback(void *context)
 	if (kvp_transaction.state > HVUTIL_READY)
 		return;
 
+	if (channel->state != CHANNEL_OPENED_STATE)
+		return;
+
 	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4, &recvlen, &requestid)) {
 		pr_err_ratelimited("KVP request received. Could not read into recv buf\n");
 		return;
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..f7924c2fc62e 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -301,6 +301,9 @@ void hv_vss_onchannelcallback(void *context)
 	if (vss_transaction.state > HVUTIL_READY)
 		return;
 
+	if (channel->state != CHANNEL_OPENED_STATE)
+		return;
+
 	if (vmbus_recvpacket(channel, recv_buffer, VSS_MAX_PKT_SIZE, &recvlen, &requestid)) {
 		pr_err_ratelimited("VSS request received. Could not read into recv buf\n");
 		return;
-- 
2.25.1


