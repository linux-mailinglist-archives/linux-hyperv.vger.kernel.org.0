Return-Path: <linux-hyperv+bounces-787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63F7E5D4F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83FD281390
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4E30341;
	Wed,  8 Nov 2023 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag/sekfg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEE3032C
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 18:35:04 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFC210A
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 10:35:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40790b0a224so53676255e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699468502; x=1700073302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=Ag/sekfgYdN+QO2qNzC+r6BzqCMo9dzcsxvOu4xJN0ribyHewu9zogJx6FWNSomfI9
         4Sjlt/qA4mplNZMnvot6/g+6cmnze23j+AP62wX8o67Qahuu0IX9K7PX266zjkQY/wRe
         hNpOh576uhk6o2F1atbxeeQelw6dBU2ObOSQ9yQGCGBdBys3mjvoiuXA1WEspYXM7dqL
         8or59NUpDHRURUG6WDvo92ajLicd3w5fF4NJHO6NtHIf4rNDQeB2t6EQLDVDKgiNAp4S
         f8GgfhkHm4K6E2W6wIdOxZzpJIJC9NgohDiD7zD6auJ87yEubapy07YfOPudCdJ85XuR
         nD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468502; x=1700073302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=HLMf3Nu3ndwo9FdyiOfz0o0cqxc1wM8OyYVwO98+PNR3Urvqwthg+rvPDQwufcu8eb
         VvYCMmSG3CmmeS02x8Ijdqkt7DcXEQcT/07ORW6WXO3fn+35/N+BW/QGMrfqjYZqSO6T
         RKhFsMYJQgwOXpYwQ+paRroHipAyTyj1jTOs8B+vm8grvcLs8/+UOAJDcYh/YVoHUTxF
         9dAmAwajflMsxqk1UCAgv+Sm52l0viqkxg07ms7N2V6fF8A6tVSWLmQt3joooWYHaEqM
         J5eSXNCckbdz2jHlFJDFS7J7KpvVrWBJBtn0uIV2C/T2+mt06T8daOVUN7TDRkIDWkPK
         B30Q==
X-Gm-Message-State: AOJu0Ywg1bbrKbwx06GFi0uYrBu0CJNJqX+gzj6NqVGBuX1qlu8m4SdN
	taW2dYWQsXC4OrkRUtFjTwAKBg==
X-Google-Smtp-Source: AGHT+IEerzRoblFu8LqWqAyQVzl32Dow78v7sZDoe2sPpmQgBWRRfSrEcftCpyNmsXV1yimnvtHQ6A==
X-Received: by 2002:a05:600c:190e:b0:405:1c19:b747 with SMTP id j14-20020a05600c190e00b004051c19b747mr2262734wmq.15.1699468501866;
        Wed, 08 Nov 2023 10:35:01 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b004068e09a70bsm20156528wmo.31.2023.11.08.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:35:00 -0800 (PST)
Message-ID: <d6664edcccd81edc5caa54e8da43b5c571a3ea76.camel@linaro.org>
Subject: Re: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, 
 acpica-devel@lists.linuxfoundation.org, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>,  Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,  Catalin
 Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>,  Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Date: Wed, 08 Nov 2023 18:34:58 +0000
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> This is a more complete solution that the first attempt here:
> https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah=
@quicinc.com
>=20
> I haven't been able to test this on any HW that touches these paths, so i=
f
> some people with HW can help get it in shape it can become non-RFC.

Thank you for this series.

Please note that we're also observing this issue on 6.1.
I think this series is a good candidate for a back port (slightly complicat=
ed by
the fact that various refactors have happened since).

For me, it's working fine so far on master, and I've also done my own back =
port
to 6.1 and am currently testing both. An official back port once finalised
could be useful, though :-)


Cheers,
Andre'


