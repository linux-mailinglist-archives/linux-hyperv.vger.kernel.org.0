Return-Path: <linux-hyperv+bounces-5675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3ECAC5A6E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74D24A064E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8EB280A57;
	Tue, 27 May 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWdgfvR5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A027B505;
	Tue, 27 May 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373020; cv=none; b=ofMx14tUGX4aJB3YYbWiUDu1+t66aFJVba/eIRq6I5tSkp5K8Cii7JbPGPSR7fH3D688q7PHn+Yt6UZEt955iZ3d2yYignvbVVMQjSshBaeD/SZt60obls9Gx+A2XupLVvfVZ0WIT9lX8MMt0aPnILcX1wMZXAI1KXXDauMyQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373020; c=relaxed/simple;
	bh=jvIursIm7xirFrAF6+nx9NHgILyAFssbM2BZDvh0Xjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYuUvwldZ/46zBbCNVtEEwQ5XKvrjeeubd01sjbyCwT84XFu1nDFZcI5eAHHtmJx5xk4MC830iDfhGOC0WtMM7jxr/QQIw23i+p4QxXd2zP+CjffuPMj+S0iqCWZuE2f/D4VItwejZEOsQIio3Uv4H972cltN5YVy9B8xjuxYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWdgfvR5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2301ac32320so31379325ad.1;
        Tue, 27 May 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748373018; x=1748977818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ4L0D20ndsCdzFmLfAE6nfeaO8SPFx82dBJgoFLkBI=;
        b=jWdgfvR5bDIKMrvCDma9xTvwfEcYD1nrh/b298vgoOKEaIORbI99Blx36EqxziHRho
         A6cFzeNFDKQ50eQO98d0aO/z3mvJRBC2VMy3NOmkK3prkdnpfoP0RfNmmn6LAGwKMrBj
         yJCAX1kysRZ6HpZHs8nKP0OyZ6OTWtwH8RkNpoH0x30MsfNaAgr5SG+a+vnLsnmK5si6
         L6BtNppYBJgA+4yATkf/orU3jgr4w6PqXTPmUBMUUlnfDcYvBiLtWseyM/Nx+WVnNtL/
         vSu3R27a3Bk9sITlh0H5YOP/hfm3H9+aRU1MpDxEHjGgiMsCEWkYZm7hKYn3jItkYmlp
         6+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748373018; x=1748977818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ4L0D20ndsCdzFmLfAE6nfeaO8SPFx82dBJgoFLkBI=;
        b=VnHEe0UD/wPkyrwnGdjLNxID+EFazgM9VziTZAo6NsTmKnVxBfxFu1nkG1QOV4v0qN
         XPk5XFnjBBDdUhMHLpy0KhxXIrODr6cJ2r8FydNF0ra85pPIRoIMwiX+pKG5krrIKPYY
         d1BtHWrO7H29FqER9YpPgoM4OuQwTu2wopO+QA6tj8qcssInH9TmCEJczvJYLmadEr0x
         uwCdVgYtzJfBNuoDz1XEHn5QXMC/n83vDfuJnPVcBMUOUD4h+X9fjiHEwri2GL1icJCT
         oqniQb+NLLcqXsPA8lA3VaJdu9sAf0E8KCDFpVXts/TMRN6EbGKzHownGKIOgSaV7SIe
         VgYw==
X-Forwarded-Encrypted: i=1; AJvYcCU1TUDJSSO2YaHkLf2jBW9dNJWa50sv1ESloOpfwP3pIPo5scsJuF13EOFR/pLt1c4yyGlx2HIam6Xo8Q==@vger.kernel.org, AJvYcCUOO/NFLfoA8sMwOj1jLhDfN/lDhyw2v3h0cXzD2vDxNHYi+qF0qk2DxHX7RLpOT9Q34cuX1QggMF20XiE=@vger.kernel.org, AJvYcCVQucvKsZOOL2rEIIxqzdu+cOInP+HwHLN9dMTdfgUwerObUGXiGbdcuuwSIx19HF1MLLr0KnzaEM+9TnXX@vger.kernel.org, AJvYcCWeG9qj4IuL592mcZ7kdXB7r+lrb+bSA+OLr37rGUhYZgFxy84lMqTBEtUDXVXG7J0dKW3e94ke@vger.kernel.org, AJvYcCXAw8On3T9KO4aYHm7sLFcGE75dAzsKZX9QLgaSKcdHz5sKrG8XHulKA2roqyKZbgDTRGtNeEFTge4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1e8TtYXBRgHGlQ+tfzyMsKxGvfI0y9SW49ago5V6oFuZ+gtA
	O71gAlQ4VmGpQLf7mZFzt+SKaYEdRseMblh1hTBjRaMIloelgY2EpMb/DvlGXw==
