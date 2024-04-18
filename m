Return-Path: <linux-hyperv+bounces-1990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A38A9299
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E626282D74
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91A54BFA;
	Thu, 18 Apr 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DHyc6I5x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5156454;
	Thu, 18 Apr 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419497; cv=none; b=E+zihHhgjz/jS1+47ZP5DcROPdSJx4tqTWyeLj65Hahryb9o6NMiVHVfon2R115ISQsOp8xcjM0XaAeZv8pZZJQUmowajhuIT0w4+oWqZuEs5YW8cK9NX1UVIZwHPdhm80+GTKu/EX5QOXQOOVFvdFFR32nPD1/ue281homDEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419497; c=relaxed/simple;
	bh=zATJ74G5Sc1DMdnW7cJJ13791upLRtnZmKExsPlmzfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRMnaHivZK6d+GfBz8gMjFTOZgLYtMjocXcBozSIhkrbcvBpuRFDSxzP5gF0vL4UJC21MzaYF4/rgrywXBw3W6uHG7Ci//GXuJ597Rp7gYpgwGHa5c190JascXtZIatCnGF1k5Tp7b/hZ/6y7fOvRN0TPcaQB/7nIHmY4qobszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DHyc6I5x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C97D220FD4D8; Wed, 17 Apr 2024 22:51:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C97D220FD4D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713419495;
	bh=mgD2zVbGomE9WC9wXHSFiZJILTvHN5Kfd0Rp4oWQDF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHyc6I5x+CWragIiq+raj0E0lD/tx6O6G4CHM9jHYNKswHCJG6E2TDzVzJdQhV+wt
	 CPF7CUYy+TeAHFj7pRwqLQnRSkOPrIBKu/8M5uJ/5I/2escB1/GPYwZOs+0AlyjOQT
	 GhUGkTJKYDUnoDIpcKRcy42FYTi0Z810i20H17vs=
Date: Wed, 17 Apr 2024 22:51:35 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <20240418055135.GA13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Apr 16, 2024 at 06:27:04AM +0200, Zhu Yanjun wrote:
> ??? 2024/4/15 18:13, Jason Gunthorpe ??????:
> >On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> >>Add new device attributes to view multiport, msix, and adapter MTU
> >>setting for MANA device.
> >>
> >>Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >>---
> >>  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
> >>  include/net/mana/gdma.h                       |  9 +++
> >>  2 files changed, 83 insertions(+)
> >>
> >>diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >>index 1332db9a08eb..6674a02cff06 100644
> >>--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >>+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >>@@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
> >>  	return dev_id == MANA_PF_DEVICE_ID;
> >>  }
> >>+static ssize_t mana_attr_show(struct device *dev,
> >>+			      struct device_attribute *attr, char *buf)
> >>+{
> >>+	struct pci_dev *pdev = to_pci_dev(dev);
> >>+	struct gdma_context *gc = pci_get_drvdata(pdev);
> >>+	struct mana_context *ac = gc->mana.driver_data;
> >>+
> >>+	if (strcmp(attr->attr.name, "mport") == 0)
> >>+		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> >>+	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> >>+		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> >>+	else if (strcmp(attr->attr.name, "msix") == 0)
> >>+		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> >>+	else
> >>+		return -EINVAL;
> >>+
> >
> >That is not how sysfs should be implemented at all, please find a
> >good example to copy from. Every attribute should use its own function
> >with the macros to link it into an attributes group and sysfs_emit
> >should be used for printing
> 
> Not sure if this file drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> is a good example or not.
> 
> Zhu Yanjun
Thanks for the reference, Zhu.
> 
> >
> >Jason

