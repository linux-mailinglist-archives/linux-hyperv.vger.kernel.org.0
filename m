Return-Path: <linux-hyperv+bounces-11952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcZIG3eeVGo+oQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11952-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:14:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E365B7488BB
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H8XIKnF0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11952-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11952-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB941303FFF6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657243A6B76;
	Mon, 13 Jul 2026 08:10:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF13A5E90;
	Mon, 13 Jul 2026 08:10:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930246; cv=none; b=Ejszz9k/6vGGI3pr/yRq4aFSblFIVsn7gchq+4XynV24i/ESwManSjTWENi+L8thi89OwaDRx5BrGM8lWNCM968Sy2OceyJt6bwBykIKYENxhRruLqCGPjIojWmjM6aTbsGnlDDyFeqPEbQDXPQ+NUSjhnYOoQ8xgQP+DoaPOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930246; c=relaxed/simple;
	bh=GVcKOX0LlfnbpnsJTSyxmzLg8GMyp3OdbGpoxVlBdCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHd4a6h2TeeEGEumfAF3Zr/gs3malQ09OLJDhZchf0ytv2k113zOBu9h7SrbLKWi4ync/k3Yc7xn2573bFBk4VYnqHyWI7BeSneP11kzvU7nHbBDB9PbGl20HlcEFgDcmP00Lf/PB+KQZ5xYEpp/ijplhumCB96c5DiYh53dh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8XIKnF0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D096B1F00A3A;
	Mon, 13 Jul 2026 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930244;
	bh=G40+xK1whqtapmB7GENINsvXeUCc45CyUBk101aOg9Q=;
	h=From:To:Cc:Subject:Date;
	b=H8XIKnF0nMGs6D+BoDZB0R/BGmxEXi1vAuLR8iBg6W8p9dpj5dOgbDnLijOS8333G
	 QWIISzTYM+UXEb44Qud7lSNxFENBLaP3umLyMJlqhpHNIEJM8EHe+u8iuH4aPiZIfu
	 m/xj5urXX8udv1FEJYSHhcQm5A6OiS5joIofNnufRqnf/S2Qi70UM0dpM/LwuDAm3E
	 e0JfXvUI8Kr4AtsR5QcYIBwa81yfpgVRdlq8+3BoHrgt2Np5jcAJghV8G8AlTnVXqH
	 SoKqH8JKXioxb4Rgh2IQ+e02AsMiPp6TVImEFT0gh2FPkwiOpQLOwxq0B1Sf9nuaTX
	 vIudN9XBOCuXg==
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
Subject: [PATCH rdma-next 0/2] RDMA: Small batch of cleanups
Date: Mon, 13 Jul 2026 11:10:33 +0300
Message-ID: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260712-fix-destroy-no-udata-dfa990b985ea
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
	TAGGED_FROM(0.00)[bounces-11952-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E365B7488BB

This series contains two independent cleanups. One fixes the problematic placemen
 of a newly introduced in-kernel API, which should be called at the beginning of
destroy functions and not at the end. The other removes a redundant memset().

Thanks.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (2):
      RDMA/bnxt_re: Validate udata before destroying resources
      RDMA: Remove redundant memset() from query_device callbacks

 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 21 ++++++++++-----------
 drivers/infiniband/hw/efa/efa_verbs.c        |  1 -
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  2 --
 drivers/infiniband/hw/hns/hns_roce_main.c    |  2 --
 drivers/infiniband/hw/irdma/verbs.c          |  1 -
 drivers/infiniband/hw/mana/main.c            |  1 -
 drivers/infiniband/hw/mlx4/main.c            |  2 --
 drivers/infiniband/hw/mlx5/main.c            |  1 -
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 --
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  1 -
 drivers/infiniband/hw/qedr/verbs.c           |  2 --
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  1 -
 drivers/infiniband/sw/siw/siw_verbs.c        |  2 --
 13 files changed, 10 insertions(+), 29 deletions(-)
---
base-commit: 15ae32c4a3551c4c9da457370bdfdd65d171e512
change-id: 20260712-fix-destroy-no-udata-dfa990b985ea

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


