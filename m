Return-Path: <linux-hyperv+bounces-7377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178EBC1D41D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F89E1886B3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E235A921;
	Wed, 29 Oct 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NdZ6LFnT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CD233722
	for <linux-hyperv@vger.kernel.org>; Wed, 29 Oct 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770656; cv=none; b=F8UUJKx0R69j0kIvn0XCag50Bldv0IsiiPDCxny90x406L026LEkvCOD5ymWxzg2HVCX9yBqlVjlqcPeBENE6CFDa4iZtpf4Rt8HMQ8IyjNWAF6kQXFlkgUrQBS7gt16MSs2eH8yTSj51M7pwYnboINpqLr2d9CyVh598P4GZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770656; c=relaxed/simple;
	bh=PpaAnelvP90qNut+ZwW7vK2RK0H4rH7vlQYQGs2uXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqJhnoBu9c3mxMs9mrXgu19Cw1Vaae66AiA0PbcmsbLxFZaVEMqfPtde5DUs5lkgO2iTHmjPZMOMjqWX1YGoSQbBveOdMNvAwU83X6AnrnDvDTBPEHbWhQDzauXYwIRLngFZVW77JqOZ8ZDMC4WiIGj1O7Fv6EdbRMRpVKrIGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NdZ6LFnT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89ead335959so24803485a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Oct 2025 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761770653; x=1762375453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXmwII94RIU4hvYvWVxvISL3Cf6KBQEXeyuNCmaeDUA=;
        b=NdZ6LFnTI6zrhukv2ioDeAyjWqg6+j1Uuru17kHskflsn1LWBlkItFGc7c7FM3RljP
         yNnibcKgqCu4WjAaGG6c4isZ79B+uilkmI9YEZJa5qx+ybSZK9nMRJzxRxRCeRNIhWuA
         fTXGFnp5F91EUwy76Gnlay+5vEK4F2az4C8WttulzlsB+VDrq0c2hnsoL6VsfwMR+Y+p
         PhVmLtEGWeulzW9Db67U4hK+aj3aJ1qGkROJRfSu1jJQJU4aqAgfMG41/l8kdySPdb4L
         QZM08T8laY4cKBaz+Szz9g5zNkE5YbReJwaZ1Ni1yy/UtV3JwhBwR2m6yfNwWiNQ3pJp
         LU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770653; x=1762375453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXmwII94RIU4hvYvWVxvISL3Cf6KBQEXeyuNCmaeDUA=;
        b=wcg1m8sKDaEw8sHirFesnTcL3p0JMM3C/2OJRgEv+1FgxoQuEpRBA19nP5OYvAu8EA
         /4/n/kCwY9F+rfS62mOg8EeYR4p1KX0B6UgAfr35LFQpm2fmSlHhTGv6f0ZniBXRDu0e
         xwV1v7iMATtUYIJV85/p4e/WbPxH7pTsakMrb8GMWycsTZMNSByf2MmW5485wUB1rWIg
         IFdWwWvF6sSMw+SkLtsnTx4X9j932eSowsLLRXwB0R8Uc32CNqlkU9PfRnr8isExkfot
         bKzYZgromH0jE5c8+WMqoeQY9WTJquTeDe1DBxiZXrBHF+xY5dBU6J/gZF0qr9KvNC40
         Yw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmvZQQsVgpO9CZjN9pjmooF5F7mrz+fPrcUr/VlnmRylxBt8v0Mlp1suOqyYiltQPEcMmzFfM5WOjz4QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlt6+8Yl6tBctkRH/PCWUpi5teq+2xupvggbJOn0arEwpVS5lw
	vIuKWRi4WJx/c3eF+LxiE/IRtYMxwD/hpSa5rF0cxxfZLcG0TXDtt3xsjlR3Yjtt1sw=
X-Gm-Gg: ASbGnctdqqcmu1XNJdd/9Orb1E+Cq0lUt6kfR/SObA1u1BQm+2dkxOMHmbh6jljT8WJ
	6gh6l4MJIn75sbfMTzLaoehs66yY1Ig39AlXHEBIxmuhzK0ZzbGd2HXXHizQ7y8aAAPQnXC1Nkl
	Cm5vTrgLq65whw5cXW5DiK0La0uLFr25dSjrPkwmGuNOyVH66vTan71CfGUKd92IsX+RXdZr0Np
	2S6KJCZnoqeuuq3t+dTvZDLZqL/fQFCAsXD7/1uTAysFQwkLmBS2xyqvYk2wrlDY9ZBSOyzSq6A
	ZbTR1oEf8fasRDdh06DGr19ZIjwPnYWJ6V6UH6r7eytbCllsy+YWk6raas0ezSkIqf8QHM92gGv
	Y/svlkJH33CFd0R36h2yA0xiZx6nPKPbaUGMC3uDXTgsQjmuVO7ye9bwXymLUoo4CTezT0PlFhg
	ZOGUYXJ+We2zSRcVQFpQDbSFpUh7DE5o2SIH4k76qhu4CAXA==
X-Google-Smtp-Source: AGHT+IGATc8r8DQBwuLiAP3r8TNXYtoAaZC4C/pNuGjsCGGzvT3LRAi9w0bLz5mbYMTI7xxUZ0KOWQ==
X-Received: by 2002:a05:620a:4496:b0:892:9838:b17a with SMTP id af79cd13be357-8a8e407c6d6mr467678485a.3.1761770653172;
        Wed, 29 Oct 2025 13:44:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24ecbc11sm1141931785a.24.2025.10.29.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:44:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vED1g-000000053O5-0MFV;
	Wed, 29 Oct 2025 17:44:12 -0300
Date: Wed, 29 Oct 2025 17:44:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: alex.williamson@redhat.com, joe@perches.com, kvm@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [RFC] Making vma_to_pfn() public (due to vm_pgoff change)
Message-ID: <20251029204412.GU760669@ziepe.ca>
References: <a9b8a3ee-b35b-5c45-5042-2466607abcd0@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b8a3ee-b35b-5c45-5042-2466607abcd0@linux.microsoft.com>

On Mon, Oct 27, 2025 at 02:21:56PM -0700, Mukesh R wrote:
> Hi Alex,
> 
> This regards vfio passthru support on hyperv running linux as dom0 aka
> root. At a high level, cloud hypervisor uses vfio for set up as usual,
> then maps the mmio ranges via the hyperv linux driver ioctls.
> 
> Over a year ago, when working on this I had used vm_pgoff to get the pfn
> for the mmio, that was 5.15 and early 6.x kernels. Now that I am porting
> to 6.18 for upstreaming, I noticed:
> 
> commit aac6db75a9fc
> Author: Alex Williamson <alex.williamson@redhat.com>
>     vfio/pci: Use unmap_mapping_range()
> 
> changed the behavior and vm_pgoff is no longer holding the pfn. In light
> of that, I wondered if the following minor change, making vma_to_pfn() 
> public (after renaming it), would be acceptable to you.

No way, no driver should be looking into VMAs like this - it is
already a known security problem.

Is this "hyperv linux driver ioctls" upstream?

You should probably be looking to use the coming DMABUF stuff instead.

Jason

