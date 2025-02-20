Return-Path: <linux-hyperv+bounces-3980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AEA3DDF4
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C559419C43EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2821D6188;
	Thu, 20 Feb 2025 15:10:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C21D5CFB;
	Thu, 20 Feb 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064202; cv=none; b=OeP1JBdwkVxR+UNpLXL/4sCCciMMDwx6AFEpaovYOlIuOXrUsywicrxgdp8s1p0MhqF3tOtAT9mZK01EDVzUNWzuTTq3NyncAglX127520811zwuvHiMuhSZt/I0E6IybMoquBBICSloHVXuIVsH+dy8+0XdiChKgnqHFre0BDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064202; c=relaxed/simple;
	bh=PQ9TqHjXPaKCOqp9eGBWmX6NMKQFiTQRXd3oz+R7xuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ0juqD7/GvvBcOfnzlvlsM7idbELMVewZBN0nqJR4lF9vopJBSb7UneMFzGzWDh31dqsyPK1yaHciJBzqeheods1s7ycd5h0GZa6U+BpdsONqBfNnCQEK5p+ur58R6bf4fGq/zLeiSqZG7EQ6ezrrGBCk1KjNQoLeJfBdSRPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221057b6ac4so19398905ad.2;
        Thu, 20 Feb 2025 07:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064200; x=1740669000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpVZCzAXEsFLdSd6AYC5NkhKgANf/LjtJUQLY81yGwY=;
        b=VQKvlVibxHTtXGufx3weVILCnNg1TCl4Qi5CrNu2+W1rR+RdpX5ajpPg/g+4DsPNKg
         Jl5GshZr2/I+x85OJbZygi71R0mIqSK7NAccEJbArlFV5NPt5gM+5d37qz+ITvSI/oyK
         WaQIgGaBtxS30u03SMM2J20kk9Qr2uVBKzivqP12B0swiPQRDQ4PJgk5+eO4UHfPDfS5
         cnRcDRaEJ/gIB9bDiNBj6WNuW2wvvI6eHVFg1nKO+V6sNPAdZgsPLgvJhA1bz95r9u2u
         Lv60kzaoU6w4xgpagrE1RifJJJHZyUfHF0eJHP3r87dnAlgGdjDvqLwnGHLkE0GbqLad
         hT7A==
X-Forwarded-Encrypted: i=1; AJvYcCUV57kROLxWYdbDXWPPdr1IeButnOvYRtOKy9zg4/MJWDjKRo5MmMFU2fOpht8iRvL/0RykXPCuLM3Jzn7q@vger.kernel.org, AJvYcCVM9rOk0IYNkBCdLWNp7FHkQd8V6BYU+XkgJ0NkohnqaNKga/KmkaHdEfbt1IrSkW04is5J/zAJjyjd@vger.kernel.org, AJvYcCX99k5ndlkRDGbSErp6RYHw3ECmiGYxDB5uavqfVL4rW1sgAL64V/sujQFsF11aCwGVPXlSLvwh9j///34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCChT9iv1Xl9GJjOsY/BwkQ5QkQmDtku3I649oL2JdaDRLsVjR
	0vBFEUB1mMunhfbrtnQEgXNMnL2ZkBZjYFeJ8Klv7/kuiOs3C72u
X-Gm-Gg: ASbGncv7MsRSyzNQlUxWByIs4Eg6sOvwn57tt3LSJ5WY5KtOrFKlida+ilrURT/Prt/
	8Y3m1YwNqFAJ0hMumJq4JVmr7MGdfVPhC5oHAWNgamMqi0s93X2NKXiSharlJjl1LSJ73byixBK
	08ilIufhKM/NYSmm/HUFZ3e8dd8lUe1gGGyuSYZE64VKzgBY38abgmIH4ZbWgg2aPhUE/9tRKDH
	pnHDZ13/pmKbYcmHFty2uyA/9WzES6Vy2C7KVG/AV+6NiJNndQowjmjGe/hFVtrpcMnAdgjsiT1
	SRfKCIraPQHFvv28byBEGUvhf2RJiJ7Zo68K5p5Z/v74LmoyFw==
X-Google-Smtp-Source: AGHT+IFS0DcQBikerTWWmL+rghCj2fPTlb1aiY8LCt2DdSKLv2v7xr031giMn7394UTBcKAh2mrG/g==
X-Received: by 2002:a17:902:e5d0:b0:220:d601:a6dc with SMTP id d9443c01a7336-2210405ccbamr364431485ad.22.1740064200251;
        Thu, 20 Feb 2025 07:10:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545cf8fsm122041715ad.152.2025.02.20.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:09:59 -0800 (PST)
Date: Fri, 21 Feb 2025 00:09:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <20250220150957.GE1777078@rocinante>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
 <Z6wGdTXExwcTh051@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6wGdTXExwcTh051@liuwe-devbox-debian-v2>

Hello,

> > The VF driver controls an endpoint attached to the pci-hyperv
> > controller. An invalidation sent by the PF driver in the host would be
> > delivered *to* the endpoint driver by the controller driver.
> > 
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> Applied. Thanks.

Would you mind if I take this via the PCI tree?

Thank you!

	Krzysztof

