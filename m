Return-Path: <linux-hyperv+bounces-6759-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F53B463D1
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD373ACC03
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70927F732;
	Fri,  5 Sep 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QnBQBWbn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B113D539;
	Fri,  5 Sep 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101294; cv=none; b=HhSm7XyV31/vFUq5JrYKT+xHBSE76qTQBhQEABux6ifz6XGQhvDCyAcG/8I7dgu3Un8QGBGD1p15DXZGQI+WJ2pow7oafUcP7B3QtINXspuSU1SnIs65fjq69CBB6qvi/+YfBabner+NIFzf5lrxqOw3+663B3Qx0DM08u4eRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101294; c=relaxed/simple;
	bh=KBpbqGyM1E7MXzUraG/0ZIzpcraPyNRhpczvq4A8FfM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UE6PTvrf4X9kBU87oO3ZtC/HqdK58FRkGvPmPuEtypDZsyJDNYJ38B5bfliVFL19NElNt4+G2Tz53uV5c6NeEGMobUR8v6HCE2X2Fu7cl5FP9VMaLJ8ukxt6znwPnnrSk8pGO/uQ/+4uzEJfGykn93J8ve3kIy0WdO1OfdCrSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QnBQBWbn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC2FC20171D9;
	Fri,  5 Sep 2025 12:41:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC2FC20171D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757101293;
	bh=YKJHhWpszRn+EHunpL4JLvNah3xSLZ98o+1VZyKQzsk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QnBQBWbnE6PSvrpokflvR9GM3kShGHjnEHHIHren524tAMuE4Dc9SZY1GAkXJK1J5
	 A2UHQrrcQw+9qUkDDv2Tg+1TOOv5sLQ45j5yx621oCiFBmLCQlnzpQp2oz6y25+iBy
	 jEiyT66H8KtLIHz9w1q+Dwd4l3rflX2dyXOG+KwM=
Message-ID: <efb80064-6eb3-40c5-bce0-18733765768a@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:41:32 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, paekkaladevi@linux.microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH 5/6] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-6-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-6-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 
> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> allocated and passed to the hypervisor to map VP state pages. This is
> only needed on L1VH, and only on some (newer) versions of the
> hypervisor, hence the need to check vmm_capabilities.
> 
> Introduce functions hv_map/unmap_vp_state_page() to handle the
> allocation and freeing.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         | 11 +++---
>  drivers/hv/mshv_root_hv_call.c | 61 +++++++++++++++++++++++++---
>  drivers/hv/mshv_root_main.c    | 72 +++++++++++++++++-----------------
>  3 files changed, 96 insertions(+), 48 deletions(-)

<snip>

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

