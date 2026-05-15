Return-Path: <linux-hyperv+bounces-10919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFfYLlxdB2qw0QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10919-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:52:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E317555A3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742113114AE7
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED864CA26E;
	Fri, 15 May 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UvGbHkwM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA814C9570
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864221; cv=none; b=Gwod2AAUSUBlAsvG3ml7cAzOGci7okjfnVhrvsZXI9PmppBxYxrage2Jprf5GzwabQSv9+s5fjGtYf49wg8JD9XGza9zwrdhs+zTjywXCzY/bWOhL9bIT2QDfYwoog/UjYzYckuAtTYSzmIY04rMt9Qe1j1ubcozc0xJlXWvywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864221; c=relaxed/simple;
	bh=dhptysQuSATSNbitwVA0RUi7lY73OfdGHsWXJQ9N5cw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aqsDKVyOSTHl5lX10kGw25hjb/CMpN7PaqINycEF+E5r8MERVRlTOjhRX16jUPIWC/J3p3bXpu4wfFT1RqaUPLWMOPkl2cxkZmceux8PW/Ftn7FPqY1asDCLxxb0cKerPG2hKyE4knt+SZyftzGiaKj/BhY1iD2MD8s2eLHqYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UvGbHkwM; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gHCz53wg2z9vGy;
	Fri, 15 May 2026 18:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778864209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THjYyH3uKjG/pqf0jTnTgVB5bOzHeeCO4NiACkPzCAA=;
	b=UvGbHkwMnE9NToXjbUNAsRia0LLJVuP/0ZjKLW6ppzyZhQjhcZMz+u2V8owicjpL+qc90x
	pT7ZRQpu3L7J/espeI8XH0yqUTi+/i2ei6D7Q8t89DylkuCkHKVKrHCQEmuwomb8THbO3P
	91TGgfWvRRM9aDNcdFxJddbLX7rHhYCfeEQM9BMv8jVPLYkLJttn+s8blSnzZrQ7w4Zngr
	WguOA7Ic/8jY+ANKQcdlrSdKDBFHC01WR1Sd0WAXYVjIJ/2tvmWFCYnG6mUGIFsWN9Ov4o
	dEMrs8Wdc8pkp+8WiAxu+ggIsRS0RPxrIimKc2/m8fDZxG3ZR6G22gMMbLpY/Q==
Message-ID: <cb461424-e4c1-4d2c-934b-ffd7374e2a56@mailbox.org>
Date: Fri, 15 May 2026 18:56:45 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, pekka.paalanen@collabora.com, jadahl@gmail.com,
 contact@emersion.fr, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260515120916.333614-1-tzimmermann@suse.de>
 <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
Content-Language: en-CA
In-Reply-To: <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de84221aa493230eab5
X-MBO-RS-META: 9sey5mwxehe7tcisizu96h4qcw6kgr1r
X-Rspamd-Queue-Id: 1E317555A3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[suse.de,ffwll.ch,gmail.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10919-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michel.daenzer@mailbox.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


[ Adding the wayland-devel list for awareness ]

On 5/15/26 17:12, Michel Dänzer wrote:
> On 5/15/26 13:55, Thomas Zimmermann wrote:
>> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
>> refresh. This is meaningless with vblank timers, which run unrelated
>> to the hardware's vblank.
>>
>> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
>> for CRTCs with simulated vblank events in all such drivers. The vblank
>> timers of these devices still rate-limit the number of page-flip events
>> to match the display refresh.
>>
>> According to maintainers, user-space compositors do not require the ioctl
>> for rate-limitting display output. Weston and Kwin rely on page-flip
>> events. Mutter uses and internal timer to limit the number of display
>> updates per second.
> 
> Actually mutter fundamentally relies on atomic commit completion events for that, same as Weston & KWin. Mutter uses the WAIT_VBLANK ioctl only for minimizing input → output latency (which can hide issues when completion of atomic commits isn't properly throttled).
> 
> 
> (Just a side not on the cover letter, no objections to the patches themselves)

After more discussion on IRC, I have some concerns.


The big one first: For drivers with no strict refresh cycle (i.e. an atomic commit can take effect more or less anytime after at least one "refresh cycle" has passed since the last one), does this change really make sense / what's the actual benefit?

In the case of the asahi & nvidia drivers, the problem with exposing this functionality to user space is that if the timestamps aren't accurate, it can result in missing display refresh cycles, which are dictated by hardware. That's why it makes sense to reject it there.

When there's no strict refresh cycle, that issue doesn't apply though.


Any changes made to the WAIT_VBLANK ioctl should also be made to the CRTC_GET_SEQUENCE / CRTC_QUEUE_SEQUENCE ioctls, which are slightly different UAPI for the same functionality.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

