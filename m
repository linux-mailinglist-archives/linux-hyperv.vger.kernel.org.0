Return-Path: <linux-hyperv+bounces-5193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED698A9F284
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5B3BDD93
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989B26B0BF;
	Mon, 28 Apr 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKVpJRu8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF05684;
	Mon, 28 Apr 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847492; cv=none; b=tShWOPjI4T/5j0ZkrzA+gu1HlLs9KvujIOYWQ6br8189kSGTGCXgs/anGhlq7fumd1ZOCxWIOx0qvoRrZFs+HqmcWavfBbs04pap/IU/DU+ftCurkjDsO2GkaF5e/dPaY6JJrpW4EitKRQJknHpSA+NcGeYpDF10vgmWi5kK78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847492; c=relaxed/simple;
	bh=HbmgZWLdgBsVQOSIyH96vvLbK8YHogMY5PAm6n3oBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD5fSeptZTlaX7ZaXGZDlE+nc2JdL9waLbRH0+lV1ruuvPXZwCqftJIp2tAxY7Ba9zgF2Kgv9QEZc6Aw0gz0PsIngr5J074lWqfmMu7WqGKxICFjZnMdppaCMU4wfS3AwlMoHqQQ9wvfYZVJ0An1TDkvm2rnL/s75CniXkUQSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKVpJRu8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b12b984e791so4626519a12.2;
        Mon, 28 Apr 2025 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745847489; x=1746452289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CsTnOUQ3ebbTHW7zXMmbWjM+gr5dHufbWP4IM4V66E=;
        b=bKVpJRu8/o+C8ZbkVpMq8JlV1tLqGPVIRMkCKRYLyW6QLuzXlPUgOxOCX8y7hkEgqD
         zcavmaZu+8A00WxjoYp65ezpskhutW+ujCg7mE7Qg9VoNm4R/oaRxadsbCFZUFQeadpt
         5Tw69M6XACCEzmwDy5XqszVH7cRqHezNt/2AlceLlcn1gXSB8pAQgX7brE8VsX785esC
         dx8nOcsHmvaBD5rqhswQlgVR1wi12t40kdGm943d5XufErd+gIl5tVqWVQUDZ62sD1/K
         k0AMOFKMN36GlLuXG7YSARt+QxolwDkOOmzC1VU0+ZwEgKEMZf38Byd0Ru9Q2zCHhbpb
         2+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745847489; x=1746452289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CsTnOUQ3ebbTHW7zXMmbWjM+gr5dHufbWP4IM4V66E=;
        b=lQRdNHPObwFo233zeSD44AR4bipVKmNk5j40bc+FCwT9Z9cBnSjCoUM2t43D8FE69E
         QAzh7FOmFdBSUhlc4nZ5tAm6K7aZ2fjFr3SqJfZrEirWs4hFKYFFIGlBooqon78GR1uN
         43UrA7FvBXGr30F+QvOatMVZWzZxDy+2q50W/YTEdbZEOiZVoSO6uX4pTrvwCP/3RS3B
         YohtWiUtRAaReTiE2BFPigUYtUDy3xz5JKL4MU/AV1pV7nTxAUjqeh25cn+immfWr4WK
         MzS/3BsHBJk8L3PqWC0Sy0R+0dfrsF3WEJVGrIGzjq74g6H+KpI6GWawfAB81sdnBsyx
         06Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUKEbrfkRa6QcWmTqXGEz0ADr9ZbV85JTfMq9SqMtEfc2tD1Q3FyjeLPKMfo/Lskt4exH4TEuZF@vger.kernel.org, AJvYcCUTosTYU4UakSBnIftKNb6UMQeQulKpCcXjxr0SNoNDz7YEXkp2siK9I6TolU/5eenVzRNXcP+l2RXAaCQ=@vger.kernel.org, AJvYcCV2Aq7dqJCst+8tA09WwdJ4v4QjKnPsgf8bu7a2KtgKYuGd2Lx3E5UfvO8S/Z581MOCzLQPMBbC5UnF@vger.kernel.org, AJvYcCXF0rVryKUAbfmgrrxFgbqvTPXcZf+uPuL9cfdBhp5EculB1W1DJqc28nLdUFOKbo+nvc/KS4uIEaOtBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzTbiGjhLMLmp+Y6kPn4r47hUA//roBKtBWheF7UGF3KsOwaI
	XmehtA/D/iAEjiLEduYAdfT8ga3IlZYCbRBboiTGKKQooJhmnj6X
X-Gm-Gg: ASbGncuWqWBYUOI4LgbYAW2luEjvbotimZhpTw1K+44adBm7Gc+z7LziQ10Zv9Y+4tP
	X7bpgcOA8ZkVUTS2tZSViWqISIGlBjinaXuerrYatL4iHT3A/eTJCYsZP12aOc4d8uC3O9vWQ2F
	mg4T/Eme5l+T981aL5+kP03K/XLg/jGutXv3L4+pRhTquFejYLGS7txknxP0N7TKOFk/rHKPobU
	kfC3Dl0MO01SLv4KKAWiM0kSSjhoZRmBnp+QrCe9CJXAptTzL8Z74p/UpkJu45rVaH0Gx+0yao9
	8KNd7AOjl1VbPRgLF80R/OVGyF7wRS3teimKLHvz
X-Google-Smtp-Source: AGHT+IGF48JsooX8LvUnStKsqx9/OInoNYqYy4bWcDkMAodF96jjJHm5fMiSfC86jPErTi/QwM+ipw==
X-Received: by 2002:a05:6a20:c90c:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-2045b6a96abmr20069432637.8.1745847489177;
        Mon, 28 Apr 2025 06:38:09 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec3116sm7207927a12.31.2025.04.28.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:38:08 -0700 (PDT)
Date: Mon, 28 Apr 2025 09:38:06 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <aA-Evojnzt2z0RdH@yury>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, Apr 25, 2025 at 03:54:38AM -0700, Shradha Gupta wrote:
> Currently, the MANA driver allocates MSI-X vectors statically based on
> MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> up allocating more vectors than it needs. This is because, by this time
> we do not have a HW channel and do not know how many IRQs should be
> allocated.
> 
> To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> after getting the value supported by hardware, dynamically add the
> remaining MSI-X vectors.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v2:
>  * Use string 'MSI-X vectors' instead of 'pci vectors'
>  * make skip-cpu a bool instead of int
>  * rearrange the comment arout skip_cpu variable appropriately
>  * update the capability bit for driver indicating dynamic IRQ allocation
>  * enforced max line length to 80
>  * enforced RCT convention
>  * initialized gic to NULL, for when there is a possibility of gic
>    not being populated correctly
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 323 ++++++++++++++----
>  include/net/mana/gdma.h                       |  11 +-
>  2 files changed, 269 insertions(+), 65 deletions(-)

To me, this patch looks too big, and it doesn't look like it does
exactly one thing.

Can you split it to a few small more reviewable chunks? For example,
I authored irq_setup() helper. If you split its rework and make it
a small preparation patch, I'll be able to add my review tag.

Thanks,
Yury

