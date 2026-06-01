Return-Path: <linux-hyperv+bounces-11428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB1mG5BfHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11428-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:31:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299261D7AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A38A3013BBD
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF3394EA7;
	Mon,  1 Jun 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVzTeCBB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXYVmeg4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA667395AE1
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309778; cv=none; b=Us/YTAtOUvVPHHnVUzKs108Dsih61zIy26UcGDREJxE3sccLiOwOsCionzT047UCVZ9mM5dAjByXcS0UJ1kX4z2K5YIeFPNFvHM42HxAB9hANQK+7R2cZsq4Ss1A2SM1Wv8bef5HYVVBZNGTa7BfV/uF9EOHVGwX+3l4+rZG4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309778; c=relaxed/simple;
	bh=4dKLYO7/xzvYtKg4HAIvf2hSPWCkn9FdTg30Var8HtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0fiJrWKJv1CryAaEm2dPQe3DvkaFszv4u+GDYp1XoEGZDqRtbErvBk0ChDagYb07nruh2CIzK5ZiSaDNQ8OpBi4vzXEf9Bj7mqI3BCOjlxMsPjKXUFzNJ+2lRiwExsTmoym5Q6uR0Mhonux0D+MnGhTtdV+bMhGpQPYisEL5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVzTeCBB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXYVmeg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
	b=VVzTeCBB+XKcHZMgzGwahCNp4+EYzp+4+IpGFwTNzk7IwCk4FqTbvmEs1YZ4CEm8zm14N5
	KmXILOGcEGk9mrcL9y2SYs3x5W9xSpAN6CDAOgqBbovGIgqiJyK/ZQ05qVEAYAeTBYJpCB
	+6BJ+BR60bf73BeAxGsepS3tG2ZMIp8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-v6ieVJdWPh-thpbWLV0cmQ-1; Mon, 01 Jun 2026 06:29:34 -0400
X-MC-Unique: v6ieVJdWPh-thpbWLV0cmQ-1
X-Mimecast-MFC-AGG-ID: v6ieVJdWPh-thpbWLV0cmQ_1780309774
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa12a788so1030394f8f.2
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309773; x=1780914573; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
        b=QXYVmeg4NI0e20bldneH0n9wiwEo41apYLCGqBo5zUcXIWFQdZZlpJLEY9PS15oioA
         bw2Q8BL129icciY8B0XSkgwNcAbp22Er8jAM/PKxI3mEUc0uJwmDACnTG8t58xiXTOtR
         4sX5ruP4oqjBR5XAa7dkNeYIXUdDnX3IEcdKz6c63Gt5XNSG9H2zRPPFyw8na5ujQZfK
         7vlDVBjogRoO2leLi0GjnZFqfJ2Bvs1bpBYXjhBa23L7OWztLhLSd2X6lximby2cdhD7
         /hjdiSG4d7/YEiHM1rcAeFn6Fzrfw0AhuX/gntfC2GG/DCxCWIoD29h5k+LJO+RFmX8H
         yEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309773; x=1780914573;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
        b=ZrONRZGhFWMdB06L0vvSL9d/P+O9JbN4yY/U4nRLzrcRI/Q0Zko2HDHYr9D9w5eW1H
         8amI3/PCpr60n4LHY3IJSR/89P9g2vpVaDEaEs34vae3QX9y6Wha6bGJ8Zz2gsvfbWRa
         3r332vivXqxCPmCCumQb919wXBX8sbWF6DktfYd0Q+LySaTofesGZm1ci8CKTyJ8P0Qa
         /OipY+OrBc81E8wMJpqOTgVaOWP4CwUyAHNAGxH232aHWWNgFDzzPwPPe73DvuC5+MZY
         5zCPzIfr/WPwpFA/LPKS/sjmZB8NCi4BHUJAHLsFaIqvtJpXFtaLSsdHpTyHEZw+2m/k
         fFmg==
X-Forwarded-Encrypted: i=1; AFNElJ9OkrCMPOtFhW4UZXgzD6tXF/HufnHbiVO6GryodIywyKfXUNT1mqKKLgN6M7RWPXA1mT/rboihqo2VtrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhv8LmvHwiIthqT9Lj7jKtnqZjlt3zPGYgJ95y/Nzcb2eNrca
	XRGH0JDtKMW/xH7q0zNP/8ODh7RVtjLGv6iOlU+MoJjFzJEnJaxoETihyDsboruP9JtnWGnvLFS
	L3juvFY5QkdwOOTCA/Qx/do+MBCnfTjWjg/rzxnZmOv/s1/c/eO0wOif2AnQkCvy37A==
X-Gm-Gg: Acq92OHxKJCOLQgNw1QMd9y+9Z/eJQpR6EAYe87UPNDUyVKbqX9Dh9YBwzyu6J5kBtR
	WER2pOOQWkAXRs0O0G2C4AVAI9GeNI+Oa3tUteFTyM7KgtGQKjHTgw7VI1F30caaCsIvMbxF6DA
	0KiR85zSpWA07z4G+67tAWJ1hnRx6DyIvomIba1Mge03FSC6K2QaW3e5FlA4f/FpKjmf+FAhPP3
	xKTtXL2sYDJsCxO4Q5adSoxNcr3sO54g9bpdrFbsGn100KutNbdR1X3N1TWobJHr075yeUJz4K1
	rKu2yC7IO7uWF3Z3+1pKILmIVeVb4mX05mUxs6mCZqAgpgSHhvQOheqWOv253s/536xMIWy0Awr
	gQeZw2ShTGMTTyewOU7ilKgwI0LZWQt5VDr+GfAOJSVSWTBH5MXbgyKCDXfoiu2LQx/uHxYM4c7
	OrP5eCf/I12vjaNnA=
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr142088405e9.28.1780309773578;
        Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr142087935e9.28.1780309773155;
        Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a037fsm25007994f8f.4.2026.06.01.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:29:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 08/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
In-Reply-To: <20260530185716.65688-9-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-9-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:31 +0200
Message-ID: <87eciqlfjo.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11428-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid,broadcom.com:email,suse.de:email]
X-Rspamd-Queue-Id: 1299261D7AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Nothing in drm_atomic_helper_damage_merged() requires the old
> plane state. Remove the parameter and mass-convert callers.
>
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


