Return-Path: <linux-hyperv+bounces-11307-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEjAEK8NGGrMbAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11307-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 11:41:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F55EFC61
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC30323BDB5
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8033AF672;
	Thu, 28 May 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0pO4gbd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6KbaBgN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC762F7F18
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960650; cv=none; b=Z1i2HiVByA4quDyscAzp1e80UaF9BwKayVopHC1mlIb4MZ4TgeInT5mTUIRtHQPPJliZVPk2FJ1GQ82WjU1XuOhGJh0DmjYlHAb7mhfa9gsPUETCNkjtYkLHJRaSxqmVRaEHPPYbEYYW7N5HCPeJyxRUOX2cSS4rxkDzVwvWpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960650; c=relaxed/simple;
	bh=LoGASex2qnTG+TbDm1RTWf0ExI8R1+KY/4AGVcMtGWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QNk39zZC4qxfwbuMkQ2TSpo5QiOQ6lJkZ7b2d9alIixPzaOf9BJdZAaR8kiKGdLCddP4f/UzULZxmNpWB+d4TYnoO9Zj7C8sW6A/8/PIHxunMjPQ3gDZCzeVQ7jFvZnX0QLwnnoe/cucuGA8v2fWj+tXQoRf/s/y1ltaD8BWiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0pO4gbd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6KbaBgN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
	b=f0pO4gbdAje+bUGJJpmNOBTVLTWgbtr09S6H7/x0qIrriZEEuAO84G0+FIt6OgUhSBsvEC
	5K+TtuC5BXNg2t/3/ZIr+D46B46ttIlg0qphs/7Y0FPZMGL7Cup+oFkpCCvhcmhw8rZ4fC
	xJmUqSh9G5gOfXwgqxFHwiEmjjtX9hg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-6qh_05zJOS6LKD1-ANBHJA-1; Thu, 28 May 2026 05:30:44 -0400
X-MC-Unique: 6qh_05zJOS6LKD1-ANBHJA-1
X-Mimecast-MFC-AGG-ID: 6qh_05zJOS6LKD1-ANBHJA_1779960643
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d9ace59efso7359210f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779960643; x=1780565443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=V6KbaBgNjttznWNNpi1z9T3hFVZiNKzLFLHpJY4/7dM8xcU3Gn1PhchlRhVKGB2gPD
         BADVKIINDAJhLRj69ru8cVAHH/wWq9UOWIJmA/C0pPF//y3FGrhZvNVE19dxjx0Xxpdy
         XFKgWQ1rqOPpvulaLYdgbzBcCTcigrrR62fAvSNdAO59R1vUhVG4YFKVAKXWuEE15tpT
         zs0/T6KrlQ1iphzT8mHq5Xc2zq/y5A2l9FO3CyboIXIROMACE5Qnw5e60dRnSzQNN/aL
         z5nVoSjTZwpJoPDiTri3lw1bTLHEKR9Ld2tOgEjwn6z/i8plJTYcsroF7jxNGAtHd82A
         qHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960643; x=1780565443;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDPtL7TwxG75IfmZr4FfYfvPDdnmXjEs/bxPVe7ap1c=;
        b=HZ68i9j+fikTWbLvzKq0pfcn6Cuos1LVIvtlGhFW6QekpuXHtMSQGT/B1/zGd8BKJT
         aRwHQd540Ug/jqd7lJ6AbjDsdZ1fG85zGgIaApE5NAuxRfSLZURie8c+MZMzs1mkcmin
         uY7ijxFqzh7RrWZNf0/kePD6ot/jqV7EH0OvVJMli3037+caukM604nNnnqIJHm3X1d5
         Heu6ewIPar5xWKhXvjzXNRC7crsS9haDd6L3rt+9MSSmLDFbs7GJLjbSjMkO3vj/jUMz
         4/QWBGtF7YEwc74lSou1Od92B2c1zAMON4RUzs/It3Xu0TUOLKE5pmPCDD5d7sAUUhPE
         Py4A==
