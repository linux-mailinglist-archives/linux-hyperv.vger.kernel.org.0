Return-Path: <linux-hyperv+bounces-10766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJKWON9vAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10766-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82328517C17
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B146302294C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1C823DD;
	Tue, 12 May 2026 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BomWILhu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A741754;
	Tue, 12 May 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544593; cv=fail; b=ua8ut7S/7DTK+P3n5Uu5kWWEfSBgel8s5UVGRu3DxznqTxpVxIeBGg78onyjBhLxp1Qa0V0gx8ORWujbslI4yNtrSazMEic0mnVuektwprgT/FLsVSVP65aMwg5J/jUhpT4r2BQvnvhJhkI8byr98b2NKlRjzPkvuuI6JXNTXy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544593; c=relaxed/simple;
	bh=jgmGCtazmBJkiZOAlC8UFWZIhc1oG+E4tviWP4n7gWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m98RcvJI9Mf5PEFQtjQP4rP2U1tdAc2E+Q39GYv1sdGMmwBmG7YboYYD2DX74MIYo6fWR/Oc3/Q3hiDBk5rfz4kEHKxb6Pf2lQxTWiy9BgSCOBIqin+v+RZHTrtC7K7uHlI5LQzOzpEHP/h5A6/tY/SkJ+gpI2DyDkiyHRVyHTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BomWILhu; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPtROcf8giOB/qIyetYlBO9WSilWaHazFDwYuMGbNAOWowCDoGrnJnd8JhojheRJNj6Nd5Bbtyb6C6MP+9/OEJ9uTLTPpSz1i1SWdNy0X2jpzrKfSQGOZ3HAGP+KPzSgqhNuHGQ+KelpnJ0EhFr1T44ptHbV3HLx6KCNX+PSdylchtjKxMhl0G8fgK3MRohdp/Y4/Tj10B8J+JbndWTPw/huRxmltFybZtLrOb7sT1zOXguTS41d32iamywjWC2YQfk6K1714TNse7+ZngyIY8x4YmNRYapTEPND4/UNABWfaulr9KBgU17Ghz38y/ePamRqMgTVSxK8qYoqOX5/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK7EtR+xQdaipo9zHVYfbWtccavPNVVtsitaLkCODGU=;
 b=CEUMzCnTCs6LuLwnXGNxu8L/lIySEh5T79q/vTecTmA5FAFXlbBOFhF6Z6FHz3a3hBacO1+L/mKwXeQt3qBDtpMQTeRi/52+DDHAnzrwgmet5Mqz5Ezz7VBuSdxmjxPT5N/VvcjfGRhm95GbEfo9XepPD3mdaSDTUZW7pydeDD73WQBRzkv+v7oksHStSI1g6AwuiG3+Jf2yCRPtBc8e75vXebPXRuphjkeYvzc8g8pBmmwBnUw9CNYBxEgvdAkVu7IUY2WbpcIA6Vj42N6r8q2iUf3CluqMsaYjZ+s5NaUqIb0KJjWcnspLseraA5/h8mrGcAXd0pbniJ3FTwdaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK7EtR+xQdaipo9zHVYfbWtccavPNVVtsitaLkCODGU=;
 b=BomWILhu1R/aQSD80VV7qceAfqPlolLZo292kMnaPJz0rKt0grNt0jII7M2++fouGs3Wt+sH+4/GnrJGMEhomWaXCsedqmNCxMyeVMglmqpxYRRMdc4GLhFi+nu8cWWl6y1Fr8LgUcRLnMID1xsu6MUUGkPhrp8LxZ41yWL4ssEh0kpxTak1f09APM8TEHfF+AtkRuxpWrxp3MTK/VmrtemU2+2fYg1YVK+UZfPYY6B6SPL8+GafYDLpcLErSHg0IIYWc9QVK74zJEZoJiv+vcWez/D8G0PiTnUhGnkUmI2Ss943YCoBpShjGdXvPoPj/Nn5jHtOuMVJ8Wmbg9XVMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:42 +0000
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
Subject: [PATCH v3 03/10] RDMA: Convert drivers using min to ib_respond_udata()
Date: Mon, 11 May 2026 21:09:32 -0300
Message-ID: <3-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f4ac77-0025-401b-8cbb-08deafbac355
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ySOVhIbQl/lJUIgbP1T51/AdaqtAbtUgUkrk5S77x58WxgNH/qeCjJ6uhSgWJ+wESNWtBDw8Oxsgfo6ZVKJcZF9DeGGwpjy6JmDMahyubWhl7YIFO0n1+6iH5XVkIWHYBdzMyzPVzg+S+i3tNgNdj1fwXEqcKM/GaBey5EOPFEXz2IY5P4awVt6Rh9/aMgS8L7/PXr2kLxflx6FzBkEA9Y42+HfQTqhYUjjhto4laXZ7+0Y1xWbDys8YAOpk4qpPpWeVMjQ2m0rVcnWB6USjM79PrQJXBMzUGlwVCe9GF3K6krMZEfHhEbvrJSJGtLfIZDovYH9bwbifIdFgDqNa3tEDMEm22iTXlXZP7s6Y+Oxucu2eWwqtnB179lm+41bVhYvm3UyDTm58ya5Aago2KPXiAjAOxGZDVAW3/SIIj2xn02N8d+dBLJbBnG5VINkoxtV1ixx8PnC00zqiU5Bcl3Uf6A9ZA3O/Oys8m/6baiFBHkzDGrAMYs0RJ13VKqqUKcwrLc2vwGtTeoRuFgewWPQswa2Ks65KrB9CyvvGJ91OcMB2GKNxbupkGnQGkRvagAW0biCprEfHCtH2ZdB1i+R+ctG+SL0b8Y44J3gSLHRl9P2op3bSKn5LY3PI84tO+waPqpkXJepV0bwiY4vMK8E2axuadKn+6OCAK7QqLrPQpmpltANWLUNZX2IFGFzqY+wiXdiRYtpDSJbz2XyCxBmdWNWokNCWfDQZ0m3dX+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/eQz755bYatfDBgPQ6BZSrKAOOnT8hQfUmb3jZj2onNdhC2kTSYcx/Rwwv8?=
 =?us-ascii?Q?lu+SPWQQDz4jrGG8tiNbFMjETrF7f/d4l7J3u6WwwzjDEtgDHAeowULPstsk?=
 =?us-ascii?Q?jcT+DjLwmAHOs4gC8Pe2S7yOg0R+gkIqS2aRN7bGZ70Dbe6Qh03Uq+2dEZvv?=
 =?us-ascii?Q?YCiNZObKeGd5WrqZddLYo7rE5F1u/Y0VbVJax5t1C2hWiQhTWzYouMx+NZCw?=
 =?us-ascii?Q?AG7cwXBtwT2xj7DksLjQpCg4eWxxZr2OmKU8BP3BZLVswh0KdbDQY2i0kgZg?=
 =?us-ascii?Q?5PM+SFk0JEF+KOX9x7TfdrNvmv+/z0Bam1uxcOAUeMQLLHv6aHv6FYVi0SFi?=
 =?us-ascii?Q?bzedU4kZtndpmNWXZMV8Ql8Yi9wAdHUB8odoZuSJGPF8SrokLmcicFaubhiU?=
 =?us-ascii?Q?RRIUM0UmVavlE0OLEXz88UfuB/D++vDzFcKImtgcq0O/xgOJS9fBL2n3eQ9s?=
 =?us-ascii?Q?EjLf5MCvgnhdq3uOH6+lvvout0mcsAuf4l/LpFrNnKV5YAU2BLBTjdYJ1lUL?=
 =?us-ascii?Q?JaRGulLfcNcYSFR6j/45a8ioQ8BZ41a+so4mpeB+UpuTzIhkU1IliAXwPpUE?=
 =?us-ascii?Q?OBhWxW69+wjF5KJil1AQgg+qo2fTdzs57sjIsP+D7QJKKhIXbQF/Hyq4/KK/?=
 =?us-ascii?Q?yiZ4IcITgpX3MB4SA3ngu48y8mxImr3BBygE36+Wm6kZ/CYCRhddXbmnLJuD?=
 =?us-ascii?Q?5D66R6G1rKH9fNXLrRp9yAvAq6g3OkWfgDqk4mHdCJRhbJLdnlUqSPzrQ/YW?=
 =?us-ascii?Q?ZoV4RgqM5FVPuBADKqWmcJWOUZxYsuyQA28+UQMCl6GYxx2Syrb/OtzJxETN?=
 =?us-ascii?Q?V26wwOXWAmTvEOY8t2pmGH6XUNonEuzAct4uKJQGQb8FOJU7f6Ku3yk9NbxX?=
 =?us-ascii?Q?EwjcPC1tziQwYKnYlZxc53U/aYXD8/y4kv1GpYQL/RBlOrnEO+G2loRtLdhj?=
 =?us-ascii?Q?iurb7KSyGFBbkl9FFc9r3JG1m2RNqG1B6u1DOAKsQxdYboBSQaPRupSV7Zsx?=
 =?us-ascii?Q?/CEYjUzWrc+EPAVccMBM8sclZ1N3FEQ7NBrFtZjLiYx4HGOUDC74SsmD/S5u?=
 =?us-ascii?Q?jk7/1K67ZhJ7G3KYTv348L72eBRUUCYHIMnjSuzqoy938Ne/woAPx35S29z2?=
 =?us-ascii?Q?z76UaSj6kFjZb6Ss1y5Lbf9LjZv0X43A7GLb7/V0Hk6S3Mx6XorUmobTjFqn?=
 =?us-ascii?Q?ch56XthQS41haeKQgdwUhTtHnSYOIJiSG68G4fvwSGvWCHTZ8VqZHucWRAQQ?=
 =?us-ascii?Q?wbvzRcPaGC8QYOIjVU2sCnoja+m1w8dVZfNLIWvhJLCK0FuzyrcilpQ6sDp9?=
 =?us-ascii?Q?f+doNfWLe3jSl9HflCH3txxbVBBy/Sa2iwh9YRmDwYIUpAYojBRMmo99ZHoe?=
 =?us-ascii?Q?RkGqlV/L+qh4zeh92/J5awGhuYgCRx8JEbInwBSOiKfXpvn6+altYGGXFh/t?=
 =?us-ascii?Q?B0vekKeU0Hhv0FQfmo01caOJF+YEJ/mozMnuDcb+3GKQCRIARIoCsce1oYDX?=
 =?us-ascii?Q?FM2zTkfOwMia393i3Ogr2z/tj5ULGJNFgoU7y9n2cxJB1EUq2J9auU8d37/R?=
 =?us-ascii?Q?YCMv3Gplfd4FsLl3fw0sl/qBI4KMizv3Do+I/5zmiJYuu/vGCWPHnAaMuje+?=
 =?us-ascii?Q?ga/fgk7WgdKtOgQLmnbMYSPzQ1HBSqOyMhCcOFVyiz29r72sCbxrcCKkmL3e?=
 =?us-ascii?Q?OMfx9z7MViAtukhZwg+HUg+Hjq0Oq6ZEk2ox0fXDQuO+wpmY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f4ac77-0025-401b-8cbb-08deafbac355
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:41.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x/GQqAlgOiXWRpN4Hkvn/70AKR/Mnb1mXwO4eFOBmZtZzsgRQckBdyR+PNEUhar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 82328517C17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10766-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index bf04ee84a94392..e333a8c4acb52c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1236,12 +1236,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
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
@@ -1494,11 +1491,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
index 8b94cbdfa54dfa..241fc9980f4f51 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -477,11 +477,9 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
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
 
 	return 0;
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
index 2d682428ef202a..f2547989f42290 100644
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
index 0fbcf449c134b5..ecf5910dbf0702 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -557,11 +557,9 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
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


