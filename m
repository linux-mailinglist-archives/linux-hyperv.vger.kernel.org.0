Return-Path: <linux-hyperv+bounces-689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9B7E0AD4
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 22:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2432E281E99
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC623776;
	Fri,  3 Nov 2023 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgRwyvVZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E6241E6
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 21:47:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DFD5A
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699048059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+aB8ULpCtjf+Gcfe540UtUd+NJKrSGjq+RpmL2JNA8=;
	b=RgRwyvVZweBgVGAk6L6MhvfxHJGscaB6d5jr81JqVo4s0w9hsRIIEJlnDURFJdyV/1J0iz
	/c/m5cNh+TfxAKUfmrEmNmD4fs0wdbDaZnpOKBltp0OAevh4Ooh51xDB1BjBakijtxwsnp
	7VVb4wGJKRJUy+7aoZL0i1bFIvOldb8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-DTW4hpEAMp2yhFlLZaD6MA-1; Fri, 03 Nov 2023 17:47:37 -0400
X-MC-Unique: DTW4hpEAMp2yhFlLZaD6MA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc29f3afe0so19968545ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Nov 2023 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048057; x=1699652857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+aB8ULpCtjf+Gcfe540UtUd+NJKrSGjq+RpmL2JNA8=;
        b=Nfbrt+VXHc0UxZvjT7A9a614GYQqkPtv4i+H/qnuEX58TMbmvTpyLJhJtZ8VH6hzpT
         g/c0eKUvTnMQ341sWsCfVAm7NWxao/wG610F+ElgQueIgKdAZw3wzM+VYfJa/iuLaJCz
         6gEeVJBmvPsAXDUQfH/xDNuUOndwX0SWyfdlmK4B3RuVcUKVc8qA5xiq+4X7dJswQZg/
         zJFA6tDEo2fbW3Bil9ROYHd8lvlb1JS1i1tXeCNesF8+D442r2+KrFhIcTtz6rlvKObJ
         VohfqEI2OOh2xHpmlVBMG3ReLA7aDBAs2g3k6+MHSs9fmaQG5RFoDrQs4eWBP7MqWiGz
         KszQ==
X-Gm-Message-State: AOJu0YzjyGoyS9Y2YHvtFta82ncCFVEY12W6JiYE/m+A2+xygy4nnSbx
	jGSf+nXoh2b3MF7OMFXPYZciGoDebzLTB3ZUbcOHhQ49J5jcMDzCR0sgQiGTUu5qsU3juqg6RYn
	lpgY5cj9dbP3dmuyAg1er44nb
X-Received: by 2002:a17:902:d28b:b0:1c7:755d:ccc8 with SMTP id t11-20020a170902d28b00b001c7755dccc8mr17083758plc.29.1699048056768;
        Fri, 03 Nov 2023 14:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdAXninLAKiU84+Ewx4UvETdEvykTsgu1OMaAqceXcjYCMbCq9Ef0fn5aeDPHxQVvb9/cevQ==
X-Received: by 2002:a17:902:d28b:b0:1c7:755d:ccc8 with SMTP id t11-20020a170902d28b00b001c7755dccc8mr17083727plc.29.1699048056432;
        Fri, 03 Nov 2023 14:47:36 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001cc2c7a30f2sm1807591plg.155.2023.11.03.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:47:35 -0700 (PDT)
Date: Fri, 3 Nov 2023 14:47:35 -0700
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
Subject: Re: [PATCH RFC 02/17] of: Do not return struct iommu_ops from
 of_iommu_configure()
Message-ID: <2qhocnpfy4lbmfm4erccztrwoec5sjphvktcyvxdb75qbjyozu@aht6gj2zzuhj>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>

On Fri, Nov 03, 2023 at 02:42:01PM -0700, Jerry Snitselaar wrote:
> On Fri, Nov 03, 2023 at 01:44:47PM -0300, Jason Gunthorpe wrote:
> > Nothing needs this pointer. Return a normal error code with the usual
> > IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
> >  drivers/of/device.c      | 22 +++++++++++++++-------
> >  include/linux/of_iommu.h | 13 ++++++-------
> >  3 files changed, 39 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 157b286e36bf3a..e2fa29c16dd758 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
> >  		      of_iommu_configure_dev(master_np, dev);
> >  }
> >  
> > -const struct iommu_ops *of_iommu_configure(struct device *dev,
> > -					   struct device_node *master_np,
> > -					   const u32 *id)
> > +/*
> > + * Returns:
> > + *  0 on success, an iommu was configured
> > + *  -ENODEV if the device does not have any IOMMU
> > + *  -EPROBEDEFER if probing should be tried again
> > + *  -errno fatal errors
> 
> It looks to me like it will only return 0, -ENODEV, or -EPROBEDEFER
> with other -errno getting boiled down to -ENODEV.
> 

Ah, I should've looked at the next patch first. So, never mind on this
and the question about the dev_dbg.


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


