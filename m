Return-Path: <linux-hyperv+bounces-8800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BMMHh0Ej2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8800-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:59:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EC1354D7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9E93053774
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9173542C3;
	Fri, 13 Feb 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXcK581z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AF3375AE;
	Fri, 13 Feb 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980343; cv=none; b=Y676nQODG9491N1GuGHYg5kyHHlmVOtiS0DFsj0ys+Z6CHQMCClUz8YPnozdhiSL0vAzc1fK1ebT4cF2miUPi7AtUJgiq2pgtrVeKl0N9d6OKgmkVjsYCdA75m4mq2uLqO5aqb7mPDww5seEiebLlOUALdyW3KW0An10pm9hMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980343; c=relaxed/simple;
	bh=jz3JOuJAEdlHIXpm9EsHibnx92bVzq0Q6O7Dk1LpG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTAzDCmGEgF/ujxeWiOQJaU09CUwxWlv23sHPp2nzuMjcufA0qe5G1+QufKkZWNBQXKnY++9lQoY4PyG6rlGraqdXkY3d9zGDfRI5AyA+eAHVuZnOspsBZ9pdiMSgeVUxRbYDeSkrX9rbYr1Bljvz3BExLWGPm2zgVf7O9K8sGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXcK581z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4544BC116C6;
	Fri, 13 Feb 2026 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980343;
	bh=jz3JOuJAEdlHIXpm9EsHibnx92bVzq0Q6O7Dk1LpG8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXcK581z65PbPgTSohJwqEMUC31igLBa03AIE6Ian+zoGOfSMZANlchpyIiT89l3x
	 ApJwW2h8Zf52A7hPh4hChvnAVkTxY9jYo5W8t43cqUZNuxZ9vSSDXfW5f/1SW41pqh
	 35Mvzh6tClsjpP88ymnCbjRu8DnsQLAFLqjoulJzCGjBwsjbQTiXSfz3XHABbCObXi
	 ZGr9665mD/9wLWL0rhdodOl24mKyVy6arIwLks+45/LahLdSYRpl9Eit+uzF3SkMSU
	 XU0ea5QRPG/sZEIayaptGPeiXty9Zyd8ICrV+TkWO2VT85G7772UUIm8bufGSg7ITr
	 8zC/cG95/gYjw==
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
Subject: [PATCH rdma-next 03/50] RDMA/umem: Remove unnecessary includes and defines from ib_umem header
Date: Fri, 13 Feb 2026 12:57:39 +0200
Message-ID: <20260213-refactor-umem-v1-3-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-8800-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: D39EC1354D7
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The ib_umem header no longer requires the removed includes or forward
declarations, so drop them to reduce clutter.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/rdma/ib_umem.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 084a1d9a66f3..c3ab11e6879f 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -7,13 +7,9 @@
 #ifndef IB_UMEM_H
 #define IB_UMEM_H
 
-#include <linux/list.h>
 #include <linux/scatterlist.h>
-#include <linux/workqueue.h>
 
 struct ib_device;
-struct ib_ucontext;
-struct ib_umem_odp;
 struct dma_buf_attach_ops;
 
 struct ib_umem {

-- 
2.52.0


