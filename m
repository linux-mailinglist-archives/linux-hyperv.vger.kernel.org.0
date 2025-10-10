Return-Path: <linux-hyperv+bounces-7189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2EBCEBB1
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C2319A31E1
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D227B333;
	Fri, 10 Oct 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qn/mYYpt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA927A10D;
	Fri, 10 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136843; cv=none; b=aoZcmlj1hB7J45s1E4/juwQ0WB3j+ZrseX5Lp4l7piIpCjXRO5sqQD0bH28bMWHorvux9zwOg565LjUZ3QhRlNyLisKZ0nVF6lUOcCK2nyTz+8gTY5heWtdunrwD9ad4TVtyCxXxTt/bqN7A0Yp0toEV/ZBC0nqICMJEuCiy84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136843; c=relaxed/simple;
	bh=dC5O/oAKoeWMJKmrtBTHsUupdBG570w4tC1m/z3q1ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ8/VFx6zZ+XhM1BkvLK7UKH2886NIac0KXL3He1q/ys7ggCwztx+4FQxcV3eWNrUYij5YzvxzksweF/9Dnkzv2Wf46LzYDFhCwR6AYgTdApoiJ2TocVjtNTRwI/vEDniXjayW5eQgrKydivT6BNGIbzOcfpfbbrpU8J4Z93Ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qn/mYYpt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F5982016012;
	Fri, 10 Oct 2025 15:54:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F5982016012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760136841;
	bh=DIt1F6mJQXMR+k/QGp+q+hT6aqDU/x9G2ahh2m5zay4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qn/mYYptZX895is+0GgCZE15F08EFz9Iz0e7EFq9+DCNnRb14UHKAP1WwDSUCa0yx
	 QXiGkh3pn0HDRR3leGgUFU5XUu/pQX8uuCQTkmSIjDIeBIrfey7JiTqWtYY5roN4Y3
	 Ge3sBzVAjcy54pyrgj/XdlZBhtAZbLL2duSEkkbk=
Message-ID: <2ad6b120-bbe5-4d81-84b3-66b892bd0abd@linux.microsoft.com>
Date: Fri, 10 Oct 2025 15:54:00 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] Drivers: hv: Centralize guest memory region
 destruction
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976318116.16834.6830692842208026430.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175976318116.16834.6830692842208026430.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/2025 8:06 AM, Stanislav Kinsburskii wrote:
> Centralize guest memory region destruction to prevent resource leaks and
> inconsistent cleanup across unmap and partition destruction paths.
> 
> Unify region removal, encrypted partition access recovery, and region
> invalidation to improve maintainability and reliability. Reduce code
> duplication and make future updates less error-prone by encapsulating
> cleanup logic in a single helper.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   65 ++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

