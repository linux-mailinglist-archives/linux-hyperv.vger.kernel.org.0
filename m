Return-Path: <linux-hyperv+bounces-5514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B4AB7259
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F093C7A5AFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C12749E3;
	Wed, 14 May 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKWwWNZw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452D111BF;
	Wed, 14 May 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242471; cv=none; b=fYJ0L40hvD90ppq8Fw0BpFUVDDeRaiRoco5sKnl2QzWoNbp09HfNAhr8Wyfjzj8PZPohbBPKLaFmtxxB65cfWX64SxEoD8tMt96zRzqqFVSiTWR1w5/3oaXesAveYubDSZRbRRSwAJkP2nKNZRScbQ66ytWaEBm9JNqCaKcenAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242471; c=relaxed/simple;
	bh=XdLg2pIG+mxLLkXPdM5zsckyRBZH2qPAfwgOgXwOm2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSeMYfbKBHL3j56po5w1e6u6rtajwQZKIuGP2obI109zZiJBX/kczZJSM0//NzSQeVW2zdsIk5AOmTYScQvc/duXF/rTXZcvtn6eBedJC6zkZE7mJp4nW4IOOaQ3tEcTnJYkEQzvh9qtc6aVvwKyO6NmcMsVA7SyxJgiqgh1O3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKWwWNZw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so94497b3a.3;
        Wed, 14 May 2025 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747242470; x=1747847270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJoA+PJtmWf5ud2q/BLeac3jyop0iaZrCK1z2Pwqxh0=;
        b=cKWwWNZwybLtZpb2NOlqoUnZTU49DHPLsCkW+uDmVBiYVzMZfF8pstmCu7/4qqKgnZ
         diZnJL4q0mUGniS2QcoU8VVxI96Hnf1MuL2ZxYnP03zmVbLIhRnseDZQ3W6caEeGjHix
         iY9finlPFtUdpADzHj/SgPM8xeqXV9LNDSzgm6BrRM4XTQpr/5r2KxPU6eM2wQ8/NuYH
         or2bHlDGHJZbS8ZXp8Tygo9iwFLF99HA+qvIDMCThN5xLE/YVo4RzxlSE7islLW5ZV5i
         vdmG3QBdNV/+02Wkh0jP/L3Djo2J8m1f4zb8ZMRvNIJK6Hen2FA8WytNT/BY6d3ryWF5
         jyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747242470; x=1747847270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJoA+PJtmWf5ud2q/BLeac3jyop0iaZrCK1z2Pwqxh0=;
        b=McEDIWaJ0Bhzf6595tS66tCO1fslnRShop1h3XfFNgtix4vLVHtHGSoUvGkHtgw9xX
         ztHz3BoXAWjCRNTAAU5S0n88snWxYRXiKGLMWdZUH/f4cWl/YJ4XXgLcCudYbKxaKXFs
         f4XYZ7HQgyQA9RqUPf8YUG87eqcmLdcHXTGYbBEsLVIGXK884LvwK+VklxhAllbTMno6
         2I7ZaPCabSERQ3GRC1UvAVXasOuE7BjapN/jil4iWnETqQjpCsn6yuoNyrhgXVdewaQT
         669LnlsFBl1+39Bn2qxhgkiOoKSyNYVmc1emzMYwYZ1h/Y6P21+Ygg6m3kj+lu7fSEcm
         uVTw==
