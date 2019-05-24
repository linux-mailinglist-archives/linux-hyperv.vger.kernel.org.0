Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DF2A10D
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 May 2019 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbfEXWPS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 May 2019 18:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404176AbfEXWPS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 May 2019 18:15:18 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A553A20862;
        Fri, 24 May 2019 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558736117;
        bh=S/mRMEkQXFi04Mis9f/sXsoi0IV12RHQlkHVTfheS9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkwFpQ4hGAB9aobq0V2zldqyZ6DaPyuZZudvGY7ehHuT9rlCafnqPXBcnOZ9HFcZM
         QBala4Ythw8IFP0+5XprdpisSJbO7wHKXMThlksnAIoJatpAQCTcRmtMxCUMuBvVs6
         QFQ8jubF0K02LFtkLXb3DwOEL0cpw4oJa0wmt+EY=
Date:   Fri, 24 May 2019 18:15:16 -0400
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
Message-ID: <20190524221516.GD12898@sasha-vm>
References: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, May 19, 2019 at 10:28:37PM +0000, Haiyang Zhang wrote:
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

Queued up for hyperv-fixes, thank you.

--
Thanks,
Sasha
