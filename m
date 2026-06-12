Return-Path: <linux-hyperv+bounces-11614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q1MEOFpHLGoEOwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11614-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 19:52:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF98467B74B
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 19:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iwUjn2iL;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11614-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11614-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10D023006933
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B834A797;
	Fri, 12 Jun 2026 17:52:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFF364E84;
	Fri, 12 Jun 2026 17:52:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286740; cv=none; b=iXwBjKGLT7Oq8JJFApR810ed/7tv1+GlxyC8wLKLsVQwc5J9GWAMNbQFL5+bCwfbtEuoA++8T6/Xwdyrgkt+tnVy47yA4DNftCOhGtUXZN7VJQc8Ss0jYPxJBZSwORMljzntWaywqaZZN1EzWjIOETssoudbf3HE5ukREB4bvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286740; c=relaxed/simple;
	bh=khARBzKR0x4jVs8JJ93rZ3aFudCIGQZoGEUfVDz0k54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqNIom1pf+SqYIymN6V6G3tbDs1DSAAEXpSXXBMpEmcP03UcebUptLn0KikUV5YurLl37n3HhCwh1z+IFI5luDYroaXUoEcIhREqlVHmYbOu94MJdqY6664hxFiiLqwXqum5nx2KKRuefkKRBppaPbVXYZd7eYYi1d3Y/02MF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwUjn2iL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220581F000E9;
	Fri, 12 Jun 2026 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286739;
	bh=RXskqk7OEdvfX4mAewnKiV5FOuBa18OnbFk1lWRp/IA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwUjn2iLxoqJupjhglRFJ639kevfhS1MREHiper4qodT2V6ONhdRybsxaETmndLib
	 dXieT8v9sFqeG5KkweJIntXE6BpgIm+bcmWenkCF8INaLSu/RRkISfTAZDUd9owY2N
	 vX//GltfZmgw4d+t8R1k23uQ7FdT3Y6iLkbQjTr2vhIUFJgRK1gkWfkujjg9/1Abqf
	 BRMhHTyNdrKcD/b+pQP9V8FXn8vCYP9NfqpimLjJDuHiwAr6Z8wKfReYx439090A9X
	 JmDf9SzQBLJPUkfuhtfxXXW73bt9BkcsBXFqDL64UjZOHRau5JDdhCB5ecihUfQ4WL
	 ppVog7/bpcBTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 17:52:18 +0000
Message-Id: <20260612175219.220581F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11614-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:linux-pci@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF98467B74B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Use-After-Free and Stack Corruption due to abandoned VMBus req=
uests on timeout.
- [Medium] Race condition in wait_for_response() polling loop can falsely t=
rigger timeout.
--

commit 18b7ab3e09172b3f0651ad176d0ab6367f1e43bb
Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

PCI: hv: add hard timeout to wait_for_response()

This commit adds a hard 5-second timeout to wait_for_response() in the
hyper-V PCI controller driver. It addresses an issue where the driver could
wait indefinitely for a device to appear if a rescind event is never
received.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad6..bd63efc4a2103 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

[ ... ]

> @@ -1045,8 +1048,13 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  static int wait_for_response(struct hv_device *hdev,
>  			     struct completion *comp)
>  {
> +	unsigned long timeout =3D get_jiffies_64() + msecs_to_jiffies(TIMEOUT_M=
S);
> +	unsigned long now;
> +
>  	while (true) {
> -		if (hdev->channel->rescind) {
> +		now =3D get_jiffies_64();
> +		if (hdev->channel->rescind ||
> +		    time_after(now, timeout)) {

[Severity: Medium]
Is there a race condition if the thread is preempted right before updating
the time?

If the thread is preempted just before calling get_jiffies_64() and the
delay crosses the 5-second boundary, this will evaluate to true and
immediately return -ENODEV.

Since there is no final check of the completion status after the timeout
check, could this falsely assume a timeout even if the Hyper-V host
successfully replied during the preemption window?

>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>  			return -ENODEV;

[Severity: Critical]
By adding this timeout, do we risk a use-after-free and stack corruption if
the VMBus request is never explicitly cancelled?

When we return -ENODEV early here, callers like hv_send_resources_allocated=
()
will free their heap-allocated request packets and return, which pops the
local completion structure off the stack.

However, since the VMBus channel remains active and the pending request is
not removed from the requestor array, what happens if the Hyper-V host
eventually replies?

Wouldn't hv_pci_onchannelcallback() fetch the dangling packet pointer and
invoke comp_packet->completion_func(...) on freed memory?

It seems this could also corrupt the stack when writing to the destroyed
completion structure. Additionally, in hv_pci_query_relations(), returning
on timeout leaves hbus->survey_event pointing to a local stack variable
that will later be completed by survey_child_resources().

Does this also leak a slot in the VMBus requestor array for each timed-out
request?

>  		}
>=20
>  		if (wait_for_completion_timeout(comp, HZ / 10))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612174010.2598=
695-1-hamzamahfooz@linux.microsoft.com?part=3D1

