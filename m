Return-Path: <linux-hyperv+bounces-11299-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFrqMKmkF2oTMAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11299-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:12:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 416665EBB27
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39643305634B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CD2D97AA;
	Thu, 28 May 2026 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg7o7y5Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F02E92BA
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934313; cv=none; b=tUJJTzrCl2jWyGRpA6Z+440pmKnUypt/kf+Wc0QrDluhxhDb1F00HPv2dQ+9Y+O3jZbyWlKuNMZIqNTWgYuOTKAJfSn4pVj+t0LJt3Pag99lSWNlZTg9tBSB3PAWQk4YHSI61EGgLDjIIRWGko57zbYVujHm4Atw6cEdoy62flM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934313; c=relaxed/simple;
	bh=L85OGWyzQ62AxtiCR1839pM5UR1RjIH2/x0Q9Nb5QQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jn4u1WihkA8WTYPci96waF77Gug2UGNQ9QDkDYALtQqkZQoA5DAsdK+luqJvn/VnPYh/n+z7JQSFQL2fgJ3Bn1rUyIK7XOz8vlner22X6f0IesWI6UCUIYKRjRZtqAd5Is/H8UmfHGZWkoeAKoPGNwV/gU54Rp3ONbz01U8PK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg7o7y5Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E201F000E9;
	Thu, 28 May 2026 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934311;
	bh=ADEw3BUzjeY6+VLTghhvVTIoE7U9QZ3x9H6JoTWT3H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gg7o7y5Z/q5XHjYI81f43dwWAVIXaQCrEi2q1qgwW5Htnkx9UyxsScZvBu2oigcj+
	 eSwAUKpJt+J2yH9sdSyEoqo0JdHGX2bDzT1YjSdBt/i02rfThaY888g5pDZu1Ya0+0
	 fMXGHHeIPuwIdSVDKKt1IBg7tMsNGM32/J/2IehSIxLSusVPT6rpcfzUOuh1JbW52+
	 fWWMXz8ysFbw5634JWFdaHDDDqzTB/1pUiwGOQRJyMciL8XljIiNW42CHWnqL6rA8A
	 gF4g9iFi9pn+UmgANMhiHC0hz4zBlamJjnDQC3UvyWj66UZRNoghyzjQyCIUMqEno5
	 coH9bTEJa+fRA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 20/20] mshv: freeze and vacuum partitions across
 kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-21-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-21-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 02:11:50 +0000
Message-Id: <20260528021151.B1E201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11299-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 416665EBB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Concurrent kfree in partition creation error path causes UAF o=
r NULL pointer dereference in mshv_freeze_and_get_partition_ids().
- [High] KHO serialization APIs are invoked without verifying if the KHO su=
bsystem is enabled.
- [High] Lockless call to mshv_eventfd_release() races with concurrent ioct=
ls, causing list corruption and double-frees.
--

commit 1d32c3ff3fb719ececcc6529a01a0e1cb8e01bc9
Author: Jork Loeser <jloeser@linux.microsoft.com>

mshv: freeze and vacuum partitions across kexec

This commit introduces logic to freeze VM partitions prior to a kexec,
ensuring no VP modifies VM-memory reused by the new kernel. It preserves
the partition IDs using the KHO subsystem so the successor kernel can
retrieve and clean them up. Finally, it provides a mechanism to vacuum
stale partitions left over from a previous kernel.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1762,6 +1790,201 @@ static void drain_all_vps(const struct mshv_parti=
tion *partition)
[ ... ]
> +	if (!nr_alloc) {
> +		pr_info("Frozen 0 partition(s) for kexec\n");
> +		return 0;
> +	}
> +
> +	ids =3D kho_alloc_preserve(nr_alloc * sizeof(*ids));

[Severity: High]
Should we verify kho_is_enabled() before calling KHO serialization APIs
like kho_alloc_preserve() here and kho_add_subtree() during preservation?

If a standard kexec is performed (with kexec_in_progress true but KHO
disabled), can calling these KHO serialization APIs lead to a NULL pointer
dereference on kho_out.fdt?

> +	if (IS_ERR(ids)) {

[ ... ]

> +	for (i =3D 0; i < nr_ref; i++) {
> +		/* Ref held; partition stays in hash and alive outside RCU */
> +		scoped_guard(rcu)
> +			partition =3D mshv_partition_find(ids[i]);
> +
> +		/* Barrier: wait for any in-flight create_vp to complete */
> +		scoped_guard(mutex, &partition->pt_mutex) {}

[Severity: Critical]
Can mshv_partition_find() return NULL here if a partition creation error
path concurrently unlinks and unconditionally frees the partition?

If mshv_freeze_and_get_partition_ids() obtains a reference in the first
loop, but the error path ignores the reference count and frees the
partition anyway, would mshv_partition_find() return NULL after the
partition is removed from the hash table?

This would cause a panic when attempting to acquire &partition->pt_mutex.
Additionally, if the reference count was ignored during a concurrent
kfree, could this result in a use-after-free regression?

[ ... ]

> +		/*
> +		 * Tear down doorbell ports owned by the parent partition.
> +		 * These survive child partition deletion and kexec, so the
> +		 * new kernel would collide on port IDs if we leave them.
> +		 */
> +		mshv_eventfd_release(partition);

[Severity: High]
Is it safe to call mshv_eventfd_release() here without holding
partition->pt_mutex?

If mshv_root.frozen is not checked in the ioeventfd ioctl dispatch path,
could userspace concurrently issue ioctls that modify the ioeventfds_list
while this function is moving it, resulting in list corruption or
double-frees?

> +
> +		mshv_partition_put(partition);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D20

