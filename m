Return-Path: <linux-hyperv+bounces-2104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8518C485A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 May 2024 22:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72DC1F2221F
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 May 2024 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2F80600;
	Mon, 13 May 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxP1MNYN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39B42070;
	Mon, 13 May 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632924; cv=none; b=PMslo6HuKXea2+2tMZAsUWvLP9d4KXjO+YyjJSWIez56yuIp5S01BF3+Fjt/0v6ZlY4zCvLiALNi79ODtkfPjZQCj7s/z3I5DnuttRqb4pkZjg61PDZZeX+EnnxOndB5INgpkREXOXvmkDBv3B3nQV//18bq/7oZ4uIjnpVCFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632924; c=relaxed/simple;
	bh=1w74yuUnytY/YP1jUnzke8Tc+lQ7zmpdid5rdAqGZv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSKAA+iAuEYuckxpFPvF+NeirZAslRboueL2ZJDMI4GiPx0hodVA/AEUlMibDN79YxB9S/5XD+weEJDC3ZPwQBYfevdOSCE2hU0fKEAFa/mtQdNbNwD6ob3x9d3q5Y0u31q9mIIq5BY8mmEfRvXKWhZOJ1p1ugcla4PRWQABgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxP1MNYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F4BC2BD11;
	Mon, 13 May 2024 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715632923;
	bh=1w74yuUnytY/YP1jUnzke8Tc+lQ7zmpdid5rdAqGZv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxP1MNYNtVjqMKp/vXe9iiaCYrMPXnJU3+A49xwVFsrx5RQA8NyLyqEfR38eagpdO
	 RUfeSmEJFuiXYZ/zurncIYmkvAONAtyLrgNkgWjGpmTjPO7MhsVXBVCjo97+dSqXll
	 UH3PZDWc8Ysn5s1M0SFaMhXvq6HCcb0QcFyPjXYALAg3b06QumId0rEP3u7IimK0aY
	 22RXNrdQehJe2DOiy6us022ngqVfZbUIcMvgNBogSmDW3b3u4PlJAKd6jZ0EneaUxq
	 lCmfEP+cVRyWG+Gxga/lepmgUpZxr1zDZ714Oa9zPw3qGKIr2RdGVn5zSRpz1IpSEn
	 izeyp4uRJEYgQ==
Date: Mon, 13 May 2024 13:42:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K
 page size
Message-ID: <20240513134201.5f5acbae@kernel.org>
In-Reply-To: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
References: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 13:29:01 -0700 Haiyang Zhang wrote:
> -	depends on PCI_MSI && X86_64
> +	depends on PCI_MSI
> +	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)

Can ARM64 be big endian?

