Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E58AC136
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfIFUDa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 16:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfIFUD3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 16:03:29 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0756320854;
        Fri,  6 Sep 2019 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567800209;
        bh=mExBVNjiBRxzB4QV3B2LFfejWgHVMRDf7/4uEQllzqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEIu4cj6eimR+r4plydg3wHpJIMOiwvK6XrHsYRaOs4dQsfN0uk78ZiL6V3YSwksz
         e8R3pr+zjo+P+2bOo3HzNg0jPQ1CCaeFesjbTbohQVdAknaLloZE4KD1wWJ7CQbbMK
         +NtWn7507V4tVg48WnPew19qIk4/p1cXTy3rHdoA=
Date:   Fri, 6 Sep 2019 16:03:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] Enhance the hv_vmbus driver to support hibernation
Message-ID: <20190906200325.GD1528@sasha-vm>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 05, 2019 at 11:01:14PM +0000, Dexuan Cui wrote:
>This patchset (consisting of 9 patches) was part of the v4 patchset (consisting
>of 12 patches):
>    https://lkml.org/lkml/2019/9/2/894
>
>The other 3 patches in v4 are posted in another patchset, which will go
>through the tip.git tree.
>
>All the 9 patches here are now rebased to the hyperv tree's hyperv-next branch:
>https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
>, and all the 9 patches have Michael Kelley's Signed-off-by's.
>
>Please review.

Given that these two series depend on each other, I'd much prefer for
them to go through one tree.

But, I may be wrong, and I'm going to see if a scenario such as this
make sense. I've queued this one to the hyperv-next, but I'll wait for
the x86 folks to send their pull request to Linus first before I do it
for these patches.

Usually cases such as these are the exception, but for Hyper-V it seems
to be the norm, so I'm curious to see how this will unfold.

--
Thanks,
Sasha
