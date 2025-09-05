Return-Path: <linux-hyperv+bounces-6758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B51B463A1
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BB1CC063C
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813992773DD;
	Fri,  5 Sep 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iSDkGhF2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D21B0437;
	Fri,  5 Sep 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100567; cv=none; b=hOQ2Rbx4SuQs402sSZn8hc520oTOomeXdBn/7FYhGw6MMh+WuimbeWVaJvYR03TdDG2ly0Ks6AIQcGajkTlJmR2k2NNqRr2O1krMH+GWgiHY0foDLsjriZ6+FiGqEd4jyktL20Da5ds8h3OAZ9b8QYHsZFGOjq44ratUG8WyRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100567; c=relaxed/simple;
	bh=t/Gbd0D1Y4LEURsKSusLQlQCu2XtrS65coyw4ghDecg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C/G86I8bQzr52R6E7NU/o1N4+Ew4GmURyNDWP7KV5N1h61oPUEftvad0+0/T1DPSSTgjBFHOxVemOdEtXQhNPOhCFYckxjvqudLIRq5nU6CSG2RxPExde8lwSJ4dq1OK/AdHtuse9iG1hdvJEtOMdFHbCS48coZ7D5fsGWkPJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iSDkGhF2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98AD520171D8;
	Fri,  5 Sep 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98AD520171D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757100565;
	bh=pgleaDXSAORJCqkPGnQpur6vzll0l3Eeg92flRbqf0c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iSDkGhF24xzKWelBJZyylItkAaczJFktbXL1GmfKK1r/alYvEOlnFPMq9YaKx6Fx4
	 t8GHztMW0t5TPSptqiEgkIzwpcd5GGXfL+ZhKSvTVHlVZNb6BjSK2fPhin9blkJpcv
	 fOJwHeN4GV/wQgv3RElNs2paCgxpc+AfgdWKAQHA=
Message-ID: <be786a72-9cad-47b5-af97-01209baa0c96@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:29:24 -0700
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
 decui@microsoft.com, paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the
 hypervisor
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some newer hypervisor APIs are gated by feature bits in the so-called
> "vmm capabilities" partition property. Store the capabilities on
> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h      |  1 +
>  drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Looks good to me.

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

