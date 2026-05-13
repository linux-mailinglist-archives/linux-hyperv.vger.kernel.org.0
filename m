Return-Path: <linux-hyperv+bounces-10869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHmREwjSBGr0PQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10869-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:33:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7763F539FE9
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CDBC304A4E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD03A75A5;
	Wed, 13 May 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwA+w81y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F319346766;
	Wed, 13 May 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700188; cv=none; b=lJEecfMLrAx5E6cADLi9moLF81mhADeYqU2tVjeRGD1HhjZT63kZEXQjI5vQ2ct5LRraMuwaqTBQPQnwJWoBYzRf/hIVj8RO0bZO5jES1ewU5WcqL/hLrAFDLjmBVpcehcov8LL3rleC6OdGKUeW+HdpY1r0yVDCX9tX8F8JSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700188; c=relaxed/simple;
	bh=zx1490a7MRtEITsnV2XL5SF+05tofRmvuMy/glZE3mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIGw/2dz3Go7LqD5471kwoVP/AeYAC8bWkwkt4Ib/+/+kGAbmzWXsOsEVNZNLfNdtEOqRLW00SinkOeIlJMANLOu7Lh6Yc6gItPIV/1sB5qdRuOFFHt/vzt9fLbO6EjrzmgrbCz6F9yz/5+0KWK7R3Tn+hg+OHT0dPKTVfXFA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwA+w81y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDEFC19425;
	Wed, 13 May 2026 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778700187;
	bh=zx1490a7MRtEITsnV2XL5SF+05tofRmvuMy/glZE3mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GwA+w81yMQKfADip/d4OhUlc14NZEKZpdjUf4sL4ABb0ESUBYENHwjDaG4XfPSH0A
	 6NL84r/QGoT9qHnAmAl2SDMxVziHV3AwEd6IFmEHRXd/zAz/PZM2s5WSx3YagweE9e
	 YAjQEPL7PrXpjD9WE/zGO3Sg/2EErDt7a/QFMOFuiDqy0PMwzvbMUww76ZQ1CDC1fJ
	 /826kuayTUlwFdK359TLWgYfGaUyXnBiUg5Oma0duhypVxJj4VbBEVc/UTAwGI5vj5
	 SliRzqHHnP3f0ViYyV+0YOJQ1ZY/QzzquN7toIaKBIZP5PL3d8iVv0p3xyy8LRqeUH
	 BsmIsCxmPYf5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 10/11] mshv: Populate mmio mappings for PCI passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260512020259.1678627-11-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-11-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:23:06 +0000
Message-Id: <20260513192307.7EDEFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7763F539FE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10869-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unvalidated physical memory mapping and integer overflow allow=
 mapping arbitrary host RAM.
- [Critical] Missing MMU notifier registration and TOCTOU race in MMIO faul=
t handling.
- [High] Architecture page size mismatch corrupts physical address mappings=
 on ARM64.
- [High] Hardcoded write permissions bypass host read-only restrictions for=
 MMIO regions.
- [Medium] Uninitialized stack variable `pfnmap_args`.
--

Note: The format of this report is altered to provide a free-form summary of
the findings, rather than using traditional inline diff quotes, to adhere to
recitation restrictions.

commit f5a60b27c18f019e0a418a3f28dcff85e1128ed4
Author: Mukesh R <mrathor@linux.microsoft.com>
Subject: mshv: Populate mmio mappings for PCI passthru

This commit adds support for mapping mmio memory to the guest upon receiving
an unmapped guest physical address intercept. It looks up the physical frame
number from the driver and asks the hypervisor to establish the map.

While reviewing this code, a few questions came up regarding the handling of
the memory mappings.

When the memory region is created from the user memory structure, it appears
only the start address is validated against the virtual memory area. The pa=
ge
count is taken directly from user input. Later, in the intercept handler, a
signed 32-bit integer is used to loop over the 64-bit page count. If a user
provides an excessively large size, could the loop counter overflow to a
negative value and prematurely terminate the validation loop? Would this
bypass the ram checks and allow mapping arbitrary host memory into the
guest, while also potentially causing a lockup without a scheduling point?

Is there a race condition when fetching the physical frame number? The memo=
ry
map read lock is dropped after resolving the address, and the hypercall is
made without holding it. Since there does not seem to be a memory management
unit interval notifier sequence check here, what happens if the host virtual
memory area is unmapped or modified concurrently? Could the guest retain
access to stale or reallocated host memory?

Does the physical frame number calculation work correctly on architectures
with varying page sizes? On arm64, the kernel page size might be 64KB,
meaning the value returned by the pfnmap functions is based on 64KB units.
However, the handler subtracts a 4KB-based offset from it. Will this
result in an incorrect base physical address being passed to the
hypervisor?

Will this logic handle read-only device memory properly? The code
unconditionally requests a write fault resolution and then hardcodes the
writable flag for the hypervisor map call. If userspace maps a read-only
memory region, will the fault fixup fail? If it does succeed, would the
guest be granted write access to a read-only region?

Does the pfnmap arguments structure need zero-initialization? The structure
is declared on the stack and only the virtual memory area and address
fields are explicitly populated. Could uninitialized padding or other
structure members contain stack garbage that might affect the pfnmap
operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D10

