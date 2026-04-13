Return-Path: <linux-hyperv+bounces-10133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABpJAWL13GkvYgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10133-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 15:53:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568973ECC70
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BD63026AA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E723BD63E;
	Mon, 13 Apr 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f/TW0Bx+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2686BFCE
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Apr 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087967; cv=none; b=TXuBhSA4KMCtzQc1WGGckIn7S58YOLkzxZoeBi017L1iFzrgd0yZHaoWNBdNvtxXL4+PBddkt5hgH8P2psr3XvHcKek63plnVvUqxAdy430x3CTY21tTfJrJic+JUC2O+iJL8LQow0OundrwxriLvsP07VJB3M6vXqr9m8raeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087967; c=relaxed/simple;
	bh=SKDyDeGLAKxeIgYcE/qZKnwcFXAE4s0elS0LgRHfpcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAhaummM0LJicjZHd18PHSf16TT1bOvU55hQgrhUyUKsKpp+c/BbEvGfpIfxYz+6swfbV0qYpvR3IXIB0hbviepQ8S2IobPWssZCoGBQCrDZHncxmlNitt5eUbC10wyeZDZz5yN7tRqqpsqvyBus9n8l2RcbK7RDClBTHe/0EbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f/TW0Bx+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cfc5941028so657273785a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Apr 2026 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776087965; x=1776692765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx2nTgwnCEnXXRiMkiTBuROyOk5YN+wYsn+Y4QhOS7Y=;
        b=f/TW0Bx+rkGxH3UsA8E8/yvYJXo+e0k96pGH27Kt2SzqKf6T+nL4Zh+vFD4AiWtT8A
         sSJZuatZcfRBCeCj7EBvfmzK8wz39zWeKAFRTFSjfBgOfy1KryEVXM6nkISDEHp++ptv
         SoZXa3h7R34NjuxEg2pAgTxLsNf7AzCKaczdupu7DjkVL+fjzYibfq1zj84FXowKcMhT
         5HtmadyhT2RQRLY+Wqw2aIYZITHXZPmLh6kifzaPvj9LR+GVCP79SecqNOUWH2mcr1uW
         MQ1XHuji/D+g/xO60/IOosD1sWEG0t5WuDCks0FgliUuIboUEFYMMhKznhhtRb89AJ1H
         dwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087965; x=1776692765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx2nTgwnCEnXXRiMkiTBuROyOk5YN+wYsn+Y4QhOS7Y=;
        b=Bxb1SYkdNfMAzjdQnc4EMOUopchd1HttYiKZNEhNC3BIvBzf4zuLA7cTGlkqFThSHt
         jEVF36/w3AzNLkDDPuG0OlvabWfUQeb7zKaLJWelzP7G+q5Ak+rbcHnCGoUWtTUXS/Nx
         oVCu7EqAzvqOddFwjcGRpST7PFLiG3z7HG51QwuEiEcfjJJw0OkXEjsDS2L0PYAkw5p4
         Gv6M2UdHmadFLvtbU07GQSXKVhpfqqDYUsx/w7FhlND0QqC84otMS/6nrQThjwl5WtKb
         pkmzJO0z16AKaSdlT8cMre0UgvutkF3NPyFw7R8SKU+kQAtHQKArwkhykdaF0VOLFj97
         fDsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uymrpOw0M7HpZK118i5xPIY0P+DSsCPFBFZfeXESfWinhqVG2/sy6hx6ss9ugpXVWibYLeaQsW46ujqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqxCac6Xilty5NSfK+3OjamtSOVjWizzbzQ0hcBsM/oVS5OQw
	TV6wfisYO8uC5655aIw+NxjJpaMKNRAmaE6JtRFwPoKs0/uohX4VAVekBC5qoRjlImk=
X-Gm-Gg: AeBDiesPg8tMRi0qKmCYhMssO4EzrX3VRZlO0aEn+ewlKnRZPJC5gJ9PBwdEGRM2QqK
	7tPi9ckis71Fqce3Mwh6nsaogqoqduwio3PLLtcHrPqvjq9s25pt4/I6UO7mWWAfMOPqoKcOPXz
	Ate2RmAP2H+m0L531oLwpI7wNJvvL3qaLkqsB1IhflUjRmNXlaboj+dBiuBS5qA3zDIopkaP736
	tBRdR/CD4Ch0otrEpJ7S3hqBVPhYYDFpHa8cl1qRnb8y7v2s1Q8UxJRSJgsd8Ne9CeiPaQ0l2+3
	R3fYRdnr0srkynxnPU05/nDyzGmA2bp5dDDwpJuYqdJlcpHiYDHnRPzTyxtjrexeF4H2Orxm+9q
	NbAQax9NeEw3/o1uwgdXQmWvt0V7RkLt4BwFCAMPyhpU85OXh/enlHVeRvaH9Oma4QiGN3QMfHZ
	QyEhM4SSGgdJjhF10keNMLbEdpQuUv+gk1nmF8y70ACBpTX7VZ6IwOdswthFC7rpor9CRPUuz+h
	6HD+w==
X-Received: by 2002:a05:620a:31a8:b0:8cd:b33a:a4da with SMTP id af79cd13be357-8ddd00a8a98mr1835861985a.55.1776087964542;
        Mon, 13 Apr 2026 06:46:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e07730d836sm381231385a.3.2026.04.13.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCHc2-00000005BFb-48oy;
	Mon, 13 Apr 2026 10:46:02 -0300
Date: Mon, 13 Apr 2026 10:46:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260413134602.GL3694781@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-10133-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 568973ECC70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:29:45PM +0000, Long Li wrote:
> > On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:
> > 
> > > How we rephrase this in this way: the driver should not corrupt or
> > > overflow other parts of the kernel if its device is misbehaving (or
> > > has a bug).
> > 
> > If we are going to do this CC hardening stuff I think I want to see a more
> > comphrensive approach, like if we detect an attack then the kernel instantly
> > crashes or something. Or at least an approach in general agreed to by the CC and
> > kernel community.
> > 
> > Igoring the issue and continuing seems just wrong.
> > 
> > This sprinkling of random checks in this series doesn't feel comprehensive or
> > cohesive to me.
> > 
> > Jason
> 
> Can we follow the virtio BAD_RING()/vq->broken pattern in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio_ring.c#n57.
> 
> Add a broken flag to mana_ib_dev. When any hardware response
> contains out-of-range values, mark the device broken and fail the
> operation - during probe this prevents device registration entirely,
> at runtime all subsequent operations return -EIO.

If that's the plan I would think it should be struct device based, but
yeah, I'm more comfortable with this sort of direction as a CC
hardening plan.

Jason

