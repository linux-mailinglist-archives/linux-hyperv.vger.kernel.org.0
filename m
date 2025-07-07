Return-Path: <linux-hyperv+bounces-6128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEBAFB83C
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4691766AA
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070921B9FE;
	Mon,  7 Jul 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxwnLMu8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962513EFE3;
	Mon,  7 Jul 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904298; cv=none; b=S7pJ0eYhosneUuPM0kFCUu/etjJ026yKfJXzlnuFlgtd6hrcxWrhMaoYff0+sHVMcc9PR4Fdb+7EQCYSi1Kzp5+75F9oVWbh3CrvL8UgqRzGz9FseQ2Ej6LXC0vc1zjaxd1E86g6X6vPuP/lUk0x7kfuQNlI1lkjlOB/t2rP+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904298; c=relaxed/simple;
	bh=PZguKu1gWtvJhhVgX3umyBR/niONdHTl+p+DO/QP/Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mCA2gG8lZ+4Ra4mIpTcWNPwXRa5C6KY5r7L/omjQomZp2pz6LGFtuepxzrSf8IXfY4vJRoCXLJYEklH9YMgw6fV0FF4PZnrDEcJi+BNGKn4yxMw7WR3rjgi2jNhXrkWkN8na9P47GSwGrhkoaGjR0p0HZkN5DEiZzdcRNVCgABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxwnLMu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D29BC4CEE3;
	Mon,  7 Jul 2025 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904298;
	bh=PZguKu1gWtvJhhVgX3umyBR/niONdHTl+p+DO/QP/Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OxwnLMu8FrXZcRkLG0kH45/ZQD56qNSbv9rildxJXMX0TpWG6e6VXaBatZcRSEWMq
	 twtzFouCMYadDU3K3e+6Up6OIxPQxjWlW843LkTFPek5fAbs3nhO/TIbdkT75pH0fW
	 BE5Gu5ZG+5hkEKOSuH690HTUXEmHTp6+cj6yjjBHcjNfLxJmQ4pDnvCBqop4tNFn7G
	 ZATDDDEDCVqWpZNeVUoYFi1wDO6CG6/aV+g8FpRg/BnPizfz7Len7pzlN4EJOaaJFS
	 L+nXq0rYBAWXykXtfNYXHLil55+buG5n0UX9w7IuCsGJc/W/xhR0gDJYtDF3fpRWAn
	 wS2MzeC5KzP5A==
Date: Mon, 7 Jul 2025 11:04:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	mhklinux@outlook.com, tglx@linutronix.de, bhelgaas@google.com,
	romank@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	jinankjain@linux.microsoft.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, x86@kernel.org
Subject: Re: [PATCH v2 1/6] PCI: hv: Don't load the driver for baremetal root
 partition
Message-ID: <20250707160456.GA2086564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751582677-30930-2-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Jul 03, 2025 at 03:44:32PM -0700, Nuno Das Neves wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> The root partition only uses VMBus when running nested.
> 
> When running on baremetal the Hyper-V PCI driver is not needed,
> so do not initialize it.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this series will be merged elsewhere.

> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index b4f29ee75848..4d25754dfe2f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -4150,6 +4150,9 @@ static int __init init_hv_pci_drv(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	if (hv_root_partition() && !hv_nested)
> +		return -ENODEV;
> +
>  	ret = hv_pci_irqchip_init();
>  	if (ret)
>  		return ret;
> -- 
> 2.34.1
> 

