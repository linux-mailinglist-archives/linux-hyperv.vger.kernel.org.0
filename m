Return-Path: <linux-hyperv+bounces-11616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mJi0LM1TLGrMPQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11616-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 20:45:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCB67BD61
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 20:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=J9hiYqXG;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11616-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11616-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72B68307E6B7
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36636369D43;
	Fri, 12 Jun 2026 18:45:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E22367B73;
	Fri, 12 Jun 2026 18:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289904; cv=none; b=akLQ/1j1Y5UZTFfWzO+2E0AVClLaKcZQNoB+YqerPy09lXkAQdcYuoPJvyIrhl8d0NzHOb+yVcDIz3XnPbvFOP6c7SHOOCIZitfkxj7LA/z35GGNhpz0fdkR9+XMHRrXG10qbtrlhNj6UC7sQyisGhnzA8m14vY3Jo+2FwIzG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289904; c=relaxed/simple;
	bh=NhAM2rnivPz5BrNpOWCW6/ItHr2V9Q+DfHIs37fwR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcR45EAV0fd/+3o1+MN1EgeYx87l/VGKHTI36j+RLoEN8GH+VVbxQXLqMvg+Ec+6DCeRVbJxetZpWk0Bz6j2pnaij1XvKhuNdGKlIY6NpWtIe+642boyJPhvfVd5PtYk0Zg96aG8SYkEe9AuNy4MqIwYs198Ov9p2MDm22I7aX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J9hiYqXG; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 91A2220B716A; Fri, 12 Jun 2026 11:44:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91A2220B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781289883;
	bh=NhAM2rnivPz5BrNpOWCW6/ItHr2V9Q+DfHIs37fwR5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9hiYqXG85M4v/+2kHazB3TUmUJow/1MO+KGeI3+8TYKwlUASGUH7Ou3X2i+Kli1v
	 7+sVjMKPKZgLObLM6RXS3x8AKKY0tQF4IQuqSN85KEUgCzxALzOWXnAhxFW+Hq3JAF
	 SzhgvqPMKR+8MQFFg7U47dZ/eJg7C+ssHAx2VsR4=
Date: Fri, 12 Jun 2026 14:44:43 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Message-ID: <aixTm07GodS/Av9c@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
 <SA1PR21MB6683BAA40F52C52150D7811ECE182@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683BAA40F52C52150D7811ECE182@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11616-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AFCB67BD61

On Fri, Jun 12, 2026 at 06:04:22PM +0000, Long Li wrote:
> What if the VMBUS response comes in right after this check? The completion is allocated on the caller stack, and it will cause kernel OOP.

That is a fair point, I'll try to see if there is a better way to handle this error case.

