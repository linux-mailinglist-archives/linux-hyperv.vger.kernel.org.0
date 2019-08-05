Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687C3824F6
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2019 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfHESg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Aug 2019 14:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfHESg7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Aug 2019 14:36:59 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7EF20679;
        Mon,  5 Aug 2019 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565030219;
        bh=nnWPhjdH3Y8W9jj1zLukhhmalyF/Qo4hWWnJ7K0di8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmu7A/LwmzSN6or76p+zMk9u3F5n1v2TZOJHXPwVJFdhI8GGrmyfPENu5ZSVjoj/4
         9+7BhXA3l1Skc/XrKbFKQ91WLEQBSzYyuizahOSmufXBgveoAnSNXGtRZjzU4Sh4iG
         mWFg7lalBAEzGgIHS7l1cBAXeZ6dUU/4i6to7KqI=
Date:   Mon, 5 Aug 2019 14:36:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190805183657.GD17747@sasha-vm>
References: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 06:52:56PM +0000, Haiyang Zhang wrote:
>Due to Azure host agent settings, the device instance ID's bytes 8 and 9
>are no longer unique. This causes some of the PCI devices not showing up
>in VMs with multiple passthrough devices, such as GPUs. So, as recommended
>by Azure host team, we now use the bytes 4 and 5 which usually provide
>unique numbers.
>
>In the rare cases of collision, we will detect and find another number
>that is not in use.
>Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.
>
>Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Acked-by: Sasha Levin <sashal@kernel.org>

Bjorn, will you take it through the PCI tree or do you want me to take
it through hyper-v?

--
Thanks,
Sasha
