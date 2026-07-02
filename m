Return-Path: <linux-hyperv+bounces-11818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EbXfK1eXRmq8ZQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11818-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:52:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D66FAADA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:52:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kKppJCYF;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11818-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11818-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A3563096FFC
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED835CB6F;
	Thu,  2 Jul 2026 16:42:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B63546D2;
	Thu,  2 Jul 2026 16:42:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010544; cv=none; b=DX7PcrLMHSrRZFcB6U+wMnkMLo6zKB3MQCzwfVqW5Q99qIOB/cX+cxs6WkYcNq+7l8QDxmGuzszhUZROmp9MeXiQzousvgaZwtSOMpRAjEkTs8uAIGnRY8FM38lnSwNwkLt3JZKFfjVsYwUTmFaX3+/u3zR87G3XZT+HHMlfRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010544; c=relaxed/simple;
	bh=GTS6Uu9pJPrqEx4yIeERKVg833roPmZ7jMVMjztHBFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CwewBhm+2pV8SItNInaldyXUFf9E4QEtS5CNzFMCbI9INYkqY+8TTJVJjqeY6Emi1GoPG/6V5CpdXzD9ANnEOUMBWyWBKGSIH3kuhJGMKcg0msnY2zEJbeSGQ0OpzR/1X+Mi1fT5MpEAqGB8oqTK/Mi9aRbac2b8K+eM+umtcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKppJCYF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F81F00A3A;
	Thu,  2 Jul 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010543;
	bh=GTS6Uu9pJPrqEx4yIeERKVg833roPmZ7jMVMjztHBFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKppJCYF3VQXzHS13ud3qCNYBeVJT+Yqm4haa5QeEsD8tDhOS48mwe5rGnuNC7N+Y
	 Yjplv3zMkU5qraZxGPmCSJ2UPnJQeyFjM6Bn+lnDoD+UtlS4CxLQ2WExcD+tHYFdKs
	 Pcn5J5PtIQjYzy/iqVix+rN/M956JKLYRl9ibpOdQu1mc9tgq3uKeS7fxao3RkgmuS
	 stitn+hyr8yOzPzvF2vpi0IDKWe3z/ONeQY7AGQiL/dT7ly5jcKWq1x604AfiN7uxs
	 m53j0/21IyyTCoU6LQFHbkQh0tb1utgnHlTx8IZ84D5jMRq7FpYYekvgh6jTriYw/k
	 xkD/PZMYkBybQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:42:21 +0000
Message-Id: <20260702164222.200F81F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11818-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 463D66FAADA

> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID in
> its hypercall interface. This ID consists of a per-bus prefix, derived
> from the VMBus device instance GUID, combined with the PCI function
> number of the endpoint device.
>=20
> Add a small registry in hv_common.c that maps a PCI domain number to its
> logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> prefix when a bus is probed and unregisters it when the bus is removed.
> Consumers such as the para-virtualized IOMMU driver look up the prefix
> by PCI domain number and combine it with the function number to form the
> complete logical device ID for hypercalls.
>=20
> The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> that pci-hyperv's interrupt retargeting path and the registry use exactly
> the same byte layout. It is derived on demand from the constant hv_device
> instance GUID rather than cached in struct hv_pcibus_device, which is
> private to the pci-hyperv module; this keeps the interface narrow and
> avoids depending on pci-hyperv internals.
>=20
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D2


