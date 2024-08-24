Return-Path: <linux-hyperv+bounces-2844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C195DB2C
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FFB21E94
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AE2AE93;
	Sat, 24 Aug 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ici0RPIL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A23214;
	Sat, 24 Aug 2024 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724471371; cv=none; b=ByR4oxGRLeuoy1jNEGlb0vhxCpNoxOm2+DqZIixkdIffcWdrq/3lMc7B+jiadpXrqXFM277DZ18jV0WHnezogyfBZMIITlzoCe2Ds538KYRVSjaZmywlOILxJ42n5/Xx0p1wYHseQEdSwUnUmhrk5T5BsqzUw0aAFfyz4mHvFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724471371; c=relaxed/simple;
	bh=oUiQbPGEIGbA8nli/SmRi3mzqzziuakoXIzOXtb+xpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKKGAq+RXw6d5KuKWwmNlxYIYrBLWJsV8C0Kj1UXoMHZRkP1YTDs8D4FBhkZ7GhkhE7lGk2XIfgKLuiBmLFvf+ItNxHwuhG411SYQkemZm/YEpznemRvdrQkCVaXNI401prHE6zmjv42Hq2cNoFbQRupHl3ThZm7R+GBBkfwQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ici0RPIL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lT8Q7lVbYLqAyc8sacwXTnlCDNIWPRROT3qiMFaqTZk=; b=ici0RPIL/M2nHmgpbOTzIczhfy
	Xf064nAGTpp3wblOY3ztqrmNg4G/oRrsm5TKwa4zywRcNwzYu1Rf08QJQ65m5S/L2Jx3eV+UQGsf7
	Mff+VAf+rr/L13sUmvF8WDOG+nvWHJYug58RxXvej6IIhW42tl98VqftFcYlm4cOdm5oA9+3nebE8
	5wFm2Mr7RYRQ+elxXzSZwHxZgjr9NAWBba6mtZDB6PDwBmc/tqvLVQB7URXCL2TWBxLx7QqSC3E5g
	vah03tQD4MtZdIu0x0BotBzYDJN+KnTgC3ow+x5Hd71rRPBnzVus8CdHINbN7Me70ym6TfyJiPRsl
	dh9ksCqA==;
Received: from 2a02-8389-2341-5b80-7457-864c-9b77-b751.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7457:864c:9b77:b751] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shhmJ-00000001Mzu-3l73;
	Sat, 24 Aug 2024 03:49:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask} return value v2
Date: Sat, 24 Aug 2024 05:49:11 +0200
Message-ID: <20240824034925.1163244-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

the above three functions can only return errors if the bus code failed
to allocate the dma_parms structure, which is a grave error that won't
get us far.  Thus remove the pointless return values, that so far have
fortunately been mostly ignored, but which the cleanup brigade now wants
to check for for no good reason.

Changes since v1:
 - fix SCSI to not call dma_set_max_seg_size and dma_set_seg_boundary
   unconditionally

Diffstat:
 drivers/accel/qaic/qaic_drv.c                         |    4 --
 drivers/dma/idma64.c                                  |    4 --
 drivers/dma/pl330.c                                   |    5 ---
 drivers/dma/qcom/bam_dma.c                            |    6 ----
 drivers/dma/sh/rcar-dmac.c                            |    4 --
 drivers/dma/ste_dma40.c                               |    6 ----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                |    6 ----
 drivers/media/common/videobuf2/videobuf2-dma-contig.c |    3 --
 drivers/media/pci/intel/ipu6/ipu6.c                   |    4 --
 drivers/mmc/host/mmci_stm32_sdmmc.c                   |    3 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c       |    6 ----
 drivers/scsi/lpfc/lpfc_init.c                         |    7 -----
 drivers/scsi/scsi_lib.c                               |   11 ++++++-
 include/linux/dma-mapping.h                           |   25 +++++++-----------
 14 files changed, 32 insertions(+), 62 deletions(-)

