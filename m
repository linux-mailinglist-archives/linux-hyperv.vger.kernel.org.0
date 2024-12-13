Return-Path: <linux-hyperv+bounces-3475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1512E9F14C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 19:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81839188E382
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419371E25F8;
	Fri, 13 Dec 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VHQcDoDp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12652E62B;
	Fri, 13 Dec 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113501; cv=none; b=cYaldazaSkIHmmcmJNDYpnsw55nbGBelcidK4xDCBhAKW42lQAWskaVRFpkfnBoDZY9qnzJe6FhJWdJ8Hv7CnQ1u2zKS0EA65faRaGq/h8JsXcWR/umoXRLguP9ombzLwnJnYhztKfUFW3Lr+BUOTOyIKUAw89sW/mbGJNiP0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113501; c=relaxed/simple;
	bh=ZnHhb2vByqDgBiP8p4vw6rgdi7yMriFaj7EduSNQjiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3vSz/zV2ZpWMfAmwAucvMTeAmTPq0m34YIijmpMfuqFbNYaGemdti7Y+EM+KYyHIytLvmZFoKhiTOCPZXtf+QK2v36rIZCqIpq5Qn3m/ebcjpqCbW3jW/ISoPYLadpYmhk8ZOQcV1e4yfQK3ySShZ/76Plcnlm5zuGLtylmfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VHQcDoDp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2139020BCAD0;
	Fri, 13 Dec 2024 10:11:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2139020BCAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734113499;
	bh=cPPK1bn0vhXxwwcxKvq6ENI1pEVUPomPB6DAj4X/JKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VHQcDoDpHSKAAUEAuDHBAso76ItH8kTKPXkw6rvP5tTZulAwVZRQ+U3IKxyNIBuZM
	 iWuyRfgefvLtIEZ17Qi51ucnd+AOxJj3NmWyUqFdJN2tHOQWzrcvbxt1xxeAJfHt0Z
	 xfqMuPzEenEeAVlNhVHM094kXIjFQErMD3UUutqk=
Message-ID: <08380797-4dea-4dc3-9312-7e4c69090cdc@linux.microsoft.com>
Date: Fri, 13 Dec 2024 10:11:38 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: hv: Fix cross-compilation
To: Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com, avladu@cloudbasesolutions.com
References: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, LGTM!

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

On 12/12/2024 12:28 AM, Saurabh Sengar wrote:
> Use the native ARCH only incase it is not set, this will allow
> the cross complilation where ARCH is explicitly set. Add few
> info prints as well to know what arch and toolchain is getting
> used to build it.
> 
> Additionally, simplify the check for ARCH so that fcopy daemon
> is build only for x86_64.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>   tools/hv/Makefile | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 34ffcec264ab..d29e6be6309b 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -2,7 +2,7 @@
>   # Makefile for Hyper-V tools
>   include ../scripts/Makefile.include
>   
> -ARCH := $(shell uname -m 2>/dev/null)
> +ARCH ?= $(shell uname -m 2>/dev/null)
>   sbindir ?= /usr/sbin
>   libexecdir ?= /usr/libexec
>   sharedstatedir ?= /var/lib
> @@ -20,18 +20,26 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>   override CFLAGS += -Wno-address-of-packed-member
>   
>   ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> -ifneq ($(ARCH), aarch64)
> +ifeq ($(ARCH), x86_64)
>   ALL_TARGETS += hv_fcopy_uio_daemon
>   endif
>   ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>   
>   ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
>   
> -all: $(ALL_PROGRAMS)
> +all: info $(ALL_PROGRAMS)
>   
>   export srctree OUTPUT CC LD CFLAGS
>   include $(srctree)/tools/build/Makefile.include
>   
> +info:
> +	@echo "---------------------"
> +	@echo "Building for:"
> +	@echo "CC $(CC)"
> +	@echo "LD $(LD)"
> +	@echo "ARCH $(ARCH)"
> +	@echo "---------------------"
> +
>   HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
>   $(HV_KVP_DAEMON_IN): FORCE
>   	$(Q)$(MAKE) $(build)=hv_kvp_daemon

-- 
Thank you,
Roman


