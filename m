Return-Path: <linux-hyperv+bounces-1540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A4854B3B
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Feb 2024 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAE283431
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Feb 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E55576A;
	Wed, 14 Feb 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ev1Inafa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D455E4A;
	Wed, 14 Feb 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920338; cv=none; b=oM1P4cUyMV6tzSnIqmYeh/23kbfYiwkO49sTd5w+ILbSjtVDSUfju7wwJ/7tRThbzP61qmodm+JlwWlIprikfTW+VKuIvL7Pj22dfla8A5Bkq7QwReqaykH5G9CU/e/A6CjmSavKNooXjEdVBuGh6pZw7LQBtghSjYsorMAfaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920338; c=relaxed/simple;
	bh=HiiTvNUDYA1r/R0rq42qY+EHfh4dR8d3IE1TQ/xRp88=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jbwRPAT9rDCfhV39WC2L/+u/xKiAgWiXWbh0yxHC+wlSZeDwUnR/UgpsEePVt7W9lImR7yQdNsthNnavNRGHpQpN1HQTFm/qyLNdwfH7etUS1fb3q8nrjxQynTOKs3Yvf8IXcmBjhWMj7a9Z3F13i6kfa2oboDEYpX4lmz6PrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ev1Inafa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707920337; x=1739456337;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HiiTvNUDYA1r/R0rq42qY+EHfh4dR8d3IE1TQ/xRp88=;
  b=ev1InafafGcw1IoUFWp5P44nnt3mqde2UkFbw1Fujh0ooIDnaBPahn6W
   h55Th1Pl0exbqO9WlJGz5m+5C0yU6aIaK9LbXsGA7PaM4KqmkFPmUnbQf
   MEcqwQOuh3ZLjemWMQvTj/xGqymNxiAnXz5CD7WLdgplJ7fwBXwAKYOa3
   E5Xd4aFr8LmEuz6W3DRV16xsY6OkBSGZUEbm2EXryNqF1v8i25l7ZT4pw
   xDNaHRTZG6dMiwUw5449VrMmoJUFezoUSfXdgJOWJ7h8Lcm4f6CQQPrZw
   EcNCkNr6lJX+7VcILwbGXJdSMMX+NhekrQlGij4zvDbbYbPp+CSmE+naq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13058909"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="13058909"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 06:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7830830"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 06:18:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Feb 2024 16:18:38 +0200 (EET)
To: mhklinux@outlook.com
cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
    lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Fix ring buffer size calculation
In-Reply-To: <20240213061910.782060-1-mhklinux@outlook.com>
Message-ID: <73f6e93d-bbb3-cf3a-1311-d80b7b6512c1@linux.intel.com>
References: <20240213061910.782060-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Feb 2024, mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> For a physical PCI device that is passed through to a Hyper-V guest VM,
> current code specifies the VMBus ring buffer size as 4 pages.  But this
> is an inappropriate dependency, since the amount of ring buffer space
> needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
> size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
> size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
> is used for only a few messages during device setup and removal, so any
> space above a few Kbytes is wasted.
> 
> Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
> header is properly accounted for, and so the size is rounded up to a
> page boundary, using the page size for which the kernel is built. While
> w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> 64 Kbyte ring buffer, that's the smallest possible with that page size.
> It's still 128 Kbytes better than the current code.
> 
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1eaffff40b8d..5f22ad38bb98 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -465,7 +465,7 @@ struct pci_eject_response {
>  	u32 status;
>  } __packed;
>  
> -static int pci_ring_size = (4 * PAGE_SIZE);
> +static int pci_ring_size = VMBUS_RING_SIZE(16 * 1024);

SZ_16K (and add the relevant #include if needed).

-- 
 i.


