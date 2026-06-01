Return-Path: <linux-hyperv+bounces-11431-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG2bF6mUHWrOcQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11431-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 16:18:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3F620AE4
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7655E301301F
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F63B5820;
	Mon,  1 Jun 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iqQvugAm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC593B27C6;
	Mon,  1 Jun 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322522; cv=none; b=h/HTnnbWo9eM49P26ek9uNyqaHkSgg673UKGziuFtyq9BuvI2Nr2IbTdI/3sNUetXrtHobnZOPNGIkzP5PzXLaE3G/VbhucjnDhfH+bnr05kWBbfhVp3G9arHRefBE5EI7fHzqKr7NsP+XiDktuvpZzh/0qCa9qHbOm3bBE0Wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322522; c=relaxed/simple;
	bh=ah6j4Gj2LOrt7SgWxqwHO3lXkONLbw7YjCRvT9SH714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP/NNPCwmU0GoxVocSfKOPMLT9iVO9JkzEoVzq0OgVN5pRwV0SKkcbWkO3N+86v2n1GCJToqdoDbVnTUZB7QVe5Zm/iauoGlfcHRIkDj2owbgEa2Wjx4TohrxvyqXaegNWQBibzT9tN5QqRf8fOJD/vMFdP2nEtSPy50yihceP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iqQvugAm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B9FBE20B7166; Mon,  1 Jun 2026 07:01:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9FBE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780322506;
	bh=EcC8oiBSWrZKUG36fS+G6X0zfViyyPCNJtfKczWUozg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqQvugAmtyeiPwjUP+vTRA8RroodNpMYwaeUz9TjyF6j8OPrRuDWHl/uW+MjOK2ta
	 1yFKe88FFz/vDqJquUtDOADt4qn6VkthwM4dJ6sj1afchnVsEBzhLm8rpHrs7JAqTw
	 GBsHJD6dBi5okk1UqzV578yXfx9azvosSv4qZ1rA=
Date: Mon, 1 Jun 2026 10:01:46 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	airlied@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	admin@kodeit.net, gargaditya08@proton.me, paul@crapouillou.net,
	jani.nikula@linux.intel.com, mhklinux@outlook.com,
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
Message-ID: <ah2QyuW9/CUoPy0e@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-8-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530185716.65688-8-tzimmermann@suse.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11431-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,broadcom.com:email,linux.microsoft.com:dkim,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A0B3F620AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 08:53:20PM +0200, Thomas Zimmermann wrote:
> Nothing in drm_atomic_helper_damage_iter_init() requires the old
> plane state. Remove the parameter and mass-convert callers.
> 
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Acked-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> # hyperv

