Return-Path: <linux-hyperv+bounces-3723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEAA171B0
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBE61888430
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA19F1EE001;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nBhej7vJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673FF1E9B20;
	Mon, 20 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394052; cv=none; b=evmdtpg0fZME35AH5MAiCDSqPlPSdFkPanBvs0mOUhacYDIVnqFHxALmzH+baoI4N8HdM6qMmTAFzpsLc0MCw8APRHx8ysbsOGQrtFOaxu1Q61mKhYhV7x1mKxxwG3RChSFXaPXX8xnY7Coumdknjk28a2xPMqUTPtsGA3aJ7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394052; c=relaxed/simple;
	bh=wuX56+DQOvYjaNsw98n3j2eXCwZhI+JlSc+nPLNqiz0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EmeS5PP+mdhQIhM180MbKwpRaNnwVH2RVH7NPFAY2A23bFMRhjTlLxHLJICXFI7D6BSxeJ2C+qH1CQ4LpnHX31r6EZcWdNNgDtx/T2kovHqaxIIASGS9S/A+p5PR4DtD/Jca/gPZCku2LCeKRinI9swUe9CzspojchAHArPYleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nBhej7vJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87405205A9C5;
	Mon, 20 Jan 2025 09:27:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87405205A9C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394045;
	bh=VKZbVZap0F5x0srxgVW1qFq2cio6NdADwwKwhGFyOp0=;
	h=From:To:Cc:Subject:Date:From;
	b=nBhej7vJrFCxrIHHh+5Kvjs5Rj8dAut6DE+na8TTwcohvb8R8tD4gBNpfuS1GfW8i
	 GRPx7PfyOiJ/douBcPbuEKv3zj/LSgfQZurFoVYx5Uk6o6Q2GO3819FJutlU56j/KD
	 TIoT6ktEEvUkF+LdBuEhEttn3LYtjHOoXTXwRqoo=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 00/13] RDMA/mana_ib: Enable CM for mana_ib
Date: Mon, 20 Jan 2025 09:27:06 -0800
Message-Id: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series enables GSI QPs and CM on mana_ib. 

Konstantin Taranov (13):
  RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
  RDMA/mana_ib: implement get_dma_mr
  RDMA/mana_ib: helpers to allocate kernel queues
  RDMA/mana_ib: create kernel-level CQs
  RDMA/mana_ib: Create and destroy UD/GSI QP
  RDMA/mana_ib: UD/GSI QP creation for kernel
  RDMA/mana_ib: create/destroy AH
  net/mana: fix warning in the writer of client oob
  RDMA/mana_ib: UD/GSI work requests
  RDMA/mana_ib: implement req_notify_cq
  RDMA/mana_ib: extend mana QP table
  RDMA/mana_ib: polling of CQs for GSI/UD
  RDMA/mana_ib: indicate CM support

 drivers/infiniband/hw/mana/Makefile           |   2 +-
 drivers/infiniband/hw/mana/ah.c               |  58 +++++
 drivers/infiniband/hw/mana/cq.c               | 227 ++++++++++++++--
 drivers/infiniband/hw/mana/device.c           |  18 +-
 drivers/infiniband/hw/mana/main.c             |  95 ++++++-
 drivers/infiniband/hw/mana/mana_ib.h          | 157 ++++++++++-
 drivers/infiniband/hw/mana/mr.c               |  36 +++
 drivers/infiniband/hw/mana/qp.c               | 245 +++++++++++++++++-
 drivers/infiniband/hw/mana/shadow_queue.h     | 115 ++++++++
 drivers/infiniband/hw/mana/wr.c               | 168 ++++++++++++
 .../net/ethernet/microsoft/mana/gdma_main.c   |   7 +-
 include/net/mana/gdma.h                       |   6 +
 12 files changed, 1096 insertions(+), 38 deletions(-)
 create mode 100644 drivers/infiniband/hw/mana/ah.c
 create mode 100644 drivers/infiniband/hw/mana/shadow_queue.h
 create mode 100644 drivers/infiniband/hw/mana/wr.c

-- 
2.43.0


