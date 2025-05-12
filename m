Return-Path: <linux-hyperv+bounces-5474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD44AB3C1F
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A41166929
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAED023A9BB;
	Mon, 12 May 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR0KDEB3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEE2367B3;
	Mon, 12 May 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063947; cv=none; b=IbUh2wszjHtBN0bu3hmub92oQ9zJoJucjdY13qf9tDMAg2yq/iRsso0iCGpcmns2xLmTP+dDVl5X7saJ7r05rMIrjMOpmniKzUFuEYe8ZuHHY0RxoxtYlcAycOjwcKMWOr2XZRlm0L5zQte6lSMX69510AgM91bFBo39syCWt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063947; c=relaxed/simple;
	bh=G8STc3nYG2oGE9loL8qWjLffTpgukBF65jhgCRfvXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6EejHCQd3kIzS1RQlWsCxtjnnbn+cZBZpcVVLsYauzuT5liqbfiBHvxFT2GJd/1m5ksYd1t8mX9bfo2b4u6d/lwBzqYleIzn/wnuBpR/uKUnmaxMhyTrnOxeiXbE8paBxQaRzGDAfGSPLz5dRcJRibGccBMgOeDBjkdSRdQEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR0KDEB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DAEC4CEE7;
	Mon, 12 May 2025 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747063946;
	bh=G8STc3nYG2oGE9loL8qWjLffTpgukBF65jhgCRfvXq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR0KDEB3P9q9DlkdVZZ8h0q0xI/q4GTgP7wYrn6KDFMcHB2dGam49torlGAxf16Eq
	 +Hobwti4JcLvGepcPASZ1VVYZ7UPkhzSb+9H5zeVf1WjG6qGFZoQdogX5hVXNxgzCa
	 vKqS1GmCm7sq67W902Z8BihGab71tqnbCa/E6DUkPwX3baIEm+r2ioRmnzFMcQGkR2
	 3Cvkuat4FJXqLJJwY5wcPFD/dY4+qY+Be3mX+wkVVD445QmTscsx9+9WfUaayp6f3r
	 fsSqANCLOcZIfF8CX7LYz08UQRp3Kondi5ADJmiqbN8wTcUZxs0ipIadhmEecKdKrD
	 hgqZt111ExdXg==
Date: Mon, 12 May 2025 10:32:24 -0500
From: Rob Herring <robh@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250512153224.GA3377771-robh@kernel.org>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507032339.GA27243@ranerica-svr.sc.intel.com>

On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > If this is a device, then compatibles specific to devices. You do not
> > > > get different rules than all other bindings... or this does not have to
> > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > 
> > > > Why do you need compatible in the first place?
> > > 
> > > Are you suggesting something like this?
> > > 
> > > reserved-memory {
> > > 	# address-cells = <2>;
> > > 	# size-cells = <1>;
> > > 
> > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > 		reg = < 0x0 0xfff000 0x1000>
> > > 	}
> > > 
> > > and then reference to the reserved memory using the wakeup_mailbox
> > > phandle?
> > 
> > Yes just like every other, typical reserved memory block.
> 
> Thanks! I will take this approach and drop this patch.

If there is nothing else to this other than the reserved region, then 
don't do this. Keep it like you had. There's no need for 2 nodes.

Rob

