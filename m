Return-Path: <linux-hyperv+bounces-11893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q+0jDY5cUGrDxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11893-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:44:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98BB736BFD
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hHanijik;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11893-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11893-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D753024100
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72931F9BE;
	Fri, 10 Jul 2026 02:40:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E07316192;
	Fri, 10 Jul 2026 02:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651253; cv=none; b=EoIwkMydTZYgvJNjKEhO2DrxUtUC4XiP5q2KWfRyz9tn/a24lVvuU6lfY4Wxzs1ronyj2H64alWhdesw9dYSvfJBDx9rJ1FxXHIBh7V3afCB9jdh5sbTc9UZWTrYtXsK+jKcSlU06xh1j2D77nTlQw/Ixo/NRd55lFtIclxmqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651253; c=relaxed/simple;
	bh=1bIxFpJjMhgLNd2foOhcK8n5deXhCENLQH5RggC23K8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRfXfAbRvo1wAwqRiVtlZ/bJvyfkOLffBoP9jcrOIGDwq3juynE4DFicq/lfF3rlFgt9q+scY3tDlX7gF66n26M+o+kw1r08uoVsiiHDT6lt0v6yuig/8HuJo0uScDHxgaPMY66rXxG3UXaTCa2GxBQK0ihZMp1/s82E+bGrIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHanijik; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEDD1F000E9;
	Fri, 10 Jul 2026 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783651251;
	bh=WP3bpq574zQaEv8RdFi9UV8IRn9KjMreVHIfRAJyvoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHanijikLiLIlvW4L2bLITg9JyCVKD7tlidcNurpJxDOog+1ZezKX9zU5Ree3Mr4M
	 Mp1WPgEhXgeLxkz/MnP5KNISpW6hIxHkJpeZqj6ktBXpEqt1EJZ2gC05eFpYPiENJ+
	 qXziEmZM90g7E1B8jND4iaO4Qdeg+iCKL5H3mr8r/Rel76UoZIZN0rjmoS4oh316Bv
	 XvPIiJMQM6nSLdAC0MAWrpLH6z9Lu629tK9EtpBpnoEET6NRxGIJ4c2wC7LR+T8Pys
	 wPRce8OJhz6pjTxJQ3zb8spS/L91g5e2/PjokW/cOtXwcD5+8GzjcYYsIXoT7BI9Jw
	 Dhd3e+zRncSfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: hyperv: validate initial device info bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710022854.3739558-2-michael.bommarito@gmail.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:40:50 +0000
Message-Id: <20260710024051.6EEDD1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11893-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:linux-hyperv@vger.kernel.org,m:dmitry.torokhov@gmail.com,m:linux-input@vger.kernel.org,m:michaelbommarito@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C98BB736BFD

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Incomplete Vulnerability Fix / Out-of-Bounds Read
- [Medium] Missing Completion / Timeout Hang
- [Low] Dead Code / Redundant Check

Pre-existing issues:
- [High] Race Condition / Use-After-Free
- [High] Out-of-Bounds Access (Read/Write) in Probe Workaround
- [High] Out-of-Bounds Read (Information Leak) in Input Report
--

--- Patch [1]: [PATCH 1/2] HID: hyperv: validate initial device info bounds=
 ---
commit a1876077d0b8322cccf9c09f43d240367749b037
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: HID: hyperv: validate initial device info bounds

This commit attempts to fix an out-of-bounds read by passing the received
initial-device-info size into the parser and rejecting descriptor lengths
that exceed the packet.

> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -171,18 +171,32 @@ static void mousevsc_on_receive_device_info(struct =
mousevsc_dev *input_device,
> -				struct synthhid_device_info *device_info)
> +					    struct synthhid_device_info *device_info,
> +					    u32 device_info_size)
>  {
>  	int ret =3D 0;
>  	struct hid_descriptor *desc;
>  	struct mousevsc_prt_msg ack;
> +	size_t desc_offset;
> +	size_t desc_size;
> =20
>  	input_device->dev_info_status =3D -ENOMEM;
> =20
> +	if (device_info_size < sizeof(*device_info)) {
> +		input_device->dev_info_status =3D -EINVAL;
> +		goto cleanup;
> +	}

[Severity: Low]
Is this check necessary? In mousevsc_on_receive(), before calling this
function, the code explicitly verifies pipe_msg->size >=3D
sizeof(struct synthhid_device_info). Since device_info_size is passed
directly from pipe_msg->size, this inner check appears to be unreachable.

> +
>  	input_device->hid_dev_info =3D device_info->hid_dev_info;
>  	desc =3D &device_info->hid_descriptor;
> +	desc_offset =3D offsetof(struct synthhid_device_info, hid_descriptor);
> +	desc_size =3D device_info_size - desc_offset;
>  	if (desc->bLength =3D=3D 0)
>  		goto cleanup;
> +	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
> +		input_device->dev_info_status =3D -EINVAL;
> +		goto cleanup;
> +	}
> =20
>  	/* The pointer is not NULL when we resume from hibernation */
>  	kfree(input_device->hid_desc);
> @@ -197,6 +211,10 @@ static void mousevsc_on_receive_device_info(struct m=
ousevsc_dev *input_device,
>  		input_device->dev_info_status =3D -EINVAL;
>  		goto cleanup;
>  	}
> +	if (input_device->report_desc_size > desc_size - desc->bLength) {
> +		input_device->dev_info_status =3D -EINVAL;
> +		goto cleanup;
> +	}
> =20
>  	/* The pointer is not NULL when we resume from hibernation */
>  	kfree(input_device->report_desc);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free?

