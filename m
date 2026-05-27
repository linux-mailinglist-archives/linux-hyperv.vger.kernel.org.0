Return-Path: <linux-hyperv+bounces-11256-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAInNc9qF2oYEggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11256-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:06:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D025EA894
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3016E300CFCE
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728A3A6B9A;
	Wed, 27 May 2026 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfO+7Q8l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F203590A9;
	Wed, 27 May 2026 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919543; cv=none; b=GfIVbZ78yACaC67h4rw7LKLVk3iSsUkyZjYdL+GTQSswczwWLyffhjtG5QenZ0YwVVwYTMqZK6ljQ8YJYpI+SDhbpXyqOMByxxfwFiR9yZyxi8tdb8kZ8BcRYPzZdbVoSrerK8YWlBxKlzZr+Bbo0GXCK4RxD0JF5a+TM6NMGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919543; c=relaxed/simple;
	bh=J9E8UDYrSityZD3SfSkIF5MMGCeA0y2oOdz2uJcFE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgihpFoxKqaBW0+9EfQwSyJFeTnoo+5F9Ik2AmaPQB5Fyh1tzJ0ZYIE8mRj3L80UTQ51mUi232dcbnF3RNeRFsjUNCBuvYqoQRKCy1CBOIClmRItS3Yl8aYgkhlWElmHD6fNXTVWrHaBzszED8xkSaXh/URXVx1UrgrRsASSbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfO+7Q8l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492761F000E9;
	Wed, 27 May 2026 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919542;
	bh=Wb9exkeDHRidtV186uF3t74XUJIa+JbljNTHeKf8E5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HfO+7Q8lcA4ntGs4VO4RVQ/+FttYMkmy8PVEn/5QzQ7BUBpdlVsZO88Tg42QwXfYr
	 4ppwLL3MxSvJ76h6ZfZYD0z5JVL3rPBUTsO/8HH8BU2QSp0dupXtXdUg/u/YCpL3/i
	 eyms66DIBbXXIVRWOgPeLdLEUl4KBklyf/JFIUJqfCclOsjE8DOSCdH43qjy4vDyHS
	 xxbZ5nLv9cPO9/R8ogg/yrL9Tys9KQcBWLoVlR17CGpfxXaLafpFIRZxmSgJEqoiBJ
	 gvN7okORybgkteqYa0RVdm6XG2PI5O0CI4795ksJYY+X1k5I6kk5jhw0yGDn7r4tvQ
	 34VxWURuArivA==
Date: Wed, 27 May 2026 15:05:41 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Message-ID: <20260527220541.GA3518940@liuwe-devbox-debian-v2.local>
References: <20260527192101.1471995-1-decui@microsoft.com>
 <ahdNVLMHrSgpVKwr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdNVLMHrSgpVKwr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11256-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44D025EA894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:00:20PM -0400, Hamza Mahfooz wrote:
> On Wed, May 27, 2026 at 12:21:01PM -0700, Dexuan Cui wrote:
> > Change the "64 bit" to "64-bit", and the "Os" to "OS".
> > 
> > Remove the obsolete paragraph since the guideline has been
> > published in the Hypervisor Top Level Functional Specification
> > for many years.
> > 
> > The "OS Type" is 0x1 for Linux, not 0x100.
> > 
> > No functional change.
> > 
> > Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied. Thanks.

