Return-Path: <linux-hyperv+bounces-2002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518288AA6B8
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 03:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CCB1F21C07
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF2137E;
	Fri, 19 Apr 2024 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="beF2/0Io"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DB7494;
	Fri, 19 Apr 2024 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491616; cv=fail; b=fwMAFIeBkpkOt5oKUqc9rdoiF98Ybm31CiPEIl/KgPfCfa/7s61UdONBFey3nkelqNUTdvM4S/Ww6Zp9MiLsncRMnJpntjMKKf1f9tmA6XjRfNFPvEbKkDz6j4hfHNBIzWEPBzheF2f1/wr52I4Xbn4TiSErNV3nDfPmgHZTWbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491616; c=relaxed/simple;
	bh=rL2jTMKGnH8yQrB1zbfrxaou/49yBNSxndQq+Zn3lR8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fwPb4GFtxP0o0MeN/Wm19gjyP9wex2rRNYmd/Q280Ef/pTsUXNk0VYbPFwR1W4OxljaPG0ejtYqas+myXGgwPArBDRdbF+Suc82SywR4dzANwOBvTeMqTsbUCwC/+doJzqE/dosnYDd8C5QuAN15cyO09ifWeyaiXIrNl7g8zKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=beF2/0Io; arc=fail smtp.client-ip=40.107.94.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlaZbIYxBnUUWnL3JEWqQDjaDctGTvAC7v/cXPLtzEDVX+iAxCCpmY2Pk+0qQ5phcifCTzUvMNYmHoBYb3jrfnmNFkTrjg2PiBzyz1lZpCrajHmbsdHYOj7g7dxRLyqtRuN6Gs6lzZdhPtmGrtXFQsjn3qsOm2z5P6/tHSm7YUY0BWt1tmAh/p30t7LowzktszODz6K/fAUCIo0W2W4HU0/9UqEcwErnRsb4Vl0mf9B4e7BrFkCciKyXJF6CJrLW8VCDbw1yM00PKmhB6YKE0qRwnT7c18htE1HouCTdjQB5DM8Rz/bq3UwASuXg2qJLGmBK0bGoUfE51IHBilQi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZtDlFUfNQTguf9s+yuwxEA8WuQAXaac53zvVCrLVIw=;
 b=E3qAaipJcNEyb7p9kmdXXR90k9LNkkzLWiQh8zlXnJUXhKJMXiFSPGBv5o8TXaGR4tXrB+sJ9FOmFnIT5T4DThPMQVd6ahVWArZYi1R261mHDqP4jqC8/1lqFf5KM3ncS9fe0AjiNjb3VQUY1+oUV8uoLCFxDbcWSyh2/sRYT4MOsSiIaKq0AL7Kpd7SbZ6pe2oHlCN/OiRi6MtPT8G1RvKLkp1V2/ZtlyoJI2hyquXwpVAYGYfXoJaXWSjEDSdfUNDG2zJTk8AC+uYHh9yFnNaUcoIz98NH2cy6NaUDJBOnsUlA5rnh2pum/HZdatkN5TuVv/j5FgtPo0UmejnKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZtDlFUfNQTguf9s+yuwxEA8WuQAXaac53zvVCrLVIw=;
 b=beF2/0IoUTRpkJQ/IQ6IiwQX1QelfMtjKw9dIV//9EF6U7sFp9Hm9Lchx6z0c3RJ4Fw8Ye/LD0Olou4TFB2nkPq7+D6Uxn7xCqCA2PXIrx8qy/NVjE4DfdVPd0ZLVkSxKwuJKmpWaxDQNWX8x6FQpo5FBFKVe47FeDZPlaFjw/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by SJ0PR21MB1293.namprd21.prod.outlook.com (2603:10b6:a03:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 01:53:32 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::1f61:f9f8:cc1e:d3ea]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::1f61:f9f8:cc1e:d3ea%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 01:53:32 +0000
