Return-Path: <linux-hyperv+bounces-11814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wdXTFSWYRmpDZgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11814-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:56:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC196FAC49
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:56:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oIRwGFX+;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11814-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11814-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 141A13180846
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD08321F5E;
	Thu,  2 Jul 2026 16:36:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5519049B;
	Thu,  2 Jul 2026 16:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010212; cv=none; b=Uw6RKQM/k7RCjljAZARRBjBRiMrAK2h6jLQqfSR6v/QQvDjvtQjTHp2YeWsbvY2eHUMXVFX22GoM2m0efzLNceziJorhy/saNy4ajR5GZFTIZxfXXSr4N3L1uw9zxgHG/7ZE/5C1efHd3rY6+fWSxSo7yI5wmWTi/50t0gCUhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010212; c=relaxed/simple;
	bh=i9VQISNzX1pWMKkdROthOHX0pc3X26tQIQE83/UHHZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0nXSm7U+IzkOA1v3j5Il8xFL4PBdPNeUVTMyYu7B429vPxsJdSHb2WNatHXBHdEIpeASVJto+92xpiLZJ7AP1Ke5sNCc0oCdYV8ZxKHaZEAAA98LTxNtNl8odGL6n17BhXoLFuzULIbzsqoBCGvCXTyJOBTHjGSmPmosMBuXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIRwGFX+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7981F00A3D;
	Thu,  2 Jul 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010211;
	bh=X5GdJEzxuvZqI/BImFFsR0KsN9CCqgh3+vyT1B1REQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIRwGFX+R8w4Dm74ofhcXaYXgkGGc7X1wOmUo8DyelWWYF43wZbErfuNGUYR+uEt6
	 QXYNWXC2+3Swk9Kd+CCMvHnoeeaidtcy5U6hMWMy3IdOYnOu0zGdAx5HHy3xNdSEaY
	 +9Sqv0decb7/Y50sM5rDo9bHqrtX1g895JsNSbAjcaFLbTMbBLv2mCkgndc6+WMivB
	 KU+A3MUWLmbuqydVodM8Dk3owTFU+U3ddC7E9K++MFtst6WO0bdmc6W2uigZF1ytSw
	 IdGNy5D/DzGYlVPVDULFZi9Itri8QXQLdDXx+CR3cZHlZyANdHw1IUZCzM08O8/P/S
	 +XIXGd5vRbtiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:36:50 +0000
Message-Id: <20260702163651.0E7981F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11814-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-pci@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EC196FAC49

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `struct hv_input_create_device_domain` is missing a 4-byte paddi=
ng field, resulting in a non-standard 28-byte size.
--

commit 267ecd2e71d0d7f097fc4d970780fef12801efc5
Author: Wei Liu <wei.liu@kernel.org>

hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

This commit introduces new hypercall definitions to allow a child partition
to interact with the para-virtualized Hyper-V guest IOMMU. It includes
interfaces for capability detection, device/domain management, and IOTLB
flushing.

[ ... ]

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9bc..493608e791b45 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h

[ ... ]

> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;

[Severity: Medium]
Does this structure need an explicit 4-byte padding field at the end to
ensure its size is a multiple of 8 bytes?

Because the struct is packed and lacks tail padding, its size is exactly
28 bytes. These structures are often initialized on a reused per-CPU page
like this:

hv_create_device_domain() {
        ...
        memset(input, 0, sizeof(*input));
        ...
}

If the hypervisor expects an 8-byte aligned 32-byte input for this hypercal=
l,
the memset will only clear the first 28 bytes. This leaves 4 bytes of
uninitialized garbage from previous hypercalls in the tail end of the buffe=
r,
which might cause domain creation to fail if the hypervisor strictly valida=
tes
padding fields to be zero.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D1

