Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8193D4A9156
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 00:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiBCX6a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 18:58:30 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49248 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356086AbiBCX63 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 18:58:29 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 52F4372C905;
        Fri,  4 Feb 2022 02:58:28 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 222C04A46F0;
        Fri,  4 Feb 2022 02:58:28 +0300 (MSK)
Date:   Fri, 4 Feb 2022 02:58:28 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-hyperv@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: hv: drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of
 type
Message-ID: <20220203235828.hcsj6najsl7yxmxa@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

There is new compilation error (for a second week for drm-tip[1] kernel):

     CC [M]  drivers/hv/vmbus_drv.o
   drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
			       ^~~~~~~~~~~~~~~~
   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
							^ ~~~
   1 error generated.

I understand this looks like possible GCC (11.2.1) bug, but still it prevents
building kernel with CONFIG_HYPERV.

Thanks,

[1] git://anongit.freedesktop.org/drm-tip

