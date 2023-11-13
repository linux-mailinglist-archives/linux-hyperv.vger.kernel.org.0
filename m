Return-Path: <linux-hyperv+bounces-900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7257EA464
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 21:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453C7280E19
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5412420C;
	Mon, 13 Nov 2023 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkFuWos4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DF224DC
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABBD73
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=QkFuWos4vfqSVbsvh7QXl3XJOrAGYJSPnYDADtfbc8++qTReh8+Cy97GqqC0DtipgMXCg0
	JjJGp3JKhqZTYh7Murx8cPeU8g15IeViWjFOufEFMGlR/uge1TBg8Ho3JfVgfPbEwDwceL
	eS+pdVvMhOmQefXQa3jc4AMiw4HnVGY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-KAa1qpQtMn-WcPyBMI1gWQ-1; Mon, 13 Nov 2023 15:10:46 -0500
X-MC-Unique: KAa1qpQtMn-WcPyBMI1gWQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788fa5f1b0so578238485a.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906246; x=1700511046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=RyZ3fVFc10MMOQ6FhqizqqjTDD3adIJHpnxHed0jHy23Msv6M/v/asSKWys63Oru5T
         lQGCyw3b36h9Jg4X+vqxNncE6Z73ntaww0shEMNejOVQEFsj2WRbL0zL8T+Mg+dPqgF+
         WNCMet/GlsBwbqYIm99y0GOgpQUOEhp6f+6wApRsX3Ow5T/JrHLBRIEmyeLoONLoQAnL
         wN3RQ+VWiAH/sqAv+l+Cqkb7J0v5Cj9Z5mNU3zFsbUsnz0iUMaOW8x9dDmhwzmvK+//a
         MzmCP9o8FUWFjB4RcLnDGoW7GWYGS5VaUm/U9hs1bTt/n5z4Ssmd0WMTozjzmxROAIXv
         ZVsg==
X-Gm-Message-State: AOJu0Yx6rYtWsCS15pqmKzJKbm1P2cBBXzXWzCcgwUskZlYHqgreBbI8
	wGnnDx7hfJH2S2ritLsUjfq1uF1DwLuKXzlRulZVwiLfyNqRODoSXsRsB44c57/M2yA2YBasKxX
	u84HBtM4qOUsACb090DPVWUJ4
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr322010qkb.13.1699906245965;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTedyYglCJvmi92iRdR2D4BIAbVzeajOKcDR1OXvlL6dJaLGV+tVe1Q6WIBYPyxZBc3gPFSw==
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr321979qkb.13.1699906245767;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a130600b007742bc74184sm2112406qkj.110.2023.11.13.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Date: Mon, 13 Nov 2023 13:10:44 -0700
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
Subject: Re: [PATCH RFC 05/17] iommu: Make iommu_fwspec->ids a distinct
 allocation
Message-ID: <bhbvxv5bt7b5tad27cuvy6efpkg2fwxx2delgcmnsd7sttqngl@irtpllmr7wq4>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


