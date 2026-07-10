Return-Path: <linux-hyperv+bounces-11895-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1K0xLDpdUGryxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11895-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:47:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10630736C47
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bNXQ1b5S;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11895-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11895-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF1DE3051D59
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C795322DAF;
	Fri, 10 Jul 2026 02:42:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884131F999
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 02:42:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651369; cv=none; b=RPXhO90SrE6IpFoJouxUJzJNUlZcJj17eX+clTsY3ijG0XkVoMFubXAILei/Z9UvOazLIgu8Nyv2wPSLIiWJPHJR0clZqwUHHkTiUTBIX6+/zXUwoPc3oWq0C2AJmBzjd1ITxO8xW062ZpBDtKQPUK4kZIZu/b2LnHqJ8qxuDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651369; c=relaxed/simple;
	bh=ZNyToD2XUVcSZoUBZcDQwrjFA/OAYH6OYwgG32NX0VY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCe+EXQijEhlNAvnbCe0pL6xTlEU+Ug2QtDwsfN0O5hl1mL+YyGAI9Ag0by55ZKLyQd7a8C7HnWGVx9vxL2VmIiXsrX2mDc6fAb4EQyUBQvu467WjRuymF/sy34UnMr6/cRPOZvr2r0olYHqf5tqHW/Gu7lwkdjEqW+z3LcjA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNXQ1b5S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE11F00A3A;
	Fri, 10 Jul 2026 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783651367;
	bh=9qqiJmEF98NPolLH7ckJjaDqS9Qk/2UD8BGtDGKfUr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNXQ1b5Sio3hjukHYPdSuLx7rpGdiylz2asiJI/3Bi2c3uIEbuWf5a0eFdT/2Gyjw
	 as8gEdECYZDg5Kfgd5GQEmPer0uKYp//Z6BLwe4Ayf7IMabMs2RKB20QZXBaL5OrgH
	 WGKE/vcn/ZCToObyiJm9T3epYFT09f9Ir3asa9QjJAJneLS2N8mhuav3LIxWylwgI7
	 TN+Ot6KZESMLvW71BWP8kgOdCNIYBtzc5ysVcgcrfyyMDdCnpW0B8stWDMQczI27Dj
	 PKdrWoXo+gf9YnpVz/I8f9aa7dL6xhWve39NhzdVvI2XRDTvRZc9tcYvwhXokaco+l
	 Zsh2r66KdiJgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hv: hv_balloon: validate unballoon range count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260710022914.3740453-1-michael.bommarito@gmail.com>
References: <20260710022914.3740453-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:42:47 +0000
Message-Id: <20260710024247.ABEE11F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11895-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:linux-hyperv@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10630736C47

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] free_balloon_pages() blindly trusts untrusted host-provided PF=
Ns, causing arbitrary memory free.
- [High] Teardown race in balloon_remove() leads to Use-After-Free.
- [High] Data race when updating worker arguments from VMBus softirq callba=
cks.
- [High] Concurrent lockless modification of dm->num_pages_ballooned.
- [High] Pending workqueues are leaked on the balloon_probe() error path.
--

--- Patch [1]: [PATCH] hv: hv_balloon: validate unballoon range count ---
commit cffe2d5855cc693f743d4cc5594c147a6fff1bdb
Author: Michael Bommarito <michael.bommarito@gmail.com>

hv: hv_balloon: validate unballoon range count

The Hyper-V dynamic memory host supplies DM_UNBALLOON_REQUEST messages
with a header size and a range_count field. balloon_down() trusts
range_count and walks req->range_array without checking that the received
message contains that many ranges. A malformed host or backend message can
therefore make the guest read past the received VMBus packet while freeing
balloon ranges.

> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 42ce27be344d5..0ebfc2524d630 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c

[ ... ]

