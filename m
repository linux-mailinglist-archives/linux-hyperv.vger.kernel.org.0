Return-Path: <linux-hyperv+bounces-11027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJIXIb5nDGrihAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11027-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 15:38:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38857FD3C
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC45C3083691
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2F348C5D;
	Tue, 19 May 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmSQTxYX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIoBG67H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE140960D
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197456; cv=none; b=TBUWo14kiOvAO+kP04pmYNmDRAH3oYpSmIcPKV4eFH9IgR6W6FPsg+CUpVJjWcZElKWdbuQKZZeAAAA+usBZWbCn66SyMmE+keWph/lbw6s6QrS3ytsmLbiGY/3RBVBwBN8aHidlV2dnNMcwFsgW2/x3yCa89zOv8wU8Y//RbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197456; c=relaxed/simple;
	bh=GNwt91Y/YiIXrN/ComEQSNR7c7pJ+6wypbzG/h6P8+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxfiHFXqbCwBLGam2LOR2WWFsjeSc1wzf1Q4tecgX8yEShzj7jzRw+bZUeSy+WitRpeT3SBCqWEzWpZWhkp554PBPjt9MtrktyHE3tApxk2wm/JGYGtWsFdS+NlfCazQbg4m30XSZJHuB1zLnc4VGVE8vTAakgSzcRS4M2Zxvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmSQTxYX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIoBG67H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779197453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
	b=JmSQTxYXRdSSUU45XMI95KXgTu5u0Y7pFaNA8dqroNS265F4GsFMBPWpd+nSMdQct217Rv
	zFb27Lhhzn+ls/9hz5bK9oqDFcSfhsId8XEU2scNTVcJdIgIRXm4XyJGxNzocCmI0Tbc3y
	YZhKlWuaL0wCBJ2HC767lYy46Gwx7y0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-tAYZ8eWAO3KNCgC3hSOvrQ-1; Tue, 19 May 2026 09:30:52 -0400
X-MC-Unique: tAYZ8eWAO3KNCgC3hSOvrQ-1
X-Mimecast-MFC-AGG-ID: tAYZ8eWAO3KNCgC3hSOvrQ_1779197451
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44dad1b938fso2172202f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779197451; x=1779802251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
        b=KIoBG67Hb2wC2cmJiYmU59PJgUWXckmJgocJMiqx0R4vkHaswS8lH+qU7F7Gu/MDkF
         qRkBWc5k7hojdGTOpLg41FuPsq0mx4wVB6oZOIj3/OKnfYu/dELBPLwPNnxKwPnuhWBp
         dTa4Y1UnLzFTi+0B1xw5eLm0EMDMCC0M7t2jZHDoLy6sPf+K4KFs32zCBVA9EHKtsUAR
         AcAULmJ2Y8n0t8MQ/OmuW+7dim2nb89zr80tIR/F0qV4DQS/ya6B3gpzfSK0t8OJPtjT
         FayrjgB96HGf9r6SFrM/nR/TclkNF1HpA3zy9QqgyXW4CSLr0iC/ccUFYonM18al028A
         YvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197451; x=1779802251;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
        b=aJ2l6gvNSlv8Qm/5KRB2rqMzuUyCdp8p3TWTKe3/5Qh8gO67GkP5texCepwAzvLDmC
         LCeVt2V0kcWNZDs+MrRs8KMZTcxMODYg58lUM90iB+cVfzkYCZaAx0NZCoBFwoqfDMEl
         XDhTDOrPs3wuPm/kl0V3mP7jq0HuJfZsEzTBBEsUOxdb8i165L4b+wlOB6BGlfftZVoB
         z7OUziLmcj1AuwA7W0MgjRL2ycCCVlEmjBeFEJmz54duIta00O17hMwLvJiL1FaNwe7E
         bnj+YdQkhIGilEQRN51RiwyRFoPwkpiQA5ZWZhIPW7zdUK0EQLKVPRxPewMf4ZszJy3J
         VUhA==
