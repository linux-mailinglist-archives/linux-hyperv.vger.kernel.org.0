Return-Path: <linux-hyperv+bounces-11189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ee1xC4drFGo+NQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11189-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 17:32:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A05CC509
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A5CE3000FC1
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7927CCF0;
	Mon, 25 May 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E/6AMGVo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FB238159;
	Mon, 25 May 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723141; cv=none; b=KDRjeYzcywSC3pbmf2OZpO4n3DeFiwgn60vqAtNqI91JxHuBV+er+Nslk6qxMD2CSJnaqnk+HlFE2x4+Tah7buE1jj/RI/m5x8Tco8sH5MjwhqHH8yX0J6duBwAQH2eslsXSOnyja9bdvY9pYZdkZMFtNIO8MgwBRW6Agoo5kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723141; c=relaxed/simple;
	bh=4Qc5CsRmwQt6pJnHqGWkb5bQB0iWdCR+1i+buvZaoAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH00xTgyrIw2a18h7Q+0uP7zFECxqLoBqU5CzQlDBmg9KqF6VM2ne0iT61nKoMgAU8zSHNevvRqS3gVxRUhrEErrxY0xASDLQX9J52PKyanuQpmdeVnaWFU8U9W1nwQSvUSu9ABz84jZm1qkr+Ams+cHWGhfj41F7OCq68ZSsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E/6AMGVo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 59B8D20B7166; Mon, 25 May 2026 08:32:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59B8D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779723130;
	bh=bwMuIe2pYJ9lckE+M2axekk85mrakFk9ZnH9KNYYavA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/6AMGVorOZ3AXYjoUxkF9z/jlIXSHy+Rt01CpmS+2Uoew8uCOtiDeJ5QvIbh7z9d
	 ACcD2sm7tXjyB4LqTt9zY+DR9IBJ2cZDlL3H7XDhEEn4ZNAooNpvEisH6sRV+mmBbm
	 Ddo2q8/ZTD2RzL1sLbyqaXDtE2If2A8bx+aoyOFg=
Date: Mon, 25 May 2026 11:32:10 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Berkant Koc <me@berkoc.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: Re: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Message-ID: <ahRrehOc3ypcxOpY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1779542874.git.me@berkoc.com>
 <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11189-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[berkoc.com,linux.microsoft.com,microsoft.com,vger.kernel.org,lists.freedesktop.org,kernel.org,suse.de,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: B90A05CC509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 02:57:24PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, May 25, 2026 4:36 AM
> > Applied, thanks!
> 
> Hamza -- which tree was this applied to?

drm-misc-fixes

> 
> Michael

