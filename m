Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2B3CF42E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGTFVW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 01:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhGTFVT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 01:21:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B641EC061574;
        Mon, 19 Jul 2021 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NJ3TnWE3CL0wCjaiOk58xi8Kq4FRhK9oxiKVctZ3D60=; b=rn5ZFwUvcWRYS0mpREkxIlmfgZ
        EvkGHPZ5mFRP90cFNx1iVBYjdd0PM7Q8nGgWf/VxFPA7ZlgUPOUNo4MwRUkLxy1NTkzvWSVpmwBZ1
        eSk/pKAggVlWWdzeZsojXFs7jFPUfICnddHBJqR3/dukxJTM+VwXHRWKn8fJzZY/PT7TmA/zbHm2S
        nLiWyvSYEOeRDHi1I8WOI/s3YdDZT05amZCl8UtVflnp1NISmVv12YCfQjFa1iUaDHWvkaqILz9Sv
        S3EZL21Jd/Fw4wkbNJN/LOazIf+M2Ke7gxAerKd/B/bwTAaEIlx73P3a64OsWVxzWilzW1hCD2pR0
        vBfUnjwA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5iom-007o6C-BX; Tue, 20 Jul 2021 06:01:33 +0000
Date:   Tue, 20 Jul 2021 07:01:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     longli@linuxonhyperv.com, linux-fs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Message-ID: <YPZmtOmpK6+znL0I@infradead.org>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 19, 2021 at 09:37:56PM -0700, Bart Van Assche wrote:
> such that this object storage driver can be implemented as a user-space
> library instead of as a kernel driver? As you may know vfio users can
> either use eventfds for completion notifications or polling. An
> interface like io_uring can be built easily on top of vfio.

Yes.  Similar to say the NVMe K/V command set this does not look like
a candidate for a kernel driver.