> @@ -1346,6 +1361,12 @@ static void balloon_down(struct hv_dynmem_device *=
dm,
>  	int i;
>  	unsigned int prev_pages_ballooned =3D dm->num_pages_ballooned;

[Severity: High]
This is a pre-existing issue, but is it safe to modify
dm->num_pages_ballooned without locking or atomic operations?

If a DM_UNBALLOON_REQUEST arrives while a DM_BALLOON_REQUEST is still being
processed, free_balloon_pages() executes synchronously in the VMBus tasklet
context and decrements the counter:

drivers/hv/hv_balloon.c:free_balloon_pages() {
	...
		dm->num_pages_ballooned--;
	...
}

At the same time, alloc_balloon_pages() executes asynchronously in the
workqueue and increments it:

drivers/hv/hv_balloon.c:alloc_balloon_pages() {
	...
		dm->num_pages_ballooned +=3D alloc_unit;
	...
}

Could lost updates corrupt the guest's memory pressure statistics, leading
to incorrect accounting when reported back to the host via
get_pages_committed()?

> =20
> +	if (!unballoon_request_valid(req, msg_size)) {
> +		pr_warn_ratelimited("Invalid unballoon request: size %u, header size %=
u, range count %u\n",
> +				    msg_size, req->hdr.size, req->range_count);
> +		return;
> +	}
> +
>  	for (i =3D 0; i < range_count; i++) {
>  		free_balloon_pages(dm, &range_array[i]);
>  		complete(&dm_device.config_event);

[Severity: Critical]
This is a pre-existing issue, but does free_balloon_pages() blindly trust
the untrusted host-provided PFNs?

If a malicious host sends a DM_UNBALLOON_REQUEST specifying arbitrary PFNs
(e.g., kernel text or page tables), the guest iterates over these PFNs and
unconditionally frees them without validating if the pages were actually
ballooned out:

drivers/hv/hv_balloon.c:free_balloon_pages() {
	...
	for (i =3D 0; i < num_pages; i++) {
		pg =3D pfn_to_page(i + start_frame);
		__ClearPageOffline(pg);
		__free_page(pg);
	...
}

Can this lead to an immediate guest crash or arbitrary memory corruption via
freeing active kernel or user pages to the buddy allocator?

[ ... ]

> @@ -1527,7 +1548,8 @@ static void balloon_onchannelcallback(void *context)
> =20
>  			dm->state =3D DM_BALLOON_DOWN;
>  			balloon_down(dm,
> -				     (struct dm_unballoon_request *)recv_buffer);
> +				     (struct dm_unballoon_request *)recv_buffer,
> +				     recvlen);
>  			break;
> =20
>  		case DM_MEM_HOT_ADD_REQUEST:

[Severity: High]
This is a pre-existing issue, but are worker arguments safely updated during
VMBus softirq callbacks?

The VMBus interrupt handler balloon_onchannelcallback() directly overwrites
shared worker arguments without any locking or synchronization:

drivers/hv/hv_balloon.c:balloon_onchannelcallback() {
	...
		case DM_BALLOON_REQUEST:
			...
			dm_device.balloon_wrk.num_pages =3D bal_msg->num_pages;
			schedule_work(&dm_device.balloon_wrk.wrk);
			break;
	...
		case DM_MEM_HOT_ADD_REQUEST:
			...
				dm->ha_wrk.ha_page_range =3D *ha_pg_range;
				dm->ha_wrk.ha_region_range.page_range =3D 0;
	...
}

If an untrusted host floods the guest with back-to-back request messages,
can worker threads operate on torn, mixed, or corrupted parameters, leading
to incorrect guest memory operations?


[Severity: High]
This isn't a bug introduced by this patch, but does balloon_remove() have a
teardown race that violates subsystem rules?

The function calls cancel_work_sync() before vmbus_close():

drivers/hv/hv_balloon.c:balloon_remove() {
	...
	cancel_work_sync(&dm->balloon_wrk.wrk);
	cancel_work_sync(&dm->ha_wrk.wrk);
	...
	if (dm_device.state !=3D DM_INIT_ERROR) {
		disable_page_reporting();
		vmbus_close(dev->channel);
	...
}

Because the VMBus channel remains open and active, an incoming interrupt can
trigger balloon_onchannelcallback() and independently reschedule the work
item after it was already cancelled.

Could this lead to a use-after-free of a work struct and device state,
causing a kernel crash upon module unload or device unbind?


[Severity: High]
This is a pre-existing issue, but does the probe_error path leak pending
workqueues?

In balloon_probe(), balloon_connect_vsp() opens the channel, allowing the
host to immediately send messages that schedule balloon_wrk or ha_wrk. If
the subsequent kthread_run() step fails, the code jumps to probe_error,
closes the channel, and returns an error without cancelling the work items:

drivers/hv/hv_balloon.c:balloon_probe() {
	...
probe_error:
	dm_device.state =3D DM_INIT_ERROR;
	dm_device.thread  =3D NULL;
	disable_page_reporting();
	vmbus_close(dev->channel);
connect_error:
	...
}

Can this result in asynchronous execution of a leaked work item on
uninitialized or freed device state, causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710022914.3740=
453-1-michael.bommarito@gmail.com?part=3D1

