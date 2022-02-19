Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5393A4BC6C6
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Feb 2022 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiBSHiF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 19 Feb 2022 02:38:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiBSHiF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Feb 2022 02:38:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD584E3B9;
        Fri, 18 Feb 2022 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h57KiAEVSKkzXdNc8Dx5lCWM++DN28M84mRcDiV5fkY=; b=KsxrcfYaerfj7S4ITWFvQAQ0x6
        24aeSlzHZ3cmMdzzDJjwD5MH7BiCBtomrZK+sUouoLD9vIJHuUOIq8hNC2rT9TREsjqowo7ZigLPU
        llG/bACQNWJM62cm7Wc1o0o5yl4BeuJOK1InpRSg6F2nlLE+wMwB6Sr0Gv2APOv6ZKnh4XB2/bx0q
        pO/NM0jEjfo63HNdo4QypAR7fM098sBkqtoJnexaTDGT2EC9VuGERlxc6rMnA1xJW3+p1h+TLVuCS
        Lhtn1UlZlZPW5MAURTUYVTtlIOcC7djUDixNNJ6pg7uXqJlAMgXvaRfk2N49sHxK0dt49GFiuTp9+
        u3rD/Uaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLKIh-00GNfs-Pt; Sat, 19 Feb 2022 07:37:03 +0000
Date:   Fri, 18 Feb 2022 23:37:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Cc:     mikelley@microsoft.com, jejb@linux.ibm.com, kys@microsoft.com,
        martin.petersen@oracle.com, mst@redhat.com,
        benh@kernel.crashing.org, decui@microsoft.com,
        don.brace@microchip.com, R-QLogic-Storage-Upstream@marvell.com,
        haiyangz@microsoft.com, jasowang@redhat.com, john.garry@huawei.com,
        kashyap.desai@broadcom.com, mpe@ellerman.id.au,
        njavali@marvell.com, pbonzini@redhat.com, paulus@samba.org,
        sathya.prakash@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sreekanth.reddy@broadcom.com, stefanha@redhat.com,
        sthemmin@microsoft.com, suganath-prabu.subramani@broadcom.com,
        sumit.saxena@broadcom.com, tyreld@linux.ibm.com,
        wei.liu@kernel.org, linuxppc-dev@lists.ozlabs.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        storagedev@microchip.com,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        andres@anarazel.de
Subject: Re: [PATCH RFC v1 0/5] Add SCSI per device tagsets
Message-ID: <YhCeHweaO5ugY5aC@infradead.org>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 18, 2022 at 06:41:52PM +0000, Melanie Plageman (Microsoft) wrote:
> Currently a single blk_mq_tag_set is associated with a Scsi_Host. When SCSI
> controllers are limited, attaching multiple devices to the same controller is
> required. In cloud environments with relatively high latency persistent storage,
> requiring all devices on a controller to share a single blk_mq_tag_set
> negatively impacts performance.

So add more controllers instead of completely breaking the architecture.
