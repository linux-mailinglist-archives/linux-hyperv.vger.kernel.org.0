Return-Path: <linux-hyperv+bounces-11954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fgB+EdGgVGrAoQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11954-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:24:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA4748A44
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:24:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cPCFPiyT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11954-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11954-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E256230AD7BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1F3A63F2;
	Mon, 13 Jul 2026 08:10:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B83A6F04;
	Mon, 13 Jul 2026 08:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930256; cv=none; b=FyNFiYwE0w38u7syP8Xquu7Po20GU28D00rtW/HC1dofSUHDPLrBJgH5UvNwWwqCsA5uy730Idx6Lokr2Y7EPOgS5g4d3Kb8vf6XYiin3YVqDge3Pu9IS3Xii1V0JGUcx1z16F5q2g84s+EDBwujVjpxPGYopmHpve1ItOLdqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930256; c=relaxed/simple;
	bh=McIFbCg2zkYhIbi7Sf6g7Cze8xlsHm6rtHQ9D/28WxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuFoRtNmlNPEwNPcH9aPYLpEpgNsO934Tm39Upx4fzIYTBCyUEhfdBnywuUT4iJDEhoTVOKrmVFoxalh32fLvJ87KCc39KaW+Zs1GSrxQXDJREINkSkpgE2K76wA/B0XBPQyKxr1iuUTzO9pVSr3Ml1h63a2r7bxPPJEwM3KsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPCFPiyT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173AC1F00A3A;
	Mon, 13 Jul 2026 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930254;
	bh=PNYc1DoMQUM6xfsQBKIi+6tgb3rpEJmTR8uGibIZoN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPCFPiyTAyfDEVKOfxbxnv+hHgjlxS9Es7rEiv/cGaQUzs77n1rFgAKoJ3KzcXMCH
	 nqjXi572umghPLMwVOIlgZNzH4IdaD72sBsfZKKsKYXzyMt+wDiOMtiITFZioH4OlD
	 CKau+O/6PZ2zoxYYebiPoyUm7kg284dEVG7WQQN+a3wmJkp+S5w+vAObsmdotO49c1
	 I/11RC3c50+wPfIFgiH6Q4YOH0OCCSxYnE3CR/8KQ6TyY0KyaPeWcVaXUm/YGQmw7D
	 fAIUHaMxRzMoI77JpirdQCEtKL+1rxZcczoNA6FoWIFwBjx7Tg9AMlo0bGZEtEd25N
	 ZJ8k/LL+JCswg==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Bernard Metzler <bernard.metzler@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA: Remove redundant memset() from query_device callbacks
Date: Mon, 13 Jul 2026 11:10:35 +0300
Message-ID: <20260713-fix-destroy-no-udata-v1-2-fcca2e34fd57@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11954-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4BA4748A44

From: Leon Romanovsky <leonro@nvidia.com>

The core always hands the driver's query_device() callback a zeroed
ib_device_attr. There are only two callers of the op and both clear the
structure before invoking it: setup_device() memsets &device->attrs, and
ib_uverbs_ex_query_device() passes an on-stack structure initialized to {}.

The open-coded memset(props, 0, sizeof(*props)) at the top of the driver
callbacks is therefore redundant. Remove it from all drivers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 1 -
 drivers/infiniband/hw/efa/efa_verbs.c        | 1 -
 drivers/infiniband/hw/erdma/erdma_verbs.c    | 2 --
 drivers/infiniband/hw/hns/hns_roce_main.c    | 2 --
 drivers/infiniband/hw/irdma/verbs.c          | 1 -
 drivers/infiniband/hw/mana/main.c            | 1 -
 drivers/infiniband/hw/mlx4/main.c            | 2 --
 drivers/infiniband/hw/mlx5/main.c            | 1 -
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 --
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 1 -
 drivers/infiniband/hw/qedr/verbs.c           | 2 --
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 1 -
 drivers/infiniband/sw/siw/siw_verbs.c        | 2 --
 13 files changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ef9943be1886..1f32537dc528 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -193,7 +193,6 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	if (rc)
 		return rc;
 
