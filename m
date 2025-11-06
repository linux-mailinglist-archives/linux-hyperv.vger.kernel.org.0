Return-Path: <linux-hyperv+bounces-7429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD1C3BE41
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 15:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FAD1894412
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF19315769;
	Thu,  6 Nov 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cjhr5i5y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FA19D07E;
	Thu,  6 Nov 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440579; cv=none; b=Ul7G53OEqlYV0SyVxk1I+3eWijAy5rbVgWy4RR69ZcVVJse3tCH/mkMU4Oby/CnTdIHyB66X6fyjXIDRyOxE5Wgbk9FyVZW2vfOEAASK4A6kSCRotzjUFnyCacvKFUbBBjzAuuBQQh8dWOzQVVIurJBqDJbUynMhIV+4MF9VerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440579; c=relaxed/simple;
	bh=Bs6PrusrQ9b6qgDuPufXQAbjKepON/qg7rOLvj4uBL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSaMqTlANRKN+Jk4MvXxLJHqX5LaIMMB2BTypJQn+ojI5Uh5If1VzM9vpst+C2QJLQ1aRKdzcmgPcjS8MxKEKVsSi2krHF5ZGt5Y4QeEv4IORsJ6hwLFvR89A1LbcQQOncqy4K2tQ3dXLWBOVdrbvqWqWaBFHqz7Y18qBjRxf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cjhr5i5y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bs6PrusrQ9b6qgDuPufXQAbjKepON/qg7rOLvj4uBL8=; b=Cjhr5i5ypTZssQkyOiVs9VQr5k
	IN/n5VIYkwZfoPwRwFRVbMB8YN0ETLUF/NFBsortsDeAab0F6oQgfPSiTWs4SPQU5WsXmrh8OpVEZ
	lM733X4vmGEARW3uGBANPUoGZ17x1VxWdElJ9Dj3+Kg+8stgQGOWevFZVLn0duXIz45s+D+AoEAaz
	XRWOK1fDZihDI4Lx+7/8ho6nTOBlljAMYSyfJ+uu83S4UMgPqdf46QFbAqXwbel0jldiQ9c/0nkMU
	rG7mC/u49Gu+Kbyu6bLgMvoNrN3keMu1xn9UPxPOAps+k/iZOVIg3Zz8mRaoBolUihKTpLSMZCnCR
	513/72tQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH0Qx-00000004Ye3-3gZU;
	Thu, 06 Nov 2025 13:53:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B268C300230; Thu, 06 Nov 2025 15:49:19 +0100 (CET)
Date: Thu, 6 Nov 2025 15:49:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v10 1/2] Drivers: hv: Export some symbols for mshv_vtl
Message-ID: <20251106144919.GT3245006@noisy.programming.kicks-ass.net>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
 <20251029050139.46545-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029050139.46545-2-namjain@linux.microsoft.com>

On Wed, Oct 29, 2025 at 05:01:38AM +0000, Naman Jain wrote:
> MSHV_VTL driver is going to be introduced, which is supposed to
> provide interface for Virtual Machine Monitors (VMMs) to control
> Virtual Trust Level (VTL). Export the symbols needed
> to make it work (vmbus_isr, hv_context and hv_post_message).

Please consider using EXPORT_SYMBOL_FOR_MODULES()

> +EXPORT_SYMBOL_GPL(hv_context);
> +EXPORT_SYMBOL_GPL(hv_post_message);
> +EXPORT_SYMBOL_GPL(vmbus_isr);

