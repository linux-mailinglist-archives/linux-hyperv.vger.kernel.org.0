Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A273AA78D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 17:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfIEPol (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 11:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390713AbfIEPoc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 11:44:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B69C2082C;
        Thu,  5 Sep 2019 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567698272;
        bh=7a2Kh0bbur1P82JOpkA0aiw3kRggM0voFXBHaO7YY/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ml7qLSuNqjg1UBZnkxl1oKa+hyxi1Xdf8QCcw+SUVhrjATDzr427/gLMAq+X2bDHS
         n22hdd5dr+OpDLiJq5UldHzbbuWQVKWwKRF+LOfUje8LV6P6XND14QvUI/bEh3hxWT
         vVFnWnDlWgZlQZ1nYS5wxamIpSqlZhvt4YvBIi3o=
Date:   Thu, 5 Sep 2019 11:44:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Message-ID: <20190905154429.GC1616@sasha-vm>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-2-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1567470139-119355-2-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 03, 2019 at 12:23:16AM +0000, Dexuan Cui wrote:
>This is needed for hibernation, e.g. when we resume the old kernel, we need
>to disable the "current" kernel's hypercall page and then resume the old
>kernel's.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi Dexuan,

When sending patches upstream, please make sure you send them to all
maintainers and mailing lists that it needs to go to according to
MAINTAINERS/get_maintainers.py rather than cherry-picking names off the
list.

This is specially important in subsystems like x86 where it's a group
maintainers model, and it's very possible that Thomas is sipping
margaritas on a beach while one of the other x86 maintainers is covering
the tree.

This is quite easy with git-send-email and get_maintainers.py, something
like this:

	git send-email --cc-cmd="scripts/get_maintainer.pl --separator=, --no-rolestats" your-work.patch

Will do all of that automatically for you.

--
Thanks,
Sasha
