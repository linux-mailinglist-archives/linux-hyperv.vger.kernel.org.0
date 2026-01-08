Return-Path: <linux-hyperv+bounces-8196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E999D05F74
	for <lists+linux-hyperv@lfdr.de>; Thu, 08 Jan 2026 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECD3330019F8
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jan 2026 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86133148AC;
	Thu,  8 Jan 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iyAxf7QT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679F284684;
	Thu,  8 Jan 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902607; cv=none; b=sc8ciGnTGNzKAxDjdIBoQZRsuPGBZ3YUmRcXvRpjZPFD3jEl6Qnsweh+TaaNofoePGQFDug+R+WXq0XxNkwHIyo+iaI2xUiznwvS4f7Vmq1FnitwvUnhbmrdFdVopZl3WQQOd9TohiBb/MSuFOq0gxQm5vWJAOp8GmY/RLMsq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902607; c=relaxed/simple;
	bh=xT1YWrNNd8xLx4uikI9DuowmJgibeH9vJ42OIJA6Dv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDe2e0TXwrfUcHOWFuGxHhAJphjMTtN1sFgMOJjgc+ximqdb8Yjlvu9u9bBnGaUVITna0xFmSmkmibX0+4xb25zSfWVAkJQq00xs3pS4W5mWdekzeKkWy9ltahaAgW0ZuSi36loE2yEegVhZ2GbylPwCMgKrmzIwXILx5A0O8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iyAxf7QT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.206] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0E75A2125396;
	Thu,  8 Jan 2026 12:03:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E75A2125396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767902600;
	bh=CDJ6iRDC7HFAeZDc7qqM3Drcfscp0HmyA4zqD4iMK8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iyAxf7QTJvsLtJcDExrZjjAZa8eG/npE8PGQg8P+0BHIueCSwrk+FgN2Rp6t9VhRL
	 Yys57aJnOkXUrYmjO4zxii+AGzwJv5hbc0wi0CdOa69wtnQwIbx+kzBlXDZSN5KJVA
	 CckjqyiVSiEao8W5cB3OHHtrvnzgsn6KgHt6ehxI=
Message-ID: <f46b9c60-a1d5-4d2c-9aaa-d4ba738f1491@linux.microsoft.com>
Date: Thu, 8 Jan 2026 12:03:19 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mshv: Align huge page stride with guest mapping
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176781093198.21595.6373086133020540990.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176781093198.21595.6373086133020540990.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/2026 10:45 AM, Stanislav Kinsburskii wrote:
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
> ---
>  drivers/hv/mshv_regions.c |   93 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 31 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

