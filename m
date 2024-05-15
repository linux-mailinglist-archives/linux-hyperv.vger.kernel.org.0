Return-Path: <linux-hyperv+bounces-2120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9658C61F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D9828251E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AF4654B;
	Wed, 15 May 2024 07:43:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB84642B;
	Wed, 15 May 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759013; cv=none; b=DkWn69LlThSbFZnzV2cYSYM6e+8wuqbs4I7nG/23pYtHIAlPD+WW+LtBQBIhSz+a4dGUi0pAgdi5R0yBIkl6x6ZSwNaTIrBWC0AbFK83rgzsppBlAGhSybdCdjVIvg9DpA57aibTrdswO7U4KTOSdRTEdF369EjbYIF3Smqz8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759013; c=relaxed/simple;
	bh=zSyTfncG7lUY0j27i8mmLlOjBoeBG4QOoit9N5vhrGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GabNmHZT8xSv77vh48JOqX6gIKzxF1zV90TEEZuo8SL6vd4cFXQo2Z+MRA5cW5O0/k2gHsYwd8HVIGfZP4qBRQo+rhLY7auUUbLmmGGJAX99Pquhr1wzlP1J0XuI5hSGP+EeRL5YxeuYn7+Lzq5YRtY5hesNSwSZuz8H8sYBw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44b5e7f07so5329703b3a.2;
        Wed, 15 May 2024 00:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715759010; x=1716363810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAnlNHmiAzFZl5O2CbFUG3dcoGehQDgQ1HpMujgq7Nw=;
        b=qa/hq+qFnt7ge5niYE6KSMAmbEftSzfx36rSgnupnVn25EdYuFqNoRs6Yjwwi0e9ZJ
         EHKXX4P3NLbct3EZDP4UXcZqfpUuN9z4tTUms815rD9yt8pMApQBRzjyGkVy6J8HL6E5
         owYIL+lulDIlSf9UXnwYZMI9nlCnT5Hjlf+ljZkQhPdF/U+OXovYvVjR/aL1m7UFGXW1
         RW7L1eNshDBAv5FCTO7lVmSRFtBR7RJELmGGjZ3ft9y/RRp0wUohxuczTCuUTQUl1YHt
         FIJFyYQAA02Ibjk942NocG42JF6+dOAZQcLZohQeqX/X79+mKrfwOfdjHp4dT80p2R5y
         VqsA==
X-Forwarded-Encrypted: i=1; AJvYcCXdxxIa64MIlGFzKkjj8lgwZaUKDxM537dbDXjXE2nh6H2Un8PwkMXsJU8z1IjGBAuMSyVtyC/g3ADp/Y4uWJJiqaYtf+TO34FQ2SnZnE9w6Jwgylcrh1MB5TQVq6FGOLUvLprHQAD4fQ==
X-Gm-Message-State: AOJu0YyKpQMdNmVtIjUs5USb9gwVWydsUvjHXUMsdcL+6Gjv1OxM8rAA
	7CBnDRn5wCG7FUfyJ1g40pQBt+/mX8/lX7n3aWHj1Lqf7Z9HFPeh
X-Google-Smtp-Source: AGHT+IHvu/0pU5n8q4rwauswr4utzbnuhiybOXuBZmM0qGxQJ5w6BbmSSzCi2CgjbyrlqEQbGDirsw==
X-Received: by 2002:a05:6a00:846:b0:6ed:de6f:d72f with SMTP id d2e1a72fcca58-6f4e02ecf12mr18968323b3a.20.1715759010230;
        Wed, 15 May 2024 00:43:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a8280csm10462767b3a.61.2024.05.15.00.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:43:29 -0700 (PDT)
Date: Wed, 15 May 2024 07:43:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: romank@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	ssengar@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH 2/6] drivers/hv: Enable VTL mode for arm64
Message-ID: <ZkRnnM1f5lUo7OLB@liuwe-devbox-debian-v2>
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
 <20240510160602.1311352-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510160602.1311352-3-romank@linux.microsoft.com>

On Fri, May 10, 2024 at 09:05:01AM -0700, romank@linux.microsoft.com wrote:
> From: Roman Kisel <romank@linux.microsoft.com>
> 
> This change removes dependency on ACPI when buidling the hv drivers to
> allow Virtual Trust Level boot with DeviceTree.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..a5cd1365e248 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> @@ -15,7 +15,7 @@ config HYPERV
>  
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
> -	depends on X86_64 && HYPERV
> +	depends on HYPERV

As Ktest bot pointed out, this change broke the build.

Thanks,
Wei.

>  	depends on SMP
>  	default n
>  	help
> @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
>  
>  	  Select this option to build a Linux kernel to run at a VTL other than
>  	  the normal VTL0, which currently is only VTL2.  This option
> -	  initializes the x86 platform for VTL2, and adds the ability to boot
> +	  initializes the kernel to run in VTL2, and adds the ability to boot
>  	  secondary CPUs directly into 64-bit context as required for VTLs other
>  	  than 0.  A kernel built with this option must run at VTL2, and will
>  	  not run as a normal guest.
> -- 
> 2.45.0
> 

