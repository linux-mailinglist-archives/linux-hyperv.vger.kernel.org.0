Return-Path: <linux-hyperv+bounces-903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DF7EA47F
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 21:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C185BB20A07
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703024213;
	Mon, 13 Nov 2023 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBFFsj20"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EA24203
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 20:12:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D90D5D
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=iBFFsj20zF4uVQYjWx7q2rniacseIJG7dEck+YcTElQhFRu6mxmerJ81FvHJI4iskAJKGf
	+Qbm7qRqzdOduAHKilbvu/mRSyDV+3T2j3mpqj3Sru8ewxm51idjUs/63iPaog3uzQfxbF
	4KG7nFanKadGBB4x2TgzLUUM7uf5b8I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-dLZzxLF4O4KZd9Mt0t929w-1; Mon, 13 Nov 2023 15:11:59 -0500
X-MC-Unique: dLZzxLF4O4KZd9Mt0t929w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41e58a33efaso58021761cf.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906318; x=1700511118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=F9zFS5B/P8KMOWKVaVjUipu1Yt0B9xvf4AbBrNQg4O0PoO4WAsYJeGGfAqehjZdCq2
         12DQW/l3qYXj282U0kkPKwdcaFj21KTbxJ0QM9zm+FFURyuNyLBw0oMro2BA3tYVJdDR
         wUZT94xsz5P/bzEIJwrlCvwUuEfG8DV2tnpsR3L6dkfq/ajVm1lzhqr6FTgKsmIP0eto
         BYfe+NxHdwmnx37hQkZxv/2vy49dMifXX4pjVDoqHdRTVMPoosGKZ4GXbe84WTr4zRLk
         oYIGxbsCMUXx2pp1OhCxx0SkG6tvgF3p7JgxFrSYaM+ZPnbOTeMsfTAjenGiC0dMGR54
         Jg1A==
X-Gm-Message-State: AOJu0YwTv8bLDn7gdSgKfnlMxTiCxdrHbdYQ2TaoP9oXpcV+U/USNoM4
	vbZF9hhDsOcxfThzMi39v0JSvwflplVr/A4cZ2bhLMDmG0/WSNyDo1Yit7wT/vMya6afcApEJHR
	TqO5iK92pC9zu3rZ8e5pbKSsV
X-Received: by 2002:ac8:5f0c:0:b0:41c:e02c:858 with SMTP id x12-20020ac85f0c000000b0041ce02c0858mr147773qta.49.1699906318370;
        Mon, 13 Nov 2023 12:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFswPYZrUE+iHPpixm0usY52QHAZzAKPKkAbEgaDvDovqU3DEFNzLkKbZFJyBFwEre9EilUMA==
X-Received: by 2002:ac8:5f0c:0:b0:41c:e02c:858 with SMTP id x12-20020ac85f0c000000b0041ce02c0858mr147719qta.49.1699906318082;
        Mon, 13 Nov 2023 12:11:58 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f19-20020ac840d3000000b0041cb8732d57sm2169319qtm.38.2023.11.13.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:57 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:56 -0700
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
Subject: Re: [PATCH RFC 08/17] of: Do not use dev->iommu within
 of_iommu_configure()
Message-ID: <ciuy76347ki3xb5jzyji5fbzpsm2ssvcyvfgm6q7fqbneaoj7y@v5fpadftudhm>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


