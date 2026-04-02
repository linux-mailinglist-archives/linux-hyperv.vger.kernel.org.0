Return-Path: <linux-hyperv+bounces-9919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNr5Ovytzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9919-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 19:57:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9038CCBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52410301A409
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2AE3D47BA;
	Thu,  2 Apr 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KcY8aOXH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398133C9429;
	Thu,  2 Apr 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152633; cv=none; b=aLkL3kMi03CV5HFQ7DDZIHoSV0xnGGEUieHzSqjDartQT9dwLuCYkbWeof4k9zaNrm9/EyT3j1ISiqhWVQMP4ZqiSQKyeFu1xL3lZbRd1A7DI1p8kndMO6vobhSoeyNhqoK0FdtAZBqgdlKpvz2bVmiXkBL6edY9JmAhkWAkTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152633; c=relaxed/simple;
	bh=CLYm4aP2ClMxsj3IfT1vok6re+4DGSxJmLWmbXJQBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQHDZ4VwoPbx0OaYoA52MuqlZMenkc2zpOKh30sbN3v0HjVZAVxrMZhd5IBEnFIf4WaCUexBL9WjRlUL8d3gXAGnsK/kzckITuqt+90U4t7J/QaKG7yFvhIUnWTWjDlcEpZlI2YzpdyENsQCZSnrA9oZlbKEDBBz3YsQy84VfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KcY8aOXH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id B74D320B712B;
	Thu,  2 Apr 2026 10:57:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B74D320B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775152632;
	bh=1o5UsYphC63IxqO4PYP93hmGRUndCMD0kxbG9B8uhAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcY8aOXHrhFoBn8mZbVfdq0k6sYoYAhqg/WGspuidNHrDxJtAUrp2iD3Ndy4FRt2l
	 bJKKX+dIq9VC9Y7UHrrZ3uEZxTWEdJLAjNq62eoQkd+wGJd1xZfhj3PuQht11xLz96
	 vxva0+kRY9Jl3MPkalt+RL1DXMk+PqX68SEO5nWw=
Date: Thu, 2 Apr 2026 10:57:09 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mshv: Rename mshv_mem_region to mshv_region
Message-ID: <ac6t9d2CIvL469_t@skinsburskii.localdomain>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-fervent-thick-boobook-45dba9@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-fervent-thick-boobook-45dba9@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9919-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 62B9038CCBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:33:24PM +0000, Anirudh Rayabharam wrote:
> On Wed, Apr 01, 2026 at 10:12:40PM +0000, Stanislav Kinsburskii wrote:
> > The mshv_mem_region structure represents guest address space regions,
> > which can be either RAM-backed memory or memory-mapped IO regions
> > without physical backing. The "mem_" prefix incorrectly suggests the
> > structure only handles memory regions, creating confusion about its
> > actual purpose.
> > 
> > Remove the "mem_" prefix to align with existing function naming
> > (mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
> > this structure manages arbitrary guest address space mappings
> > regardless of their backing type.
> 
> I don't think the "mem_" prefix automatically suggested the backing
> type.
> 

What else can it suggest?

> Isn't mshv_region too vague now? Region of what?
> 

The region of address space, which can or can not be backed by memory.

Thanks,
Stanislav

> Thanks,
> Anirudh.

