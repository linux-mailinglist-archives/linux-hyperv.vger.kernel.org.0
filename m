Return-Path: <linux-hyperv+bounces-1695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7F876BE2
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 21:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8884CB212A6
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D745D900;
	Fri,  8 Mar 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9f9RbSq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOUx0g/2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6E31A66;
	Fri,  8 Mar 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930014; cv=none; b=Qi3ePBDTcPylSN0z8WBFv0gYP/1zfGynknf2KWY/6IZjXNuD+JLJfFMmIknRlF5yDWajAT6/ntLmoUrlBReI+5m8DAPnAj1LDW2AVWBEZCaUajct9GYa4A6eK0uje88AAyXog66cDzrMWl9OJ2Wo4cqDesymIvC0cJoZnZ590co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930014; c=relaxed/simple;
	bh=mbU8isap81SxzNzDKLf+EXRxnmhyRYSIpTTrNxuafgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOPzkLyt2YfrcOF+ESaSSsTYP+honxhjr9I2onevDVCYaZQ9ZJAF7d9KI9po0melq34ghTpneR0XlAFmPQR2paXK/wNuLDLMEOHmdxfIF2yKexcrr2nGRFziqLBzVcnZ/6l4ExxPOey8UpoRvZZaPM1ML1qQgMb018OIS0Ehr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9f9RbSq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOUx0g/2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Mar 2024 21:33:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709930010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vwt+VDLDRvl/LmacdV+mArgWDFVTfPr6L4CGq1jg7iM=;
	b=Y9f9RbSqdey9V8dfdCvfDsnukOebtoJo+6d2pQKjR7kElvsby2DO2FvbgifxygGaG6lWZS
	Ju8mCG9/05W3bHjnk+GD4SeMi2yIjHt+UYM1CvCRHEKZm0ntRs+qJAMWeh7ta+s3YlIseu
	Wj3UNnRnSyAC5Fg8Z35dJu1hZXKwOjWd0biYGjnihXAq+1Hw56B9wPO1Qbfag96ZKDLl+k
	wBNHhNyOixrZuoVwuQ/gQXESQ02d/o4Q2oNOBQRiyfQJIb9F+gBWSEH7RRGhzcr3vOej/F
	oxOKYImAFl85qeUIjI4l2y1ZlZOjM0DiiUQgYCazCGJl1yHrEIgW5a5diGuBsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709930010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vwt+VDLDRvl/LmacdV+mArgWDFVTfPr6L4CGq1jg7iM=;
	b=MOUx0g/2AvvcSiTbU8MX33za3/D88DDcKUIh16xlqY3skmnxiyrhRHlAgdgLf2qsj2+Ce/
	q5/pd0mZvSVkZ/Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	Alireza Dabagh <alid@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>
Subject: Re: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240308203328.IvakSEHd@linutronix.de>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
 <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>

On 2024-03-08 19:43:57 [+0000], Haiyang Zhang wrote:
> > Do you have experimental data showing this making a difference
> > in production?
> Shradha, could you please add some data before / after enabling irqbalancer 
> which changes cpu affinity?

so you have one queue and one interrupt and then the irqbalancer is
pushing the interrupt from CPU to another. What kind of information do
you gain from per-CPU counters here?

> Thanks,
> - Haiyang

Sebastian