X-Gm-Gg: ASbGncsE7ZZqmFnV2puCCa7t7ejJ4RJq9zzk/iuzhlIqSf/2/60f4CwUtWHJk+vJQcN
	EPuv3q/aZ5bgDRIyrqlikQ80v3JRkUFxPh4VUJ9PeNR/DNnONDKd9fHcfQ+E/OoMJx2Qw9Hvqcc
	lJ9sDhySUT+VJEZlu4FBGBGOLMkW/KCWaBs6VpE3zYwjXIhzsttPHmKxMPZCJEp/W8cAHAjYlzU
	qbhrhexAoO4cO1T62XAMWyajjZHrA/zbeFAU0sIqHI2tf1p9bwyMa46GF1KY4/WU3hqCApOSE9f
	8a/Aqd50LTwkjNsZko+CHhDhOjM5hbYhIzMv2W5UdPi8ONNaWcA=
X-Google-Smtp-Source: AGHT+IE4iGM8B7MNpxVPekqnTow+ybSs+QzOfae2nsSVmSU48C6P19U5szUtP3FoDqyqAr63lEfoCg==
X-Received: by 2002:a17:903:2593:b0:234:9374:cfae with SMTP id d9443c01a7336-2349374d00dmr57470505ad.19.1748373018305;
        Tue, 27 May 2025 12:10:18 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234a1681ca4sm14031415ad.46.2025.05.27.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:10:17 -0700 (PDT)
Date: Tue, 27 May 2025 15:10:15 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
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
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 3/5] net: mana: explain irq_setup() algorithm
Message-ID: <aDYOFzQrfDFcti-u@yury>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361505-25513-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748361505-25513-1-git-send-email-shradhagupta@linux.microsoft.com>

So now git will think that you're the author of the patch.

If author and sender are different people, the first line in commit
message body should state that. In this case, it should be:

From: Yury Norov <yury.norov@gmail.com>

Please consider this one example

https://patchew.org/linux/20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr/20250326-fixed-type-genmasks-v8-6-24afed16ca00@wanadoo.fr/

Thanks,
Yury

On Tue, May 27, 2025 at 08:58:25AM -0700, Shradha Gupta wrote:
> Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
> added the irq_setup() function that distributes IRQs on CPUs according
> to a tricky heuristic. The corresponding commit message explains the
> heuristic.
> 
> Duplicate it in the source code to make available for readers without
> digging git in history. Also, add more detailed explanation about how
> the heuristics is implemented.
> 
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..f9e8d4d1ba3a 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1288,6 +1288,47 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> +/*
> + * Spread on CPUs with the following heuristics:
> + *
> + * 1. No more than one IRQ per CPU, if possible;
> + * 2. NUMA locality is the second priority;
> + * 3. Sibling dislocality is the last priority.
> + *
> + * Let's consider this topology:
> + *
> + * Node            0               1
> + * Core        0       1       2       3
> + * CPU       0   1   2   3   4   5   6   7
> + *
> + * The most performant IRQ distribution based on the above topology
> + * and heuristics may look like this:
> + *
> + * IRQ     Nodes   Cores   CPUs
> + * 0       1       0       0-1
> + * 1       1       1       2-3
> + * 2       1       0       0-1
> + * 3       1       1       2-3
> + * 4       2       2       4-5
> + * 5       2       3       6-7
> + * 6       2       2       4-5
> + * 7       2       3       6-7
> + *
> + * The heuristics is implemented as follows.
> + *
> + * The outer for_each() loop resets the 'weight' to the actual number
> + * of CPUs in the hop. Then inner for_each() loop decrements it by the
> + * number of sibling groups (cores) while assigning first set of IRQs
> + * to each group. IRQs 0 and 1 above are distributed this way.
> + *
> + * Now, because NUMA locality is more important, we should walk the
> + * same set of siblings and assign 2nd set of IRQs (2 and 3), and it's
> + * implemented by the medium while() loop. We do like this unless the
> + * number of IRQs assigned on this hop will not become equal to number
> + * of CPUs in the hop (weight == 0). Then we switch to the next hop and
> + * do the same thing.
> + */
> +
>  static int irq_setup(unsigned int *irqs, unsigned int len, int node)
>  {
>  	const struct cpumask *next, *prev = cpu_none_mask;
> -- 
> 2.34.1

