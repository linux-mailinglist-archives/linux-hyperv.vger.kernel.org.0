Return-Path: <linux-hyperv+bounces-7260-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CBBEBE62
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E23B1804
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB992D4814;
	Fri, 17 Oct 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9eZvfHU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F7354AC3;
	Fri, 17 Oct 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739382; cv=none; b=a0KsQCs1uUxpKiycKQP+ADWXx+9etbqbEOuKT8yUfsgDhxVUq7VgGG/1fsVLQnj5t8cDU95oRlE++rdv8Zl/MsD74+EWfeO7x5vnFgs7snlkfjar2bNRmUiCZKdYvf5sK7rvWcQvaRfyt2LcFtmjtc27SYguakAgtJiHTOOHyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739382; c=relaxed/simple;
	bh=kPhCqHZuNpS145cs5Ndc1SX3JYd9L6ZJoPIkQMXvMRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/0wyC97I02eF7ljaVizuQT79IctDDQWVkOdbnNyjWEHlKPmcfzBEW8VbDhv2umRSYFE+AG8X9LKl43VNwSFtB/wGyzdHYdx/2FqoD+tkCTyQDCdQwJmDZ+gl9pb/Wuo8s0CC3MxwB8VMPhQxfNr5FOvOyPC+5JVZAZ/9tz1XH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9eZvfHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB8EC4CEE7;
	Fri, 17 Oct 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739382;
	bh=kPhCqHZuNpS145cs5Ndc1SX3JYd9L6ZJoPIkQMXvMRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9eZvfHU0sppp/CIlQVvsbG7vElW/vPeiUiE0TUPD4+VEVf4cVPmvAAmY/OOVtXpd
	 +ICgRFDVEa6FDjML2r+tKhZHX45jEFXsGNYJGRXYJrkYbKJoUaJ8ncBfov7a2zIXq+
	 qHGfmiEcqV3tWhLViZepd/4qojliiN1jiMK43AJ6vex5xlikOlH8xD+BdfwVvOiffg
	 ouVUNT6V2JdTnECo1zylFZ3EtQ2gGow1uSz3noCnlZxTz2lmT6OeSxlZ91vN8nz6Ub
	 hOOGY3phXRdrJpKAODdCzZs67qYzq/pxUy9HogrQRYCUT7SEEd+yPAGze4SVGFDc9z
	 8793pJPiix9Kg==
Date: Fri, 17 Oct 2025 22:16:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v6 08/10] x86/smpwakeup: Add a helper get the address of
 the wakeup mailbox
Message-ID: <20251017221620.GD614927@liuwe-devbox-debian-v2.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-8-40435fb9305e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-8-40435fb9305e@linux.intel.com>

On Thu, Oct 16, 2025 at 07:57:30PM -0700, Ricardo Neri wrote:
> A Hyper-V VTL level 2 guest in a TDX environment needs to map the physical
> page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). It
> needs to know the physical address of this structure. Add a helper function
> to retrieve the address.
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Can I get an Ack from x86 maintainers?

> ---
> Changes since v5:
>  - Added Reviewed-by tag from Dexuan. Thanks!
> 
> Changes since v4:
>  - None
> 
> Changes since v3:
>  - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
>  - Added Reviewed-by tag from Michael. Thanks!
> 
> Changes since v2:
>  - Introduced this patch
> 
> Changes since v1:
>  - N/A
> ---
>  arch/x86/include/asm/smp.h  | 1 +
>  arch/x86/kernel/smpwakeup.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 47ac4381a805..71de1963f984 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -151,6 +151,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
>  
>  void acpi_setup_mp_wakeup_mailbox(u64 addr);
>  struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
> +u64 acpi_get_mp_wakeup_mailbox_paddr(void);
>  
>  #else /* !CONFIG_SMP */
>  #define wbinvd_on_cpu(cpu)     wbinvd()
> diff --git a/arch/x86/kernel/smpwakeup.c b/arch/x86/kernel/smpwakeup.c
> index 5089bcda615d..f730a66b6fc8 100644
> --- a/arch/x86/kernel/smpwakeup.c
> +++ b/arch/x86/kernel/smpwakeup.c
> @@ -81,3 +81,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
>  {
>  	return acpi_mp_wake_mailbox;
>  }
> +
> +u64 acpi_get_mp_wakeup_mailbox_paddr(void)
> +{
> +	return acpi_mp_wake_mailbox_paddr;
> +}
> 
> -- 
> 2.43.0
> 

