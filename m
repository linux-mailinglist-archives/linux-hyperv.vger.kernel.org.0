Return-Path: <linux-hyperv+bounces-2522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CF9252B3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 06:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA21C22907
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 04:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C643B298;
	Wed,  3 Jul 2024 04:53:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB618654;
	Wed,  3 Jul 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982427; cv=none; b=gTwEivBMv6+ZpClo+LKWxHf0yrHPcqUUTC9nJdk8rOkLZRfZ8QGuHm57FoWrV5Ruv76RTz3GNyAfwjhF9UksqmGM/KMUzhnWCfCViZV9mioc+fiT/vzOakxvBle3531gSZKUkdF/ERi6TqIcDPT8hjtCUw/GWxj2sQBOZxfpzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982427; c=relaxed/simple;
	bh=fdph8gzw0bhTlnqkG8OPrbIDgCYt3mQM5oiV54nFOVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkAgQ1X6ZA5UhHyRmVrqk1H2MpbMmVETumWN6n3gF4QZEakRzD+7PDE9vftEPdWotIt/DG70JlreuP/JVDVlSA7Oge0tQVXmHUEXSjldVay4g0GuMlLDx4EHx5aJf0KuQyaI6s/fvuoKG+dONH2BceHM29GIZtUL/BHf+ubJYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-726d9b3bcf8so3686524a12.0;
        Tue, 02 Jul 2024 21:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719982425; x=1720587225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWbB1JJmNa1nbn2SVD9o6rsFR0fZsKtfpPmjtOkX148=;
        b=n9i+jIjqyQ8lPgxDmAbi+vCn0vNsvy0IkB9o0yL/5185IHbQfdDXcCOfMJpGDrMpYp
         XvNBg9ANAerU/wao+yF95b7Qx8Ur2PxtsoVb5fhrMdUo/vuSL4qshr76rhvVAc2Tg9Iz
         W9CkQ1oiaNdDpnqUsHTxCl1jbI4aLZHJruyJFJyU9kPxHcBPtFgHhmdunBro3DHHdDrE
         JmiiMYX6jSYPs2kuBWD/bJHjLcdobYmGd6Uhm0U72csOoCB355MinJJDM5LUSMSCCvR+
         AcqjhyZOBUELvHcmnvmsOvLvo79PbJs+my3Mg81hTfkcqnSX1EATt5OfquCccV4bvi/J
         T1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUYSlHrgnMK9tYSV1c6LhIEgVVKfSbOB++CyeON69/mwoLl/jKkd5jkNeyUna3+QVU9RibOr8h73ETVvmYCuk9fFG1z57TnTQnpFbfGMYWIWmR1V3evChIHqfknYb7J18Ca2JJZO23T
X-Gm-Message-State: AOJu0YwbHKMFFwLNqsYADek4ttbZIPnRFozUWyo7Rk6/tjaFr6eyvNAm
	t0FxSaP5zlL90Eb3NeG5BAjEP3xgkWSldT6LjWa7zGEWFWfcZH9U9lvkRA==
X-Google-Smtp-Source: AGHT+IGIYcceA2KedaYCXiAH0dqJI7Aor4j1HCAzEFUPzg8mdkjSUYaas7WBdG7ELRJcdUXVLdFVuA==
X-Received: by 2002:a05:6a21:99a5:b0:1bd:1aca:2b39 with SMTP id adf61e73a8af0-1bef60e3bcdmr10570053637.8.1719982424714;
        Tue, 02 Jul 2024 21:53:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a3d081bsm3172555ad.221.2024.07.02.21.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 21:53:44 -0700 (PDT)
Date: Wed, 3 Jul 2024 04:53:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>, stable@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Return zero, not garbage, when reading
 PCI_INTERRUPT_PIN
Message-ID: <ZoTZTvL-SKxZEmu5@liuwe-devbox-debian-v2>
References: <20240701202606.129606-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701202606.129606-1-wei.liu@kernel.org>

On Mon, Jul 01, 2024 at 08:26:05PM +0000, Wei Liu wrote:
> The intent of the code snippet is to always return 0 for both
> PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> 
> The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> 
> This is discovered by this call in VFIO:
> 
>     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> 
> The old code does not set *val to 0 because it misses the check for
> PCI_INTERRUPT_PIN. Garbage is returned in that case.
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Cc: stable@kernel.org
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Bjorn & other PCI maintainers, do you want to pick this up via your
tree?

I can pick this up via the hyperv tree if you prefer.

Thanks,
Wei.

> ---
> v3:
> * Change commit subject line and message per Bjorn's suggestion
> v2:
> * Change the commit subject line and message
> * Change the code according to feedback
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5992280e8110..cdd5be16021d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>  		   PCI_CAPABILITY_LIST) {
>  		/* ROM BARs are unimplemented */
>  		*val = 0;
> -	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
> -		   PCI_INTERRUPT_PIN) {
> +	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
> +		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
>  		/*
>  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
>  		 * because this front-end only supports message-signaled
> -- 
> 2.43.0
> 

