Return-Path: <linux-hyperv+bounces-11243-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P13D/wJF2pB2AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11243-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:13:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6265E6A33
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E84300A8F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671036D51E;
	Wed, 27 May 2026 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnU8fIjr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81C236453
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894451; cv=none; b=rf3Gas6gTJD8/hqm31Q+dB5U4bqtvZX6aP5rkix5u0ZNhiJuTCanrGVNa59pAv/kN0ecJG3uDvjg/A0jL4vbTnCeRvSdhKVUCT3QF9OsLMpVQRcdBpfQOaLUyhas7SU2F3zstczkPan4g72xWBYo3ut+bKqp8AGx3wXuG0C/3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894451; c=relaxed/simple;
	bh=Y1oMKrqfgHJ0QlD/+C6AFpPoPlwJoO0CQweMXscQtH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eCiXoeWikqWomjVlk0fh4vxxetOjwQaG5wnf2sVEg77lapqBPljvjulag2rQYh3Pm/mTRZ/oCR4OfuUwrDUasZ7E7EhhTRIgPReuMIu7W93v7fU8zv0hat0e9IaWX0qinsbzDwt1zhN9TlamF1/CG6O6UVLt7mIhWC+Bx9Ys9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnU8fIjr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C6B1F00A3E;
	Wed, 27 May 2026 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894450;
	bh=U4bNEynIawIfUutO95Nrez8wbly++HDn0EgfhDvShOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnU8fIjrPBWYeamgirRrrfSpxlcFLJGyISD/YdzbWYHmmUDAZcXRGCjDuLUCNKVdX
	 j7QcwxVleGdNQJCufhVzqQI526B9DFHSpbhtJZ0CytmJDF2F+Poz/0YQM55htN4cyn
	 jl1iU932QmduNgQAa4pS4st77GjflFvS4O83+uH7SJNrZmDgyJUSDdBbpuR3nZ0ZN9
	 XYzza/uNyO2AiEgXxEO0kQvMcHJ3WiTFozKhTbmO6eb9fkWGsZKUkeLSIntpuSY2g5
	 T/GorLHeVbRw6HTdWPWPtuRqUFPTuNhAlTO0G8E+KNx28SJRR4O1cOzR77dRw/EevJ
	 /AZNeBvsF6DFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-7-tzimmermann@suse.de>
References: <20260527145113.241595-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:07:29 +0000
Message-Id: <20260527150730.35C6B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11243-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,suse.de:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 8C6265E6A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in `frames_size` accumulation in `appletbdrm_=
primary_plane_helper_begin_fb_access()` leads to an undersized allocation a=
nd subsequent heap buffer overflow.
--

commit 95dfe9915dca0c203d54cd610ead65b1de9a07b7
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Remove old state from drm_atomic_helper_damage_iter_init=
()

This commit removes the unused old_plane_state parameter from
drm_atomic_helper_damage_iter_init() and updates all callers. Most callers
no longer require the old plane state in their atomic_update helpers.

[ ... ]

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index b683dcb35b0be..eadc3aed72774 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -324,7 +324,7 @@ static int appletbdrm_primary_plane_helper_begin_fb_a=
ccess(struct drm_plane *pla
>  	struct drm_rect damage;
>  	size_t request_size;
> =20
> -	drm_atomic_helper_damage_iter_init(&iter, NULL, new_plane_state);
> +	drm_atomic_helper_damage_iter_init(&iter, new_plane_state);
>  	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		frames_size +=3D struct_size((struct appletbdrm_frame *)0, buf, rect_s=
ize(&damage));

[Severity: Critical]
This is a pre-existing issue, but can this loop cause an integer overflow
when accumulating frames_size?

Because +=3D is used instead of safe accumulation like size_add(), supplyin=
g a
large number of clips (or clips with large dimensions) could cause the size=
_t
variable frames_size to wrap around. For example, on 32-bit systems, a large
amount of damage clips can map to >4GB of frame data.=20

This would result in an undersized buffer being allocated via kvzalloc().

Subsequently, in appletbdrm_flush_damage(), the code iterates over the same
clips and uses drm_fb_memcpy() or drm_fb_xrgb8888_to_bgr888() to copy the
full unclipped frame data into the destination buffer, potentially causing a
heap buffer overflow.

>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D6

