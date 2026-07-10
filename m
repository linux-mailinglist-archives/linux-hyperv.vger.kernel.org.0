Return-Path: <linux-hyperv+bounces-11894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6h8+L9xbUGpcxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11894-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:41:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032A736BA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dzQZaKSH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11894-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11894-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DC4D300753E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1631F9B1;
	Fri, 10 Jul 2026 02:41:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480AB21CC5C;
	Fri, 10 Jul 2026 02:41:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651289; cv=none; b=Dc+A/fnm/QWidbLoL9cw+uPlNfl6ptKeoYFarCXNphzhyhmdHKxHWDSx0yzmOHl1AvgMTqCt+QDFP1Rm3CLsuusomO4cs379AeFxeKwVZ27iAcMRGjQhrLjn3jCVwYGkumkU8a+C8VWHW/aELH18IhEUmJhAVsGBvN7tzEWdl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651289; c=relaxed/simple;
	bh=5JbM+mx1w8VCEcf8CXuq8tzx7FVolRCNKM6zdfNObFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+KGIr4Pj47M4K01IhDRTDOTjVtJKaCYxqkdiHC6wHul1nTM10NibPMTYcM0FHe2zE/isMTnsqAn2SfQPuzJrCotgoSLoozXrJgQGuc4HGnK3mPir4jkMCuXH02TN60XxoTXHXvkbeELujukTWKFO6cxoe4dlloCbscIfQuJzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzQZaKSH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85081F000E9;
	Fri, 10 Jul 2026 02:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783651287;
	bh=SzCKMHZZc7Y7tnEXNZDnowDD+y6vHfPQketk1EHW+uY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzQZaKSH7upkvcKO+nwYklMsrUJ7QNj9fQurZyjOQtCIb049YYgDrZ2fUHZHiyGgq
	 TzA00tRL3yXMCMiT+jfT0ELW/18DUfmKqxZIv8fkIYi/CdSiReyRqtsEs4j/CQJRAl
	 irk2CSX3+7HNM3JQfKjZR3si79srNyrNRiGAQGh4u94+8K/IYlYoufe+1ghzth2unv
	 rpN9w/wqatSuEelK+jwSqBYarqVvoqUjVqnohQImFMLin+zv3kn1M01XBYLPFqDBms
	 RLgazLFSUUq/gnx6haJbkvxz1YBc8TteADkUOf1B26upLl6eYaiKh2XgKZt3Ysh4Ed
	 NMQkBeFgxqQhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info
 bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710022854.3739558-3-michael.bommarito@gmail.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:41:27 +0000
Message-Id: <20260710024127.A85081F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11894-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:dmitry.torokhov@gmail.com,m:michaelbommarito@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3032A736BA0

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The embedded KUnit test will be silently disabled and cannot be com=
piled when both KUnit and the Hyper-V mouse driver are configured as module=
s.
- [Low] Test-specific mock logic is injected directly into the production V=
MBus I/O path.

Pre-existing issues:
- [High] The driver and the newly added bounds checking rely on unvalidated=
 inner payload sizes (`pipe_msg->size`, `input_report->header.size`) instea=
d of validating against the actual physical VMBus transport packet size, ex=
posing the guest to OOB reads.
- [High] Missing bounds check before accessing `report_desc[14]` allows out=
-of-bounds heap memory corruption.
--

--- Patch [2]: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info =
bounds ---
commit d676a1b2eb911b6f9e0db4e282e431e24c17d123
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: HID: hyperv: add KUnit coverage for device info bounds

This commit adds KUnit tests for the Hyper-V synthetic HID initial
device-info parser. The tests exercise malformed host-provided HID
descriptors using a KUnit-only ACK bypass.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1215,6 +1215,16 @@ config HID_HYPERV_MOUSE
[ ... ]
> +config HID_HYPERV_MOUSE_KUNIT_TEST
> +	bool "KUnit tests for Hyper-V mouse driver" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && HID_HYPERV_MOUSE
[Severity: Low]
When both KUNIT and HID_HYPERV_MOUSE are configured as modules, will this
regression cause the dependency expression to evaluate to "m", forcing the
boolean config to "n" and silently preventing the test from being enabled f=
or
module builds?

The standard kernel idiom for this is "depends on KUNIT=3Dy || KUNIT=3DHID_=
HYPERV_MOUSE".

> +	default KUNIT_ALL_TESTS
[ ... ]
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
[ ... ]
> @@ -240,13 +243,18 @@ static void mousevsc_on_receive_device_info(struct =
mousevsc_dev *input_device,
[ ... ]
> -	ret =3D vmbus_sendpacket(input_device->device->channel,
> -			&ack,
> -			sizeof(struct pipe_prt_msg) +
> -			sizeof(struct synthhid_device_info_ack),
> -			(unsigned long)&ack,
> -			VM_PKT_DATA_INBAND,
> -			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST) &&
> +	    !input_device->device) {
[Severity: Low]
Is this regression injecting test-specific mock logic directly into the
production VMBus I/O path?

Could we instead extract the device-info validation into a pure helper
function that the KUnit tests can call directly, avoiding the need to
conditionally bypass network sends in the core logic?

> +		ret =3D 0;
> +	} else {
> +		ret =3D vmbus_sendpacket(input_device->device->channel,
[ ... ]
> @@ -635,5 +643,100 @@ static void __exit mousevsc_exit(void)
[ ... ]
> +static void mousevsc_device_info_valid_descriptor(struct kunit *test)
> +{
[ ... ]
> +	info->hid_descriptor.bLength =3D sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength =3D cpu_to_le16(4);
[Severity: High]
This is a pre-existing issue, but does this test highlight an incomplete
bounds check in the driver?

The test sets the report descriptor length to 4 bytes. However, looking at
mousevsc_probe(), the driver contains a workaround that accesses index 14:

mousevsc_probe() {
    ...
    /* workaround SA-167 */
    if (input_dev->report_desc[14] =3D=3D 0x25)
        input_dev->report_desc[14] =3D 0x29;
    ...
}

If a compromised host provides a valid descriptor with a length between 1 a=
nd
14, as tested here, could this result in an out-of-bounds heap memory read
and write since the bounds check in mousevsc_on_receive_device_info() only
ensures the size is greater than zero?

> +	report =3D ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
[ ... ]
> +static void mousevsc_device_info_report_desc_oob(struct kunit *test)
> +{
[ ... ]
> +	info->hid_descriptor.bLength =3D sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength =3D cpu_to_le16(64);
> +	report =3D ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	memset(report, 0x42, 8);
> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
[Severity: High]
This is a pre-existing issue, but does the bounds validation tested here
rely on an unvalidated inner payload size rather than the physical VMBus
transport packet size?

If a compromised or malicious Hyper-V host sends a VMBus packet with a
massive pipe_msg->size but a small physical payload:

mousevsc_on_receive() {
    ...
    mousevsc_on_receive_device_info(input_dev,
                                    (struct synthhid_device_info *)pipe_msg=
->data,
                                    pipe_msg->size);
    ...
}

Could mousevsc_on_receive() pass this spoofable size to
mousevsc_on_receive_device_info(), leading to out-of-bounds reads during
memcpy() or kmemdup() because the bounds checking trusts this inner size?

> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -EINVAL);
> +
> +	kfree(input_dev->hid_desc);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710022854.3739=
558-1-michael.bommarito@gmail.com?part=3D2

