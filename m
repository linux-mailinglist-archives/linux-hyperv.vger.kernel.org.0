Return-Path: <linux-hyperv+bounces-899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D337EA436
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 21:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C23A1F214EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73401224CA;
	Mon, 13 Nov 2023 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzyzED5H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBE241E6
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 20:06:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0830D5D
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699905968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=GzyzED5HYzF4rvyrbEXuum1zn5kLd+ca4p2b9B2YPFJXo/eG+/WFvae3SribMTd/gNLQZU
	wZpIJKkOCKqLpk/8/3il0yaEjGdTxJQ4TWAH5amwcrV+t8I8rjuKHp2Rte9KvvF8KYWpTY
	tFCv6cVrXg2T6AwXA9oYZRNpRQALSoM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-sbMDZvqcPF-NShF2KSGZwA-1; Mon, 13 Nov 2023 15:06:07 -0500
X-MC-Unique: sbMDZvqcPF-NShF2KSGZwA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d0b251a6aso59225716d6.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905966; x=1700510766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=NkRLOuXTwdtuoP6QKF/mN2uNbHdCpunX1eAZpPFApIMZL93sqqHmyr6tE6TLmq087O
         d8OD7L9JWboZZeNUqYtslw0Z5R8M+Gqz1HPceUpZwNVq2AyFRS5/iPsAQAKyQo079YZX
         gI0Nd3VbDHGiN3F4w49Jaw5ab7M6GH8kyBpbNWZB4v4QYc02BMGfEr9kztarCMkmDg2l
         ummwqXDCKdVPJt4ai8Zxvr5cfdnacIQYdAndw6/U1KfL4jJxkVR8n+DhFyt4Uc7h0C4j
         tYbDDc1yP62+qcgl2CZFbgS9y1a3qR1th2C/TaWzwh+msl+U9xQFhvC41edkdSjIYPGp
         G2Fg==
X-Gm-Message-State: AOJu0YyV48fM7y847Nt6EKzdHM/CoyOJugDLwfZaXQzaO/qpCIRYoeq3
	VkBqfeNk4ju4w5YwZfqk1rqmRSWviqfiiOiFw3ktTHFE5BRQQZs8qkOMk3Jnn1a4cNOJeOlw3dv
	6Sh8THBzZCyrXpg52vKfuQlI1
X-Received: by 2002:ad4:53c6:0:b0:63f:80a0:4eea with SMTP id k6-20020ad453c6000000b0063f80a04eeamr283849qvv.24.1699905966598;
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU546dToL/RnbvSEEgGYhgfAOuTUeuUj6W3IfV3UEMZ3+1fSCYuM0AW5xrguKdlx+xfhHm1A==
X-Received: by 2002:ad4:53c6:0:b0:63f:80a0:4eea with SMTP id k6-20020ad453c6000000b0063f80a04eeamr283817qvv.24.1699905966425;
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q8-20020a0ce208000000b00647386a3234sm2299097qvl.85.2023.11.13.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
Date: Mon, 13 Nov 2023 13:06:04 -0700
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
Subject: Re: [PATCH RFC 13/17] iommu: Remove dev_iommu_fwspec_set()
Message-ID: <fussoe3f2shd222d2lwvcts3odhnyuvfxpgv6c3k2d4udxu3uv@db53jszpgq7v>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


