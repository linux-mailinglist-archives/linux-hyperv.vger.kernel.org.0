Return-Path: <linux-hyperv+bounces-9348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tqVdG5ZEsmk5KwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9348-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:44:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA926D2C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7783047012
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455E39768D;
	Thu, 12 Mar 2026 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/h4rC0Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F63624C4;
	Thu, 12 Mar 2026 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290643; cv=none; b=AJJGaI2rDV3X+xhT+ETGSS8zkfRI6cZvsOf/MPtvkD3NEas3dXhdcHBmQwhzncz/oQIbbMgp4cpgF8eMVCTwqp/512jH9C2ly8edufjFVKfKF6lBzcJKmjuRgjFJSwbaZglZ/J6RPEX3wZgp8/JrmBwJMJZM5epBq0d5iPnfhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290643; c=relaxed/simple;
	bh=pNQtAGuNoSMQbftL7oQbjLogUhi6yxjmPX2y+E2kUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltyAzywsFawfFLM/FekWcYimNrj3E/bPv7Iz/R8AZgXTnxiEpWXmsWhbOXbWtWysSu9HQOzy2nmPNwFOrQyUorcR2Wp8iyKaY5nAgugNgSMXbAjni9brMhisSni3wZ+PTfqSO5dg2MB5XmOnSw1h11AFePewkoFYBpo3wXokXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/h4rC0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEDBC4CEF7;
	Thu, 12 Mar 2026 04:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773290643;
	bh=pNQtAGuNoSMQbftL7oQbjLogUhi6yxjmPX2y+E2kUPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/h4rC0QEEgmD8rbnUvuFApIKpo0P7xhOrebw7W+v+imzOv5rg396HrcMree+L1bc
	 imqSpkGv2K7O66mvgOzOgRXVDE/Sm4bR/9XhNjYbNb+ENt6ocFmc6IYNMqHDdZM9gG
	 UcpmQ6UKfl9m+OOYu0dklhLs2kid+N1cIXO8HsCKPLOe4qEJ1eAMB9r/rdSNiROtc7
	 G7j96MUCQxqeexnKNZhOKLekMOpOpXikIM+s2ULq5Y13vtg7/iEeUmPBRfN6nKWWe2
	 rp/KJunkgkAkB8dGUbTU6XRbUWQuiIGCeUmJ876dGBVKry0BSKLldP4YU8uFW0PByk
	 /o9dJtwz0XuHg==
Date: Thu, 12 Mar 2026 04:44:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Limit channel interrupt scan to
 relid high water mark
Message-ID: <20260312044401.GA3771304@liuwe-devbox-debian-v2.local>
References: <20260220164045.1670-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220164045.1670-1-mhklkml@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-9348-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,outlook.com:email]
X-Rspamd-Queue-Id: BCBA926D2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Feb 20, 2026 at 08:40:45AM -0800, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When checking for VMBus channel interrutps, current code always scans the
> full SynIC receive interrupt bit array to get the relid of the
> interrupting channels. The array has HV_EVENT_FLAGS_COUNT (2048) bits.
> But VMs rarely have more than 100 channels, and the relid is typically
> a small integer that is densely assigned by the Hyper-V host. It's
> wasteful to scan 2048 bits when it is highly unlikely that anything will
> be found past bit 100. The waste is double with Confidential VMBus because
> there are two receive interrupt arrays that must be scanned: one for the
> hypervisor SynIC and one for the paravisor SynIC.
> 
> Improve the scanning by tracking the largest relid that has been offered
> by the Hyper-V host. Then when checking for VMBus channel interrupts, only
> scan up to this high water mark.
> 
> When channels are rescinded, it's not worth the complexity to recalculate
> the high water mark. Hyper-V tends to reuse the rescinded relids for any
> new channels that are subsequently added, and the performance benefit of
> exactly tracking the high water mark would be minimal.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

