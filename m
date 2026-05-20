Return-Path: <linux-hyperv+bounces-11052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGPYN4m6DWpT2wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11052-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:43:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6092458EFCE
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7222E301BED3
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF52E2F1F;
	Wed, 20 May 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cBzOeB90"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB712D7DC4
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284291; cv=none; b=XcEkFonZP+lyE9x13u7FJD301VWknlxAou7C4k2ldrYfoYmDC+yAbzXG8P2dAkpmfSiraRQjvSEIZ1l54hcDK1PPcM0a41f1SBuZIvQ0P8ekiWvto+d1tc6cJCJrgovgfCP7nmr9W4yj0zEV+uSVdUH0Lckns4gWN9ZOfS3HZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284291; c=relaxed/simple;
	bh=FcTKYryF3HlZcFivdjcw94sl1hUA9PtC2/zgtt2ZZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY6CKOuDe5vaMBdJV3VAI71X51J5fLWzfwBUI+qNKMUVS8iglzHMsVVVESm83ES6PbM0BVwIZXVuDArGZMCQ7o0D+nT5wTcLyjxU5dgIGkVbbWmcGHDNI6Dg8akrJ6i+r8xxV/adBJFWHgSSe8BbmuX3k3sWvyQLqHazAdfdDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cBzOeB90; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90ea08cc5ceso824228285a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284289; x=1779889089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=cBzOeB90De6JH9YZRFW4WdvPomMlPt+GLQnVKxGLpjoAW9+MZqNKeid4oFTWgQ11k5
         9vt4MvanJfFqfc0J7YsM82g3CPSDDBbEnEX/6L4fV2XTMUc/puxSVOI3bzTcEtcMcmqH
         v1/iG/yQlqyVlfl1XeHsKgPDYOHSvnqy+xHQQoMXiwf5ZX+i2IIcD65QmN+GCDdUKQV3
         fjhyMGr6UFZTz/iqinGH2Jn/MnFb3n6FkD6lL7MOfEwck6DTMJs8OY/kL4L8PQmd4spr
         Vs22mr5Ruv2OSsSaw5v+x+zjF/dQdPNixEh1rHLzVwhHyHwWg9uaI+epPBP23XLfwJiE
         z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284289; x=1779889089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=dyFH4ufZ9E/mYaGO9X+5mDCFXgaO80XYKLrWSKMqZiyB5KOKGJ1Ta4QA4UKBDaWCNt
         aD0gjx3a2WHkcwozO5jdQ6sCv2GWjEc0iPkt4C2l+cPzOFCubTR9S5lx5LKXkzLt21Eb
         AlXriPMhC/HKWIzL/q+udy2Mfg0Mw1oren9d1HE5G5qqKXG+QHkpvTD6iMdeDQ2iOkr4
         uOQJqWaEe8v/B+oMnSXrf+q65cpZ2aJLhjYdH34coveQW0Fd40m5nhtzfbYXEHqUunnf
         SWSIRnFdozt1RlFSw+MDWVOwjNant+Ax2hMjPdhIK0Xkf3uVnkzUYkBgfZ+OyFa8Salp
         tpKA==
X-Forwarded-Encrypted: i=1; AFNElJ8eDG2BlhiR+JuEDc1Lvs8wDWKmz7n7edXoiKtXBAAMVMYqFAZFuCxcNIm3pj/qvjjNI5DRszTR/THqna0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUehFFF7Xl9YP/cd5ViqsrsE2N6T/MsgoaUJwsKhy4+ZQHgVB
	Eyq6kAdATJolvz1JvWruXZfxI/LJ3FDG895OWGa6PPaPNqVnu1pQ8hFPze/5wyxrZ/A=
X-Gm-Gg: Acq92OEqMY5aUtRPj4jsHFHFlNLZCry3XVbVRCtXKBmC6NLhMfKo2VcMy1nK2c+O3Pv
	xxgGwKCUOkMVAeoOChFsYF9XS6SbGONwvHAaCnBEJ/bK2Y6gAwZaixbWlAGXPR7tyat8VaQcR9R
	KAcDThSTW+qFKlj+CfgfcqLWLrUSnIcYa9t9h3swISh7Tze5QcRGfXyO/NLEf0FURF7FjRXLFtH
	iN0NMSp1XNcq+uzFhwZTLotRqRyBVYxtVRwLVUKNuVAffXcpiNw6uk4LVZeVCEqMq+KQ6C8QZg9
	4Lb+W89kpIxL8+J0kJ2NZTlOjApjRoG6s8Zdclc+8JlB6oCFv/shdhzriKIglsk1oyLJ93+4pqu
	PPIeSeVGujRh8G8TL8A2EXJBD1cIZby7CwwyUllrVUbz9AC7ZpJbxUl4WtveUC9UJ5wR89MHOCM
	cMAjdHwa8Twg6MfWYU8c+PrHcXAmUFuxR6H9RQ9gKsGibGPNKpCwCfPrf7JJhoinGslISv0nv8G
	6iXTMBtTokdp/Vv
X-Received: by 2002:a05:620a:2950:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-911ce524059mr3564626085a.24.1779284288689;
        Wed, 20 May 2026 06:38:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm2144919485a.26.2026.05.20.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPh7f-0000000HAxk-0y0i;
	Wed, 20 May 2026 10:38:07 -0300
Date: Wed, 20 May 2026 10:38:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <20260520133807.GS7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
 <20260515221918.GJ7702@ziepe.ca>
 <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-11052-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6092458EFCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:37:03PM +0800, Yu Zhang wrote:
> On Fri, May 15, 2026 at 07:19:18PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> > > From: Easwar Hariharan <eahariha@linux.microsoft.com>
> > > 
> > > The Hyper-V IOMMU driver currently only supports IRQ remapping.
> > > As it will be adding DMA remapping support, prepare a directory
> > > to contain all the different feature files.
> > 
> > Any possibility we could put the irq remapping thing under the irq
> > directory?
> > 
> > The other drivers have it here because they are co-mingled with their
> > iommu HW, will hyperv have the same issue?
> > 
> 
> Good question. I don't think Hyper-V have the same co-mingling issue.
> 
> But from a code organization perspective, I think drivers/iommu/hyperv/
> is still the most natural place:
> 
> - The IRQ remapping framework itself (drivers/iommu/irq_remapping.c
>   and its internal header irq_remapping.h) lives under drivers/iommu/,
>   and all three backends (intel/, amd/, hyperv/) sit there today.
>   hyperv/irq_remapping.c includes that internal header directly.

IMHO it is a fair question if that even belongs under iommu.

I think it was dumped into here because of the co-mingled drivers..

Jason

