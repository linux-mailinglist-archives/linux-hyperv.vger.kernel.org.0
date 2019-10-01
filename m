Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BBC4065
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfJASug (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 14:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJASug (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:50:36 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6E720B7C;
        Tue,  1 Oct 2019 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955835;
        bh=bBRD8WZq+ebTWJFYFaHwjQ80HEj4uzX3OTv5GSo/iLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ue5nWn+wxjQSubuW7+L5G5Uw07ukW2ZoykYzwdqrwGSvsQX/I69oxmXGATjK+fE7r
         Ddvp+xGqg3usvlqGgSHrdNNeDBdysrQPtpcemlg7Bcg+E7viDxeybbu+7wmRubIj8o
         tpXaIzWHw1DelKyHExqSnfqxACENUA/ZXH+xNZLY=
Date:   Tue, 1 Oct 2019 14:50:33 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM_SLEEP
Message-ID: <20191001185033.GG8171@sasha-vm>
References: <1569436998-130708-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569436998-130708-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 25, 2019 at 06:43:57PM +0000, Dexuan Cui wrote:
>If CONFIG_PM_SLEEP is not set, we can comment out these functions to avoid
>the below warnings:
>
>drivers/hv/vmbus_drv.c:2208:12: warning: ‘vmbus_bus_resume’ defined but not used [-Wunused-function]
>drivers/hv/vmbus_drv.c:2128:12: warning: ‘vmbus_bus_suspend’ defined but not used [-Wunused-function]
>drivers/hv/vmbus_drv.c:937:12: warning: ‘vmbus_resume’ defined but not used [-Wunused-function]
>drivers/hv/vmbus_drv.c:918:12: warning: ‘vmbus_suspend’ defined but not used [-Wunused-function]
>
>Fixes: 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for hibernation")
>Fixes: f53335e3289f ("Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation")
>Reported-by: Arnd Bergmann <arnd@arndb.de>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

I've queued this up for hyperv-fixes.

>In v3:
>	Add Michael's Reviewed-by.
>	No other change.

There's really no need to re-spin just to add tags :)

--
Thanks,
Sasha