During mousevsc_probe(), the driver waits for the first
SYNTH_HID_INITIAL_DEVICE_INFO and proceeds to hid_add_device(), which parses
input_dev->report_desc.

If the host concurrently sends a second SYNTH_HID_INITIAL_DEVICE_INFO packe=
t,
the channel callback processes it asynchronously and calls
mousevsc_on_receive_device_info(). This executes
kfree(input_device->report_desc) without any locking while the HID core is
actively reading it.

[ ... ]
> @@ -273,14 +291,17 @@ static void mousevsc_on_receive(struct hv_device *d=
evice,
>  		break;
> =20
>  	case SYNTH_HID_INITIAL_DEVICE_INFO:
> -		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
> +		if (WARN_ON_ONCE(pipe_msg->size <
> +				 sizeof(struct synthhid_device_info)))
> +			break;

[Severity: Medium]
If this break is taken, are we skipping the completion event?

By breaking out of the switch statement early, we skip the call to
mousevsc_on_receive_device_info(). As a result, the
complete(&input_device->wait_event) inside its cleanup path is never
executed. This might cause the waiting thread in mousevsc_connect_to_vsp()
to stall until the 5-second timeout expires.

> =20
>  		/*
>  		 * Parse out the device info into device attr,
>  		 * hid desc and report desc
>  		 */
>  		mousevsc_on_receive_device_info(input_dev,
> -			(struct synthhid_device_info *)pipe_msg->data);
> +						(struct synthhid_device_info *)pipe_msg->data,
> +						pipe_msg->size);

[Severity: High]
Does this fully prevent out-of-bounds reads if the host sends a malicious
payload?

The pipe_msg->size field comes from the untrusted payload. If a malicious
host sends a short physical VMBus packet but sets pipe_msg->size to an
artificially large value, the bounds checks in
mousevsc_on_receive_device_info() will pass because they are evaluated
against this large device_info_size.

Could we restrict the size to the actual VMBus packet boundary, perhaps usi=
ng
something like (packet->len8 - packet->offset8) << 3, to ensure we don't
read past the received packet?

>  		break;
>  	case SYNTH_HID_INPUT_REPORT:
>  		input_report =3D
> 			(struct synthhid_input_report *)pipe_msg->data;
> 		if (!input_dev->init_complete)
> 			break;
>=20
> 		len =3D min(input_report->header.size,
> 			  (u32)sizeof(input_dev->input_buf));
> 		memcpy(input_dev->input_buf, input_report->buffer, len);

[Severity: High]
This is a pre-existing issue, but does this blind trust of
input_report->header.size enable an out-of-bounds read?

When handling SYNTH_HID_INPUT_REPORT, a malicious host could send a
physically short packet but set input_report->header.size to 4096.

The memcpy length is bounded using:

len =3D min(input_report->header.size, (u32)sizeof(input_dev->input_buf));

However, it isn't validated against the actual VMBus packet envelope. This
could result in copying beyond the packet boundary, potentially causing an
access violation or exposing memory adjacent to the packet.


[Severity: High]
This is a pre-existing issue, but I noticed another potential out-of-bounds
access during the probe workaround in mousevsc_probe():

drivers/hid/hid-hyperv.c:mousevsc_probe() {
    ...
    if (input_dev->report_desc[14] =3D=3D 0x25)
        input_dev->report_desc[14] =3D 0x29;
    ...
}

If a malicious host provides a wDescriptorLength of less than 15 bytes
(for instance, 8 bytes), this accesses and potentially writes to memory past
the dynamically allocated report_desc buffer. Should we ensure the buffer is
at least 15 bytes long before accessing index 14?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710022854.3739=
558-1-michael.bommarito@gmail.com?part=3D1

