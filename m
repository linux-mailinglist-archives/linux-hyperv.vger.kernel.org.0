Return-Path: <linux-hyperv+bounces-10980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPpZGGqcB2ry+wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10980-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:21:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2A8558C3F
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59FB13018408
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F03F5BEA;
	Fri, 15 May 2026 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oi067Wi+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFF3803CD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883563; cv=none; b=Ps1LupuUUmRomNW2BE93IchIQOeYpJeNqR5BUm4fxykLFHHUhw+uybFcUoqDhPo6aGO2YTWRMOtt9gJlDLF4wA/0SaQTHqifivkQV1oCO4b64YMK//EtMNp0FeYHS9NJFtSJVSlpIHTfOXCjXCR79SVyjAm0BUFKK6p8qG5Ha6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883563; c=relaxed/simple;
	bh=8SzpbZgJBvBRL/hzxIjQ/9GeIwvuw2el3nJZdpXd+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEMYbpKLW7YPN51P8zB0hu+8ZC4HGloinT46q7moU9OuNZn68rIVHiQiYFgAVL3Obbs46a/iTKVuOt11r/WAjKA/ZU7OCZWkTqyYXnmX/FwPck8/sJtHeryFeEA82mbQtRIZ1wxzhEXp1oLl2sVmiERAwph5KoLJY71odUuz/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oi067Wi+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50fbd79350dso5374611cf.3
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778883560; x=1779488360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=Oi067Wi+P4Yx6RvbsIpM+7igYMAEy3+eLQdCmDQLjimAaOAccY2Sjla9OJTvYqZFMC
         QIGOPvYnE8V66UXsT8jkxGePlTpcpvUgxfCNxJ+qES+j2eM9z7u0UR9F6uGF3qbG/Vn+
         jPiNT32XjhaZjR7qzaCltoSdK9jnaVhJnlbuSV7MfgeffHHJdlgVAIPkeDE4oBIIFTua
         bNI1d1/TkqhsqbeoO1FrhRyH8eYYpqLn3xshhpXXFxxmkwW83Em/1RDTcwrsVMMBwGHl
         SJNT6uMMb/09pS6NZMOD6WEG+59G15EcD08Vk9oVfPAXdf89Ck71Gk1KvG3G7hafcWSf
         it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883560; x=1779488360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=DAXItUWJVrE6M3Wi6/+ZWBtq7kOTePhD510w18Z15S/rOG+px3TnODG4wVJmYHXb2V
         fMaPDuPkm01JiCoVyqQjhUTOoCVzxubJpXRg0CxxPho+Kx/hZNS3fVDr/Inap8BuKpQf
         WRZCspEwVuYhiYlMyy4St6S5x3CQccDoIn+9gLrVmzuggZs7IoFTzHANAx4JU7KW0fot
         K5lJfz7B+oOecslLyR8Z9nCIBYnmV7zGYyymNPX8ojGJMawonq/lJM8Q4p/vuTr0BAp8
         oSEX/r4GMHb/oZypy0pLcDybAbbUzooghmTLysgVuNyd6i3yuETeS646QHlJPraGqEmk
         nKSg==
X-Forwarded-Encrypted: i=1; AFNElJ8adeYMY1OYbdvDSGA5Kezi+LUQTOPOWKzVW4AHiLYMYcWTdmiETrEcvMkPykdIFoRhdnXyhpOMITQ6zJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGNfMLIsRKQuLLtCfJtyitOgi5U4NkuudEMUtPA8MtQ8Xuq40
	iMF0ByP+LmiFHvZSmO2DDTOwewTgphHDXeLuj0iGhA+4UpN40ea2JiueunNpaHcsR4I=
X-Gm-Gg: Acq92OGNE/OwpK9LymKowDJafOKvKHpZFksORWc7UzejXiWrrmoKT7aIJl90K3keRUq
	pr0af4Jm1hg8hSizAQ6lm4v0G26IJvtavFPSw2dUNr2Z7Gli7vdL1ju1V8FApnTOS6i4+cbogDM
	Bo1cLmnHD0BTaMvgy8nXsL4YMyFeHR4Xn9f+VrCb+dE+60E0YOAcK4NsIMUWJSPVUXMRiPByzpF
	KE9FTmR/gEw8jUT4zOoPwPscvLSwr4AXBXZACkr933h/Bb1aB8+su5Wi1W00e483mgzQa4sKg7/
	OXWjayczTm5QmIHpq9MzwL6ZWbGx1u0DCb0QFfYbKxHINoHSSncG2cl72In+nVyt5P1OUYizB+n
	VNRAVRoo02XD1uyVY1jH4q4RgXcTgL94turVOQWj19W6JkN7zwB+BLpDBg3ijWH9k4JNwtU+Obj
	5g0efbcip+b8DOk3DwO084V3IDCb6EDPn+NCxGQTBQLoQtkTcQ+8mSlsaWiSWaBqj9JcZTcOPwJ
	IuUGSmouE1nDqWx
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr85536381cf.23.1778883559652;
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm58162851cf.18.2026.05.15.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO0sI-00000008D1f-2Swb;
	Fri, 15 May 2026 19:19:18 -0300
Date: Fri, 15 May 2026 19:19:18 -0300
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
Message-ID: <20260515221918.GJ7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
X-Rspamd-Queue-Id: CA2A8558C3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10980-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> The Hyper-V IOMMU driver currently only supports IRQ remapping.
> As it will be adding DMA remapping support, prepare a directory
> to contain all the different feature files.

Any possibility we could put the irq remapping thing under the irq
directory?

The other drivers have it here because they are co-mingled with their
iommu HW, will hyperv have the same issue?

Jason

