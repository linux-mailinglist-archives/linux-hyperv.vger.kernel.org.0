Return-Path: <linux-hyperv+bounces-7188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7519BCEB8A
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 00:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA119A21A1
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A6276048;
	Fri, 10 Oct 2025 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N80/HoPk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223781F4C8E;
	Fri, 10 Oct 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136578; cv=none; b=fnjR2MDbdmJqVe/hevovi2VbkorZ+DCPJP2cghGlt0iHfvHmrE9PqaXcYFVMfl/uQ88FBKHoO8u4Jxbjitah41iqha2gj68IL728ZJLtMrtLpyP1gsVZDrE2d73s/oaJKUVQUwdClrFTtTxjpykURhwI2TE+p1Q4zhXeEs3FYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136578; c=relaxed/simple;
	bh=utW0Ey8ri/x00Pxu2qEp6HZVbsMvKfPEAWCDeIITY84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKHUDgDUGsHZbJ18z0laobQEipVIDWXD1yH566tN7jxivJiZK5LENgtjEyHtVhBi075ySO+Dw+oFg2VH0cViZTod8lNJGLna6jBx+CUZo1bg3VfqF4J+t5WX4f9tcGS3WfzPRA4JOeC+MXbBAnabYH6BSbrEqKgH3DGWU3BDjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N80/HoPk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70AD2201601B;
	Fri, 10 Oct 2025 15:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70AD2201601B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760136576;
	bh=hWcYr0BL80j1/GbQO+qD+sJ/rTwwhTaXjPpTotUU+FM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N80/HoPkGqSf8ltsZ3heGflwl5ZmvpDg2yH5g3zRVmU752Y5vTJrQWz8n9+N3zelo
	 gf8AQyh/Id5h2/wokEwIvmkYjT6K2LC0stirGquLI4w+0/sOWkPlAEcjqUHMrVd7tG
	 QbdjFiF0PnYa5MMWBiHZZslat0ml08tYyHXOrmAY=
Message-ID: <bbc67703-ffed-4ed0-aede-4e569236454c@linux.microsoft.com>
Date: Fri, 10 Oct 2025 15:49:35 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976317202.16834.13905194415092065784.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175976317202.16834.13905194415092065784.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/2025 8:06 AM, Stanislav Kinsburskii wrote:
> Simplify and unify memory region management to improve code clarity and
> reliability. Consolidate pinning and invalidation logic, adopt consistent
> naming, and remove redundant checks to reduce complexity.
> 
> Enhance documentation and update call sites for maintainability.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   80 +++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 44 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