From: Dexuan Cui <decui@microsoft.com>
To: bhelgaas@google.com,
	wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	lpieralisi@kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun.Feng@microsoft.com,
	sunilmut@microsoft.com,
	ssengar@microsoft.com,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: Add a mutex to protect the global list pci_domain_busn_res_list
Date: Thu, 18 Apr 2024 18:53:02 -0700
Message-Id: <20240419015302.13871-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|SJ0PR21MB1293:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dc4b73-46cd-41a2-07a8-08dc601383e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|52116005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pWdmds6nXqPivNjSOFDh6G5M0e+4+yq2ZZ2VUUDQl5hKX55t1uYRo/HYL1RT?=
 =?us-ascii?Q?sn9dFZC/KNpc52IAZp63YzPedcUhGCuegTJevxYJqF6i6k3eJ8OSRleJXKFT?=
 =?us-ascii?Q?HtD5PKXoga+vnEwrMG/m1i3AiXY2Gpcaa9yw/vVGhbuVRkTuoXvXA861LB/h?=
 =?us-ascii?Q?Sxp923L5o8u9vjDMq9iZtpK2I7ui7+0b94NdHIUuprhaUS1AXuVS+Zb+tIMF?=
 =?us-ascii?Q?K7u7Hta0/bBl0qwwzoHD9FOKn0KYaY5oWXJm14/Q0idI/SYxSzzDclntvbjn?=
 =?us-ascii?Q?49vQGE7RJhxvwjt4BgShYjMks6SM1e/gwf6aF6njrrnzD28UMTofL8oLvppu?=
 =?us-ascii?Q?27EaNr05LhPiuizrDavsRhIFJZVtQlPj2e9m3Me5Rityi9B8BaOkuc/yagSE?=
 =?us-ascii?Q?SRHxHWOc77pnV1wWX964VG7n7lkFznow1VYiAdeh/e5kRQA4k4HQZ/qEinfV?=
 =?us-ascii?Q?3KrS+p7p3EOp10pg1DfguWgN/+Vv8oLaB/XY+CF4Mj/atoLqeikCpcDAkYzW?=
 =?us-ascii?Q?iWwBlV9NqD0TGRPZFEzImx4lslHBwqKH0mgSNNE049nHwOgmP2gMveNnPnDT?=
 =?us-ascii?Q?kcqOCQDpP+85EGbXmG1sPCh2IwPpNUckVu1HYPeprKLiBy5s/Cr39G254R2g?=
 =?us-ascii?Q?XdliQcRAYifTowx4ly5DCgarrvUjgljx4DxGdzkKGyUfMrZQlQA9EYp5exG1?=
 =?us-ascii?Q?dOQbsYdSin7WBpIlzLcOIYf6GTabJS7XNf7qcmagvRC93jd48tcf9Xu3Dv0g?=
 =?us-ascii?Q?L0s3YuDy+cbVsNwHM2pKLuOHeWH7VPxMk0oBhHCvxyJGh49kVomRarKuF3y0?=
 =?us-ascii?Q?vPEeMjn45aLqtthqHXRnetuRK8oX+WqrOGz4NMk8cxMndH40uLUVX/VOcjot?=
 =?us-ascii?Q?ufT4zmFRUS5QdW1rSuWlxlqAcUrJmABL9Lr6qvHJbI42gNkBYF8An2vQ7EYj?=
 =?us-ascii?Q?9WRio018o6+8bKgHKZvPt9YDWOrW1FW+eC59kcvXviBWxpbpbLxFq6CT4NDQ?=
 =?us-ascii?Q?VSvIIvYs2obabBE4o1nAf+k+nT74347D39EEbNy/FF5/bMcvt5/ibrDjRK1L?=
 =?us-ascii?Q?PLTYpJksV7ZM93m0jOWOO9NXHS2A+KBKJmp7nLRMTmNBzIg7kXLslyaFWOQw?=
 =?us-ascii?Q?63A1Er7KsBRcJfvCbGzT8TEkQw/u/4zuDi/kjwl9EA77WlWKRf58KHMw5hlO?=
 =?us-ascii?Q?BK4g0zgwzOSbl6BP9qS71I0GIwNwIzIbMUJUEs6Tuyb9qtYZdSxMOLiJivcL?=
 =?us-ascii?Q?KV36/KqeyIGf8iOSwqCaBMBIPk7KXNrr+6ONrE+6qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ro3l1HyX2aG+6L4KfX/OrEoXr7jbqI3s0pcvXwJWxw4SvAOMwtNuq/2rz+ZL?=
 =?us-ascii?Q?CA65xba19XplOGg9b/d3B6R00XW/Xzf8mlJ5jS/UxBqgd/iT3+B/BY+ODR7V?=
 =?us-ascii?Q?ArtpIvNZfpjVT7rUcb8NoCv+yHJZAH17s5Nu6A1ZZRg8BMBPd57hZD87F164?=
 =?us-ascii?Q?WAGukaO4+nAHVS7zVMklCUxhITJeLqycQL0VApfIXacacdriaPZ30IKbhbCB?=
 =?us-ascii?Q?HfuJqKCWrBgOKSxtLM/gNRPV6Mj+aVRgKYUEyVhgAebZHYMKLyETeHNPVfY7?=
 =?us-ascii?Q?8o2HVID3A9qJlH4przA5+8+GoalhupdblmePccbj0PVfr1RzTXUIe1eIQCek?=
 =?us-ascii?Q?dPCSq4Da4WfyfPSVDB58VVD+BpbOh/n+ndPAOVvPQI21NS523GqqM7wSufqk?=
 =?us-ascii?Q?3KW2zmSlb/RwJF8oGaU4CUXRIOzUS0wNL3ftQ2DdphVm+ovxdqx7NWFlixNT?=
 =?us-ascii?Q?NYckvJRNa5Pjen+LNYv9RNbdgM4xbCS37v2l+443AigCsxIEcTkVakW/t+oA?=
 =?us-ascii?Q?nZ4/gmtlk2E8oye3Jt1j+g8a51QF2gx7UZEbI2RbXUH6vLycaHldO/zavaD2?=
 =?us-ascii?Q?qMVSzkrNB5dke/OpRWLGkoPRvrbSETl1TsKulkCgbtZ5UnAyyRls2/ksqjm0?=
 =?us-ascii?Q?bg/0Zl8sblCzBMm2NgZLG1cvKGyuvX5m2JDu5V5a4s5xc7a1O6aE0jQkzx4w?=
 =?us-ascii?Q?MB/kCAAMyuTW6jFrAYupqFTIth5N0zkKVKVTGeRn6TxFLgMySEaihWfyiKH8?=
 =?us-ascii?Q?5VVMSzarTUUg5p7b3o5x4JFcZ6LcX73/tx6BWnijJmGsTRUHxTrGRVjkW+0D?=
 =?us-ascii?Q?6UyrfLizVEYqUKtgIZTYrWm0Cu+X0FyIXCQYTGGExWjJVL+XxgMUb0SG9B0L?=
 =?us-ascii?Q?mzK5ALazORgKyqXSDIyybXs4gSZvY0Zahb6tKJGmfVLyIZlJWNBjj3Ah/6Bs?=
 =?us-ascii?Q?CQkBtG0laH4t/udIe2NbpO4lSBw1TOSuRmdlOK24Zwlx7KBlo4WilhKdJ8+H?=
 =?us-ascii?Q?TBpovCGeDUUwEzwGcz3hilWQm3JwzoXymeUtoQOBsiyv+wBlTMkBFqo/2cBd?=
 =?us-ascii?Q?4gR8RhG8zUCX2Kb93hbmqgm79N5i9B8gxaxq7Oq8u6ON0rNcL5KMX7W9dkik?=
 =?us-ascii?Q?VvdMybGipc3A+0EbXUEJo+XQVRECLmDEr2f2zUtlULnf5vsEhHiUIGOBpG6J?=
 =?us-ascii?Q?J4zGtWD2ervsaCivy7E/JYRWNJpxJUa8NtOroHBYPHme9FfRh3GCd0RFCj8I?=
 =?us-ascii?Q?EpNTE7Zjp/p7ceDTTjSJDVCr/ILyJhNrVZNPUFDmbJO7yApQ5X5kD2S34kOi?=
 =?us-ascii?Q?/2qofHvqfOSGXEF5viTUZjbFhYhWA5aFCEcfFF05tRPv9e1sz4rYdOP6dk99?=
 =?us-ascii?Q?Xp/zQI8XOPQQA9GvuKQ94kLid88eA9hgQIwSBztAWMiPW8uWoV2m9B1uz2K9?=
 =?us-ascii?Q?pwq7eOiY+w210DK0DTP4W54PbXDJAOOu2ST0aygDEl3wkkbJqJ25BD4nUMG6?=
 =?us-ascii?Q?wF20ekapWbLQIQqwmvvxwucWe3NCNoapFvqg9VEFJ13cpYaLOqoheV+XxmfC?=
 =?us-ascii?Q?iJOX5oDkxC9PUddFk1F1mB7KIdVJA8OhtDf/NGVGrv3C65FKd7NWRdCMGm/V?=
 =?us-ascii?Q?X7KdVnx/8qsTCntGxK31nGrfQn1hR2dX9Ab3yiEuRaiV?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dc4b73-46cd-41a2-07a8-08dc601383e9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:53:31.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bivz2TEGY58MhSrUuX9Ni2YOa+F9M10BlAH3gM2gZV3ZFLBqyPe1qpbm0ELW+FWOR1+zTsqjJv8dact+ZOsTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1293

