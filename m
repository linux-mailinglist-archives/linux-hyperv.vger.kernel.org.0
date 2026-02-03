Return-Path: <linux-hyperv+bounces-8685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFt3BNh+gmnAVQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8685-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 00:03:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B8DF867
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 00:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B1F13023003
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6E28725D;
	Tue,  3 Feb 2026 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AQ6UKaA2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEAA256C8B;
	Tue,  3 Feb 2026 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159827; cv=none; b=LN3G+8CdJMiSNP19qhPqwzOwlbyWrSBD0yn5JSZco739MzpfGQuqi91CI/bO0f1q2pBDANPoqzTe/sfzrC2giAucbnBATw/7EhEAAyssfIkZDOpvU1a6q777menE3X8tNpjVCeKDPRBX0Q0JgiTCTxn9f+xfZx3K7QLNRoUnEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159827; c=relaxed/simple;
	bh=M4qLAT+nrYBVB1VLraX52FiSLQynnh5Sl7HlW6Y2iek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9vWBdlgvWsZwmX64ekx8xoXcSCj0qLGd0IWSl9C9PBUXgoheVCbYUnXN7+p5yO9UflJ62sPfUExbvgEMAMsoVXSjUfGBaK/CBhQL2UIAOCThJ9F57uk9mH8bZ6iw+yLEukRkVjMxDnofubGIUF/v4UkaIzSB94/jAf/kVk6BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AQ6UKaA2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E6A820B7168;
	Tue,  3 Feb 2026 15:03:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E6A820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770159826;
	bh=6hzK3Q8RvwkBme3HNEU0vmRwz+DrLkRcyVcSS7kBUZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AQ6UKaA2+kBf4WqdYGgQb2tE5ZT0525M4Rsv9zXXIqc1AMuEPquLmbhIn+DaOaR11
	 RFzOXCroZ52UPH106ZqqMIkxIZmlhDbz016kq64yvQhlofCTOgi5004+M43Rrt0dE5
	 4pvBV6nIt/WSyWHVS3T3xz+ZCeDwLcV3dWFbJiJQ=
Message-ID: <617915e0-f63b-2f0d-e285-2c968a992486@linux.microsoft.com>
Date: Tue, 3 Feb 2026 15:03:45 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/4] Improve Hyper-V memory deposit error handling
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8685-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A92B8DF867
X-Rspamd-Action: no action

On 2/2/26 09:58, Stanislav Kinsburskii wrote:
> This series extends the MSHV driver to properly handle additional
> memory-related error codes from the Microsoft Hypervisor by depositing
> memory pages when needed.
> 
> Currently, when the hypervisor returns HV_STATUS_INSUFFICIENT_MEMORY
> during partition creation, the driver calls hv_call_deposit_pages() to
> provide the necessary memory. However, there are other memory-related
> error codes that indicate the hypervisor needs additional memory
> resources, but the driver does not attempt to deposit pages for these
> cases.
> 
> This series introduces a dedicated helper function macro to identify all
> memory-related error codes (HV_STATUS_INSUFFICIENT_MEMORY,
> HV_STATUS_INSUFFICIENT_BUFFERS, HV_STATUS_INSUFFICIENT_DEVICE_DOMAINS, and
> HV_STATUS_INSUFFICIENT_ROOT_MEMORY) and ensures the driver attempts to
> deposit pages for all of them via new hv_deposit_memory() helper.
> 
> With these changes, partition creation becomes more robust by handling
> all scenarios where the hypervisor requires additional memory deposits.
> 
> v2:
> - Rename hv_result_oom() into hv_result_needs_memory()
> 
> ---
> 
> Stanislav Kinsburskii (4):
>        mshv: Introduce hv_result_needs_memory() helper function
>        mshv: Introduce hv_deposit_memory helper functions
>        mshv: Handle insufficient contiguous memory hypervisor status
>        mshv: Handle insufficient root memory hypervisor statuses
> 
> 
>   drivers/hv/hv_common.c         |    3 ++
>   drivers/hv/hv_proc.c           |   54 +++++++++++++++++++++++++++++++++++---
>   drivers/hv/mshv_root_hv_call.c |   45 +++++++++++++-------------------
>   drivers/hv/mshv_root_main.c    |    5 +---
>   include/asm-generic/mshyperv.h |   13 +++++++++
>   include/hyperv/hvgdk_mini.h    |   57 +++++++++++++++++++++-------------------
>   include/hyperv/hvhdk_mini.h    |    2 +
>   7 files changed, 119 insertions(+), 60 deletions(-)
> 

for the whole series:

Reviewed-by: Mukesh R <mrathor@linux.microsoft.com>


