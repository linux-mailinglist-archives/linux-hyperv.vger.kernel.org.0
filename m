Return-Path: <linux-hyperv+bounces-1539-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19905852970
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 07:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7BFB2376F
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3E14296;
	Tue, 13 Feb 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DscRVihF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6B17593;
	Tue, 13 Feb 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807266; cv=none; b=sIpghHjeJ1H5d37cNxkAYGpBKkBwaXpGH0gfex/m5QOLWvjdVioBh+9JatfrFyOyV/D/d2GWHC+L4+7Clr8XCOZz8jlve0QngDC0tFolxB9rymZ5johbHpIdf4CDcSn+JNQ+TG31ukuFb7uGaJq74mb/xpAd8JYXoCFK1EWO05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807266; c=relaxed/simple;
	bh=dg+czpDpRsfS+ywc/VdeVy3c5O4goOqBngd+M7qerq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A37eCqQzvjHVhFBNe8sjydcFrrCdixensYB668wOamoQa+yXTg/l1wg+UuSLHEvU4uo+FH+GzPw4uYAQyW71BenxmLO8XXE4yrOnrG1jQC6HZVfPiy1Qoc5Eh3Jal7/SRvPjS8698UoMwEnzeZh5NFxTHz7EbfDqAM/Cwczbh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DscRVihF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707807264; x=1739343264;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dg+czpDpRsfS+ywc/VdeVy3c5O4goOqBngd+M7qerq8=;
  b=DscRVihFtoaYkCjVgJ9Qk4HMldLn0UFC3TpEtEWjsypLr0NMR9Rqqd9M
   KCj3FUAaU9MafFd1EBNKMGRZctJq7mfxQLCnZe1f6QlIQSqjxxYkEGdAW
   +OJGLOvOtMjeuzfZayCL/D2SUyh1dz20epecEelrnQJVAh89mc1tohEOn
   qIHYp1gM5Sdh4GchZ4NJaDIbAHcBwN8HYPxl3VRl22iS+lbiOIpgSfprR
   80HdKNo0DMgi/GjLSgLlghw9Yj2WlyLohHTTnv98fuLY4EhAgNbKXXuu1
   g0AAIYN3D42jcRTPO167y99lcy7lQnCt5ZfgSaPkWs48CiWx0RVbB7sy/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1927759"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1927759"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 22:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="3149430"
Received: from maleekmc-mobl.amr.corp.intel.com (HELO [10.209.16.85]) ([10.209.16.85])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 22:54:24 -0800
Message-ID: <12efa165-b4bb-40ae-ac38-deedceba7b27@linux.intel.com>
Date: Mon, 12 Feb 2024 22:54:23 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: hv: Fix ring buffer size calculation
Content-Language: en-US
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20240213061910.782060-1-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240213061910.782060-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/12/24 10:19 PM, mhkelley58@gmail.com wrote:
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
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
>  
Nit: I think you can use SZ_16K to make it more readable.
>  /*
>   * Driver specific state.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


