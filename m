Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABA102546
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Nov 2019 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfKSNUs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Nov 2019 08:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSNUs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Nov 2019 08:20:48 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2C3222B5;
        Tue, 19 Nov 2019 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574169648;
        bh=t4XReblODWNSE1CTYCwaKhK65whPDslrhtvW2X5LD8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOp2AlPLA0rTcaJRHCq8ceAIbKoKFyJlNmL5h4jTJEva0V1mNaB5mBWLbnoU77FGW
         pXMz9EdTxmLhXj2UB+SAR6UA8kxykdKvxiXBIUf/gc+8VSh6FO3Up5S1F32ZvsI9nH
         L4O9UBma0VCjVOFL7gT3NsR/NgJvHlT+UzAYv02U=
Date:   Tue, 19 Nov 2019 08:20:46 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] drivers/hv: Replace binary semaphore with mutex
Message-ID: <20191119132046.GE16867@sasha-vm>
References: <20191101200004.20318-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191101200004.20318-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 01, 2019 at 01:00:04PM -0700, Davidlohr Bueso wrote:
>At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
>than semaphores; it's also a nicer interface for mutual exclusion,
>which is why they are encouraged over binary semaphores, when possible.
>
>Replace the hyperv_mmio_lock, its semantics implies traditional lock
>ownership; that is, the lock owner is the same for both lock/unlock
>operations. Therefore it is safe to convert.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Queued up for hyperv-next, thank you.

-- 
Thanks,
Sasha
