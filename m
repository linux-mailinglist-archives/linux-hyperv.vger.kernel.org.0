Return-Path: <linux-hyperv+bounces-10672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGmTNCeE/GmOQwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10672-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 14:23:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC294E823C
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D183003EA8
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6092E7F25;
	Thu,  7 May 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eE686EVL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5F38229C
	for <linux-hyperv@vger.kernel.org>; Thu,  7 May 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156581; cv=none; b=XoiwwYV5tFc9x72S4lLnXbfCLLlcVAAzdmaNw/JudMwYJX/cw92lOZmIIh+k5hAibDs4PgpsE7diWIzZ55+rwYtu3OaHN7pHwknKCZx168YXorwPVKSqyQNrKyOM/+MUd5XeIB15DVZ6H4/OaCjuVWHtD1xDqx7h5BrrcDqJm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156581; c=relaxed/simple;
	bh=yXyy/1avikG//9PNJ0NYNRcQ/+6OhcdCpQSlhFY4bVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdw2OQr27hGtXB3Y9LXZXs+7nKeBqcjNKn5HH6E15g33XHkiAv0rxebKDrFpeVYHxtYzfgJFO7kyBZgjVyAwJCSSNchxoqst1TEzaWce3MB1PmuLmkp06F+LFwj9dKxBbtCHNQAe+rNoy8LDPqqVnOrdM6X9RmmSRheCytogkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eE686EVL; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rf6dlxadgragpeknl2zvhwifqq.protonmail; t=1778156569; x=1778415769;
	bh=yXyy/1avikG//9PNJ0NYNRcQ/+6OhcdCpQSlhFY4bVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eE686EVLPG9E3IvxDNMtZPAUgQnZvjYhBtGeYCeLsfCNrwyUOwDYNTExiom1wb1Vv
	 qxf5nbN2AYwB+PjB6b4dqbRmwRB6HO9ooY5fYpYBLWpa0Jrj4sc5E1DnxJYfqEFebE
	 pjq0qImRlNPXZuB/Kjwt4l0RDL2eqGnBDNaN2Fa6Zw9J60dvsjbk8K/SC9kyx70guD
	 zRaMFJ8yT4aNrsf/KcU9MiDUzcCrQfOd+3neh79Rt+4WHcxEvs/Xro0+zBG7mfowTX
	 HKw6d77yk6g1BGDajPKTBLEZHfo54YyENhNsf1cmjFijEBhEN7yZf+DNbhP37d96Ie
	 XL4adMF90c2LQ==
Date: Thu, 07 May 2026 12:22:42 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Aditya Garg <gargaditya08@proton.me>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net, paul@crapouillou.net, zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-mips@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/10] drm/appletbdrm: Allocate request/response buffers in begin_fb_access
Message-ID: <G66ElwoYASE3O3RpWWuKm9V5LNUTUtjJ_lGUsDxN3EujU3wsp3vpT-KcXMsrFfYEZkBwq9TNaD3Pc2g4oaueu4B-JXN3PTCoNGY999s5WHU=@proton.me>
In-Reply-To: <20260507075725.29738-6-tzimmermann@suse.de>
References: <20260507075725.29738-1-tzimmermann@suse.de> <20260507075725.29738-6-tzimmermann@suse.de>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 809317f98a9202275d5c4ae88ce01ca05792218d
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2BC294E823C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=rf6dlxadgragpeknl2zvhwifqq.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10672-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,crapouillou.net,broadcom.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@proton.me,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Action: no action

On Thursday, May 7th, 2026 at 1:27 PM, Thomas Zimmermann <tzimmermann@suse.=
de> wrote:

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>=20
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Aditya Garg <gargaditya08@proton.me>