X-Forwarded-Encrypted: i=1; AJvYcCU03dEt5WA+dXYkHokxzOVjkmBTw1EvP63EA0kKqCBm4POgOS0eQ1gRWgHtNHy+P8QmK4LQ6zplK4ji@vger.kernel.org, AJvYcCUNNRURmj/DUMXSVrpVrfdJvKrQP4/SRvYw7SPs1c8tzoLJ6Sm6YKvaxkbp8ENpqxDtsU7YAe+q5Q1hCLr5@vger.kernel.org, AJvYcCVGVDfovy8cstCEJW0u+a/NseARNzCjsS0jtoTZgGtsxIrRvvnI2Sa0bPUhCggSyvi2z99V3SRbpLx4hQ==@vger.kernel.org, AJvYcCWDthco1jpFUmZlaQDoe3G0iF8j8RYefr39kLI9udX8ipOZdYrF0l5kiQvU6/cwN6/+Vmb0kNyU6ebsKn0=@vger.kernel.org, AJvYcCWqpjnAj99Cc5lm3N5nsaEmrTo5z4Hd+/8/QoWUte7WFGmmcRJ+SuR7UCh5MBIociONQR8jgGXW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1K2DzfAU/HhzAOa9adYkpHUAYBm0uInEwCF4259ftLwlQ0QKH
	tBgCD1twALlku29Dl+1XtFVxikEO/haT8IqvhS1UYSe1a1FlGSQW
X-Gm-Gg: ASbGncszIQhHoMgeQRKkCPbPzoye89BOOvJWHtCXjQLwaxr0Be2kKIOid1puwm6h90i
	cVcrhPh4FxcnYh2hL9hVVv10s6r87UqPu9wNL33EUSJTV5qUocqoh4adK/RTTpeqzQC0ssjkG/J
	W3JwwGBqjd7XoxCNOFmGug2hGwDZzApUec8BA4uuGYUv1cniP1ouN75GNZA5TpO83KJlUIh+0vG
	fFsDz3x8nWXS/yPyRUbAUW9kk2Gqc9ZpQqWF6nyi4aOJR18sTOJCfqYHZ7RfmAYPDQrpfgA5Fup
	9zzqBhnenE6/egGPo7QsOQoeZmgxUrMSDqNmf6/cfqquTGhL09o=
X-Google-Smtp-Source: AGHT+IE8yKn2sT46UJJvS6Ice8X9bYuvWD23vsV/OkjkW84qmgH4nvxXynVSLJtxqPpkMU4yfMQMVQ==
X-Received: by 2002:a05:6a00:17a3:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-74289290036mr5560234b3a.7.1747242469517;
        Wed, 14 May 2025 10:07:49 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0f14csm10071804b3a.107.2025.05.14.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:07:48 -0700 (PDT)
Date: Wed, 14 May 2025 13:07:47 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 4/4] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <aCTN4yfHBsJGXvnB@yury>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785637-4881-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157AD1A0BA2C0C9237FEAA3D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AD1A0BA2C0C9237FEAA3D491A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 14, 2025 at 05:04:03AM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, May 9, 2025 3:14 AM
> > 
> > Currently, the MANA driver allocates MSI-X vectors statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > up allocating more vectors than it needs. This is because, by this time
> > we do not have a HW channel and do not know how many IRQs should be
> > allocated.
> > 
> > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining MSI-X vectors.
> 
> After this patch is applied, there are two functions for setting up IRQs:
> 1. mana_gd_setup_dyn_irqs()
> 2. mana_gd_setup_irqs()
> 
> #1 is about 78 lines of code and comments, while #2 is about 103 lines of
> code and comments. But the two functions have a lot of commonality,
> and that amount of commonality raises a red flag for me.
> 
> Have you looked at parameterizing things so a single function can serve
> both purposes? I haven't worked through all the details, but at first
> glance it looks very feasible, and without introducing unreasonable
> messiness. Saving 70 to 80 lines of fairly duplicative code is worth a bit
> of effort.
> 
> I have some other comments on the code. But if those two functions can
> be combined, I'd rather re-review the result before adding comments that
> may become irrelevant due to the restructuring.
> 
> Michael

On previous iteration I already mentioned that this patch is too big,
doesn't do exactly one thing and should be split to become a reviewable 
change. Shradha split-out the irq_setup() piece, and your review proves
that splitting helps to reviewability.

The rest of the change is still a mess. I agree that the functions you
mention likely duplicate each other. But overall, this patch bomb is
above my ability to review. Fortunately, I don't have to.

Thanks,
Yury

