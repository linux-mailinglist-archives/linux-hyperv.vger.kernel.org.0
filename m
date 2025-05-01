Return-Path: <linux-hyperv+bounces-5286-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B2AA6100
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984C51BC4BC2
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676ED20B807;
	Thu,  1 May 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bhJrT6nX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7711BF37;
	Thu,  1 May 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114981; cv=none; b=En4LM/eF8DW3yS+DETj18wFLmwCdsv3isNX/BArPyLb3dzGwUkrEA6cr29azPd/0CKDax9amggy1yhs3V4VtYjc/dY+hzZ6TDaEVT01o+b6bEt3CepKt9o1yVh9B8eV3JjRjxnE15fvw9yNS+ErbJqtvEmYtnQQKRnfuYvWPOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114981; c=relaxed/simple;
	bh=Q0rI3Ix5bKbL3oXvzTrIX1mYZLSUqs3Li6p9AXMr1cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdWuUma+gs7UpUycLRXZNxZQUjm5EHCbhuIMxOhaHfKWj/3MJAgaibEh8mqZeWCkw2KyrmYnM/dGkLtQXp4QOk2FVKoA88iYGAkFiapQF428FnP34qZoiSG68ngtXBEkdIKkIju1Gt4O1G88ehEydg8wrsKBpWpytneCBSBBAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bhJrT6nX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zTjgeh/y5NGBu1mrW+W0Jg2XIh99/pQSz8ZxlAYIlW8=; b=bhJrT6nXBQWvb48rdqzWBiycvh
	2NVLX2Y38i8ecaxv1yDgPLivqRVxsvZDUMplcSuQ9IuaZXrPS1q8zbTE/4m86DivGyJtcbW1UblZ0
	6NH3gzsybTuwtaritDRKIyf05mtszgoo/ob9Nq+gjXJbK5PFj/7AT3ed+ystg67I3vep5QvZDvy+g
	2I0NQXBlzR/CzNoahyn897LRhLmXfUgBouJq9kPLNE9msXZijQJ/O7aSPpUNHgOuXiH5tAQYNhbRH
	VefmDdWBsbB4uvqwGnh18DpPoCEw3dv4CNTvPQdWWKQu2COF0vNoZG951pGL7AoJM3AnXCO2iY0AZ
	9IoUSViQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAWGa-0000000E3Q7-1uZz;
	Thu, 01 May 2025 15:56:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE9FC300642; Thu,  1 May 2025 17:56:03 +0200 (CEST)
Date: Thu, 1 May 2025 17:56:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH v2 13/13] objtool: Validate kCFI calls
Message-ID: <20250501155603.GE4356@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.443414861@infradead.org>
 <u4v64j3wgdml5zkij43lcksknhpoaqs3jmrm5udejrg75dl2ny@x4jexlz64amd>
 <20250430190328.GO4439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190328.GO4439@noisy.programming.kicks-ass.net>

On Wed, Apr 30, 2025 at 09:03:29PM +0200, Peter Zijlstra wrote:

> > > +	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
> > > +		struct symbol *sym = insn->sym;
> > > +
> > > +		if (sym && sym->type == STT_FUNC && !sym->nocfi) {
> > > +			struct instruction *prev =
> > > +				prev_insn_same_sym(file, insn);
> > > +
> > > +			if (!prev || prev->type != INSN_BUG) {
> > > +				WARN_INSN(insn, "no-cfi indirect call!");
> > > +				warnings++;
> > 
> > Do we not care about indirect calls from !STT_FUNC?

I extended to also cover STT_NOTYPE, no additional warns.

