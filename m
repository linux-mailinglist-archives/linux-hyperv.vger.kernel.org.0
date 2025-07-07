Return-Path: <linux-hyperv+bounces-6129-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECFAFB84A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801861AA4F36
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DB21FF57;
	Mon,  7 Jul 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGe9GTfm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684442049;
	Mon,  7 Jul 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904324; cv=none; b=YXvy+hu66k1t3TM29xyqJRO4V1swysJnM0Jq6DXYDgASpEFrwff52b+UaZ7mPTINir8I1uECvEPyT+wnfc6D84XFOTK1zpUBgu6fDJbGFYqXgGEkeDFV9v2sHcNu/lhC/l8Xf5DolhIowDEEQgRE+OkpdtswduOIeoRx5sjzOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904324; c=relaxed/simple;
	bh=kVh12//YSMQ4B4jH4d5HEOfJcPY9d17U+Of7O6JlIQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LQwTQmFcZ8wAhSZeJE2nGqtDWJSeVc9+c6yo0wktus8hJPV9u2QiiZEN4wdEucMl3CPPt91LdA6WksikfzJcLfKnnn8MtCnnIL8+fOwyhikUp/C9t4iw3nCg305e9YgFSIkmngvRAhZUGIJJUIZI5uK4PgachVnuy+hL1VwKZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGe9GTfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D8C4CEE3;
	Mon,  7 Jul 2025 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904324;
	bh=kVh12//YSMQ4B4jH4d5HEOfJcPY9d17U+Of7O6JlIQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mGe9GTfmVE7XJ8H87jr9KtM0uEO7HzuctE//hGNAUPHzRVH2JJP+5pJGZJhcHyXyw
	 eqh05iP4WZrABco7Q+tQimDbHjNmiOFfneAb4dVTf/o1E/LsS/cjSG4TfP3Faf8/Sy
	 YIMICeOjcoOOfq9JIBDHqBtOAS/lyIadQnvQrzse9XjUTpXD1f9/DLxsZ6hkJXCMNI
	 3wEUVvYrIKa6HhH5uy9ul/j1NJ+RsbsElUm9O7K3ONgd9SUZPBAZu/j6QWK1m7Cj+w
	 KISwYWqNcjvtRQLifs/JazUsitpHW5eH32y4u81gOAvXIr2RQZwe8s161Wk7KBymTA
	 CuAAO2ivLAQRw==
Date: Mon, 7 Jul 2025 11:05:22 -0500
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
Subject: Re: [PATCH v2 6/6] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Message-ID: <20250707160522.GA2086655@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751582677-30930-7-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Jul 03, 2025 at 03:44:37PM -0700, Nuno Das Neves wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Running as nested root on MSHV imposes a different requirement
> for the pci-hyperv controller.
> 
> In this setup, the interrupt will first come to the L1 (nested) hypervisor,
> which will deliver it to the appropriate root CPU. Instead of issuing the
> RETARGET hypercall, issue the MAP_DEVICE_INTERRUPT hypercall to L1 to
> complete the setup.
> 
> Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().
> 
> Co-developed-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 4d25754dfe2f..9a8cba39ea6b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -600,7 +600,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  #define hv_msi_prepare		pci_msi_prepare
>  
>  /**
> - * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> + * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
> @@ -609,7 +609,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>   * is built out of this PCI bus's instance GUID and the function
>   * number of the device.
>   */
> -static void hv_arch_irq_unmask(struct irq_data *data)
> +static void hv_irq_retarget_interrupt(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> @@ -714,6 +714,20 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>  }
> +
> +static void hv_arch_irq_unmask(struct irq_data *data)
> +{
> +	if (hv_root_partition())
> +		/*
> +		 * In case of the nested root partition, the nested hypervisor
> +		 * is taking care of interrupt remapping and thus the
> +		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
> +		 * RETARGET_INTERRUPT.
> +		 */
> +		(void)hv_map_msi_interrupt(data, NULL);
> +	else
> +		hv_irq_retarget_interrupt(data);
> +}
>  #elif defined(CONFIG_ARM64)
>  /*
>   * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving a bit
> -- 
> 2.34.1
> 

