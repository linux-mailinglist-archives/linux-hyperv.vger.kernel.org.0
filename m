Return-Path: <linux-hyperv+bounces-10922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOYxG6tmB2ps1wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10922-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:32:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19306556446
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B96303769D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308030C16B;
	Fri, 15 May 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k9ar4Jio"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EB30C168
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869406; cv=none; b=glhIYoPDFGZGGT5aSC0duFzp/vD7VaM7kEdgAP21EnLQMmpAd1ZB/bprkvwgYZUD6KSXoXM4nUrKmS4/TnQc2Yy8gs6LGxDGAYUuouC/MEK3Ypve5H/bh+Hz5zgKgLchcE2GU7SARVH8otZJVNEkDhZo7nsHZ7bM6N5zypi0VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869406; c=relaxed/simple;
	bh=gMaEvicj1lkTTKjknQzylRPd7tw3CbzIlWyBBZkqlhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLvhb847Z7VWF22ZA8KBDo8/mWiP0gfJvxDEdfCqdsitXMDurLNtGcceslgAjlSGbC1FCNyU+/DNlDoFbpAToJU//HRWcu/NWguhXAOdW97Si/zeWzCxqlp2tvp3VK09ukwNWoDRDsSaFNh6fY2VvZpi3gs5R82b4RDfg3VbAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k9ar4Jio; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5148cbdea08so1579651cf.2
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778869403; x=1779474203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=k9ar4JioCr7PMwm3IFL/V1gS4qbnNYXjESygqFknkEVOcMtvBp/ZLENxK/R++emVRS
         Ezlr+J3zGCYZXg50ek9wta6Z6s/ldjH3ggZVY7lqfdXIrjCmccOJgblHHMKaVLVgVgCO
         +pX6bFf2RIXeTU5g51Ph/PYUyTKt3Uq24hiX0kSTM2eZ6lwCTTv/GpRe+iJgEqNXqEhc
         QPdVrO0M5CW162/CFbdXxDuzMAekPO2u6Yy1n27LXZLRm7NQxIRv8sfhQCmsg/xlRmW2
         r05yl1IH8n17wu+9EyyqOEzId4pnPcvi9IXVSzivi9ikr+mLdfhVYupevfbB1XoGYyH6
         Rzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869403; x=1779474203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNJjeOCe7S+U51t5FVhB76I4sx7yhCYVtg8gepAxec=;
        b=R1c0nVJUC6It7aGH9spU9bA5EeJZecNA/MzMjRg5THq2EIwTJLJtLHEUZoJFR2z7XI
         cbHT5x3dLTalFDq8w11J1C+QVQmE5YUakGDx065lwaZ+Pg0XhTHmDyYayM85nNzI5pHY
         Qm4QWzA8fi+kv+Grq5nilJngfD58QQImMIqzG11DUwujmU33KV5KdflKWhILWXZYOKLb
         Be1kYicULVV2lghec+AwxUsDkfE0cK/TR6Yp2mpB2gz/Q+tPHpxLBZPpp/0ca+fIWfU6
         uLLEHOIeofR8EP9VugayZFPYrJCqVvkUrS3mUiRTEy7UkjTZ3gdALXhHkoIAVdfyccAz
         3/Sg==
X-Forwarded-Encrypted: i=1; AFNElJ92j9Y5g0RZ7dHu7lX4HGsdcB4ZoeSdY8bbW6k5Mp79WHQIEyD93ziftTFN+tXTWovpS+QiaOG8M8mIivU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfozIeEqA4gStArBsPGI9uoW+IawKB60RXK7Es3+dLPSE0wgdE
	iM0cv0shMkKYSegetkdB4OyPxb+W8yoX+b0yTBc/gbsT6nMDwt+iDKszwgrI3M5rcF4=
X-Gm-Gg: Acq92OGwhRT32TpVDxr1cJ5pTBv+PeNG0ayp9jLf8E6qPeFvWkytCtCXBIU0FJcj6Rw
	iRqgny38StBKesm9kUAlB14m7/37KWZHmXIeIXSZ4vdqF3KFGwGYRAcTrSLUWMBy+fT5Z0zldMe
	0hf9z9HpXT/vZg3ALnNYSal6FYf59SDUpYGLLb5pzpuZLylgKZ5BD4UYQXHsRSWM9gVQNpkck7y
	tViRx7CYk+hxkXyWLAfYTzgsqZH8dyZ25w7QwEKkTzacvw3n8WaUV05cxUQ0Elz3HlCg08O01xC
	QugWbUS9lBqTr1yUG5speLBIaADOdpGZesOe9S8XVFcfG+LBRtN/mn81Qox7L6RzfZbzxY5s7ws
	devdE90vEPZo+pv2shMC+H2C5axq7MKx1sMNcjNANVc6zyOeznwpGI5HwpeaLv1JQ/aiqco+kIU
	3nRSGrITxsLG1mJcBB2iksv4SoNozRqBqo4EqVACi/azZOS5TPf1/gj5s/h2vfRlvOXYSl7cyl8
	cMw4Q==
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr72758491cf.23.1778869403362;
        Fri, 15 May 2026 11:23:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645801211sm50772901cf.20.2026.05.15.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:23:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNxBy-00000007tTG-1fso;
	Fri, 15 May 2026 15:23:22 -0300
Date: Fri, 15 May 2026 15:23:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260515182322.GI7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-10-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: 19306556446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	TAGGED_FROM(0.00)[bounces-10922-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:02:57PM -0700, Mukesh R wrote:
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;
> +
> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm()) {
> +		pr_err("Hyper-V: l1vh iommu does not support host devices\n");
> +		return NULL;
> +	}
> +
> +	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
> +	if (hvdom == NULL)
> +		return NULL;
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree = RB_ROOT_CACHED;
> +
> +	/* Called under iommu group mutex, so single threaded */
> +	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie, UINTMAX */
> +		goto out_err;
> +
> +	hvdom->domid_num = unique_id;
> +	hvdom->partid = hv_get_current_partid();
> +	hvdom->iommu_dom.geometry = default_geometry;
> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
> +
> +	/* For guests, by default we do direct attaches, so no domain in hyp */
> +	if (hv_dom_owner_is_vmm(hvdom) && !hv_no_attdev)
> +		hvdom->attached_dom = true;

What are you thinking sending something like this?!?!?

The function is called *alloc domain PAGING*, it does not, and can not
allocate weird "special" domains that are not PAGING domains. I just
spent a long time removing all this kind of crazyness from drivers.

There is alot of other things I don't like in this patch, but this is
too much.

You have to drop this "direct attach" idea from the first iteration,
Linux can't do it without alot more work, you should start with the
basic paging domain mode.

Jason