-	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
 	       min(sizeof(dev_attr->fw_ver),
 		   sizeof(ib_attr->fw_ver)));
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ec124fbda637..6be8ec53dcb3 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -222,7 +222,6 @@ int efa_query_device(struct ib_device *ibdev,
 
 	dev_attr = &dev->dev_attr;
 
-	memset(props, 0, sizeof(*props));
 	props->max_mr_size = dev_attr->max_mr_pages * PAGE_SIZE;
 	props->page_size_cap = dev_attr->page_size_cap;
 	props->vendor_id = dev->pdev->vendor;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 74afe6eb18b0..9491cbab69b3 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -324,8 +324,6 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	if (err)
 		return err;
 
-	memset(attr, 0, sizeof(*attr));
-
 	attr->max_mr_size = dev->attrs.max_mr_size;
 	attr->vendor_id = PCI_VENDOR_ID_ALIBABA;
 	attr->vendor_part_id = dev->pdev->device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c6f633bd5a34..09c07de5f022 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -227,8 +227,6 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 	if (ret)
 		return ret;
 
-	memset(props, 0, sizeof(*props));
-
 	props->fw_ver = hr_dev->caps.fw_ver;
 	props->sys_image_guid = cpu_to_be64(hr_dev->sys_image_guid);
 	props->max_mr_size = (u64)(~(0ULL));
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 5c907ffce99b..c9b606cc67d4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -22,7 +22,6 @@ static int irdma_query_device(struct ib_device *ibdev,
 	if (err)
 		return err;
 
-	memset(props, 0, sizeof(*props));
 	addrconf_addr_eui48((u8 *)&props->sys_image_guid,
 			    iwdev->netdev->dev_addr);
 	props->fw_ver = (u64)irdma_fw_major_ver(&rf->sc_dev) << 32 |
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index efe2935bda29..a5b3606a1dd5 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -579,7 +579,6 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	if (err)
 		return err;
 
-	memset(props, 0, sizeof(*props));
 	props->vendor_id = pdev->vendor;
 	props->vendor_part_id = dev->gdma_dev->dev_id.type;
 	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 17073e8f105a..7266a6141944 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -471,8 +471,6 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	if (err)
 		goto out;
 
-	memset(props, 0, sizeof *props);
-
 	have_ib_ports = num_ib_ports(dev->dev);
 
 	props->fw_ver = dev->dev->caps.fw_ver;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 02809114fc79..e8bba5a76d4e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -969,7 +969,6 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	if (err)
 		return err;
 
-	memset(props, 0, sizeof(*props));
 	err = mlx5_query_system_image_guid(ibdev,
 					   &props->sys_image_guid);
 	if (err)
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index f90f67afc8fa..e933a53779a4 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -69,8 +69,6 @@ static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *pr
 		goto out;
 	}
 
-	memset(props, 0, sizeof *props);
-
 	props->fw_ver              = mdev->fw_ver;
 
 	ib_init_query_mad(in_mad);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 53ba32d168a1..de83dc0ea79c 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -74,7 +74,6 @@ int ocrdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	if (err)
 		return err;
 
-	memset(attr, 0, sizeof *attr);
 	memcpy(&attr->fw_ver, &dev->attr.fw_ver[0],
 	       min(sizeof(dev->attr.fw_ver), sizeof(attr->fw_ver)));
 	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index d5416b161340..1cf502579ad1 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -118,8 +118,6 @@ int qedr_query_device(struct ib_device *ibdev,
 	if (rc)
 		return rc;
 
-	memset(attr, 0, sizeof(*attr));
-
 	attr->fw_ver = qattr->fw_ver;
 	attr->sys_image_guid = qattr->sys_image_guid;
 	attr->max_mr_size = qattr->max_mr_size;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index dc355b00f61c..3402c84eb904 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -284,7 +284,6 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 
 	mutex_lock(&us_ibdev->usdev_lock);
 	us_ibdev->netdev->ethtool_ops->get_drvinfo(us_ibdev->netdev, &info);
-	memset(props, 0, sizeof(*props));
 	usnic_mac_ip_to_gid(us_ibdev->ufdev->mac, us_ibdev->ufdev->inaddr,
 			&gid.raw[0]);
 	memcpy(&props->sys_image_guid, &gid.global.interface_id,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index b74ac85c1b8b..e281517fc6f9 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -136,8 +136,6 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 	if (rv)
 		return rv;
 
-	memset(attr, 0, sizeof(*attr));
-
 	/* Revisit atomic caps if RFC 7306 gets supported */
 	attr->atomic_cap = 0;
 	attr->device_cap_flags = IB_DEVICE_MEM_MGT_EXTENSIONS;

-- 
2.54.0


