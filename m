Return-Path: <linux-hyperv+bounces-2524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2584925517
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6328D289888
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E3139CE2;
	Wed,  3 Jul 2024 08:12:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816113958F;
	Wed,  3 Jul 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994372; cv=none; b=tcMmSqu7njhOJgwFfOVhw9oYP6D/LfCO9O88QLnyRKLqqMkjzoQV4TrXgJn+/RKG+e1GRLG6eggFUE20ocbLlzVBefOVBxbszROC/XSzwv6FUp4ZSw+Rp8qFI7OdCY43m0VxOI8/0GlDDuM2PLZPMQfe87+imDEwcxIstWhYD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994372; c=relaxed/simple;
	bh=LjWBjkhymTXWG8jxDyvh/R+x8HIRkjnR2bAAke34eac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0cpQojOvx/imspHz3CiH1oyZtG0uY7KjQxxsjhvE2Cb/za6YLeDh316tBDM91MNSnVNR2Q0XDQzQXPkg1uawUc59M1Zv8HzDPa4UNe2CJ2OtzYv0F39OCp4MHt2HEeCKKTA+wyb+Svr+BC30aCQlxCrBAi0HcJfUTlUOOiufNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-700ca6171f1so2066264a34.2;
        Wed, 03 Jul 2024 01:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719994370; x=1720599170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVJ3f5u3PrYS4IREw/pHWtVoSGKwETgJ1yT2FSPRVvk=;
        b=E2wZVwRZGox0nV9+hEvHQEYm8D16HTGUIv4hnPhpwxobY3VXHE+YAD5w2Ob2m3qVxv
         3MOOQX5faMUzAWzgKE3fhKrwoI4JCrO2+QZLiVb1+PfKZrE5m4Xh3M9zOuMtBFHcMk5+
         M5zn1gmayb/U/zrmzF+Z4jA6uNISjT8o17ljNe48urQntc836hCqWVO2Mdp+IivYjmzD
         ATo7JcqAWkPkN3VsftFWE7iV/geui7DA9v/ToJYFE2mBRSxHqUzeaR4dodXMdU3MJ6j3
         tGw1l+jogNBnjsTf+6cCjJ7g0tiEr5Xm777U4UcWjjGEYv7vtx4rrVtjKF+DkBGdBW57
         PU0w==
X-Forwarded-Encrypted: i=1; AJvYcCVLaZgLbjMuHENkj3fD0+Yh3QvQm/ZuxHMpYG6LAe/tbR84Y70GW2RHhjMdUdv9WM7710alaf3cFTzRVEh3cF+pQrJPYYIbTfl0hW85iS5e0Q4wtqvajPn/9d6Tmn3wwT/C/S/uZOq+
X-Gm-Message-State: AOJu0YzQ1wtqFqgxOxGYeEgZXHeYjSTLKsz2MGgLsGM0ZbVTzMpTefAH
	ZyOtrwl0Blay0hm6rN63ZdO3jcW+6DW9OOAYkgkwX0lXg6G6VvYv
X-Google-Smtp-Source: AGHT+IFvEXcX9FDu/Fs4ZoYWlE5ZeWAdLG4L7RvTDHdKLdI4+8XVWQbX1dxRkS2ktpUznH3ppPvQog==
X-Received: by 2002:a05:6830:13d3:b0:701:a795:11c6 with SMTP id 46e09a7af769-702076e8beamr11817907a34.20.1719994369450;
        Wed, 03 Jul 2024 01:12:49 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm9779571b3a.207.2024.07.03.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:12:48 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:12:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, stable@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Return zero, not garbage, when reading
 PCI_INTERRUPT_PIN
Message-ID: <20240703081247.GA4117643@rocinante>
References: <20240701202606.129606-1-wei.liu@kernel.org>
 <ZoTZTvL-SKxZEmu5@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoTZTvL-SKxZEmu5@liuwe-devbox-debian-v2>

Hello,

> > The intent of the code snippet is to always return 0 for both
> > PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> > 
> > The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> > 
> > This is discovered by this call in VFIO:
> > 
> >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > 
> > The old code does not set *val to 0 because it misses the check for
> > PCI_INTERRUPT_PIN. Garbage is returned in that case.
[...]
> 
> Bjorn & other PCI maintainers, do you want to pick this up via your
> tree?
> 
> I can pick this up via the hyperv tree if you prefer.

We will pick this up.  No worries.

	Krzysztof

