Return-Path: <linux-hyperv+bounces-11065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEVgG6r1DWry4wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11065-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:55:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C456594EF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB0D3109B3F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10413E3C62;
	Wed, 20 May 2026 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g5q08TTM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75923D88FC
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298171; cv=none; b=qgiCUeV+5dUyHhiwUREydRi07xVsq+rd/bSPJzgtxtsUE0HlKHlH0ZEVUPnaYC458J/tT/2PZhLt+Gt9l0EJq5V+rn4vCeum16BwXuOCtvRN10RTV7fMSRjPOljt2fPzieZhvMt1oy32F4i9S3II3aPgfDsgvR+kA+X64CGMqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298171; c=relaxed/simple;
	bh=swndveOwFBrQHenLNsbHaeYRdxFM/mHCS9gLfA23gKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmYprQaERplGrqXU+o51RNlPYQTtmLD5BkqPygrpPBz2BAiMV5siX1pQbwvYMfFxVSa5SALZPPyrJ2ay52UEoOYeHD3PL5NzQmX98KFI7ruxw6iEG+Onigdi+75ptcwsmD8pd5j9F7X4HQPMiw4Ac6shcSj+dRWIDjV4SkXlfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g5q08TTM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90fa736d46fso325925285a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779298169; x=1779902969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=g5q08TTMelkn0L0SxZb3+ATrnYT+H17KcUvpo6YT57GhpzTX63o12oJoplsGIXqDMF
         GO76FfzfnDxsdTrA9IqQw3FzgxAp+liRKxpWnAO6W5WAES6sjX1HLkGHHSyBzey8Egxj
         Kodo0NDVqR/KyaH5hzfiuJe+STzNS1+SjePZUOQxziLgCnw9KN07v7c57mZBskZeM0Vs
         XCAg4qW6g/lVX9CuvlZ4Xlu/HIiEBvUumlD8G8fwEV7HvcBOflk4eLTYihZH8Rh0Jyji
         AYvXldlm17JaoZECuUabPJZ7jLeWHL8I8l+54KjnTY7vZTPjp/mF7mD7/21pkdjl2end
         nXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298169; x=1779902969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=Ap6npzgkbD34EITFPhn8Y+7PSduixRtjICvOmnLFfb+feb3JB4xTx1GObLqoen7ncD
         EBbq61UjMhNJpGhGTDc0LZHOQPbRckNbr1PcTwEYZnk7l2x+MyzbWx/qPyZrr2Tg3WFi
         /fmEKsrqJoTzh34fIzNgvC4/sXxciex0wm7QXW+LZefAf8N6biB8k4d0yHck0fhC8ycj
         frUqJegZKwXv4NCXBLZmPb+NetqnslXbUb8Lgw4HhByyhNkg84WckwwKswT2xxKMO8S3
         0m0RMh38VlBFsYkB7K+M5g6fADVU5v4783yZJWGVpyBHk93Kxc/dh7DA/bztduDqeRxH
         ASWw==
X-Forwarded-Encrypted: i=1; AFNElJ+5b4pb7DKWHLnnUsLs2hX7yyOAJnecm7wToogf2Xj3ic0rWDUrgBfBo2bORiR3RSTK3fBEugDPqR7qx9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4+S+VuQXcWK7LdKHhTKhD17vN+gZgbqa/reoc2/KddqXdpJ4
	+Fji05F4PZR0QNWfC0g5lw3YJ+buOD/A2KjKKdYPUfNzPhd9lVYG6aCGWyOF9haSliQ=
X-Gm-Gg: Acq92OGVFJTnyOBlGln16yfVb703iw+Li137JfisorcRq+9Qe3LS+6rFqYwBQJrECCR
	0zcGKgFe4iFI8mKaEj9KkmhvZacgqGy+Pq9x9SMGwf45dffXbcMoLDyb3goe6TrTRBdAJAcjM1J
	iCxVHXHWyfGC/2/AqoMsC/e4/VsGzbKNTJLirnLBqVrhHPBow6VDcBktU6NnukiP+60RAdKktq2
	82Vfi6dh3NU47WK0dHIhpiVa2JttqKzvaTjBIVxizthpXV7fasTipCXR4bhB0DJ2QBNmOIxjnGg
	At4ImHv96B0ayV9sN3MILCYPceHcBRZKXtAtNmDcEkCoWy0cpvRNf8QPTymB7RsBEblJt+CAOKs
	JakeKJj+m/PxahR3rNRhgtYJRWQWS694zZz+ZuQmv+vdSmbC6V350ImQYVtOugRk8aDxEFkMVkB
	LqHUd3M/ajo9XDF+64j5ULJ2/pY/7CKD99x40EQHylCpR7xepw+lWL0SgwnZHtaX8AN7Gsi/voW
	iuvkQ==
X-Received: by 2002:a05:620a:4112:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-911d087bedfmr3730351885a.53.1779298168893;
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm2298183085a.36.2026.05.20.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPkjX-0000000HXSw-2zB0;
	Wed, 20 May 2026 14:29:27 -0300
Date: Wed, 20 May 2026 14:29:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, arnd@arndb.de, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260520172927.GY7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-11065-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 0C456594EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:15:24AM +0800, Yu Zhang wrote:

> 2) Follow what Intel/AMD drivers do: find a single minimal
>    2^N-aligned block that covers the entire range, but may
>    over-flush.

If it is plugged straight into a HW invalidation I would do this..

Jason

