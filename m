Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229543241D2
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Feb 2021 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhBXQLo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Feb 2021 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhBXPx7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Feb 2021 10:53:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC5C06174A;
        Wed, 24 Feb 2021 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2cfgLrUfwrBlhLqmvNFBxhy8YJ0VUlYc9/uzyh409x8=; b=PLMfKC9Zl0Xs9PY1AWvKDemuIZ
        O81VZ0aTNn2cxF0DsfkwLcsNoQt5pmX5qDQ+SlLfshqOZWBoS4AWzGQ6wM2DxH2OQ7zh6i6eGh4+a
        14QyAaEdeyDtZOVR703re0UkUKxR6rv/XCxtBPS7dZe3XW2W/cx/8Io8qhnJCbde9A9DDwmqkTo1R
        w3+G0aXRm9D9DIH7+r6wJb6B2f63cYiE7mAee85gevTeHJmhielnac8iAoizCGj80EUaVTscWD0Ty
        M/Y+rtiVywNYy8FuQBgoEaQ2Joq7IpNao70f4QIFxhXC+6TpkE4+cCA/yb/OeE06ZmyImBAfz33Fn
        FiCtjTrg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEwSv-009aWA-Fd; Wed, 24 Feb 2021 15:52:49 +0000
Date:   Wed, 24 Feb 2021 15:52:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        martin.petersen@oracle.com, longli@microsoft.com,
        wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Message-ID: <20210224155241.GA2284544@infradead.org>
References: <1613682087-102535-1-git-send-email-mikelley@microsoft.com>
 <874ki2yhzm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ki2yhzm.fsf@vitty.brq.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Shouldn't storvsc just use blk_queue_virt_boundary instead of all this
mess?
