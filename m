Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3637FC3FFC
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJASig (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 14:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfJASig (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:38:36 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34D12133F;
        Tue,  1 Oct 2019 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955116;
        bh=SFNaZVvdlStLpfO46A2b6K/AG9EpSTq9sMu/WFeNxPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFVKmnlvkOhetuVuOA+0dp0CketPneA2Uq5efIkAWIQuB5H9UowQytql9ORm979zW
         OzZpZEFG9VNZ4o2AySWIXL6b8eDo0ygO8c1lY5fKZb3zJ9tSoDTx+bHUdUAtxQcYYC
         7KJpMNgaUHd1E5BgSTs6aQCDzq3k/MjiRsm9XcyQ=
Date:   Tue, 1 Oct 2019 14:38:34 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] video: hyperv_fb: Add the support of hibernation
Message-ID: <20191001183834.GA8171@sasha-vm>
References: <1568244833-66476-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1568244833-66476-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 11, 2019 at 11:34:10PM +0000, Dexuan Cui wrote:
>This patch depends on the vmbus side change of the definition of
>struct hv_driver.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
