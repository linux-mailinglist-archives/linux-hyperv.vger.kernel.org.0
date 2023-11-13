Return-Path: <linux-hyperv+bounces-904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB57EA483
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 21:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E121DB20A0A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 20:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF81249F1;
	Mon, 13 Nov 2023 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm4gRkCB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937802420C
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 20:12:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786910A
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=Hm4gRkCBuIO9rmOii3qGBKiY2plZL5PcCwmmp7SN/T+J1tLfgYnvCmGz43FSmkwPF+dJy5
	PM14dTgEOMqc+QehedM7btPN5Gl5eHElUYTKgE773fxtgBZAWjHT58+n5vNsku8UeDHKX2
	pi/oCIxSWN25n2Dzg4bgjkKK/7D5C0E=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-YWjOwrT0MyKGNuPmnEsS7A-1; Mon, 13 Nov 2023 15:12:36 -0500
X-MC-Unique: YWjOwrT0MyKGNuPmnEsS7A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7cc433782so56334427b3.3
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Nov 2023 12:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906356; x=1700511156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=SuRHACwpSDmJHurqhIjyNizjAFn+/lnxVb/Po2R/vb6FFZacvJxUveMktswOnlVYTK
         Rp/c5W4/EF5KcPBI4yGtp4RROf4yjswey04ZetAV4HSEo0TMpkwnOrEJixad2leiMNLE
         j7hnVltL0kxjszSi/NyosWAM4cl8+Ua4y1IyF9BrqHQbewGEKQPdthBZLf4S3lVxg0yD
         3Vq3FD8Yat3+Ob/msXfp3E2w2fUUHabDJ+KYyrN5he63gssQpTtgJE7r7KjMKIU1qXCQ
         xYaaUlo3caqQ1KNiJV/EMZy7vzLkMaWPnhnUbqJhHJ9E1nS64QBP9hqZSqibuRjwIffv
         ei3g==
X-Gm-Message-State: AOJu0YzBjFgcOj2iWzQ0xsFLVQwoMlEZbPr/6qkOpRV82t+vwj4LY1N/
	Z4MuFSLBGomNZehVqjzVA0UD1aSwfnvGyO44kn0P4OadsOEVGvjEj0IlU/67bx2CC5qli8DLdZZ
	PG7VXQEUR8QyvttkC/hR4QQiA
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681670ywg.16.1699906356195;
        Mon, 13 Nov 2023 12:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8TAFaS4ERYYFs+8jp6ZPsOwc5cP1r90IboZbxfRfwy6gwcqiZWRR9jIiN36BiWY+6zJFv5g==
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681632ywg.16.1699906355905;
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a10-20020a0dd80a000000b005a7ba08b2acsm1972894ywe.0.2023.11.13.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Date: Mon, 13 Nov 2023 13:12:34 -0700
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
Subject: Re: [PATCH RFC 09/17] iommu: Add iommu_fwspec_append_ids()
Message-ID: <xv2544jtubq5aefvzaiabazmz5uf32alw6blcdbvsui6wn37ep@vpykzk2vvyp5>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


