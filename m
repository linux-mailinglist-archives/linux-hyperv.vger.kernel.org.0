Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B065883911
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2019 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfHFSze (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 14:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFSzd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 14:55:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2953C214C6;
        Tue,  6 Aug 2019 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565117733;
        bh=OFNe4cx5n7BU2ztYRPRilOpQxiFFszGkU5k0ee0lgwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieZfYW/7dJMqNDvD9xxwr0JT47lTdC+yJlm6ytFcnzJjm/i/jrJA6K0168204MM/N
         ayRy1CbN1vbTA29bBkP8khNiy/BUjQ/OYqX7a3KKjUvT/21aBfG9Mva5qgqSJnKsp7
         05tCt9lcWijPAmqgRpGSU+GWdvVbeIYpiANB0wBw=
Date:   Tue, 6 Aug 2019 13:55:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190806185531.GS151852@google.com>
References: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
 <20190805183657.GD17747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805183657.GD17747@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 05, 2019 at 02:36:57PM -0400, Sasha Levin wrote:
> On Fri, Aug 02, 2019 at 06:52:56PM +0000, Haiyang Zhang wrote:
> > Due to Azure host agent settings, the device instance ID's bytes 8 and 9
> > are no longer unique. This causes some of the PCI devices not showing up
> > in VMs with multiple passthrough devices, such as GPUs. So, as recommended
> > by Azure host team, we now use the bytes 4 and 5 which usually provide
> > unique numbers.
> > 
> > In the rare cases of collision, we will detect and find another number
> > that is not in use.
> > Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Acked-by: Sasha Levin <sashal@kernel.org>
> 
> Bjorn, will you take it through the PCI tree or do you want me to take
> it through hyper-v?

Lorenzo usually applies patches to drivers/pci/controller/*, so that
would be my preference.

Bjorn