X-Forwarded-Encrypted: i=1; AFNElJ9yYTQ/NNmGWdRwlHqStCCj8ZeBh6sZlY4/awxOsygbj6kjlMqyyESdPVHN/HNvwMwQwTIB2tioXrL3qZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUYFuJ1umuIAcnfFJofnbR915Hnukzlp05a1DVGCadZZCRQ1D
	p5H55ugDKih/doCXVJTZFSVJSRC3Eqz/RQrSJrrpPX2ANUs9NJifb5nw/Di3UJruID12z7oJVds
	UTppRtm+dA6rZiBp6y9UPBtgfyG2FQSU3kO8wZZ3oT/1gUT8yYEti77fVPR2bTVsWKw==
X-Gm-Gg: Acq92OFu1onbZM/Q4YLxiJq2gI4KuXuYjxq02wIH253ifPp8CqLhuYmGGXo0dFq7nui
	tB5tnYBKxO58EN3fCbaI8gwjy8+jMmSRGTTJjssvXYKJi49s1rgo7zIN9ppZ3CTUkaA71zs5QKQ
	NiocmTYUxuYuK/J5ZSQOp+EcRRYd4GV7cHLOrIICQu8BV0YU87LEtDTL2UCh0iLbzNBoSoncQv0
	nHbBJVzNQY8RCZ4VehnH2dlAfLRbP9Vs6srZKkAHf4lH1i9frJJp0nOKKwrKxskbaOBqItd9KVJ
	rVLBeKIHNY0fz3uFc4xFqQi6PROOWMWKXOlk014aV1hXNOyamM9WKYqRAiz23+Qk/B75WSruzSg
	RYpUszUgPy3i3oO/DUkfBf3SvrQzEj0synACCiWL+TY+ie2/ZzyRbejg=
X-Received: by 2002:a05:6000:400f:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45e5c57d40bmr31702172f8f.4.1779197450881;
        Tue, 19 May 2026 06:30:50 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45e5c57d40bmr31702094f8f.4.1779197450324;
        Tue, 19 May 2026 06:30:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm45094750f8f.30.2026.05.19.06.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:30:49 -0700 (PDT)
Message-ID: <e024150c-6970-47a5-8ba5-d16a7a189d89@redhat.com>
Date: Tue, 19 May 2026 15:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/6] net: mana: Create separate EQs for each
 vPort
To: longli@microsoft.com
Cc: kotaranov@microsoft.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, shradhagupta@linux.microsoft.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515040508.491748-2-longli@microsoft.com>
 <20260519132825.172490-1-pabeni@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260519132825.172490-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11027-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: DF38857FD3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 3:28 PM, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: mana: Create separate EQs for each vPort
