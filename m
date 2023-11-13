Return-Path: <linux-hyperv+bounces-902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663E7EA478
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA772B20A16
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645EC2420C;
	Mon, 13 Nov 2023 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TETKR5gE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FE24208
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 20:11:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D78D75
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=TETKR5gEqAHG8BMIkcGPuwULTW0Rk8Vc9TY0Nk3rmBw9RrQDuw/NQ7rtYPDQtXOal9X/FY
	HeGfV8BmQ1aMhp3IyZO3rjBi76cxpjCzrLKZoXRSipuLu7hu1zeVCnSbbdf3eWZ1lZTYQV
	3B69cOWP2DBPlgeaRbvgL3Cku0KAn94=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-rbm4KhouPvq8z3jakFQUZg-1; Mon, 13 Nov 2023 15:11:40 -0500
X-MC-Unique: rbm4KhouPvq8z3jakFQUZg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-589fa8cd181so3873745eaf.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906300; x=1700511100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=TvD/PSrajpibitQP17XJrjPss7H9lWCoHwI+x3Lu+kifk2ZoA9jDatyQH6AH5cEKPy
         v4yighTe9jrHtxjyJGn27LjbmnDnT9uYai36rJNk1z3z1qLd5eGQI2qqpVx7wX0fOw5L
         L9FMAGfiEDQzCzywghkb1BwRBztzoozH+A63GT834dhf9k1FyHEaWOq247EEjWR4X8Uu
         cceoL7PQUbO0l4Hx1ZnhI0hIj7hG9in9p9u37Quphrj0xnNOEytZS7J4JxAdg46ST+ly
         HHQCFZbtugQI49cv+K+836ilC/ud3vr/KlBajNwS6ZWlvtusb8BgP1rIctsnclvHs67R
         ozKQ==
X-Gm-Message-State: AOJu0Yyuxu80NHDFUDYaBwYeVQcmKKks3Lrfvu5C60wjsSxs05hCwUMP
	H7PEfv4ZuI4Gbmzthu/8EtBIj65YHO5xpqaDGk39PCcdtVnJtCSigIB8QXzFmr4BrsWR6c5Nut9
	rCceLmuO8lzTvw15VHDZFonJv
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367414rwb.25.1699906299912;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIOetclT7JIwJMgw/sY1gBz67FNYTbvIhgzf8jdwnJ0WmLDY550/th30Kkt+kh8RpDUm+sYQ==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367389rwb.25.1699906299658;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i2-20020ac87642000000b004194c21ee85sm2173891qtr.79.2023.11.13.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 07/17] iommu: Add iommu_probe_device_fwspec()
Message-ID: <uw2q27tpuqmxe5gzjjsmnjy2rvtztqomdh4czbws3yredeshzl@7zy6ls5ozqg7>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


