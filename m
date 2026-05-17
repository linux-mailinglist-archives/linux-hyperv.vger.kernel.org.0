Return-Path: <linux-hyperv+bounces-11001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FREMrLcCWqgtAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11001-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 17:20:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C50561F74
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BB873001CFE
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873EC2DECD3;
	Sun, 17 May 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIIybxE1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646222C21F1
	for <linux-hyperv@vger.kernel.org>; Sun, 17 May 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030822; cv=none; b=IrFn60Qe9RguM1zeXXi7kKlceFvQ2+4saQEJyR+UTt7NS/Moi8x+tTOTuI7euNsPgt/dMKY7r+ykRUt/HpoMKwIsOAqwLr7i1lraW62LcyG/Nozud0GfQflMnrXvbZzHY/6zi/+QdSpU6FsRDR/Ypad807m6PUMCH2CLlsHuEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030822; c=relaxed/simple;
	bh=3GQUQrorKzXNEOSJEXy2/EJJiyr1VX4PqPYCju9RbfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VN73hfX8F/Wd66mTYtWE7eAgLypDehRdt/iFNcgt4vvEmYNs2gdLRhEHiwAHh21p8Vxa996Wn59pXtmdIhEQ5vnyiohUC43o40bc7WBOAx28uvMtWI7+RuMQa+A6IH3At9BRboeM20wJNq2AN4/bPzU0VD4G9EqcVJW4sa+Jo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIIybxE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18DC2BCB0;
	Sun, 17 May 2026 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779030822;
	bh=3GQUQrorKzXNEOSJEXy2/EJJiyr1VX4PqPYCju9RbfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NIIybxE1rH/Jzz6XF89NJzV6f5ummUeTsR/nY/TPdKNhXdII2Um1zEUZJwN0eIgWZ
	 2nrU8p7IKeg91sm8AC5uZosHWxGq2s3inqku0k1FawIH2beu7SUHvUrwsu5VTo7xdR
	 rfb6Digb1WPgBTLLr0hQnWKsScY1+1rppj0FvMCVoyQn+87jsP2/BrUCZtuf9YcAu6
	 x5jI4cqJBkDcrXiIHi3iVq3zLoNm+dxgNpGSmX0KlUHbgjFtdNl1KnL+C6r7TX7a+J
	 sHhegPrhSEp+kg5LqBrB7QQT0fmZFrUJatVIVnf6msWmcj40Hm2RpxUJTXJ2L9acdF
	 qzoOVmGVwmt0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in
 receive callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260517-drm-hyperv-patch2-v2@berkoc.com>
References: <20260517-drm-hyperv-patch2-v2@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 15:13:41 +0000
Message-Id: <20260517151341.DC18DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C2C50561F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	MISSING_MIME_VERSION(2.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11001-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-hyperv];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.219];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,berkoc.com:email,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete validation of synchronous response payload sizes causes=
 state leakage and deterministic false success.
--

commit 31b0cdbb563323a78bd6df8c18d507462a03a084
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate VMBus packet size in receive callback

This commit updates the hyperv_receive callback to validate the received
packet size before processing it. It ensures that the packet contains at
least the message headers, passes bytes_recvd to the sub-handler, and
uses it to bound the memcpy for synchronous responses.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 3b5065fe06e46..cdab4895dd404 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> @@ -423,26 +423,35 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
> =20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
>  	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
> +	size_t hdr_size;
> =20
>  	if (!hv)
>  		return;
> =20
> +	hdr_size =3D sizeof(struct pipe_msg_hdr) +
> +		   sizeof(struct synthvid_msg_hdr);
> +	if (bytes_recvd < hdr_size || bytes_recvd > VMBUS_MAX_PACKET_SIZE)
> +		return;
> +
>  	msg =3D (struct synthvid_msg *)hv->recv_buf;
> =20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		memcpy(hv->init_buf, msg, bytes_recvd);

Is it possible for a truncated response to incorrectly report success here?

Since hv->init_buf is reused for both sending requests and receiving respon=
ses,
and their structures alias each other in the synthvid_msg union, a short pa=
cket
would leave the payload section of hv->init_buf unmodified.

For example, if a truncated SYNTHVID_VRAM_LOCATION_ACK packet contains only
headers, memcpy() will only copy the headers. The request's vram.user_ctx a=
nd
the response's vram_ack.user_ctx reside at the exact same memory offset in =
the
union. Because the payload in hv->init_buf is unmodified, msg->vram_ack.use=
r_ctx
will perfectly retain the request's vram_pp value.

The waiting thread checks this with:

	if (msg->vram_ack.user_ctx !=3D vram_pp)

Because the memory was unchanged, this check will deterministically evaluate
to false, causing the driver to proceed as if the VRAM location was
successfully acknowledged despite the malformed packet.

Should this code validate that bytes_recvd is large enough to contain the
specific response type's payload before copying and calling complete()?

>  		complete(&hv->wait);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517-drm-hyperv=
-cover-v2@berkoc.com?part=3D2