> 
> This patch moves EQ allocation from per-device to per-vPort, exports
> mana_create_eq()/mana_destroy_eq() for use by the RDMA driver, takes
> a vport reference for RSS QPs, and adds cross-port PD-sharing
> rejection for raw QPs along with serialization between
> mana_set_channels() and the RDMA vport configuration.
> 
>> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
>> index ac5e75dd3494..f8a9013f0ca3 100644
>> --- a/drivers/infiniband/hw/mana/main.c
>> +++ b/drivers/infiniband/hw/mana/main.c
>> @@ -40,13 +42,27 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>>  
>>  	pd->vport_use_count++;
>>  	if (pd->vport_use_count > 1) {
>> +		/* Reject cross-port PD sharing. EQs and vport config
>> +		 * are per-port, so the PD must stay bound to the port
>> +		 * that was configured on the first raw QP creation.
>> +		 */
>> +		if (pd->vport_port != port) {
>> +			pd->vport_use_count--;
>> +			mutex_unlock(&pd->vport_mutex);
>> +			ibdev_dbg(&dev->ib_dev,
>> +				  "PD already bound to port %u\n",
>> +				  pd->vport_port);
>> +			return -EINVAL;
>> +		}
>>  		ibdev_dbg(&dev->ib_dev,
>>  			  "Skip as this PD is already configured vport\n");
>>  		mutex_unlock(&pd->vport_mutex);
>>  		return 0;
>>  	}
>>  
>> -	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id);
>> +	pd->vport_port = port;
>> +
>> +	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id, true);
>>  	if (err) {
>>  		pd->vport_use_count--;
>>  		mutex_unlock(&pd->vport_mutex);
> 
> [Low]
> In the failure path of mana_ib_cfg_vport(), if mana_cfg_vport() or the
> later mana_create_eq() fails, vport_use_count is rolled back to 0 but
> pd->vport_port keeps the value just written.
> 
> Is the contract that pd->vport_port is only meaningful while
> vport_use_count > 0?  That invariant is not documented in the struct
> mana_ib_pd comment, and a future reader who consults pd->vport_port
> without first checking vport_use_count under vport_mutex would see stale
> data.  Would it be worth either resetting pd->vport_port on the rollback
> path or documenting the rule explicitly?
> 
>> @@ -55,15 +71,23 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>>  		return err;
>>  	}
>>  
>> -	mutex_unlock(&pd->vport_mutex);
>>  
>> -	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
>> -	pd->tx_vp_offset = mpc->tx_vp_offset;
>> +	err = mana_create_eq(mpc);
>> +	if (err) {
>> +		mana_uncfg_vport(mpc);
>> +		pd->vport_use_count--;
>> +	} else {
>> +		pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
>> +		pd->tx_vp_offset = mpc->tx_vp_offset;
>> +	}
> 
> [ ... ]
> 
>> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
>> index 0fbcf449c134..108ec4c5ce51 100644
>> --- a/drivers/infiniband/hw/mana/qp.c
>> +++ b/drivers/infiniband/hw/mana/qp.c
>> @@ -155,6 +156,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>>  
>>  	qp->port = port;
>>  
>> +	/* Take a reference on the vport to ensure EQs outlive this QP.
>> +	 * The vport must already be configured by a raw QP.
>> +	 */
>> +	mutex_lock(&mana_pd->vport_mutex);
>> +	if (!mana_pd->vport_use_count) {
>> +		mutex_unlock(&mana_pd->vport_mutex);
>> +		ret = -EINVAL;
>> +		goto fail;
>> +	}
>> +	mana_pd->vport_use_count++;
>> +	mutex_unlock(&mana_pd->vport_mutex);
>> +
> 
> [Critical]
> The cross-port PD-sharing check added to mana_ib_cfg_vport() is not
> mirrored here.  mana_ib_create_qp_rss() takes the user-supplied port
> from ucmd.port and only checks that vport_use_count is non-zero, so the
> RSS path will happily attach to a different port than the one bound to
> the PD by the first raw QP.
> 
> If a user creates a raw QP on port A (which sets pd->vport_port=A and
> allocates mpc_A->eqs via mana_create_eq()), then creates an RSS QP on
> the same PD with ucmd.port=B where port B has no Ethernet up and no
> RDMA activity, mpc_B->eqs is NULL.  The subsequent code in this same
> function:
> 
> 	eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
> 	cq_spec.attached_eq = eq->eq->id;
> 
> would then dereference NULL through mpc_B->eqs.
> 
> If port B does have Ethernet up, mpc_B->eqs is owned by the Ethernet
> driver and the RSS QP attaches to those EQs.  When the QP is destroyed
> mana_ib_destroy_qp_rss() calls mana_ib_uncfg_vport(mdev, pd, qp->port=B),
> and once pd->vport_use_count reaches 0 mana_ib_uncfg_vport() will run
> mana_destroy_eq(mpc_B) on Ethernet's live EQs and call mana_uncfg_vport
> on a port whose apc->vport_use_count was never incremented by this PD,
> tripping the WARN_ON in mana_uncfg_vport() and corrupting Ethernet's
> vport state.  Meanwhile port A's EQs and vport configuration are leaked
> because nothing on this PD will destroy them.
> 
> Should mana_ib_create_qp_rss() apply the same pd->vport_port == port
> check that mana_ib_cfg_vport() now performs, before bumping
> vport_use_count?

Sashiko reported alredy this problematic pattern in 2 separate places.
Please ensure that there are no other similar buggy usage pattern
elsewhere in the newly introduced code.

/P


