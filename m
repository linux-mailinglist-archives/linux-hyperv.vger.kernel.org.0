Return-Path: <linux-hyperv+bounces-8273-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B67D1A8F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E322D301141B
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE672512C8;
	Tue, 13 Jan 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eG4/ug25"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447302EBDC8
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324598; cv=none; b=g6CGZyZzwFJxaHF1nqUq6SndAV6f0hm9pW8BWMbwVRp6iEKlQ0CiW5GNW5L2FQm5cI0Anf5f438U92AX5t7uZct159qKrBFhgaWNiQXBj2BEpGJsy29EbR2N8SMsrc99rrdD/DzLhh1Oru1e5xvYkLe298o210c2gxzm2oEhX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324598; c=relaxed/simple;
	bh=CAxd3/8RG7FjNNHAVA9sz43qFhdE99Vuwm2A5lV4mUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNMUGWlK6D4I6Ub9hWOPKd5dspzmPqVv+hnsZedU2X2s+lXg+Vqp9U+661OviFJrAGbI1Yd8AyVILEE5lSmivXiiQakclj9UnHv7MPt9yy9KsVxUCq8LReKQ3uPyVyzX2h0adgBcvcguzLDdO/wJL/1hWPWkcNH7PJBiTK2OwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eG4/ug25; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.112] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C903720B716D;
	Tue, 13 Jan 2026 09:16:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C903720B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768324590;
	bh=h+TzB4/Hjzw0CJE8nk+VDEnr9Mf0y9gH672OxFmHyqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eG4/ug25usJQ5VRy9U04wm3piHawlT3iHk6xpYJv2qGHV6ttsF/ghCkE9XASL4dFQ
	 kq3jxjpRkzaUuDl/4BOHY/DA2ZXrrA3q67tXv3DnyWMivnrIyKmkytznOtCT6+9Yx/
	 I1+omJ8TvCeXaQKW+guWnsK4d9to/0QazNxzC4yE=
Message-ID: <c8c4d00b-b5dd-499d-92ae-41f35cc1ae86@linux.microsoft.com>
Date: Tue, 13 Jan 2026 09:16:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mshv: make certain field names descriptive in a header
 struct
To: Mukesh Rathor <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org
References: <20260112194943.1701785-1-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260112194943.1701785-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/2026 11:49 AM, Mukesh Rathor wrote:
> When header struct fields use very common names like "pages" or "type",
> it makes it difficult to find uses of these fields with tools like grep
> and cscope.  Add the prefix mreg_ to some fields in struct
> mshv_mem_region to make it easier to find them.
> 
> There is no functional change.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c   | 44 ++++++++++++++++++-------------------
>  drivers/hv/mshv_root.h      |  6 ++---
>  drivers/hv/mshv_root_main.c | 10 ++++-----
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

