Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13C5481BA
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfFQMUO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQMUO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q5UXmR+68j/d4kmwjkqm57NnYDn0QLnoBNJzOKhpq6Y=; b=ZCMzeUB9iCTNxyQRc2KJsJUxv
        KZMdK33r/L1JCOJ0WcAJ0Gwg4UhVodgV/zTyCErj6/1jXfPNXecsBB26ArJ9tImZGgHLIIZd3qKhT
        0TXGfdx2yqDOBoXlCiMizmXNkHhARuwEuA/seQChXpZDVALQIMgkw4HX2/4F8mpuFwMV8uUkIz+SJ
        NzSnSvwV8oALS8Skqq3GyUo3TfOQnk9ZwdQoOdvXBRR8D6Xuse7IjzMFyKQdPgpM26TI0GpnsCPMS
        ucE/phcgLfZWajV9g/9OC1xdBHIc0m6l+VvuTplyxVKvjzBOh/r9sbuZKMvh1edPGFXGNo/sVJh7I
        jhQ9pXZZQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcG-0003eR-GJ; Mon, 17 Jun 2019 12:20:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: properly communicate queue limits to the DMA layer v2
Date:   Mon, 17 Jun 2019 14:19:52 +0200
Message-Id: <20190617122000.22181-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Martin,

we've always had a bit of a problem communicating the block layer
queue limits to the DMA layer, which needs to respect them when
an IOMMU that could merge segments is used.  Unfortunately most
drivers don't get this right.  Oddly enough we've been mostly
getting away with it, although lately dma-debug has been catching
a few of those issues.

The segment merging fix for devices with PRP-like structures seems
to have escalated this a bit.  The first patch fixes the actual
report from Sebastian, while the rest fix every drivers that appears
to have the problem based on a code audit looking for drivers using
blk_queue_max_segment_size, blk_queue_segment_boundary or
blk_queue_virt_boundary and calling dma_map_sg eventually.

For SCSI drivers I've taken the blk_queue_virt_boundary setting
to the SCSI core, similar to how we did it for the other two settings
a while ago.  This also deals with the fact that the DMA layer
settings are on a per-device granularity, so the per-device settings
in a few SCSI drivers can't actually work in an IOMMU environment.

It would be nice to eventually pass these limits as arguments to
dma_map_sg, but that is a far too big series for the 5.2 merge
window.

Changes since v1:
 - dropped block layer parts merged by Jens
 - dropped the usb-storage / uas changes, as the virt_boundary usage
   there will be dropped soon
 - reworked the mpt3sas / megaraid_sas changes to keep per-device
   settings
