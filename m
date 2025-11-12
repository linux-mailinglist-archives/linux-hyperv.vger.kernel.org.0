Return-Path: <linux-hyperv+bounces-7521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61576C519C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59FC4EC929
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7092FF641;
	Wed, 12 Nov 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qO05cn8L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F76214A64;
	Wed, 12 Nov 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942253; cv=none; b=XKBEhtlKWIMJOJYadDDkUdhTx17hxo20YZ8mvufNmvntk2Pd6YrtKhCxjPDVmYpEg+QIxbmkGmcizM+e6bik78kAfZiNHPBU7OFfNNNDEXBnRx32jE6RmP5+YDSga11xIZrOq6R6iJo0qYMbUtBQ/d/+DEC9s9014VFfFeCSty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942253; c=relaxed/simple;
	bh=q6ZLUHypSLT28KPh3EkAo+lw5+LwyFgAdDV/3SdaTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBRa6p0qJEDgemykSM71ql/mM3oD3T6FUdRWcTefbjBERpjD6q1vKbGZbUdcmDijPsSA9Sbsg5iqSAJUPfu2QTvGNQL6tL9ea2t1wIurlHnj36gwpScbkoL0gKEIH8rdLge6pygGCdYY4lxo7vmIfZ+qS8D/hPh/JLl6fPFlyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qO05cn8L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxaCj8iJVCQOjb3584RLsDGGWdbgO7TCVHLkB72ARmU=; b=qO05cn8LOBffIOPcshsfuH3ihS
	D903biXWaPlB45bI0kZNB08dpV8wCOQ9+7U2NlTiE5f2MlJHRGZRIWSN8Z4OmV54mXkiqw3wq+Klj
	Cs6zUsrey7oYUlP5XAwhnfWwVQjTw8spWitGDkDbqxGxK74vueCsSz2K5QpBBblmzZA9aoe80EGsa
	UkiGW3m7AJL+8d6kzYwBlfIt0sT+F/Ka8ry38dIF4axEhxpvoBTkQ596pR6VZkGD1uwBnP+F8rUMu
	qZW9ZUCpMG1IQhArjat/M1orv/0EjfDqS3e2UP0KyiabawLootRQRmUH+92sjSp2TpEdd8zoHLPxZ
	7/85e+7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6wa-0000000F9NB-1QfZ;
	Wed, 12 Nov 2025 09:15:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 876B3300325; Wed, 12 Nov 2025 11:10:38 +0100 (CET)
Date: Wed, 12 Nov 2025 11:10:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251112101038.GE4067720@noisy.programming.kicks-ass.net>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251112093704.GC4067720@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157F3F565621B32AC29EC92D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F3F565621B32AC29EC92D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Nov 12, 2025 at 09:44:20AM +0000, Michael Kelley wrote:

> Thanks. If that symbol is referenced only by these few lines, I'd
> go with something even shorter and simpler. Perhaps:
> 
> .section		.discard.addressable,"aw"
> .align 8
> .type	vtl_return_sym, @object
> .size	vtl_return_sym, 8
> vtl_return_sym:
> .quad	__SCK____mshv_vtl_return_hypercall
> 
> Regardless of the choice of symbol name, add a comment about
> mimicking __ADDRESSABLE(). That feels less messy to me, but
> it's Naman's call.

Right, that'll work.

