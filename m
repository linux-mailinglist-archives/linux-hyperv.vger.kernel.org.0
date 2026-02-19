Return-Path: <linux-hyperv+bounces-8915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGRLmKylmmRjwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8915-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 07:49:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D215C79C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 07:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C62C2300679B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BE31AF15;
	Thu, 19 Feb 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZGxoTq3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A23090E5;
	Thu, 19 Feb 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483744; cv=none; b=tSa7vrZRZftb33vBIt7Qo0fyhDU52rd+33elSFd2kyD+TTIl1AkDm+92vyQS7FNjpXisyS5c0IV81TOUm8mLhIbF+KG65NqPefn9XwVPw4iaBfmpEiMJfrw38lLZqg95iow+d3B/4pL0V0oJqyj715m8ogkUJncewLglyBfWVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483744; c=relaxed/simple;
	bh=YlAebUXAN1PXliaJkMhI/1o1RSDlm6w8Cd60Knx4M5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfXh5DE9jSLfxNS8ey0kPasF4FIci+iGamEwKLk9P6hp821NMocjz0/S8ouqLp6Jp8MKjiwLMZYjCjaQxdRuFMP9N9i8TQqmaTFBMKcgeNDbsPxxAGqIrDQQW3OC8wIgShysCAHZ9/T/nreiyvXaGetwzAqN04L7+zw9dhCSIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZGxoTq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437DAC4CEF7;
	Thu, 19 Feb 2026 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771483744;
	bh=YlAebUXAN1PXliaJkMhI/1o1RSDlm6w8Cd60Knx4M5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZGxoTq3ZCZ1JBz3AiO9Do/JkRHqYvDfWC78Gvm5JxfF/H7vC8o4flgb1M6o6ckvu
	 eyjwT0ouLb61Ju0QtQE5lWvPoSimjLEoBFgwJf5peY3Mcbt5vy9BGpXf3dNur8/653
	 JtYB9MNjIqH/4w+WErzUO9wHePXDc/bfMLTxxmGgGkDtEjOmj8qv5aQwuhRXFOQjxW
	 1O7SM9ifa14lTcMxgq0v9rGVMiySG3CIou/WAaHB7Va87J18cb4XDSee8mYI3jhCcp
	 aarAe0VOUlVBJjIMtzZ3k7N79psNnsWpz0u9yWxnlhv6b6yyxmeiw8MjziKnZxCFPf
	 MCdaoqzNgOPzA==
Date: Thu, 19 Feb 2026 06:49:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Improve Hyper-V memory deposit error handling
Message-ID: <20260219064903.GR2236050@liuwe-devbox-debian-v2.local>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8915-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 636D215C79C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:42:04PM +0000, Stanislav Kinsburskii wrote:
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
> v3:
> - Fix uninitialized num_pages variable in hv_deposit_memory_node() in case
>   of HV_STATUS_INSUFFICIENT_ROOT_MEMORY status
> 

I fixed a typo pointed out by Mukesh in the previous version, dropped
the note from the commit message in the last patch, and applied this to
hyperv-next.

Please address Michael's comment in patch four and send out a follow-up
patch if necessary.

Wei

