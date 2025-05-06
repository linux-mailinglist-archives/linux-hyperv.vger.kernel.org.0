Return-Path: <linux-hyperv+bounces-5373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795EAABBD1
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7737BECF3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473122D4FE;
	Tue,  6 May 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqz0uf5J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FB17A310;
	Tue,  6 May 2025 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515426; cv=none; b=BTO0r6IaE4XSZGmE2gFZc3wmqgdDEK32r7Cw7TQxJu1fwKHLthayKRUBMiIDY8UWwh8TRBZgKTq9vlIFXiiz5OuNIiM/mDcws68K4Tz5H2ukG0tQco6W/sgm/cgHz+I1RNien7GdQdphhWld+LCr/2kgpgI8Qsxqhfy+AgeTtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515426; c=relaxed/simple;
	bh=yv6EvulzuyOjzbFqHlNYUWQZ40kXK+s59mBrzAxeERw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh3y1swVaeVOQAQHtC/vgmt6HIm4XI5Tyr3c9hgXxUkclZeOI4m6z2AH8EP9LqNQI3q0tMdnoCCkFKU1I1E/+8SzLzwVvc1UT+ddoEoKq7HAH0con5w7YhpBptvOUzHAWvYiSDzHZApzPhH96gGaKLU2yLyis9T6vTBBXDtoGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqz0uf5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1471C4CEE4;
	Tue,  6 May 2025 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746515425;
	bh=yv6EvulzuyOjzbFqHlNYUWQZ40kXK+s59mBrzAxeERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqz0uf5JziG2vyN3X5hTRcFbqzFC6daZjAnWixLageNBzBmkKhn1Q6zhj1a0nZ3rc
	 OhHge9jfKP66r1YSkjtHSHZVPVWO2DDE7Zi5qQ9jH4KtxNy7v0Kr1cNYDg1/G57his
	 bxGX6YhpF9bvCvP3GFyyrhic7aYjAVrjDD+ghRgO4XEbHdque0k5lNUIg0ryJkENXG
	 iPXVSJGyo0gDybEWC/umL8vg8fy8OhHbjff/eC13hxcHv6p0nMO2QaTxxsp+SKbcD3
	 EL8GbZYWRmx/UOppKNWaFg/VJGzCraSSY4GZJB48mv6In+uUldXd/GterkHVGtAyb0
	 fBp4ZFaw4UQIA==
Date: Tue, 6 May 2025 09:10:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250506-pompous-meaty-crane-97efce@kuoka>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506051610.GC25533@ranerica-svr.sc.intel.com>

On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > If this is a device, then compatibles specific to devices. You do not
> > get different rules than all other bindings... or this does not have to
> > be binding at all. Why standard reserved-memory does not work for here?
> > 
> > Why do you need compatible in the first place?
> 
> Are you suggesting something like this?
> 
> reserved-memory {
> 	# address-cells = <2>;
> 	# size-cells = <1>;
> 
> 	wakeup_mailbox: wakeupmb@fff000 {
> 		reg = < 0x0 0xfff000 0x1000>
> 	}
> 
> and then reference to the reserved memory using the wakeup_mailbox
> phandle?

Yes just like every other, typical reserved memory block.

Best regards,
Krzysztof


