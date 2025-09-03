Return-Path: <linux-hyperv+bounces-6710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE4B422DB
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Sep 2025 16:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40D11694CD
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Sep 2025 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAA19AD5C;
	Wed,  3 Sep 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ec+XGks0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBsJfZsM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F930F528;
	Wed,  3 Sep 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908024; cv=none; b=LwnecEtLIZw5fPn0T/9+RSuFEF0SivdHSnmMabQnwENWdb2Fl+QWVzFbBk7/dwDjeL3dhCV32KfZK8CZ9Pce1vbU4F4v+nMVS4NsCgCIvt1/4SBruKDAuSB/S3PDVf0XLzexNL6JhGaTuraSGj/cWJC+rAmQRD/XuHeKMFKFSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908024; c=relaxed/simple;
	bh=n01rXX8gH+qYURzTMyX/5ruFEtqfyopaguFn1tS4SP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0P6JJpSU9f36q5cSLob1FoH6ijw6bo0MyZrPQtXABfiY8lwZU8Eq6GscdCUbXqRIFNdTXvSCud74kBN/hof2WYIcvBYX6ui0D3cu7EWzY5mziRx7n+m+0IP2T2H/dsTQrN72cHA/0xZhhFO6mBOFsOKvjyD7LKiYdZvvrqejPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ec+XGks0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBsJfZsM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPzPIAnlOUXFheFDu//uBtGcfste1iOG0vBUur8+92Q=;
	b=ec+XGks0wkFXr9aTVaS+fKEhULY0ehpslA+1lg41Gp+cznZBEs8NMBVcpnUagaMXNU5H+c
	b5dE5HGVngQ8qr4uNy2LKHBnqVEXIWGbtGP2tL72P7a2YPjwPQbt8Toe7pAQ7ozdkDV4Ms
	mxe+0gQUVMaU+fmHsm7TZJeFRza0S7EkmRcaVY3IF1x7WuYpdbheVE19jGwoujOqkFOikI
	bX/Hg1CUTCU1sxetyoSNd1cLNNDnBBS5KdKp3nCz8sX6zpWYJmahTFqdwEm5n8XVEIJmc8
	mVkCND46Ff4KPxRJ8oj8KSJvOOA6Z9iN8DUw5ShYfPnKJI+/hUYfVSqSplh7vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPzPIAnlOUXFheFDu//uBtGcfste1iOG0vBUur8+92Q=;
	b=uBsJfZsMIjUcRPwqpbJbC+718lDStZRClLPbEs2OU1PrgFiGQxz4k6KaWKG7MFjQSPq761
	mQFvNM4nfImfB1Dw==
To: Wei Liu <wei.liu@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Nuno Das Neves
 <nunodasneves@linux.microsoft.com>, Marc Zyngier <maz@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] x86/hyperv: MSI parent domain conversion
In-Reply-To: <aIJjrYne1VvGjBux@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <cover.1752868165.git.namcao@linutronix.de>
 <aIJjrYne1VvGjBux@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Date: Wed, 03 Sep 2025 16:00:18 +0200
Message-ID: <871ponzle5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:47, Wei Liu wrote:
> Nuno, can you please take a look at this patch?

Can we get this moving so that the legacy PCI stuff can be retired?

Thanks,

        tglx

