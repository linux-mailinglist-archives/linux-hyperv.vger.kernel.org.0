Return-Path: <linux-hyperv+bounces-8807-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJanLgQFj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8807-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31613561E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38AE3098822
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB23542C3;
	Fri, 13 Feb 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKXiziMZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18A352921;
	Fri, 13 Feb 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980369; cv=none; b=M6YiApUcIUKnB0BHTrGhhkas4GKHPzLZrfxLEPShN/n/00/Iep8fSu+rvicEBaeuOPNtqjIihS0ggZrogsHgnXv8XXsunus2X+L+IMVNPOKHZejhnw9MNKQicfgOYUt1Dd7QE2Aju5sz+thKWWG9YgoJBfwyvjzSKOtJpOnSlqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980369; c=relaxed/simple;
	bh=i/qKvrjNfvmFI1sFm/qwVSuao4YeuySQMuQRd70krlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt6suvXGAATiDwGxwkaVsskQkIVI+0/BhjtKbwMZd52wKy1t4dYWsVWefvaKudxXg7xW4R0WRCVj3QUVBHfT44ns5WuIOxoeyiNw7Zw2BQxDe/nQ7YmCvfqa06LbnCgbyxJ4N6syeA8tQJM/FEoT6VZh6v2cTukbee9NKinPvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKXiziMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD2C116C6;
	Fri, 13 Feb 2026 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980369;
	bh=i/qKvrjNfvmFI1sFm/qwVSuao4YeuySQMuQRd70krlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKXiziMZYUNuGfCQ0RULIqDte/ZGcOWiRPBH84iwuWflzmGecugR/bfnatOMUSehV
	 fVLtP8JQ+333JomO+2dkf4vdI4/vn/IgNGR0aGDqoLPcYovkOZKa9pmiECk2V47aN3
	 VSADKx5ijPiFho1qXXXHq7s2Vh5E+H7SKWWZkLTOPyEDwW8zRNFc5G7FQrhMdezaU+
	 LHP9mn4ATVmhFM0u/Q4i35r03D4z9Yj5QQWp2k7NkAHc7fETVSOvY0LaSv5wK2uksa
	 fHmy/Ctd60nrAYatFEddhV2R5/U3UBYX6KHEThdswPFFxbBQYuGUSEnQplzxN8ye0K
	 ZZo6BNUEwCfsw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: =?utf-8?q?=5BPATCH_rdma-next_06/50=5D_RDMA/efa=3A_Rely_on_CPU_ad?= =?utf-8?q?dress_in_create=E2=80=91QP?=
Date: Fri, 13 Feb 2026 12:57:42 +0200
Message-ID: <20260213-refactor-umem-v1-6-f3be85847922@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8807-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F31613561E
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Align this code with other locations where efa_free_mapped() depends on the
presence of a valid CPU address, which is guaranteed when qp->rq_size != 0.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ae9b98b4b528..bc69aef3e436 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -579,7 +579,7 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 
 	resp->llq_desc_offset &= ~PAGE_MASK;
 
-	if (qp->rq_size) {
+	if (qp->rq_cpu_addr) {
 		address = dev->db_bar_addr + resp->rq_db_offset;
 
 		qp->rq_db_mmap_entry =
@@ -828,7 +828,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 err_destroy_qp:
 	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
 err_free_mapped:
-	if (qp->rq_size)
+	if (qp->rq_cpu_addr)
 		efa_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr,
 				qp->rq_size, DMA_TO_DEVICE);
 err_out:

-- 
2.52.0


