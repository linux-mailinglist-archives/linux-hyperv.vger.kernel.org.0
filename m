Return-Path: <linux-hyperv+bounces-8157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCBCF55F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CD3B302E3F7
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CB346E41;
	Mon,  5 Jan 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Pe+KYuqU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44952346ADD;
	Mon,  5 Jan 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641261; cv=pass; b=aJCK4dcZwgHPb08hDIKpuJ4hC6CuIBmRUJtNgNIigwlJIt4He7XSXmGzkxrhVUaKg7ycgx8nvzb/6deuZNWy2Vp/l8E7PGCxi+EKmpe+sWqpJpFShaqWs7/EKiiHm/vg8D8+Hp6pXmO1t5fFA73eB0E/N+hdBxi5NaM+HDq98Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641261; c=relaxed/simple;
	bh=cjGcFxCZXFqIYOuLYZZvaEBGRPYOyqBacIMOjasfbzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u92kRAaPj01R63PN9y4Dn0ChlEJgibTy9uJ3slWCbQPvbCOpYSrs80EbAgBbQY3qvhLm4AWbQt3fB59kV96CbBjjYtbD2XER5ZFQeORsJ5FXUvFLr8viK5Gb/BM7cixsdQArmD3acx4gVfEBN6EjH+7F6jJCk1xlPUQ34jxFW/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Pe+KYuqU; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767641237; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Egn+cMtbyB8dD1gMRHDXXWC0PYZ+6V4Xw1RGvfDOvT7nK9xvKSS/IhD5M1dY68ZWSRTzT6rt5H9+ismPSXh7sh7v6aDJJFZ2gQ44E5GYeUQH7DhY/lK3s5R5rg9ak724JLxD48QoLETfO27NjkWNJWCQnTiP/jiBW00Rg2ldI1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767641237; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Gj34fk+1zm83K/lwjPXqdvD6pKvhqt0ru9M/e1z+Qs=; 
	b=F16wfJtR4GcraqzkoplKnhvEUgZ9y+etmnYSni1kvvGL+jfxcQDSqdtToPt0nmF2wfosqJLrodhXMgNy8yiNEJxJpZLGZEIrBUnrOpy7bYcxxzfYk6reI39EFKib905LYmc7T1X96qgVPeQYYjh+dXuwtbHL76e+RoAEdlofAw4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767641237;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0Gj34fk+1zm83K/lwjPXqdvD6pKvhqt0ru9M/e1z+Qs=;
	b=Pe+KYuqUzkqtzkFOxNIcMNADAtE06QrtZYfso0qRdv/rm3iPS8+L0tg8bSO2QJzn
	xVyJKTXwyKA9dAeE4q/cgau8xd8R7/k6s8zHfzhCK5Aor+WsV+CM0VZXXBUfiWQM1tC
	mzGJ6SfAPQII2lKct5t+K56BMgC32KrSANQ+IKKY=
Received: by mx.zohomail.com with SMTPS id 1767641233899759.5263087395728;
	Mon, 5 Jan 2026 11:27:13 -0800 (PST)
Date: Tue, 6 Jan 2026 00:57:07 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: vdso@mailbox.org
Cc: "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hyperv: add definitions for arm64 gpa intercepts
Message-ID: <atnnav7x4gzbeghpuh4fjpdig3i4zxzb56kpfvx3stgelajbm6@52lzmsycwzss>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-2-anirudh@anirudhrb.com>
 <993970797.13531.1767629162352@app.mailbox.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993970797.13531.1767629162352@app.mailbox.org>
X-ZohoMailClient: External

On Mon, Jan 05, 2026 at 08:06:02AM -0800, vdso@mailbox.org wrote:
> 
> > On 01/05/2026 4:28 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> 
> [...]
> 
> >  
> > +#if IS_ENABLED(CONFIG_ARM64)
> > +union hv_arm64_vp_execution_state {
> > +	u16 as_uint16;
> > +	struct {
> > +		u16 cpl:2; /* Exception Level (EL) */
> 
> Anirudh,
> 
> Appreciate following up on the CPL field in that ARM64 structure
> and adding the comment!

My bad, actually I was gonna explain this in a reply to the previous
thread but it slipped my mind.

> 
> Still, using something from the x86 parlance (CPL) and adding a comment
> stating that this is actually ARM64 EL certainly needs an explanation
> as to _why_ using an x86 term here is beneficial, why not just call
> the field "el"? As an analogy, here is a thought experiment of writing
> 
> #ffdef CONFIG_ARM64
> u64 rax; /* This is X0 */
> #endif
> 
> where an x86 register name would be used to refer to X0 on ARM64, and
> that doen't look natural.

Well, in this case neither CPL nor EL is an architecturally defined
register name. These are just architectural concepts.

> 
> So far, I can't seem to find drawbacks in naming this field "el", only
> benefits:
> * ARM64 folks will immediately know what this field is, and
> * the comment isn't required to explain the situation to the reader.
> 
> Do you foresee any drawbacks of calling the field "el" and dropping
> the comment? If you do, would these drawbacks outweigh the benefits?

As a general rule we want to keep these headers exactly same as the
hypervisor headers so that we can directly ingest them at some point in
the future.

I am not seeing a substantial benefit in breaking that rule. The CPL ->
EL analogy is not a huge leap to make IMO and the comment helps. One
could think of "current privilege level" as a generic term here.

Thanks,
Anirudh.

> 
> [...]
> 
> --
> Cheers,
> Roman

