Return-Path: <linux-hyperv+bounces-9755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGSgFfKvw2nAtAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9755-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:50:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C532273A
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860FD303AA94
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB239FCCC;
	Wed, 25 Mar 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfKaWPpC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pUu5Q1Fv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850353009EE
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432071; cv=none; b=pFJadgJR4CcZu8jssll3b+v1mdCzn0nvIHv9qyayWvZ0M68V1K937B4KKI/u5Cr51diBbO7ze311zsJ0ZHB1+ypm3MioeO2vC+wbz64V8iG2xUxQZ7en6/D5v8O9ml+jzR10zbyL4EQiSX/J5rll5R1/H9DqpeVDkBip+r+xJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432071; c=relaxed/simple;
	bh=W9VsU7ayZ8RVpTIhzcUcmUQ6PvuDoGrgazbk6OfstuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R51gV7bh4j0nZKSIAKDLBsBI/k/Ci3smYY7C2X7rnsW0j3VBF8KBUI1k6F25V+LYe48TgXczWkbH3uNvn1KmlsHJnSEmcmzhybyjcDaLggbiVjOmXuckkUGGdoSfChl4lTU2EEp+3sqhs0Qc6IHuusxqlGIFJEHEa7XerTNaw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfKaWPpC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pUu5Q1Fv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774432069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
	b=EfKaWPpCAUsePTyya+dKudwO3IGWr5Dmj2eqNCsqSMpCCnIs+0qQAjEp4luqyQcWIQrXKI
	hyu7WTl08+1GwRYBPpNbgLqhNYKrDsC1XnnVA3h0JGZICf1sE2b50IPJPnO7p+nxstO7QE
	/v3I2sieNBhc1896T/0C0u5sTfPbuSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-6JRcT1tUMPK50gebqHMnNg-1; Wed, 25 Mar 2026 05:47:48 -0400
X-MC-Unique: 6JRcT1tUMPK50gebqHMnNg-1
X-Mimecast-MFC-AGG-ID: 6JRcT1tUMPK50gebqHMnNg_1774432067
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so35878605e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774432067; x=1775036867; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
        b=pUu5Q1FvrnGky3NpnbohpKOlKhW+ceKeTES9yxnvUzMisGUIdNZUG6LvT+1MRy3kUR
         LdO2tlNfe8CVFvO0BE8WhkcxdY5wVYSlvUwBSQquV8ih+bekeA1WqPZMpfXQYXPpAFYv
         03l9Ol0YG3PDQVwK3KyWnqFpOESIcHfvSlNQRuG5CxmtlYIWn0Yyy3jrNbFMSQdzuq0o
         Q/T0ZzuyRQJ7ZT6uSfutQvVDUTHIBpRrX2CqfLQr7zvhKk6v3RlWyhUFWjgi/MbK53t7
         LSU4FAca2voUy9wJjw/cc0+vBrThlysiUpmBOCVWfgecd89P50ML+DHC1J+HWbzKMCSh
         xTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432067; x=1775036867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
        b=noIAangmLTqVbgM2FaT57wGcv21TqIdBF+Fd2J/qg0p602rBg3BtXlTtXTFEr5JSl6
         /afga55IwOw/fTCfIyVAJssmngwlfVSb3QSNOWYScDwe2jbgh3Th6OAwZzRN4LX/10p5
         qvJfovzONtjCm40zNMDHuxA0KpghXc6bfy0KXHU3Hc2psWswSGqlpObW4qCcRi0R+5Fl
         iPTNkEmtRHan24LbVcaEE6/KcXHgOVbZc3xf0E7nmyypMPDAqeO6253KU09GMTAen/Y8
         KgGLPKDxSFHZO3cw13BTl60PAID0UnpFqJGvfv91D4m48crQOGnuoq57zYgX4yMN+nMj
         HdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVlCWuaO5C0wb5m8D0V5QTyFAqOGtXHQVkGsG3OnSi6ryoKSBNI0j5fUXcyAnpCC4jQce1RSBRsUxZ0VAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypM06ZIAn/okzC5V0Y9dCKIqn5zTm31RvfWL9JjpIbbLN5M0Jn
	EntK1R7cvyBc/SMjas/iAbvBIk0WocqxZuTMQ08XtokdWWaTmt5DxWEewGc2IacCReeUPWlRAU9
	mnz0gEIhqHt07iShzHMHkYTPUy8QmY9T6gtHrBn71An/pjITwd8c3AbN5ZJUiv4/Oug==
X-Gm-Gg: ATEYQzxfaKWbyYPY+Vw7RYZwqR2475f3t3BCq9hWDCJwijwMSXuxfV00XUu06CP9mK1
	NujR/BV7ZGfJvqVy3xrHLCAeGSP4Pwoj6h7gBSn8ADbph+pJiQp0B04PacURlQTQS+t5AWqSbQM
	SUMKxhbvS/hdcgOWR+k3Ox3b/NpMqs4pM9DzEilVU5r8dxyWR4CnFio0qK7DWItMlwJ9027c3Tg
	4Q1xcGTfUCSgoZ1dD/5maTxV/u+aobR5j/hUepMfv1EAO+MrQng7Or0uMxJ5kq2IxE8HKebL9uL
	0TjDhyXOAUF2rwzoyzF7d6coOHsqg2aUKm07IOLBXhA3PTx70fo3agGjlQBkfXgqpeY4yZpx4pl
	FxiS+jf0w+sIBSR8szg==
X-Received: by 2002:a05:600c:a15:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-4871606c89dmr38627365e9.31.1774432066856;
        Wed, 25 Mar 2026 02:47:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-4871606c89dmr38626985e9.31.1774432066386;
        Wed, 25 Mar 2026 02:47:46 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d820bsm113568205e9.10.2026.03.25.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:47:45 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Li Tian <litian@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, Li Tian
 <litian@redhat.com>
Subject: Re: [PATCH net] netvsc: transfer lower device max tso size during
 VF transition
In-Reply-To: <20260325045006.18607-1-litian@redhat.com>
References: <20260325045006.18607-1-litian@redhat.com>
Date: Wed, 25 Mar 2026 10:47:44 +0100
Message-ID: <87a4vwnsu7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9755-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vkuznets@redhat.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B90C532273A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Li Tian <litian@redhat.com> writes:

> When netvsc is accelerated by the lower device, we can advertise the
> lower device max tso size in order to get better performance.
> While a long-term migration to user-space bonding is planned, current
> users on RHEL 10 / Azure are experiencing significant performance
> regressions in 802.3ad environments. This patch provides a localized,
> safe fix within netvsc without introducing new core networking helpers.
>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index ee5ab5ceb2be..971607c7406f 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2428,10 +2428,14 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
>  		 * This value is only increased for netvsc NIC when datapath is
>  		 * switched over to the VF
>  		 */
> -		if (vf_is_up)
> +		if (vf_is_up) {
>  			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
> -		else
> +			WRITE_ONCE(ndev->gso_max_size, READ_ONCE(vf_netdev->gso_max_size));
> +			WRITE_ONCE(ndev->gso_ipv4_max_size,
> +				   READ_ONCE(vf_netdev->gso_ipv4_max_size));

It seems netif_set_gso_max_size() helper does exactly that, i.e. sets both
gso_max_size and gso_ipv4_max_size.


> +		} else {
>  			netif_set_tso_max_size(ndev, netvsc_dev->netvsc_gso_max_size);
> +		}
>  	}
>  
>  	return NOTIFY_OK;

-- 
Vitaly


