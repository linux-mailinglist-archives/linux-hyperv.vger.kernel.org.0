Return-Path: <linux-hyperv+bounces-8304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F5D22B27
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA449303F353
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732212EBBAF;
	Thu, 15 Jan 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVUU/cCw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506162DCF7B;
	Thu, 15 Jan 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460433; cv=none; b=iirx+wWK72ItesXs16o6nXXmLDK031yk3e0r/SlnM+kFzjWMv2wkUftlYTTEyH2OdwaF9hAr6wkHfzUbq9vpgJVeLO9hOk7d1cblWC8ww5aFFiZZCrwJhl+p8p9Cxv3x4zD1Erd0LrJHfolDdWFo788ZogjYLErrHjxM/WAE9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460433; c=relaxed/simple;
	bh=Eg2yGtjmWDrMBaQeNK9+f9HpENRZrawORb/NKZHLrIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmUpZY3J4GggbAJl1djmmTQmh+tdQ73W8STpE/ZSOQqCbVbEYwtyVQkUpEaeYhcLw5weaSnQuZfwcOj141iM1Pl+t/9/eoeLst/03VnAcre2Quck7mfnisLqikvKaUEVsNJn/gglZRuqbCOEziXXMMQN3EK+M7INIEeKPkNxJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVUU/cCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7269C116D0;
	Thu, 15 Jan 2026 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768460432;
	bh=Eg2yGtjmWDrMBaQeNK9+f9HpENRZrawORb/NKZHLrIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVUU/cCwMMWIPiATLyexwcw8QFrwwg4G9h/D5cXTBJSdhvT4utdLqLyQaNyKPZVe2
	 6mz1nzc+K44jWd5EDdGyJuA3KVkwQvfqQKyheZ8LwWBaNLRpAQjGOqB+Mieit7k0z0
	 kFaKUeKLbzjFEUwXJQypsHzl0ocf8SJxwqcMV3GXhoAliQKdqqYI2jG4Sb/zlH8WUh
	 elpKn4VVDEUA0zn2u3WqnL64KjJ2W4kTAUfXrKY34Qt7z5HS04t5t/EvXFswOpNqIV
	 7p6UcndIZbrvbkvII3NCgBlOhILlxDZyVf9rr3YmqRZL0+XCnV3AG0myeOE0ecFAGl
	 UsJOi2or69m0g==
Date: Thu, 15 Jan 2026 07:00:31 +0000
From: Wei Liu <wei.liu@kernel.org>
To: vdso@mailbox.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>, yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: fix typo in function name reference
Message-ID: <20260115070031.GA3557088@liuwe-devbox-debian-v2.local>
References: <20251230141414.94472-1-Julia.Lawall@inria.fr>
 <1647289009.63012.1767104334567@app.mailbox.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647289009.63012.1767104334567@app.mailbox.org>

On Tue, Dec 30, 2025 at 06:18:54AM -0800, vdso@mailbox.org wrote:
> 
> > On 12/30/2025 6:14 AM  Julia Lawall <julia.lawall@inria.fr> wrote:
> > 
> >  
> > Replace cmxchg by cmpxchg.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > 
> 
> Reviewed-by: Roman Kisel <vdso@mailbox.org>
> 

Applied. Thank you.