X-Forwarded-Encrypted: i=1; AFNElJ+oAAnYnOe/WnNC712AXUt1jyCbR2+VoYO4IusTVIxR37p+ysMxbgzRU2uUtotaVd+i4vlQZLD9PWNMrd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ohsRD/OjvtwHNfsCUfTTutMFICZ7LvywHPmbe+6TfJpvg3jI
	o+Kh98qHGsy7I97yHpQeNh9QxUoT5IViiHD6+Ib2klCd7r7WFiAZ2kGOUm8Gf6/OwCgipcdEJbI
	rFjODwZZbJSjPxXX7SudDpvuKFkxfsSS4FGCIroN6aSQkOxulsc7VxAvHHr/prbz+YA==
X-Gm-Gg: Acq92OFAmSagrTBO8mO6rDj/BcMzaCjGNUjWAFR1fTcq51Va8SwAtTGc75JLbHmGra0
	Ba0Hj8AkDqLr2InOvUc+Zv/gPkKyK1aQG8ccHkdp67aUWQKCRymhOMRdzrLWGkvKsT2v18aEc8B
	5sZ09PwvSwy1rSjOEkOgyxDKehfcJC9KM92zFU2hzuUXAgcyphwxkcRenCsl5zlPTOm/Q3BNR0d
	aXl5iqnvhfa8XsdQN7yKEbl3sCztJQbZ9VNTOD0DRk/+qRHhQpVncPIiygvSygvsIKWl3HWrxQg
	ZBI4cQGoti8Z/zlUxPWlUrirv9vU1zrUehyNAVg+k9i6zaQLmEfBRVetUycq7Z+z2bEQecdamCQ
	8av0cK8q8kilAOLw/DHH7oVUUqi9hSmKt4D7gQRY6/yhGDJs0w4pWvgn6FFJYeXBspQ==
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523760f8f.38.1779960642517;
        Thu, 28 May 2026 02:30:42 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-45eb38bfdebmr32523688f8f.38.1779960641995;
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm11898279f8f.21.2026.05.28.02.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:30:41 -0700 (PDT)
Message-ID: <3665f7c1-9c97-44ac-8b6a-e6c31ad96730@redhat.com>
Date: Thu, 28 May 2026 11:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: mana: Skip redundant detach on
 already-detached port
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com
References: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
 <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11307-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A02F55EFC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 10:08 AM, Dipayaan Roy wrote:
> When mana_per_port_queue_reset_work_handler() runs after a previous
> detach succeeded but attach failed, the port is left in a detached
> state with apc->tx_qp and apc->rxqs already freed. Calling
> mana_detach() again unconditionally leads to NULL pointer dereferences
> during queue teardown.
> 
> Add an early exit in mana_detach() when the port is already in
> detached state (!netif_device_present) for non-close callers, making
> it safe to call idempotently. This allows the queue reset handler and
> other recovery paths to simply retry mana_attach() without redundant
> teardown.
> 
> Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 0582803907a8..1e1ad2795c3c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
>  
>  	ASSERT_RTNL();
>  
> +	/* If already detached (indicates detach succeeded but attach failed
> +	 * previously). Now skip mana detach and just retry mana_attach.
> +	 */
> +	if (!from_close && !netif_device_present(ndev))
> +		return 0;
> +
>  	apc->port_st_save = apc->port_is_up;
>  	apc->port_is_up = false;

sashiko(gemini) notes the above can lead to different race:

---
Can this early return cause state machine corruption by bypassing the
updates
to apc->port_st_save?
Consider this sequence:
1. queue_reset_work runs, mana_detach() succeeds (apc->port_st_save = true,
   apc->port_is_up = false), but mana_attach() fails.
2. The admin brings the interface down (ip link set dev eth0 down), skipping
   mana_close() since apc->port_is_up is false.
3. The admin changes the MTU, triggering mana_change_mtu() which calls
   mana_detach() followed by mana_attach().
4. mana_detach() hits this new early return, preserving
   apc->port_st_save == true.
When mana_attach() runs, it sees apc->port_st_save == true and allocates
queues, setting apc->vport_use_count = 1 and apc->port_is_up = true, even
though the interface is administratively down.
If the admin then brings the interface up, mana_open() will unconditionally
call mana_alloc_queues(). That function calls mana_cfg_vport(), which will
return -EBUSY because apc->vport_use_count is already 1.
This leaves mana_open() failing and the interface down. Since the interface
is already down, trying to bring it down again is a no-op, meaning
mana_close() is never called to clean up the orphaned queues.
Does this sequence permanently brick the port until the driver is reloaded?
---

I think you need to be more restrictive in the early return check.

/P


