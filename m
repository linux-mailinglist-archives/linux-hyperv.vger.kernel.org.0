Return-Path: <linux-hyperv+bounces-8306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC9D22BB4
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0130330039C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167D43254AE;
	Thu, 15 Jan 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWJGKEB0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7522DFA4;
	Thu, 15 Jan 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461048; cv=none; b=aJwD8ao4vDfbRDYSHgI9P44wFUDcMLEJRVnm4vl9dfjI0x5Eiq1unz0+08cCk6ER87bXgiKIvAeTBQgenssw8wh6bDTorT9cFyQv4+JBckOLGb6XWdBbK1e1u5g3wlY4BE7/sIOiSMVsvagFwDMV28koOY2ZyguCiV1gE9Ot1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461048; c=relaxed/simple;
	bh=eO+Sw8wsqQe+oHKVZDeBwvpIM9kgU8Dsz92izQ4hEqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+p9DHdsOVJDTQTcSqz4dlSm+4+bSn3ggacgUd+VMY+vXgvWym4bID68Ga006e83h0/fPBA/aIAJ7AHbLwqdrLpS5B0VJ2bkaSAYzX7ABzKBdOmdIMZVdWc3v8hb6RlshDmrudgbsetEuo5SXUHxqn2tKiLXz/TTgzrQeoQIIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWJGKEB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808C3C116D0;
	Thu, 15 Jan 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768461047;
	bh=eO+Sw8wsqQe+oHKVZDeBwvpIM9kgU8Dsz92izQ4hEqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWJGKEB052qgGfco9Fb3imScCu5Y7XTc3hjqjH3YeHwqWExFhNgwuTL6OnseFpmo6
	 j+vewaxb06SqCfxcg7BKhs2vLDOmdm3S9qS7V23dVa8bTADvyj4jFrQ/ocN7/WLW/q
	 4NRxmQG38Bpl7fc8SvxaD0lB8qLr1XZlz9P8C2rsOkn0hoFFlbglr/STrzrqPODOnU
	 2lwAcLxafJ/xO/J5Yajls/0DVY3aQLGyzhvyw3JEgkCHdu46GgWyFvkZgs0txpTw91
	 fCG+ePJ0BYB+G0czHwqOYkb/VJgLVQnusU9RDMqssGI0spkSBLlm7Abk1dY9GZeDCd
	 VWbqjSWNIlaHg==
Date: Thu, 15 Jan 2026 07:10:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Align huge page stride with guest mapping
Message-ID: <20260115071046.GC3557088@liuwe-devbox-debian-v2.local>
References: <176781093198.21595.6373086133020540990.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176781093198.21595.6373086133020540990.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Jan 07, 2026 at 06:45:43PM +0000, Stanislav Kinsburskii wrote:
> Ensure that a stride larger than 1 (huge page) is only used when page
> points to a head of a huge page and both the guest frame number (gfn) and
> the operation size (page_count) are aligned to the huge page size
> (PTRS_PER_PMD). This matches the hypervisor requirement that map/unmap
> operations for huge pages must be guest-aligned and cover a full huge page.
> 
> Add mshv_chunk_stride() to encapsulate this alignment and page-order
> validation, and plumb a huge_page flag into the region chunk handlers.
> This prevents issuing large-page map/unmap/share operations that the
> hypervisor would reject due to misaligned guest mappings.
> 
> Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region traversal")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Applied.

