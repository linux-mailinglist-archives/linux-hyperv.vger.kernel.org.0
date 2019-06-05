Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16E36447
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFETIz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:08:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFETIy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aXk533Y40BLOyImNad0BaK/HkvfBpi+VFKiLovkq2FY=; b=MqJkkcnxuMst8SfYFH0p/H0sS
        Lyndhu8pTjyjfQyCjGGLFai29f329X1ePrgtN/YiqkHPIN0jszBGe0NaFysyaLUT8iQXMi77kr3Ek
        VK9dgOqwdzPw6Acy6G9wKOUedXKcUzEoKGZWxrXhzwj0M/MSx7rRNoFuVUIWqQsLzx2BOQ9Z5aGKa
        E1OsE0J46lx96G9b7y4w7pjA57wrq6KmUpVXPoT6CN1Zwy/HvcQQB4OQD57GDHUtGETcm1tOVobgA
        82otTB9t6FSATrXnlqA+euiivNTTfNlrFuP4C+PcevHuUSUXXHc8/huT8lQNz6KUokynQWTV5UM5L
        ++qe37rJw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbH4-0005Cx-Qz; Wed, 05 Jun 2019 19:08:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: properly communicate queue limits to the DMA layer
Date:   Wed,  5 Jun 2019 21:08:23 +0200
Message-Id: <20190605190836.32354-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Jens,

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
blk_queue_virt_boundary and calling dma_map_sg eventually.  Note
that for SCSI drivers I've taken the blk_queue_virt_boundary setting
to the SCSI core, similar to how we did it for the other two settings
a while ago.  This also deals with the fact that the DMA layer
settings are on a per-device granularity, so the per-device settings
in a few SCSI drivers can't actually work in an IOMMU environment.

It would be nice to eventually pass these limits as arguments to
dma_map_sg, but that is a far too big series for the 5.2 merge
window.
