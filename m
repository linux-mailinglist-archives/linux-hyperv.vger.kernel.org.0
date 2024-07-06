Return-Path: <linux-hyperv+bounces-2537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10A4929049
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jul 2024 05:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2378DB21B38
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jul 2024 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E9DDA6;
	Sat,  6 Jul 2024 03:20:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826DDDA1;
	Sat,  6 Jul 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236034; cv=none; b=FjXklFXFsiOteYhwTCwCTvfqOwjNyAWxFEW5m0HzAxGhjN4pIcjKG9xw2JSrIs1vMnxFUG8M2GmAQSsnYix/D/IlWjBkeO+5gso4BuWscqrSb9oBhtGRRikah39GwWaA92K6yaqISFsqeLGqIcmmtlhTjunEECHazyi6H8T1qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236034; c=relaxed/simple;
	bh=Z3B0ZSnM/zP03ZZAPgjEhsKcaFphHxVTAgYD0vT07D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4LQpQeRd0KdneqHgRTTcYEu5LsifuA8b6zjZm2iDt6vmEp2i6OukCY2M0PZI3gdXNkWLrdZ+lrAMEffgjLIEO+wVYvOTMdExi5Q2Byv+r5IdnpyyzuxoiUkwd2KqwEzVcst5X+7VQko6XKtHMF/g8f0/ouf5VpS8RZaNg4vjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso1099446b3a.0;
        Fri, 05 Jul 2024 20:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236033; x=1720840833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJjdj69JUvtdskdae9ZCogfAIU+JoEfJISpUJiy+VIc=;
        b=bxL3Ev3/M9Sdhbhjc3C6k76zBuxn2bUMP1busJgJQm3OiddRod2JQu6nMjsjvKvd0D
         45MmfNfWVH8W18CrFJyPhSy3fPEK15wfwNrtte1IQgqpwTf5MibkFGuw6k3b1C5saeC6
         ttlteL1mlwTbBCcgErPaXKcpOGvjHVssqbRPYXFhfXNnRyHTI0H5rx4p/gtp4yJIIyD3
         WuJ5T36vAvUM3dSSCYXOE3+yNbyn+tuA4F7RpYW1ODoJJCbtm6lMhwHmHU3m4giZJAVT
         ifhrUR9pNYcz3zmfFCnaU/ELGt4VC+Jwq5NZDlwwvpbjU0SH8AiPH4q5h3ZNQKzgR3UG
         PKwg==
X-Forwarded-Encrypted: i=1; AJvYcCWbm5C9mPotpfcPV8w1adfdPMyLjDdKJtMpxfocBJJrlexaH3azQ6/hOUZPb8FmWF48GynVMz3NYjuL0xAYqU2h804+8rSV48mJiH9UZHr6h/SpEV7DsHqajyKxlhMkXFM6jH3x8loB
X-Gm-Message-State: AOJu0YzyDcyM9Qyba0TZt0/UsEhKndJ9WNGfhuLqbNiVjhNdXOhPQZ6/
	2s4500XWNvsf0NeqU07nhuR+Ia/ltMxDp/4zpSk6Wr4o0tg6eyCN
X-Google-Smtp-Source: AGHT+IFvgyXDuZ5Dcjd5yHOUo7fT0IXXrMxAQQOCnepAclsvXgLIvcbG0defXhjZDAE3/jD8DOb3NA==
X-Received: by 2002:a05:6a20:4303:b0:1b8:a3c5:3475 with SMTP id adf61e73a8af0-1c0cd17eba8mr11027098637.4.1720236032689;
        Fri, 05 Jul 2024 20:20:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b128b1d3fsm1694599b3a.149.2024.07.05.20.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:20:32 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:20:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, stable@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Return zero, not garbage, when reading
 PCI_INTERRUPT_PIN
Message-ID: <20240706032031.GF1195499@rocinante>
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

Hello,

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

Applied to controller/hyperv, thank you!

[1/1] PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN
      https://git.kernel.org/pci/pci/c/fea93a3e5d5e

	Krzysztof