There has been an effort to make the pci-hyperv driver support
async-probing to reduce the boot time. With async-probing, multiple
kernel threads can be running hv_pci_probe() -> create_root_hv_pci_bus() ->
pci_scan_root_bus_bridge() -> pci_bus_insert_busn_res() at the same time to
update the global list, causing list corruption.

Add a mutex to protect the list.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/probe.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e19b79821dd6..1327fd820b24 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -37,6 +37,7 @@ LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
 
 static LIST_HEAD(pci_domain_busn_res_list);
+static DEFINE_MUTEX(pci_domain_busn_res_list_lock);
 
 struct pci_domain_busn_res {
 	struct list_head list;
@@ -47,14 +48,22 @@ struct pci_domain_busn_res {
 static struct resource *get_pci_domain_busn_res(int domain_nr)
 {
 	struct pci_domain_busn_res *r;
+	struct resource *ret;
 
-	list_for_each_entry(r, &pci_domain_busn_res_list, list)
-		if (r->domain_nr == domain_nr)
-			return &r->res;
+	mutex_lock(&pci_domain_busn_res_list_lock);
+
+	list_for_each_entry(r, &pci_domain_busn_res_list, list) {
+		if (r->domain_nr == domain_nr) {
+			ret = &r->res;
+			goto out;
+		}
+	}
 
 	r = kzalloc(sizeof(*r), GFP_KERNEL);
-	if (!r)
-		return NULL;
+	if (!r) {
+		ret = NULL;
+		goto out;
+	}
 
 	r->domain_nr = domain_nr;
 	r->res.start = 0;
@@ -62,8 +71,10 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	r->res.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
 
 	list_add_tail(&r->list, &pci_domain_busn_res_list);
-
-	return &r->res;
+	ret = &r->res;
+out:
+	mutex_unlock(&pci_domain_busn_res_list_lock);
+	return ret;
 }
 
 /*
-- 
2.25.1


