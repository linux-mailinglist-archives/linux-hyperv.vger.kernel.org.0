Return-Path: <linux-hyperv+bounces-7717-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4DC75688
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93DB04EB6E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A032957CD;
	Thu, 20 Nov 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwrOxElx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60472366DA1;
	Thu, 20 Nov 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656196; cv=none; b=FvuNOkmu6CxZkuu6Ft5pQnj6AkUlF2M8fkMh/5i4gjf3L+JSkbZ0qyi+HEgRooj3hNxM/o8XB6E1vpfQ3XiMjv43i5l46S1e9jOWbNIizOe0iJOlY3RYUa8XqbwVP2+LLVnzTij6rp/o3ly7r5jS61qyy1/4jEFM0JiZapT4/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656196; c=relaxed/simple;
	bh=qZuO+bWj9QbruQ1DZ5TfWss4kzqoIm5Q4+D+Uzgs0Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWa4FJGcEY5gs/Tc8oFb853RIMPtZPwUeMm7C9tjFrKk2iCvLQnkLMHVLQY7gnunTrGU29GynnQprr8ieuUWTK9NcTfcAc/amN0GltLeFOzjF2cqSz5O2lwcGne/4ftjsOvHkegtNTCNOXdV73ulqFBd5DubEAlVGrA2V/hSqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwrOxElx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BA8C116C6;
	Thu, 20 Nov 2025 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656195;
	bh=qZuO+bWj9QbruQ1DZ5TfWss4kzqoIm5Q4+D+Uzgs0Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwrOxElx3JHE/FCsAWLiwngvD24y/HohRrQuvDkBCMJFZZ/Tei1t5Jatap0xr74cA
	 SFpPun9KwBUe+g+IKZ+nDIyuxh3/vn8dIyxdRihCJtMjfFJcy6BgJr9tU8Wx/9qogL
	 EpWLkh6zgFumqybSEwW++vDH7Ee0UHJWdFrkyPmvvOkUCJHqjJA5eEXXmxcOeokcmK
	 ar260723ZSy8i4xOJd5Ft8kvafpzXmPMToHHUbh5BfLjsTdyfVaC1BO9yGZZrZJh4O
	 vksot33RiBh64MDe8MQReuJogRwT1mGBLERqud6X+LJkpEWgjiAkTo1xWT8qXiodSF
	 /IEQiSjHqNeMg==
Date: Thu, 20 Nov 2025 16:29:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] x86/hyperv: Use savesegment() instead of inline
 asm() to save segment registers
Message-ID: <20251120162954.GA3330456@liuwe-devbox-debian-v2.local>
References: <20251120134105.189753-1-ubizjak@gmail.com>
 <20251120134105.189753-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120134105.189753-2-ubizjak@gmail.com>

On Thu, Nov 20, 2025 at 02:40:23PM +0100, Uros Bizjak wrote:
> Use standard savesegment() utility macro to save segment registers.

Acked-by: Wei Liu <wei.liu@kernel.org>

