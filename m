Return-Path: <linux-hyperv+bounces-11025-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDB2C7NeDGoVggUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11025-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 14:59:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BA57F2F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 14:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03FC3081863
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E84DD6ED;
	Tue, 19 May 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AZFapDe6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA74DB559
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195129; cv=none; b=Cyq5Ue7IwyHz46ZE4mVu+HP7byWXK7Pq18UcjD0CI+5on5CljIvkM9lLsVIN+bEiIAOYKIUk3Te0MnCM53zrSOXQHjDVfQMmhZs5bAIacL13yjXhBJ6YPRo0Rsir7fpecrdJqeQnJW2t5jBj5wna7oxLrcIX+D6adG0AbWrKF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195129; c=relaxed/simple;
	bh=Cj+9AGLaj6N5gNCq9PN/+geG3jfXVteqrgLjuRvx6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKJa3/IGpVaaRqL6MQa2SKlsyCIJ7jl0yxHV8t75/5CP8bTdZJVtEL+48pVbZOJZb4FA1TKL5RjZ8j+jz1wLNFheFQtXTFhk8+IULsN7QvL8LElA29Z05Lfa7bbToS39rCT8ZsLw4rRNjBeLFhgOF38MwERuUMAdQuIMXi/n/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AZFapDe6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90cbb2b50ccso276115785a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779195127; x=1779799927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=AZFapDe63IIqwh5Nq8h1Q8jil2q6xV2puAm2XBSaUlSkNNWR6bel4Kx+kamGhm8+sF
         s38iylU78T4pqAaPvJzWOX+5u651wZaVODwSm30e1pTsPf+n/YKHJDSkz3+ni31FydH4
         N5v9b0EHDdC7PXxCeFQ4Kr4nkl+gPYC1/e3CqWIyA8dm9nYzdR5mCOLFz5+ZpYykr3fN
         /ApvtaDGVtMPigrD1TxE8J5rmOjkHcqkLh8XlpSRocsxAzYsityhmRjlo/A6RBPLgD+T
         ob54Brye3ZmQskyoZ9wQsadzEI03a51+crhkkiBcv3ZbZ21X/lETo0TTshfGsChAJ8Sv
         3VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195127; x=1779799927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=phxRYbfFlRLWCU81q5Cvcad5NHazoWdWJP8ZYrqwDiuldEuJphXSioVfV9q+dWEPeJ
         1Mqvduap1QUbL6+KJ0YxJaLunsgEAB+ZSb5cspfJjTCn3qSExSoWyXZTo3vgnMOou9SZ
         7UdZS9W+vh/ENm7uzZYqJoPHjs+zTSwCfJRrqqotGcVfk6DJjb+Wxe7dEHGab++QxFRl
         4n7ftWAJB81pE7hVuIBFqKpGnQ/cEwQ/h0AITVCbk7FbDNlxKHqgvXBR5QIfduQisCx9
         0SprLm/DmS4R33DLDp6qC1/dwuqDSilQ4eRkM8FVuK1a+LCopD6EnyD0CtJbaTSBnsim
         TFDA==
X-Forwarded-Encrypted: i=1; AFNElJ8o97b08OKP8Jm0E4nd2NwSuOKotlo0lTGdagvQyJij83M1gR1iTI172Xuw67zHgC0tqRPTdmAJq2H2bMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gHhN3Xj3j8zi3xBp7O/bTU8yK/KFoiCUS1Fn6jQFKXXZo7Rt
	H4oQyectbirvu28zFfm2QcWx1Nig8JqPkz8AsRZIWP5IlNRnc06RkjvkgfjwQzU2lec=
X-Gm-Gg: Acq92OHmxkAlT7XgI4NudtVQ+60p+Ac9AToE9vQjJbqgXF0ZXSoT6Vl76TPhbHoIKc9
	3SBaKyDi2dByZ77IQiKiyEUQgtd3x91pqab3yOaXlN5GJW8LpH3PKN5vZtdQdFTtOH4NWk7+IG0
	/hT9BP4Zh1veKZJm5EDBN5RfQwnTbRwwdibES48DOdHLEHxJSzlfE+auyVWeCM3Foow9Ne0n2Qq
	zAvBA6gbdh7KkShPKdB7nCSYwvvLtmYQgYP6sc/NyamfD2hmOTnFHl5yytSMI0se0q0bDeDL7kQ
	kqUTsd3NlbF6op3Mr8S0P100h7l4Pg4Pp7SghnMy8XyadnFe1MKLE49d9I8F3Fi/F3wCNM/IJ6Q
	BUdJFF8NoVKJGb7WP4efDRbCt7a/Cxl8WBGFifUxM3t2HV6HT7aGB+zMb4y1fSJMBDiaZ5YGhuM
	gUMIjiBr9ZF06TEscsGcmfRtgnWL0LU93+mE/cemJmXf/6gLL19gZQfGD95X4e3lqLLc0S+O/QZ
	vM9qw==
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id af79cd13be357-911cd1752admr2935359485a.18.1779195127354;
        Tue, 19 May 2026 05:52:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm1823801385a.20.2026.05.19.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:52:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPJva-0000000Eg2n-14zp;
	Tue, 19 May 2026 09:52:06 -0300
Date: Tue, 19 May 2026 09:52:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260519125206.GY7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
 <20260515182322.GI7702@ziepe.ca>
 <20260518224136.0000403e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518224136.0000403e@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11025-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: A70BA57F2F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:41:36PM -0700, Jacob Pan wrote:

> Just wondering what work is needed to support this "direct attach"? I
> felt this issue is due to trying to cram two distinct domain types
> (paging domain & direct attach) into the VFIO container model where
> only unmanaged paging domain is supported.

Xen has the same issue and you two need to come up with a uniform
solution.

VFIO container can't support it, that's out.

You should be focusing on a iommufd flow that accepts some FD
representing the VM (ie KVM FD) that can be converted by the driver
into a HWPT representing that FD's S2 translation.

> I am thinking if we were to switch to iommufd and let user(vmm) have
> direct control of HWPT, vmm will be able to selectively use a
> different domain type to handle direct attach. 

Yes

> IMHO, it is essentially the same as attaching nest parent domain
> without nested domain immediately attached. The unprivileged guest
> may attach nested domain directly with Hyper-V if nested translation
> is needed.

nest parent domain is really for supporting the viommu objects.. If
you don't have that flow you don't need to worry about that nest
parent stuff.

> From this driver POV, it will allocate a 2nd stage only domain with
> different domain ops (w/o map/unmap) for "direct attach" thus avoid this
> hack.

Yes, from a driver POV you need a unique iommu_domain allocator that
returns an iommu_domain without an ops.

It should probably work similarly to the viommu where the iommufd path
can send in a driver-specific tagged struct that can describe these
special domains.

But be mindful of the lifetime rules, whatever ID is used to describe
the VM at the hypercall boundary has to be bound into a linux FD and
become immutable. The driver has to hold that FD as long as the domain
exists.

Jason

